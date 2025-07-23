SELECT p.id AS idPlato, p.nombre AS nombrePlato, n.id AS idComercio, n.nombre AS nombreComercio
    FROM dbo.Plato AS p
    JOIN dbo.Seccion AS sec ON p.idSeccion = sec.id
    JOIN dbo.Menu AS m ON sec.idMenu = m.id
    JOIN dbo.Comercio AS n ON m.idComercio = n.id
    WHERE p.id = 87 OR p.id = 106;