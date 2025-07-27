USE GourmetGo;
GO



EXEC sp_MSforeachtable @command1="ALTER TABLE ? NOCHECK CONSTRAINT ALL"
GO

DROP TRIGGER dbo.manejar_devolucion;
DROP TRIGGER dbo.registrar_opciones;
DROP TRIGGER dbo.validar_cantidad;
DROP TRIGGER dbo.poblar_factura;
DROP TRIGGER dbo.registrar_referido;
DROP TRIGGER dbo.registrar_entrega;

GO


EXEC sp_MSforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL"
GO