WITH 
pizzas AS (
    SELECT * 
    FROM Plato AS p
    where p.nombre LIKE '%Pizza%'
),
comerciosConPlatoPizza AS (
    SELECT c.id AS idComercio, c.nombre AS nombreComercio, p.id AS idPlato,
           p.nombre AS nombrePlato
    FROM Comercio AS c
    JOIN Menu AS m on m.idComercio = c.id
    JOIN Seccion AS s ON s.idMenu = m.id
    JOIN pizzas AS p ON p.idSeccion = s.id
), ventasPizza AS (
    SELECT p.id AS idPlato, case when SUM(pd.cantidad) IS NULL then 0 else SUM(pd.cantidad) end AS cantidadVentas
    FROM pizzas AS p
    LEFT JOIN PedidoDetalle AS pd ON pd.idPlato = p.id
    GROUP BY p.id, p.nombre
)

SELECT *
FROM comerciosConPlatoPizza AS cp
JOIN ventasPizza AS vp ON cp.idPlato = vp.idPlato
GROUP BY cp.idComercio, cp.nombreComercio