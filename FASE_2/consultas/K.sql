WITH TotalMensualUltimosDoceMeses AS (
    SELECT YEAR(f.fecha_emision) AS Anio, MONTH(f.fecha_emision) AS Mes, SUM(f.monto_total) AS Total
    FROM Factura AS f
    WHERE f.fecha_emision BETWEEN DATEADD(MONTH, -12, GETDATE()) AND GETDATE()
    GROUP BY YEAR(f.fecha_emision), MONTH(f.fecha_emision)
), TotalAnioAnterior AS (
    SELECT SUM(Total) AS Total
    FROM (
        SELECT YEAR(f.fecha_emision) AS Anio, MONTH(f.fecha_emision) AS Mes, SUM(f.monto_total) AS Total
        FROM Factura AS f
        WHERE f.fecha_emision BETWEEN DATEADD(MONTH, -24, GETDATE()) AND DATEADD(MONTH, -12, GETDATE())
        GROUP BY YEAR(f.fecha_emision), MONTH(f.fecha_emision)
    ) AS s 
),
Variacion AS (
    SELECT 
        ( 
            (
                (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) -  
                ( (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) * (1 + (((SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) - (SELECT Total FROM         TotalAnioAnterior)) / (SELECT Total FROM TotalAnioAnterior)) ) )
            ) / 
            ( 
                (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) * (1 + (((SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) - (SELECT Total FROM       TotalAnioAnterior)) / (SELECT Total FROM TotalAnioAnterior)) ) 
            )
        ) * 100
    AS VariacionPorcentual
)

SELECT AVG(Total) AS PromedioMensual, SUM(Total) AS TotalUltimoAnio, AVG(Total) * 12 AS ProyeccionSiguientes12meses, 
       (SELECT VariacionPorcentual FROM Variacion) AS VariacionPorcentual
FROM TotalMensualUltimosDoceMeses;

-- ingreso total ultimo anio : (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses)
-- ingreso total penultimo anio : (SELECT Total FROM TotalAnioAnterior)
-- tasa de crecimiento historica: (((SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) - (SELECT Total FROM TotalAnioAnterior)) / (SELECT Total FROM TotalAnioAnterior))

-- tendencia de crecimiento: ( (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) * (1 + (((SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) - (SELECT Total FROM TotalAnioAnterior)) / (SELECT Total FROM TotalAnioAnterior)) )

-- Variacion Porcentual: 
        -- ( 
        --     (
        --         (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) -  
        --         ( (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) * (1 + (((SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) - (SELECT Total FROM         TotalAnioAnterior)) / (SELECT Total FROM TotalAnioAnterior)) ) )
        --     ) / 
        --     ( 
        --         (SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) * (1 + (((SELECT SUM(Total) FROM TotalMensualUltimosDoceMeses) - (SELECT Total FROM       TotalAnioAnterior)) / (SELECT Total FROM TotalAnioAnterior)) ) 
        --     )
        -- ) * 100