WITH ClienteconPedido AS (
    SELECT c.id AS idCliente, COUNT(p.id) AS cantidadPedidos
    FROM dbo.Cliente AS c
    LEFT JOIN dbo.ClientePedido AS cp ON c.id = cp.idCliente
    LEFT JOIN dbo.Pedido AS p ON cp.idPedido = p.id
    GROUP BY c.id
),
ClienteCantidadOpciones AS (
    SELECT c.id AS idCliente, COUNT(o.id) AS cantidadOpciones
    FROM dbo.Cliente AS c
    JOIN dbo.ClientePedido AS cp ON c.id = cp.idCliente
    JOIN dbo.Pedido AS p ON cp.idPedido = p.id
    JOIN dbo.PedidoDetalle AS pd ON p.id = pd.idPedido
    JOIN dbo.PedidoDetalleOpcionValor AS pdov ON pd.id = pdov.idPedidoDetalle
    JOIN dbo.Opcion AS o ON pdov.idOpcion = o.id
    GROUP BY c.id, c.nombre
)

SELECT cp.idCliente AS idCliente, (c.nombre ++ ' ' ++ c.apellido) as NombreCompleto, cp.cantidadPedidos AS cantidadPedidos, 
    case when cco.cantidadOpciones is NULL then 0 else cco.cantidadOpciones end as cantidadOpciones, 
    case when cantidadPedidos = 0 then 0 else (case when cco.cantidadOpciones is NULL then 0 else cco.cantidadOpciones end) / cantidadPedidos end as promedioOpcionesPorPedido 
from ClienteconPedido AS cp
JOIN Cliente as c on c.id = cp.idCliente
LEFT JOIN ClienteCantidadOpciones AS cco ON cp.idCliente = cco.idCliente
