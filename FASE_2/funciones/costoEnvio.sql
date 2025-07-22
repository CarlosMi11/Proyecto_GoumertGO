CREATE FUNCTION costoEnvio(
    @idFactura INT
)
RETURNS FLOAT
AS BEGIN
    DECLARE @COSTE FLOAT;
    SELECT @COSTE = P.costo_envio
    FROM Factura F
    JOIN Pedido P ON F.idPedido = P.id
    WHERE F.numero = @idFactura;
    RETURN @COSTE;
END;