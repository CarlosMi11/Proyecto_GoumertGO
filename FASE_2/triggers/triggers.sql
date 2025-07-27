-- CREO QUE AUN HAY ALGUNOS ERRORES PERO YA COMPILA

-- a, poblar factura
CREATE TRIGGER poblar_factura
ON Pedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @numero_factura INT;
    DECLARE @idPedido INT;
    
    -- Obtener el ID del pedido insertado
    SELECT @idPedido = id FROM inserted;
    
    -- Obtener el próximo número de factura
    SELECT @numero_factura = ISNULL(MAX(numero), 0) + 1 FROM Factura;
    
    -- Insertar la nueva factura usando las funciones definidas
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
        dbo.subTotal(@numero_factura),  -- Usa la función subTotal
        0.16,                           -- Porcentaje fijo de IVA
        dbo.montoIVA(@numero_factura),   -- Usa la función montoIVA
        dbo.montoTotal(@numero_factura), -- Usa la función montoTotal
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
    
    -- Solo para nuevos clientes despu�s del 70% inicial
    IF @TotalClientes > @ClientesBase
    BEGIN
        -- Asignar referidor aleatorio de los clientes base (70% inicial)
        INSERT INTO ClienteConClienteReferido (idCliente, idClienteReferido, fecha_referido)
        SELECT 
            (SELECT TOP 1 id FROM Cliente 
             WHERE id <= @ClientesBase  -- Solo de los primeros 70%
             ORDER BY NEWID()),         -- Selecci�n aleatoria
            i.id,                       -- ID del nuevo cliente
            GETDATE()                   -- Fecha actual
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
    
    -- Verificar si algún pedido cambió a estado "Entregado"
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN EstadoPedido ep ON i.idEstadoPedido = ep.id
        WHERE ep.nombre = 'Entregado'
    )
    BEGIN
        -- Insertar valoraciones automáticas para pedidos entregados
        INSERT INTO ClienteRepartidor (idCliente, idRepartidor, fecha, puntaje, comentario)
        SELECT 
            calculos.idCliente,
            calculos.idRepartidor,
            CAST(GETDATE() AS DATE),
            -- Cálculo del puntaje basado en diferencia de tiempos
            CASE 
                WHEN calculos.porcentaje_error <= 10 THEN 5  -- Excelente
                WHEN calculos.porcentaje_error <= 20 THEN 4  -- Bueno
                WHEN calculos.porcentaje_error <= 30 THEN 3  -- Regular
                WHEN calculos.porcentaje_error <= 50 THEN 2  -- Malo
                ELSE 1                                       -- Muy malo
            END,
            CASE 
                WHEN calculos.porcentaje_error <= 10 THEN 'Entrega excelente'
                WHEN calculos.porcentaje_error <= 20 THEN 'Buen servicio'
                WHEN calculos.porcentaje_error <= 30 THEN 'Entrega regular'
                WHEN calculos.porcentaje_error <= 50 THEN 'Tardó más de lo esperado'
                ELSE 'Entrega muy tardía'
            END
        FROM (
            -- Calcular el porcentaje de error para cada pedido entregado
            SELECT 
                i.idPedido,
                rp.idRepartidor,
                (SELECT TOP 1 idCliente FROM ClientePedido WHERE idPedido = i.idPedido) AS idCliente,
                -- Fórmula: ((|Valor real - valor estimado|)/valor estimado) * 100
                -- Usamos tiempo estimado como denominador para evitar división por cero
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
                -- Obtener el estado anterior para calcular duración real
                prev_pep.idEstadoPedido <> i.idEstadoPedido
                AND prev_pep.fecha_inicio = (
                    SELECT MAX(fecha_inicio) 
                    FROM PedidoEstadoPedido 
                    WHERE idPedido = i.idPedido 
                    AND idEstadoPedido <> i.idEstadoPedido
                )
        ) AS calculos
        WHERE 
            -- Solo si el cliente no ha valorado aún a este repartidor hoy
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
    
    -- Actualizar la cantidad disponible de los platos devueltos
    UPDATE p
    SET p.cantidadDisponible = p.cantidadDisponible + d.cantidad
    FROM Plato p
    INNER JOIN deleted d ON p.id = d.idPlato;
    
    -- Actualizar el total del pedido (restando el valor de los �tems devueltos)
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
        -- Registrar las opciones asociadas a cada nuevo ítem de pedido
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
            -- Seleccionar la primera opción disponible para cada opción del plato
            pov.idOpcionValor = (
                SELECT TOP 1 id 
                FROM OpcionValor 
                WHERE idOpcion = pov.idOpcion
                ORDER BY id
            );
    END TRY
    BEGIN CATCH
        -- Registrar el error si ocurre
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
    
    -- 1. Identificar �tems insuficientes y eliminarlos del pedido
    DELETE pd
    FROM PedidoDetalle pd
    JOIN inserted i ON pd.id = i.id
    JOIN Plato p ON i.idPlato = p.id
    WHERE p.cantidadDisponible < i.cantidad;
    
    -- Mensajes para productos eliminados
    SELECT 'El producto no est� disponible por los momentos' AS Mensaje
    FROM inserted i
    JOIN Plato p ON i.idPlato = p.id
    WHERE p.cantidadDisponible < 1
    AND i.id IN (SELECT id FROM PedidoDetalle);
    
    -- Productos insuficientes
    SELECT 'No hay unidades suficientes del producto para esta compra' AS Mensaje
    FROM inserted i
    JOIN Plato p ON i.idPlato = p.id
    WHERE p.cantidadDisponible < i.cantidad
    AND p.cantidadDisponible >= 1
    AND i.id IN (SELECT id FROM PedidoDetalle);
    
    -- 2. Actualizar cantidad para los �tems v�lidos
    UPDATE p
    SET p.cantidadDisponible = p.cantidadDisponible - i.cantidad
    FROM Plato p
    JOIN inserted i ON p.id = i.idPlato
    WHERE i.id IN (SELECT id FROM PedidoDetalle)
    AND p.cantidadDisponible >= i.cantidad;
    
END;