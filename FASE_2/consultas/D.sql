WITH UsuariosReferidos AS(
    SELECT c.id AS id
    FROM Cliente c
    JOIN ClienteConClienteReferido cc ON c.id = cc.idClienteReferido
),
TotalGastado AS (
    SELECT u.id, SUM(case when f.monto_total is NULL then 0 else f.monto_total end) as TotalGastado
    FROM UsuariosReferidos u
    LEFT JOIN ClientePedido cp ON u.id = cp.idCliente
    LEFT JOIN Pedido p ON cp.idPedido = p.id
    LEFT JOIN Factura f ON p.id = f.idPedido
    GROUP BY u.id
), 
GeneradoOtrosReferidos AS (
    SELECT u.id, COUNT(cc.idClienteReferido) AS CantidadReferidos
    FROM UsuariosReferidos u
    JOIN ClienteConClienteReferido cc on u.id = cc.idCliente
    GROUP BY u.id
)
SELECT tg.id AS ClienteID, tg.TotalGastado, case when gr.CantidadReferidos is NULL then 'false' else 'true' end as GeneradoReferidos
FROM TotalGastado tg
LEFT JOIN GeneradoOtrosReferidos AS gr on gr.id = tg.id
ORDER BY tg.id