--b)
CREATE PROCEDURE SP_AsignarRepartidor
@idPedido int
AS
BEGIN
    BEGIN TRY

    DECLARE @idRepartidor int;
    DECLARE @idCliente int;
    DECLARE @tiempo_entrega int;

    IF NOT EXISTS (SELECT 1 FROM Pedido WHERE id = @idPedido)
    BEGIN
        RAISERROR('Pedido no encontrado', 16, 1);
        ROLLBACK;
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM PedidoEstadoPedido WHERE idPedido = @idPedido AND idEstadoPedido = 16)
    BEGIN
        RAISERROR('Pedido con estado incorrecto', 16, 1);
        ROLLBACK;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM RepartidorPedido WHERE idPedido = @idPedido)
    BEGIN
        RAISERROR('Pedido ya asignado', 16, 1);
        ROLLBACK;
        RETURN;
    END

    SELECT numero
    INTO #FacturasHoy
    
    SELECT (SELECT COUNT(*)
            FROM Factura
            WHERE fecha_emision = GETDATE())  AS numfacturasHoy, R.id AS idRepartidorConMenosPedidos
    INTO #RepartidorescomMenosPedidosHoy
    FROM Repartidor R
    LEFT JOIN RepartidorPedido RP on R.id = RP.idRepartidor
    LEFT JOIN Factura F on RP.idPedido = F.idPedido
    WHERE estado = 'Activo'
    GROUP BY R.id
    ORDER BY numfacturasHoy ASC

    SELECT TOP 1 @idRepartidor = idRepartidorConMenosPedidos 
    FROM #RepartidorescomMenosPedidosHoy;

    SELECT @idCliente = idCliente
    FROM ClientePedido
    WHERE idPedido = @idPedido;

    SELECT @tiempo_entrega = tiempo_entrega
    FROM Pedido
    WHERE id = @idPedido;

    INSERT INTO ClienteRepartidor(idCliente,idRepartidor,fecha,puntaje,comentario)
    VALUES (@idCliente, @idRepartidor, GETDATE(), 0, '');

    INSERT INTO RepartidorPedido (idRepartidor, idPedido, tiempo_entrega) 
    VALUES (@idRepartidor, @idPedido, @tiempo_entrega);

    INSERT INTO PedidoEstadoPedido(idPedido, idEstadoPedido, fecha_inicio)
    VALUES (@idPedido, 5, GETDATE());

    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;