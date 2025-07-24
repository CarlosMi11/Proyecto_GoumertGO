/* YO NO HE PROBADO ESTO PUEDE O NO FUNCIONAR DENME CHANCe
LA PRIMERA VEZ QUE TERMINE CERRE SQL SERVER SIN QUERER Y SE BORRO TODO
NECESITO UN DESCANSO AYUDA
*/
-- a, poblar factura
CREATE TRIGGER poblar_factura
ON Pedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @sub_total FLOAT;
    DECLARE @porcentajeIva FLOAT = 0.16;
    DECLARE @montoIVA FLOAT;
    DECLARE @monto_total FLOAT;
    DECLARE @numero_factura INT;
    DECLARE @idPedido INT;
    DECLARE @costo_envio FLOAT;
    
    -- Obtener el ID del pedido insertado y su costo de env�o
    SELECT @idPedido = id, @costo_envio = costo_envio FROM inserted;
    
    -- Calcular el subtotal sumando:
    SELECT @sub_total = ISNULL(SUM(
        PD.total + 
        ISNULL((
            SELECT SUM(OV.valor_adicional * PDOV.cantidad)
            FROM PedidoDetalleOpcionValor PDOV
            JOIN OpcionValor OV ON PDOV.idOpcionValor = OV.id AND PDOV.idOpcion = OV.idOpcion
            WHERE PDOV.idPedidoDetalle = PD.id), 0)), 0)
    FROM PedidoDetalle PD
    WHERE PD.idPedido = @idPedido;
    
    -- Costo de env�o + sub_total
    SET @sub_total = @sub_total + @costo_envio;
    
    -- Monto IVA
    SET @montoIVA = @sub_total * @porcentajeIva;
    SET @monto_total = @sub_total + @montoIVA;
    
    -- Obtener el pr�ximo n�mero de factura
    SELECT @numero_factura = ISNULL(MAX(numero), 0) + 1 FROM Factura;
    
    -- Insertar la nueva factura
    INSERT INTO Factura (numero, fecha_emision, sub_total, porcentajeIva,
    montoIVA, monto_total,idPedido) 
    VALUES (@numero_factura, GETDATE(), @sub_total, @porcentajeIva,@montoIVA,
        @monto_total,@idPedido);
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
    
    -- Verificar si alg�n pedido cambi� a estado "Entregado"
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN EstadoPedido ep ON i.idEstadoPedido = ep.id
        WHERE ep.nombre = 'Entregado'
    )
    BEGIN
        -- Insertar valoraciones autom�ticas para pedidos entregados
        INSERT INTO ClienteRepartidor (idCliente, idRepartidor, fecha,
            puntaje, comentario)
        SELECT 
            p.idCliente,
            rp.idRepartidor,
            GETDATE(),
            -- C�lculo del puntaje basado en diferencia de tiempos
            CASE 
                WHEN porcentaje_error <= 10 THEN 5  -- Excelente
                WHEN porcentaje_error <= 20 THEN 4   -- Bueno
                WHEN porcentaje_error <= 30 THEN 3   -- Regular
                WHEN porcentaje_error <= 50 THEN 2   -- Malo
                ELSE 1                               -- Muy malo
            END,
            CASE 
                WHEN porcentaje_error <= 10 THEN 'Entrega excelente'
                WHEN porcentaje_error <= 20 THEN 'Buen servicio'
                WHEN porcentaje_error <= 30 THEN 'Entrega regular'
                WHEN porcentaje_error <= 50 THEN 'Tard� m�s de lo esperado'
                ELSE 'Entrega muy tard�a'
            END
        FROM (
            -- Calcular el porcentaje de error para cada pedido entregado
            SELECT 
                i.idPedido,
                rp.idRepartidor,
                p.idCliente,
                -- F�rmula: ((|Valor real - valor estimado|)/valor real) * 100
                ABS(DATEDIFF(MINUTE, pep.fecha_inicio, i.fecha_inicio) - ep.tiempo_promedio) / 
                NULLIF(DATEDIFF(MINUTE, pep.fecha_inicio, i.fecha_inicio), 0) * 100 AS porcentaje_error
            FROM 
                inserted i
            JOIN 
                EstadoPedido ep ON i.idEstadoPedido = ep.id
            JOIN 
                PedidoEstadoPedido pep ON i.idPedido = pep.idPedido
            JOIN 
                RepartidorPedido rp ON i.idPedido = rp.idPedido
            JOIN 
                Pedido p ON i.idPedido = p.id
            WHERE 
                ep.nombre = 'Entregado'
                -- Obtener el estado anterior para calcular duraci�n real
                AND pep.idEstadoPedido <> i.idEstadoPedido
                AND pep.fecha_inicio = (
                    SELECT MAX(fecha_inicio) 
                    FROM PedidoEstadoPedido 
                    WHERE idPedido = i.idPedido 
                    AND idEstadoPedido <> i.idEstadoPedido
                )
        ) AS calculos
        WHERE 
            -- Solo si el cliente no ha valorado a�n a este repartidor por este pedido
            NOT EXISTS (
                SELECT 1 
                FROM ClienteRepartidor cr 
                WHERE cr.idCliente = calculos.idCliente 
                AND cr.idRepartidor = calculos.idRepartidor
                AND cr.fecha >= DATEADD(DAY, -1, GETDATE())
        );
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
    
    -- Registrar las opciones predeterminadas para cada nuevo �tem de pedido
    INSERT INTO PedidoDetalleOpcionValor (
        idPedidoDetalle,
        idOpcionValor,
        idOpcion
    )
    SELECT 
        i.id,
        ov.id,
        ov.idOpcion
    FROM 
        inserted i
    JOIN 
        PlatoOpcion po ON i.idPlato = po.idPlato
    JOIN 
        OpcionValor ov ON po.idOpcion = ov.idOpcion
    WHERE 
        ov.es_predeterminado = 1; -- Solo opciones predeterminadas
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