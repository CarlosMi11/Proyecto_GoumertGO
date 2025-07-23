WITH PlatoConComercioID AS (
    SELECT p.id AS idPlato, p.nombre AS nombrePlato, n.id AS idComercio
    FROM dbo.Plato AS p
    JOIN dbo.Seccion AS sec ON p.idSeccion = sec.id
    JOIN dbo.Menu AS m ON sec.idMenu = m.id
    JOIN dbo.Comercio AS n ON m.idComercio = n.id
), pedidosFromComercios AS (
    SELECT p.id AS idPedido, pc.idComercio AS idComercio
    FROM dbo.Pedido AS p
    JOIN dbo.PedidoDetalle AS pd ON p.id = pd.idPedido
    JOIN PlatoConComercioID AS pc ON pd.idPlato = pc.idPlato
), comercioConCocinaPrincipal AS (
    SELECT c.id AS idComercio, 
           MIN(co.nombre) AS nombreCocina
    FROM dbo.Comercio AS c
    JOIN dbo.ComercioCocina AS cc ON c.id = cc.idComercio
    JOIN dbo.Cocina AS co ON cc.idCocina = co.id
    GROUP BY c.id
), comercioConPlatoMasVendido AS (
    SELECT * 
    FROM (
        SELECT pc.idComercio, p.nombre AS nombrePlato,
            ROW_NUMBER() OVER (PARTITION BY pc.idComercio, p.nombre ORDER BY SUM(pd.cantidad) DESC) AS rn
        FROM dbo.PedidoDetalle AS pd
        JOIN PlatoConComercioID AS pc ON pd.idPlato = pc.idPlato
        JOIN dbo.Plato AS p ON pd.idPlato = p.id
        GROUP BY pc.idComercio, p.nombre
    ) AS subquery
    WHERE rn = 1
)


SELECT c.nombre, SUM(fac.monto_total) AS totalFacturado, 
       ccp.nombreCocina AS nombreCocina, cpv.nombrePlato AS nombrePlatoMasVendido,
        
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
FROM dbo.Factura AS fac
JOIN pedidosFromComercios AS pfc ON fac.idPedido = pfc.idPedido
JOIN dbo.Comercio AS c ON pfc.idComercio = c.id
JOIN comercioConCocinaPrincipal AS ccp ON c.id = ccp.idComercio
JOIN comercioConPlatoMasVendido AS cpv ON c.id = cpv.idComercio
GROUP BY pfc.idComercio, c.nombre, ccp.nombreCocina, cpv.nombrePlato