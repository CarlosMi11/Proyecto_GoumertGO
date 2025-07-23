SELECT p.id as idPedido, pl.id AS idPlato, pl.nombre AS nombrePlato, pd.cantidad as cantidad, pl.precio AS precioPlato, f.sub_total AS subTotal, f.monto_total AS montoTotal
    FROM dbo.pedido AS p
    JOIN dbo.PedidoDetalle AS pd ON p.id = pd.idPedido
    JOIN dbo.Plato AS pl ON pd.idPlato = pl.id
    JOIN dbo.Factura AS f ON p.id = f.idPedido
    WHERE p.id = 82 OR p.id = 120;