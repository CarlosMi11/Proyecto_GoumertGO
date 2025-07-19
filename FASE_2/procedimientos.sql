--a)
CREATE PROCEDURE SP_CrearPedido
@idCliente int,
@idPlato int,
@idOpcion int,
@idOpcionValor int,
@cantidad_items int,
@costo_envio float,
@tiempo_entrega int,
@notaPedido varchar(256),
@notaPedidoDetalle varchar(256),
@porcentajeIVA float
AS
BEGIN
    BEGIN TRANSACTION;
    DECLARE @idPedido int;
    DECLARE @idPedidoDetalle int;
    DECLARE @numFactura int;
    DECLARE @total float;
    DECLARE @hora_apertura int;
    DECLARE @hora_cierre int;
    DECLARE @esta_activo int;

    SELECT @hora_apertura = C.hora_apertura, @hora_cierre = C.hora_cierre, @esta_activo = C.estaActivo
    FROM Plato P
    JOIN Seccion S on P.idSeccion = S.id
    JOIN Menu M on S.idMenu = M.id
    JOIN Comercio C on M.idComercio = C.id 
    WHERE P.id = @idPlato

    BEGIN TRY

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE id = @idCliente)
        BEGIN
            RAISERROR('Usuario no encontrado', 16, 1);
            ROLLBACK;
            RETURN;
        END
    IF NOT EXISTS (SELECT 1 FROM Plato WHERE id = @idPlato)
        BEGIN
            RAISERROR('Plato no encontrado', 16, 1);
            ROLLBACK;
            RETURN;
        END
    IF NOT EXISTS (SELECT 1 FROM PlatoOpcion WHERE idOpcion = @idOpcion)
        BEGIN
            RAISERROR('Opcion no encontrada', 16, 1);
            ROLLBACK;
            RETURN;
        END
    IF EXISTS (SELECT 1 FROM Plato WHERE cantidadDisponible < 1 AND Plato = @idPlato)
        BEGIN
            RAISERROR('Plato no disponible', 16, 1);
            ROLLBACK;
            RETURN;
        END
    IF (@hora_apertura < DATEPART(HOUR, GETDATE()) OR @hora_cierre > DATEPART(HOUR, GETDATE()) OR @esta_activo = 0)
        BEGIN
            RAISERROR('Comercio no disponible', 16, 1);
            ROLLBACK;
            RETURN;
        END
    
    SELECT @idPedido = ISNULL(MAX(id), 0) + 1 
    FROM Pedido;

    SELECT @idPedidoDetalle = ISNULL(MAX(id), 0) + 1 
    FROM PedidoDetalle;

    SELECT @numFactura = ISNULL(MAX(numero), 0) + 1 
    FROM Factura;

    SELECT @total = P.precio + OV.precio_extra
    FROM Plato P 
    JOIN PlatoOpcionValor POV on P.id = POV.idPlato
    JOIN OpcionValor OV on POV.idPocion = OV.OpcionValor;

    INSERT INTO Pedido(id, cantidad_items, costo_envio, nota, tiempo_entrega, total)
    VALUES (@idPedido, @cantidad_items, @costo_envio, @notaPedido, @tiempo_entrega, @total);

    INSERT INTO Factura(numero, fecha_emision, sub_total, porcentajeIva, montoIVA, monto_total, idPedido)
    VALUES (@numFactura, GETDATE(), @total, @porcentajeIVA, @porcentajeIVA*@total/100, @total + (@porcentajeIVA*@total/100), @idPedido);

    INSERT INTO ClientePedido(idCliente, idPedido, fecha)
    VALUES (@idCliente, @idPedido, GETDATE());

    INSERT INTO RepartidorPedido(idCliente, idPedido, tiempo_entrega)
    VALUES (@idCliente, @idPedido, @tiempo_entrega);

    INSERT INTO PedidoDetalle(id, cantidad, nota, total, idPedido, idPlato) 
    VALUES (@idPedidoDetalle, @cantidad_items, @notaPedidoDetalle, @total, @idPedido, @idPlato);

    INSERT INTO PedidoDetalleOpcionValor(idPedidoDetalle, idOpcionValor, idOpcion) 
    VALUES (@idPedidoDetalle, @idOpcionValor, @idOpcion);

    INSERT INTO PedidoEstadoPedido(idPedido, idEstadoPedido, fecha_inicio)
    VALUES (@idPedido, 1, GETDATE());

    UPDATE Plato
    SET cantidadDisponible = cantidadDisponible - 1
    WHERE id = @idPlato;

    END TRY

    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

--b)
CREATE PROCEDURE SP_AsignarRepartidor
BEGIN
@idPedido int
END;