CREATE PROCEDURE SP_CrearPedido
@idCliente int,
@idPlato int,
@idPlatoOpcion int,
@cantidad_items int,
@costo_envio float,
@tiempo_entrega int,
@total float,
@notaPedido varchar(256),
@notaPedidoDetalle varchar(256)
AS
BEGIN
    BEGIN TRANSACTION;
    DECLARE @idPedido int;

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
    IF NOT EXISTS (SELECT 1 FROM Plato WHERE id = @idPlato)
        BEGIN
            RAISERROR('Plato no encontrado', 16, 1);
            ROLLBACK;
            RETURN;
        END
    
    SELECT @idPedido = ISNULL(MAX(id), 0) + 1 FROM Pedido

    END TRY

    BEGIN CATCH

    END CATCH
END;