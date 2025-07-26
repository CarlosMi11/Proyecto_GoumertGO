WITH PedidosUltimos6Meses AS (
    SELECT cp.idPedido as idPedido, cp.idCliente as idCliente
    FROM ClientePedido as cp 
    WHERE cp.fecha BETWEEN DATEADD(MONTH, -6, GETDATE()) AND GETDATE()
    
),
ClientesHanPedido4enlos6 AS (
    SELECT pu.idCliente
    FROM PedidosUltimos6Meses as pu
    GROUP BY pu.idCliente
    HAVING COUNT(idPedido) >= 4
)


SELECT *
FROM PedidosUltimos6Meses