SELECT 
    r.id AS id_repartidor,
    r.nombre + ' ' + r.apellido AS nombre_repartidor,
    COUNT(DISTINCT rp.idPedido) AS total_pedidos_asignados,
    AVG(cr.puntaje) AS promedio_puntaje,
    AVG(rp.tiempo_entrega) AS tiempo_promedio_entrega_exitosos
FROM 
    Repartidor r
LEFT JOIN RepartidorPedido rp ON r.id = rp.idRepartidor
LEFT JOIN ClienteRepartidor cr ON cr.idRepartidor = r.id AND cr.idCliente = rp.idCliente
LEFT JOIN PedidoEstadoPedido pep ON pep.idPedido = rp.idPedido
LEFT JOIN EstadoPedido ep ON pep.idEstadoPedido = ep.id
WHERE 
    ep.nombre = 'Entregado'  
GROUP BY 
    r.id, r.nombre, r.apellido
ORDER BY 
    total_pedidos_asignados DESC;
