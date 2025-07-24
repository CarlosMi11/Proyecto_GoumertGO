WITH PlatosConOpcion AS (SELECT p.id, p.nombre AS nombrePlato, STRING_AGG(o.nombre, ', ') AS nombresOpciones
FROM Plato AS p
JOIN PlatoOpcion AS po ON p.id = po.idPlato
JOIN Opcion AS o ON po.idOpcion = o.id
WHERE o.nombre != 'Sin Opcion'
GROUP BY p.id, p.nombre)

SELECT P.nombre, case when pco.nombresOpciones is NULL then 'Sin opciones registradas' else pco.nombresOpciones end AS nombresOpciones
FROM Plato AS P
LEFT JOIN PlatosConOpcion AS pco ON P.id = pco.id
