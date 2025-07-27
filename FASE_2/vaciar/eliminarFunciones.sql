USE GourmetGo;
GO



EXEC sp_MSforeachtable @command1="ALTER TABLE ? NOCHECK CONSTRAINT ALL"
GO

DROP FUNCTION dbo.costoEnvio;
DROP FUNCTION dbo.montoIVA;
DROP FUNCTION dbo.montoTotal;
DROP FUNCTION dbo.subTotal;

GO


EXEC sp_MSforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL"
GO