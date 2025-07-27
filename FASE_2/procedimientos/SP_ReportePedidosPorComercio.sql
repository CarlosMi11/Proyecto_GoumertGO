--c)
CREATE PROCEDURE SP_ReportePedidosPorComercio
@idComercio int
AS
BEGIN
    BEGIN TRY

    CREATE TABLE #Reporte (
        cantidadPedidos int,
        totalEnVentas float,
        pedidosFav varchar(256),
        fecha date
    );

    CREATE TABLE #PlatosMasSolicitados (
        id int,
        fecha date,
        conteo int,
        rank int,
        idComercio int
    );

    WITH PlatosSolicitados AS (
        SELECT Pl.id as idPlato, F.fecha_emision as fecha, COUNT(*) as cont, C.id as idComercio
        FROM Comercio C
        JOIN Menu M on C.id = M.idComercio
        JOIN Seccion S on M.id = S.idMenu
        JOIN Plato Pl on S.id = Pl.idSeccion
        JOIN PedidoDetalle PD on Pl.id = PD.idPlato
        JOIN Factura F on PD.idPedido = F.idPedido
        WHERE C.id = @idComercio
        Group by F.fecha_emision, Pl.id, C.id
    ), Rank AS (
        SELECT idPlato, fecha, cont, ROW_NUMBER() OVER (PARTITION BY fecha ORDER BY cont DESC, idPlato) AS ranking, idComercio
        FROM PlatosSolicitados
    )
    INSERT INTO #PlatosMasSolicitados
    SELECT idPlato, fecha, cont, ranking, idComercio
    FROM Rank
    WHERE ranking <= 3;

    INSERT INTO #Reporte
    SELECT 
        COUNT(*),
        SUM(F.monto_total),
        LTRIM(
            ISNULL(MAX(CASE WHEN PMS.rank = 1 THEN Pl.nombre ELSE '' END), '') + ' ' +
            ISNULL(MAX(CASE WHEN PMS.rank = 2 THEN Pl.nombre ELSE '' END), '') + ' ' +
            ISNULL(MAX(CASE WHEN PMS.rank = 3 THEN Pl.nombre ELSE '' END), '')
        ) AS platos_top,
        PMS.fecha
    FROM #PlatosMasSolicitados PMS
    JOIN Comercio C on PMS.idComercio = C.id
    JOIN Plato Pl on PMS.id = Pl.id
    JOIN PedidoDetalle PD on Pl.id = PD.idPlato
    JOIN Factura F on PD.idPedido = F.idPedido
    WHERE PMS.idComercio = @idComercio
    GROUP BY F.fecha_emision, pms.fecha

    SELECT 
        cantidadPedidos as 'Cantidad de Pedidos',
        totalEnVentas as 'Total en Ventas',
        pedidosFav as 'Pedidos Mas Solicitados',
        fecha
    FROM #Reporte
    ORDER BY fecha;

    DROP TABLE #Reporte;
    DROP TABLE #PlatosMasSolicitados;

    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;