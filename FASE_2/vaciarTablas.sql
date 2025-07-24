USE GourmetGo;
GO

-- 1. Deshabilitar todas las restricciones FOREIGN KEY y CHECK en todas las tablas
-- Esto permite que los DELETE se ejecuten sin violar la integridad referencial.
EXEC sp_MSforeachtable @command1="ALTER TABLE ? NOCHECK CONSTRAINT ALL"
GO

-- 2. Vaciar las tablas en el orden correcto (o en cualquier orden, ya que las restricciones están deshabilitadas)
-- Es recomendable empezar por las tablas "hijas" para evitar problemas de referencias,
-- aunque con las restricciones deshabilitadas, el orden es menos crítico.

DELETE FROM ClienteConClienteReferido;
DELETE FROM ClientePedido;
DELETE FROM ClienteRepartidor;
DELETE FROM PedidoDetalleOpcionValor;
DELETE FROM OpcionValor;
DELETE FROM PlatoOpcionValor;
DELETE FROM PlatoOpcion;
DELETE FROM PedidoDetalle;
DELETE FROM PedidoEstadoPedido;
DELETE FROM Pedido;
DELETE FROM RepartidorPedido;
DELETE FROM Repartidor;
DELETE FROM DireccionCliente;
DELETE FROM Direccion;
DELETE FROM Factura;
DELETE FROM EstadoPedido;
DELETE FROM Cliente;
DELETE FROM Plato;
DELETE FROM Seccion;
DELETE FROM Menu;
DELETE FROM ComercioCocina;
DELETE FROM Cocina;
DELETE FROM Comercio;
DELETE FROM Opcion; -- Asegúrate de que esta tabla se vacíe si es referenciada por OpcionValor

GO

-- 3. Reactivar todas las restricciones FOREIGN KEY y CHECK en todas las tablas
-- La cláusula 'WITH CHECK' es crucial: verifica los datos existentes y marca la restricción como confiable.
EXEC sp_MSforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL"
GO

PRINT 'Todas las tablas han sido vaciadas y las restricciones reactivadas.';