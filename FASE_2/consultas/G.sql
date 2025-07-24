WITH comercioConCocinaChina AS (
    SELECT c.id AS idComercio, 
           MIN(co.nombre) AS nombreCocina
    FROM dbo.Comercio AS c
    JOIN dbo.ComercioCocina AS cc ON c.id = cc.idComercio
    JOIN dbo.Cocina AS co ON cc.idCocina = co.id
    WHERE co.nombre = 'China'
    GROUP BY c.id
), comercioConPedido AS (
    SELECT distinct p.id AS idPedido, pc.id AS idComercio
    FROM dbo.Pedido AS p
    JOIN dbo.PedidoDetalle AS pd ON p.id = pd.idPedido
    JOIN dbo.Plato AS pl ON pd.idPlato = pl.id
    JOIN dbo.Seccion AS sec ON pl.idSeccion = sec.id
    JOIN dbo.Menu AS m ON sec.idMenu = m.id
    JOIN dbo.Comercio AS pc ON m.idComercio = pc.id
), comercioCantidadPedidos AS (
    SELECT ccp.idComercio, COUNT(ccp.idPedido) AS cantidadPedidos
    FROM comercioConPedido AS ccp
    GROUP BY ccp.idComercio
)

SELECT c.nombre AS nombreComercio, ccp.cantidadPedidos AS cantidadPedidos, ((c.hora_cierre - c.hora_apertura)*7) AS horasAtencion, ccc.nombreCocina
FROM comercioCantidadPedidos AS ccp
JOIN comercioConCocinaChina AS ccc ON ccp.idComercio = ccc.idComercio
JOIN dbo.Comercio AS c ON ccp.idComercio = c.id
where ccp.cantidadPedidos > 20