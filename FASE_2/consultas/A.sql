WITH TiemposEstado AS (
    SELECT 
        pep.idPedido,
        pep.idEstadoPedido,
        ep.nombre AS NombreEstado,
        ep.tiempo_promedio AS TiempoEstimado,
        DATEDIFF(MINUTE, pep.fecha_inicio, 
                 LEAD(pep.fecha_inicio) OVER (PARTITION BY pep.idPedido ORDER BY pep.fecha_inicio)) AS tiempo_real
    FROM 
        PedidoEstadoPedido pep
    JOIN EstadoPedido ep ON ep.id = pep.idEstadoPedido
)

SELECT 
    NombreEstado,
    COUNT(idPedido) AS veces_usado,
    AVG(tiempo_real) AS tiempo_promedio_real,
    AVG(TiempoEstimado) AS tiempo_promedio_estimado,
    (SUM(CASE WHEN tiempo_real <= TiempoEstimado THEN 1 ELSE 0 END) * 100.0 / COUNT(idPedido)) AS porcentaje_cumplimiento
FROM 
    TiemposEstado
WHERE 
    tiempo_real IS NOT NULL
GROUP BY 
    NombreEstado
ORDER BY 
    porcentaje_cumplimiento DESC;
