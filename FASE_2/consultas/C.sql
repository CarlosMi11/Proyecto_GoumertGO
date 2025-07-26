WITH PedidosValidos AS (
    SELECT 
        cp.idCliente,
        p.id AS idPedido,
        p.total,
        COUNT(DISTINCT pd.idPlato) AS platos_distintos,
        COUNT(DISTINCT s.id) AS secciones_distintas
    FROM 
        ClientePedido cp
    JOIN Pedido p ON cp.idPedido = p.id
    JOIN PedidoEstadoPedido pep ON p.id = pep.idPedido
    JOIN EstadoPedido ep ON pep.idEstadoPedido = ep.id
    JOIN PedidoDetalle pd ON p.id = pd.idPedido
    JOIN Plato pl ON pd.idPlato = pl.id
    JOIN Seccion s ON pl.idSeccion = s.id
    WHERE 
        cp.fecha >= DATEADD(MONTH, -6, GETDATE())  
        AND ep.nombre = 'Entregado' 
    GROUP BY cp.idCliente, p.id, p.total
    HAVING 
        COUNT(DISTINCT pd.idPlato) >= 2 AND
        COUNT(DISTINCT s.id) >= 2
),
ClientesConPedidosValidos AS (
    SELECT 
        idCliente,
        COUNT(*) AS cantidad_pedidos,
        SUM(total) AS total_gastado
    FROM 
        PedidosValidos
    GROUP BY 
        idCliente
    HAVING 
        COUNT(*) >= 4
),
RepartidoresCalificados AS (
    SELECT 
        cr.idCliente,
        cr.idRepartidor,
        AVG(cr.puntaje) AS promedio_puntaje
    FROM 
        ClienteRepartidor cr
    WHERE 
        cr.fecha >= DATEADD(MONTH, -6, GETDATE())
        AND cr.puntaje >= 4
    GROUP BY 
        cr.idCliente, cr.idRepartidor
),
RepartidorTopCliente AS (
    SELECT 
        rc.idCliente,
        r.id AS idRepartidor,
        r.nombre ++ ' ' ++ r.apellido AS nombre_repartidor,
        rc.promedio_puntaje,
        ROW_NUMBER() OVER (PARTITION BY rc.idCliente ORDER BY rc.promedio_puntaje DESC) AS rn
    FROM 
        RepartidoresCalificados rc
    JOIN Repartidor r ON rc.idRepartidor = r.id
)

SELECT c.id AS ClienteID, c.nombre ++ ' ' ++ c.apellido AS nombre_cliente, cpv.cantidad_pedidos as CantidadPedidos, cpv.total_gastado AS TotalGastado, rtc.nombre_repartidor AS RepartidorMejorPuntuado, rtc.idRepartidor
FROM 
    ClientesConPedidosValidos cpv
JOIN Cliente c ON cpv.idCliente = c.id
JOIN RepartidorTopCliente rtc ON cpv.idCliente = rtc.idCliente AND rtc.rn = 1
ORDER BY TotalGastado DESC
