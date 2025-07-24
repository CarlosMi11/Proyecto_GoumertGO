WITH PlatoConComercioID AS (
    SELECT p.id AS idPlato, p.nombre AS nombrePlato, n.id AS idComercio
    FROM dbo.Comercio AS n
    LEFT JOIN dbo.Menu AS m ON n.id = m.idComercio
    LEFT JOIN dbo.Seccion AS sec ON m.id = sec.idMenu
    LEFT JOIN dbo.Plato AS p ON sec.id = p.idSeccion
), pedidosFromComercios AS (
    SELECT distinct p.id AS idPedido, pc.idComercio AS idComercio
    FROM PlatoConComercioID AS pc
    LEFT JOIN dbo.PedidoDetalle AS pd ON pc.idPlato = pd.idPlato
    LEFT JOIN dbo.Pedido AS p ON pd.idPedido = p.id
), comercioConCocinaPrincipal AS (
    SELECT c.id AS idComercio, 
           MIN(co.nombre) AS nombreCocina
    FROM dbo.Comercio AS c
    JOIN dbo.ComercioCocina AS cc ON c.id = cc.idComercio
    JOIN dbo.Cocina AS co ON cc.idCocina = co.id
    GROUP BY c.id
), comercioConPlatoMasVendido AS (
    SELECT distinct c.id as idComercio, p.nombrePlato AS nombrePlato
           
    FROM dbo.Comercio AS c
    JOIN PlatoConComercioID AS pc ON c.id = pc.idComercio
    LEFT JOIN (
        SELECT * 
        FROM (
            SELECT pc.idComercio, p.nombre AS nombrePlato,
                ROW_NUMBER() OVER (PARTITION BY pc.idComercio, p.nombre ORDER BY SUM(pd.cantidad) DESC) AS rn,
                SUM(pd.cantidad) AS totalVendidos
            -- FROM dbo.PedidoDetalle AS pd
            -- JOIN PlatoConComercioID AS pc ON pd.idPlato = pc.idPlato
            -- JOIN dbo.Plato AS p ON pd.idPlato = p.id
            FROM PlatoConComercioID AS pc
            LEFT JOIN dbo.PedidoDetalle AS pd ON pc.idPlato = pd.idPlato
            JOIN dbo.Plato AS p ON pd.idPlato = p.id
            GROUP BY pc.idComercio, p.nombre
        ) AS d
        WHERE rn = 1
    ) AS p ON c.id = p.idComercio
)

SELECT c.nombre, ccp.nombreCocina AS CocinaPrincipal, 
    case when cpv.nombrePlato IS NULL THEN '' ELSE cpv.nombrePlato END AS PlatoMasVendido,
    case when SUM(fac.monto_total) IS NULL THEN 0 ELSE SUM(fac.monto_total) END AS totalFacturado, 
    CASE 
        WHEN SUM(fac.monto_total) > (
            SELECT AVG(MONTOTOTAL) 
            FROM (
                SELECT SUM(fac.monto_total) AS MONTOTOTAL
                FROM dbo.Factura AS fac
                JOIN pedidosFromComercios AS pfc ON fac.idPedido = pfc.idPedido
                GROUP BY pfc.idComercio
            ) AS subquery2
        ) THEN 'Por encima del promedio'
        ELSE 'Por debajo del promedio'
    END AS comparacionPromedio

FROM dbo.Comercio AS c
JOIN pedidosFromComercios AS pfc ON c.id = pfc.idComercio
LEFT JOIN dbo.Factura AS fac ON pfc.idPedido = fac.idPedido
LEFT JOIN comercioConCocinaPrincipal AS ccp ON c.id = ccp.idComercio
LEFT JOIN comercioConPlatoMasVendido AS cpv ON c.id = cpv.idComercio
GROUP BY c.id, c.nombre, ccp.nombreCocina, cpv.nombrePlato