
WITH PromedioGastoGeneral AS (
    SELECT 
        AVG(p.total * 1.0) AS PromedioGeneral
    FROM 
        Pedido p
    JOIN ClientePedido cp ON p.id = cp.idPedido
    WHERE 
        cp.fecha >= DATEADD(MONTH, -3, GETDATE())
),
PedidosConSeccionesRequeridas AS (
    SELECT 
        cp.idCliente,
        p.id AS idPedido,
        p.total
    FROM 
        Pedido p
    JOIN ClientePedido cp ON p.id = cp.idPedido
    JOIN PedidoDetalle pd ON pd.idPedido = p.id
    JOIN Plato pl ON pl.id = pd.idPlato
    JOIN Seccion s ON s.id = pl.idSeccion
    WHERE 
        cp.fecha >= DATEADD(MONTH, -3, GETDATE())
    GROUP BY 
        cp.idCliente, p.id, p.total
    HAVING 
        COUNT(DISTINCT CASE WHEN s.nombre = 'Principales' THEN s.id END) > 1 AND
        COUNT(DISTINCT CASE WHEN s.nombre = 'Bebidas' THEN s.id END) > 1
),
ClientesConRepartidorMoto AS (
    SELECT DISTINCT
        cp.idCliente
    FROM 
        RepartidorPedido rp
    JOIN Repartidor r ON r.id = rp.idRepartidor
    JOIN Pedido p ON p.id = rp.idPedido
    JOIN ClientePedido as cp ON p.id = cp.idPedido
    WHERE 
        r.detalle_vehiculo LIKE '%Moto%'
        AND cp.fecha >= DATEADD(MONTH, -3, GETDATE())
),
ClientesValidos AS (
    SELECT 
        psr.idCliente,
        COUNT(DISTINCT psr.idPedido) AS CantidadPedidos,
        SUM(psr.total) AS TotalGastado
    FROM 
        PedidosConSeccionesRequeridas psr
    GROUP BY 
        psr.idCliente
    HAVING 
        COUNT(DISTINCT psr.idPedido) >= 3
)

SELECT c.id as ClienteID,c.nombre ++ ' ' ++ c.apellido AS Nombre, cv.CantidadPedidos AS CantidadPedidos, cv.TotalGastado AS TotalGastado, pg.PromedioGeneral AS PromedioGeneral
    FROM 
        ClientesValidos cv
    JOIN Cliente c ON c.id = cv.idCliente
    JOIN ClientesConRepartidorMoto crm ON crm.idCliente = cv.idCliente
    JOIN PromedioGastoGeneral pg ON 1 = 1
    WHERE 
        cv.TotalGastado > pg.PromedioGeneral
ORDER BY TotalGastado DESC;
