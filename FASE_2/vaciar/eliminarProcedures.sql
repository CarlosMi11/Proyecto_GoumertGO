USE GourmetGo;
GO



EXEC sp_MSforeachtable @command1="ALTER TABLE ? NOCHECK CONSTRAINT ALL"
GO

DROP PROCEDURE dbo.SP_AsignarRepartidor;
DROP PROCEDURE dbo.SP_CrearPedido;
DROP PROCEDURE dbo.SP_RegistrarPlatoEnMenu;
DROP PROCEDURE dbo.SP_ReportePedidosPorComercio;
GO


EXEC sp_MSforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL"
GO