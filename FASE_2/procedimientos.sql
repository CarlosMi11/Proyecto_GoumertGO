--a)
CREATE PROCEDURE SP_CrearPedido
@idCliente int,
@platos_ids VARCHAR(MAX), -- Sintaxis: "5,55,2"
@opciones_ids VARCHAR(MAX),
@opciones_valor_id VARCHAR(MAX),
@cantidades VARCHAR(MAX),
@notaPedidoDetalle varchar(MAX),
@notaPedido varchar(256),
@costo_envio float,
@tiempo_entrega int,
@porcentajeIVA float
AS
BEGIN

    BEGIN TRY
    
    DECLARE @idPedido int;
    DECLARE @idPedidoDetalle int;
    DECLARE @numFactura int;
    DECLARE @total float;
    DECLARE @cantidad_total int;
    DECLARE @hora_apertura int;
    DECLARE @hora_cierre int;
    DECLARE @esta_activo int;

    DECLARE @ids_platos TABLE (id_p int);
    DECLARE @ids_opciones TABLE (id_op int);
    DECLARE @ids_opciones_valor TABLE (id_opv int);
    DECLARE @cantidad_plato TABLE (cantidad int);
    DECLARE @notas TABLE (nota varchar(256));

    INSERT INTO @ids_platos (id_p)
    SELECT value FROM STRING_SPLIT(@platos_ids, ',');
    
    INSERT INTO @ids_opciones (id_op)
    SELECT value FROM STRING_SPLIT(@opciones_ids, ',');

    INSERT INTO @ids_opciones_valor (id_opv)
    SELECT value FROM STRING_SPLIT(@opciones_valor_id, ',');

    INSERT INTO @cantidad_plato (cantidad)
    SELECT value FROM STRING_SPLIT(@cantidades, ',');

    INSERT INTO @notas (nota)
    SELECT value FROM STRING_SPLIT(@notaPedidoDetalle, ',');

    SELECT @idPedido = ISNULL(MAX(id), 0) + 1 
    FROM Pedido;

    INSERT INTO Pedido (id, costo_envio, nota, tiempo_entrega, total)
    VALUES (@idPedido, @costo_envio, @nota_Pedido, @tiempo_entrega, 0);
    

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE id = @idCliente)
        BEGIN
            RAISERROR('Usuario no encontrado', 16, 1);
            ROLLBACK;
            RETURN;
        END

     -- PedidoDetalle(id, cantidad, nota, total, idPedido, idPlato)
    DECLARE @i int = 1;
    DECLARE @cantidad int;
    DECLARE @nota varchar(256);
    DECLARE @idPlato int;
    DECLARE @precio float;
    DECLARE @idOpcion int;
    DECLARE @idOpcionValor int;
    
    WHILE @i <= (SELECT COUNT(*) FROM @ids_platos)
    BEGIN
        -- Obtener Datos
        SELECT @idPlato = id_p FROM @ids_platos WHERE id_p = (SELECT id_p FROM @ids_platos ORDER BY id_p OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);
        SELECT @cantidad = cantidad FROM @cantidad_plato WHERE cantidad = (SELECT cantidad FROM @cantidad_plato ORDER BY cantidad OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);
        SELECT @nota = nota FROM @notas WHERE nota = (SELECT nota FROM @notas ORDER BY nota OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);
        SELECT @idOpcion = id_op FROM @ids_opciones WHERE id_op = (SELECT id_op FROM @ids_opciones ORDER BY id_op OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);
        SELECT @idOpcionValor = id_opv FROM @ids_opciones_valor WHERE id_opv = (SELECT id_opv FROM @ids_opciones_valor ORDER BY id_opv OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);

        SELECT @hora_apertura = C.hora_apertura, @hora_cierre = C.hora_cierre, @esta_activo = C.estaActivo
        FROM Plato P
        JOIN Seccion S on P.idSeccion = S.id
        JOIN Menu M on S.idMenu = M.id
        JOIN Comercio C on M.idComercio = C.id 
        WHERE P.id = @idPlato

        IF NOT EXISTS (SELECT 1 FROM Plato WHERE id = @idPlato)
        BEGIN
            RAISERROR('Plato no encontrado', 16, 1);
            ROLLBACK;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM PlatoOpcion WHERE idOpcion = @idOpcion)
        BEGIN
            RAISERROR('Opcion no encontrada', 16, 1);
            ROLLBACK;
            RETURN;
        END
    
        IF EXISTS (SELECT 1 FROM Plato WHERE cantidadDisponible < @cantidad AND Plato = @idPlato)
            BEGIN
                RAISERROR('Cant. de Plato/s no disponible', 16, 1);
                ROLLBACK;
                RETURN;
            END

        IF (@hora_apertura < DATEPART(HOUR, GETDATE()) OR @hora_cierre > DATEPART(HOUR, GETDATE()) OR @esta_activo = 0)
            BEGIN
                RAISERROR('Comercio no disponible', 16, 1);
                ROLLBACK;
                RETURN;
            END
        
        SELECT @idPedidoDetalle = ISNULL(MAX(id), 0) + 1 
        FROM PedidoDetalle;
        
        -- Precio Plato
        SELECT @precio = precio FROM Plato WHERE id = @idPlato;
        
        SET @total = @total + @precio * @cantidad;
        SET @cantidad_total = @cantidad_total + @cantidad;
        
        -- Insertar en el detalle del pedido
        INSERT INTO PedidoDetalle(id, cantidad, nota, total, idPedido, idPlato)
        VALUES (@idPedidoDetalle, @cantidad, @nota, @precio * @cantidad, @idPedido, @idPlato);

        INSERT INTO PedidoDetalleOpcionValor(idPedidoDetalle, idOpcionValor, idOpcion) 
        VALUES (@idPedidoDetalle, @idOpcionValor, @idOpcion);

        -- Actualizar cantidad de platos
        UPDATE Plato
        SET cantidadDisponible = cantidadDisponible - @cantidad
        WHERE id = @idPlato;
        
        SET @i = @i + 1;
    END;

    --(id, cantidad_items, costo_envio, nota, tiempo_entrega, total)
    UPDATE Pedido
    SET cantidad_items = @cantidad_total, total = @total
    WHERE id = @idPedido;
    
    SELECT @numFactura = ISNULL(MAX(numero), 0) + 1 
    FROM Factura;

    INSERT INTO Factura(numero, fecha_emision, sub_total, porcentajeIva, montoIVA, monto_total, idPedido)
    VALUES (@numFactura, GETDATE(), @total, @porcentajeIVA, @porcentajeIVA*@total/100, @total + (@porcentajeIVA*@total/100), @idPedido);

    INSERT INTO ClientePedido(idCliente, idPedido, fecha)
    VALUES (@idCliente, @idPedido, GETDATE());

    INSERT INTO PedidoEstadoPedido(idPedido, idEstadoPedido, fecha_inicio)
    VALUES (@idPedido, 12, GETDATE());

    END TRY

    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

--b)
