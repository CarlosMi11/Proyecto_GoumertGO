CREATE FUNCTION montoTotal(
    @idFactura INT 
)
RETURNS FLOAT
AS BEGIN
    DECLARE @SUBTOTAL FLOAT;
    DECLARE @IVA FLOAT;
    DECLARE @COSTEENVIO FLOAT;

    SET @SUBTOTAL = dbo.subTotal(@idFactura);
    SET @IVA = dbo.montoIVA(@idFactura);
    SET @COSTEENVIO = dbo.costoEnvio(@idFactura);
    RETURN @SUBTOTAL + @IVA + @COSTEENVIO;
END;