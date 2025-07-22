CREATE FUNCTION montoIVA(
    @idFactura INT 
)
RETURNS FLOAT
AS BEGIN
    DECLARE @SUBTOTAL FLOAT;

    SELECT @SUBTOTAL = SUM(PD.total)
    FROM Factura F
    JOIN Pedido P ON F.idPedido = P.id
    JOIN PedidoDetalle PD ON P.id = PD.idPedido
    WHERE F.numero = @idFactura
    GROUP BY P.id;

    RETURN @SUBTOTAL * 0.16;
END;