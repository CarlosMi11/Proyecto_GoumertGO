USE GourmetGo;
GO

-- Eliminar tablas en orden inverso a su creación para evitar problemas de dependencias
DROP TABLE IF EXISTS PedidoEstadoPedido;
DROP TABLE IF EXISTS EstadoPedido;
DROP TABLE IF EXISTS PedidoDetalleOpcionValor;
DROP TABLE IF EXISTS PedidoDetalle;
DROP TABLE IF EXISTS RepartidorPedido;
DROP TABLE IF EXISTS Factura;
DROP TABLE IF EXISTS ClientePedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS ClienteRepartidor;
DROP TABLE IF EXISTS DireccionCliente;
DROP TABLE IF EXISTS Direccion;
DROP TABLE IF EXISTS ClienteConClienteReferido;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Repartidor;
DROP TABLE IF EXISTS PlatoOpcionValor;
DROP TABLE IF EXISTS OpcionValor;
DROP TABLE IF EXISTS PlatoOpcion;
DROP TABLE IF EXISTS Opcion;
DROP TABLE IF EXISTS Plato;
DROP TABLE IF EXISTS Seccion;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS ComercioCocina;
DROP TABLE IF EXISTS Cocina;
DROP TABLE IF EXISTS Comercio;
GO