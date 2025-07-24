WITH PlatoConComercioID AS (
    SELECT p.id AS idPlato, p.nombre AS nombrePlato, n.id AS idComercio
    FROM dbo.Comercio AS n
    LEFT JOIN dbo.Menu AS m ON n.id = m.idComercio
    LEFT JOIN dbo.Seccion AS sec ON m.id = sec.idMenu
    LEFT JOIN dbo.Plato AS p ON sec.id = p.idSeccion
)
    SELECT distinct p.id AS idPedido, pc.idComercio AS idComercio
    FROM PlatoConComercioID AS pc
    LEFT JOIN dbo.PedidoDetalle AS pd ON pc.idPlato = pd.idPlato
    LEFT JOIN dbo.Pedido AS p ON pd.idPedido = p.id