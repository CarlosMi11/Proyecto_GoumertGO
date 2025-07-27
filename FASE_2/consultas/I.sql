WITH 
pizzas AS (
    SELECT * 
    FROM Plato AS p
    where p.nombre LIKE '%Pizza%'
),
DireccionesPedidosPizza AS (
    SELECT d.municipio AS municipio,
            p.id AS idPlato,
            p.nombre AS nombrePlato,
            SUM(pd.cantidad) AS cantidadVentas     
    FROM pizzas AS p
    JOIN PedidoDetalle AS pd ON pd.idPlato = p.id
    JOIN Pedido AS pdo ON pd.idPedido = pdo.id
    JOIN ClientePedido AS cp ON pdo.id = cp.idPedido
    JOIN Cliente AS c ON cp.idCliente = c.id
    JOIN DireccionCliente AS dc ON c.id = dc.idCliente
    JOIN Direccion AS d ON dc.idDireccion = d.id
    GROUP BY d.municipio, p.id, p.nombre
),
ventasPizzaPorMunicipio AS (
    SELECT municipio, SUM(cantidadVentas) AS cantidadVentas
    FROM DireccionesPedidosPizza
    GROUP BY municipio
    
),
comerciosConPlatoPizza AS (
    SELECT c.id AS idComercio, c.nombre AS nombreComercio, p.id AS idPlato,
           p.nombre AS nombrePlato
    FROM Comercio AS c
    JOIN Menu AS m on m.idComercio = c.id
    JOIN Seccion AS s ON s.idMenu = m.id
    JOIN pizzas AS p ON p.idSeccion = s.id
)

--Esto muestra las ventas de cada plato de pizza en cada municipio, junto con el nombre del comercio, agrupados por municipio y los municipios ordenados por cantidad de ventas totales en el municipio.

SELECT dp.municipio AS municipio, 
       dp.nombrePlato AS nombrePlato, 
       cp.nombreComercio AS nombreComercio, 
       dp.cantidadVentas AS cantidadVentas
FROM ventasPizzaPorMunicipio AS vp
JOIN DireccionesPedidosPizza AS dp ON dp.municipio = vp.municipio
JOIN comerciosConPlatoPizza AS cp ON cp.idPlato = dp.idPlato
ORDER BY cantidadVentas ASC
