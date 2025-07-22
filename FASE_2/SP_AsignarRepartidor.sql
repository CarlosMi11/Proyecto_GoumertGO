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

    SELECT F.numero, RP.idRepartidor as idRepartidor
    INTO #RepartidoresConFacturasHoy
    FROM Factura F
    JOIN RepartidorPedido RP on F.idPedido = RP.idPedido
    WHERE f.fecha_emision = GETDATE()
    
    SELECT R.id as idRepartidorConMenosPedidos, COALESCE(cont.contador, 0) AS contFinal
    FROM Repartidor R
    LEFT JOIN (SELECT idRepartidor, COUNT(idRepartidor) AS contador
                FROM #RepartidoresConFacturasHoy
                GROUP BY idRepartidor) AS cont ON R.id = cont.idRepartidor
    WHERE R.estado = 'Activo'
    GROUP BY R.id
    ORDER BY contFinal ASC;

    SELECT TOP 1 @idRepartidor = idRepartidorConMenosPedidos 
    FROM #RepartidoresconMenosPedidosHoy;

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

    DROP TABLE #RepartidoresConFacturasHoy;

    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;