--d)
CREATE PROCEDURE SP_RegistrarPlatoEnMenu
@idMenu int,
@idComercio int,
@nombre varchar(256),
@precio float,
@descripcion varchar(256),
@cantidadDisponible int,
@orden int,
@opcionesPersonalizables varchar(MAX) -- Sintaxis: "5,55,2"
AS
BEGIN
    BEGIN TRY

    DECLARE @idPlato int;
    DECLARE @seccionValida int;
    DECLARE @cont int;
    DECLARE @i int = 1;
    DECLARE @idOpcion int;
    DECLARE @ids_opciones TABLE (id_op int);

    INSERT INTO @ids_opciones (id_op)
    SELECT value FROM STRING_SPLIT(@opcionesPersonalizables, ',');

    IF NOT EXISTS (SELECT 1 FROM Comercio WHERE id = @idComercio AND estaActivo = 1)
    BEGIN
        RAISERROR('Comercio inactivo', 16, 1)
        ROLLBACK;
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Menu WHERE id = @idMenu)
    BEGIN
        RAISERROR('Menu no existente', 16, 1)
        ROLLBACK;
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Menu WHERE idComercio = @idComercio)
    BEGIN
        RAISERROR('El menu no pertenece al comercio', 16, 1)
        ROLLBACK;
        RETURN;
    END

    SELECT @idPlato = ISNULL(MAX(id), 0) + 1 
    FROM Plato;

    --Se elige la seccion con menos platos arbitrariamente
    SELECT TOP 1 @cont = COUNT(P.id), @seccionValida = S.id
    FROM Menu M
    JOIN Comercio C on M.idComercio = C.id
    JOIN Seccion S on M.id = S.idMenu
    JOIN Plato P on S.id = P.idSeccion
    WHERE M.id = @idMenu AND C.id = @idComercio
    GROUP BY S.id
    ORDER BY @cont

    INSERT INTO Plato(id, nombre, orden, cantidadDisponible, precio, descripcion, idSeccion)
    VALUES(@idPlato, @nombre, @orden, @cantidadDisponible, @precio, @descripcion, @seccionValida);


    WHILE @i <= (SELECT COUNT(*) FROM @ids_opciones)
    BEGIN
        -- Obtener Opciones
        SELECT @idOpcion = id_op FROM @ids_opciones WHERE id_op = (SELECT id_op FROM @ids_opciones ORDER BY id_op OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);

        IF NOT EXISTS (SELECT 1 FROM Opcion WHERE id = @idOpcion)
        BEGIN
            RAISERROR('Opcion/es no encontrado', 16, 1);
            ROLLBACK;
            RETURN;
        END
        
        --Insertar Plato Opcion
        INSERT INTO PlatoOpcion(idPlato, idOpcion)
        VALUES(@idPlato, @idOpcion)
        
        SET @i = @i + 1;
    END;
    
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;