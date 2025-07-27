
-- a, poblar factura
CREATE TRIGGER poblar_factura
ON Pedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @numero_factura INT;
    DECLARE @idPedido INT;
    
    
    SELECT @idPedido = id FROM inserted;
    
    
    SELECT @numero_factura = ISNULL(MAX(numero), 0) + 1 FROM Factura;
    
    
    INSERT INTO Factura (
        numero, 
        fecha_emision, 
        sub_total, 
        porcentajeIva,
        montoIVA, 
        monto_total,
        idPedido
    ) 
    SELECT 
        @numero_factura, 
        GETDATE(), 
        dbo.subTotal(@numero_factura),  
        0.16,                           
        dbo.montoIVA(@numero_factura),  
        dbo.montoTotal(@numero_factura),
        @idPedido
    FROM inserted;
END;
GO

-- a, registrar cliente referido
CREATE TRIGGER registrar_referido
ON Cliente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalClientes INT = (SELECT COUNT(*) FROM Cliente);
    DECLARE @ClientesBase INT = @TotalClientes * 0.7; -- Los primeros 70%
    
    
    IF @TotalClientes > @ClientesBase
    BEGIN
        
        INSERT INTO ClienteConClienteReferido (idCliente, idClienteReferido, fecha_referido)
        SELECT 
            (SELECT TOP 1 id FROM Cliente 
             WHERE id <= @ClientesBase  
             ORDER BY NEWID()),         
            i.id,                       
            GETDATE()                   
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 FROM ClienteConClienteReferido 
            WHERE idClienteReferido = i.id
        );
    END
END;
GO

-- a, registrar entrega
CREATE TRIGGER registrar_entrega
ON PedidoEstadoPedido
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
   
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN EstadoPedido ep ON i.idEstadoPedido = ep.id
        WHERE ep.nombre = 'Entregado'
    )
    BEGIN
        
        INSERT INTO ClienteRepartidor (idCliente, idRepartidor, fecha, puntaje, comentario)
        SELECT 
            calculos.idCliente,
            calculos.idRepartidor,
            CAST(GETDATE() AS DATE),
            
            CASE 
                WHEN calculos.porcentaje_error <= 10 THEN 5  
                WHEN calculos.porcentaje_error <= 20 THEN 4  
                WHEN calculos.porcentaje_error <= 30 THEN 3  
                WHEN calculos.porcentaje_error <= 50 THEN 2  
                ELSE 1                                       
            END,
            CASE 
                WHEN calculos.porcentaje_error <= 10 THEN 'Entrega excelente'
                WHEN calculos.porcentaje_error <= 20 THEN 'Buen servicio'
                WHEN calculos.porcentaje_error <= 30 THEN 'Entrega regular'
                WHEN calculos.porcentaje_error <= 50 THEN 'Tardó más de lo esperado'
                ELSE 'Entrega muy tardía'
            END
        FROM (
            
            SELECT 
                i.idPedido,
                rp.idRepartidor,
                (SELECT TOP 1 idCliente FROM ClientePedido WHERE idPedido = i.idPedido) AS idCliente,
                
                
                ABS(DATEDIFF(MINUTE, prev_pep.fecha_inicio, i.fecha_inicio) - ep.tiempo_promedio) * 100.0 / 
                NULLIF(ep.tiempo_promedio, 0) AS porcentaje_error
            FROM 
                inserted i
            JOIN 
                EstadoPedido ep ON i.idEstadoPedido = ep.id AND ep.nombre = 'Entregado'
            JOIN 
                PedidoEstadoPedido prev_pep ON i.idPedido = prev_pep.idPedido
            JOIN 
                RepartidorPedido rp ON i.idPedido = rp.idPedido
            WHERE 
                
                prev_pep.idEstadoPedido <> i.idEstadoPedido
                AND prev_pep.fecha_inicio = (
                    SELECT MAX(fecha_inicio) 
                    FROM PedidoEstadoPedido 
                    WHERE idPedido = i.idPedido 
                    AND idEstadoPedido <> i.idEstadoPedido
                )
        ) AS calculos
        WHERE 
            
            NOT EXISTS (
                SELECT 1 
                FROM ClienteRepartidor cr 
                WHERE cr.idCliente = calculos.idCliente 
                AND cr.idRepartidor = calculos.idRepartidor
                AND cr.fecha = CAST(GETDATE() AS DATE)
            AND calculos.idCliente IS NOT NULL);
    END
END;
GO

-- b, devolucion
CREATE TRIGGER manejar_devolucion
ON PedidoDetalle
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    
    UPDATE p
    SET p.cantidadDisponible = p.cantidadDisponible + d.cantidad
    FROM Plato p
    INNER JOIN deleted d ON p.id = d.idPlato;
    
    
    UPDATE pe
    SET pe.total = pe.total - d.total,
        pe.cantidad_items = pe.cantidad_items - d.cantidad
    FROM Pedido pe
    INNER JOIN deleted d ON pe.id = d.idPedido;
    
END;
GO

-- c, registrar valores de opcion
CREATE TRIGGER registrar_opciones
ON PedidoDetalle
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        
        INSERT INTO PedidoDetalleOpcionValor (
            idPedidoDetalle,
            idOpcionValor,
            idOpcion
        )
        SELECT 
            i.id,
            pov.idOpcionValor,
            pov.idOpcion
        FROM 
            inserted i
        JOIN 
            PlatoOpcionValor pov ON i.idPlato = pov.idPlato
        WHERE
           
            pov.idOpcionValor = (
                SELECT TOP 1 id 
                FROM OpcionValor 
                WHERE idOpcion = pov.idOpcion
                ORDER BY id
            );
    END TRY
    BEGIN CATCH
       
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- d, verificar cantidad disponible
CREATE TRIGGER validar_cantidad
ON PedidoDetalle
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    
    DELETE pd
    FROM PedidoDetalle pd
    JOIN inserted i ON pd.id = i.id
    JOIN Plato p ON i.idPlato = p.id
    WHERE p.cantidadDisponible < i.cantidad;
    
    
    SELECT 'El producto no est� disponible por los momentos' AS Mensaje
    FROM inserted i
    JOIN Plato p ON i.idPlato = p.id
    WHERE p.cantidadDisponible < 1
    AND i.id IN (SELECT id FROM PedidoDetalle);
    
   
    SELECT 'No hay unidades suficientes del producto para esta compra' AS Mensaje
    FROM inserted i
    JOIN Plato p ON i.idPlato = p.id
    WHERE p.cantidadDisponible < i.cantidad
    AND p.cantidadDisponible >= 1
    AND i.id IN (SELECT id FROM PedidoDetalle);
    
    
    UPDATE p
    SET p.cantidadDisponible = p.cantidadDisponible - i.cantidad
    FROM Plato p
    JOIN inserted i ON p.id = i.idPlato
    WHERE i.id IN (SELECT id FROM PedidoDetalle)
    AND p.cantidadDisponible >= i.cantidad;
    
END;