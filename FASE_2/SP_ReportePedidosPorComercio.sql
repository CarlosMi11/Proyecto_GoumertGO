--c)
CREATE PROCEDURE SP_ReportePedidosPorComercio
@idComercio int
AS
BEGIN
    BEGIN TRY

    CREATE TABLE #Reporte (
        totalVentas float,
        cantidadPedidos int,
        fecha date
    );

    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;