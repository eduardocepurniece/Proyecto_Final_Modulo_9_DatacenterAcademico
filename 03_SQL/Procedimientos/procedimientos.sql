USE SolucionesEmpresarialesRD;
GO

/* =========================================================
   PROCEDIMIENTOS ALMACENADOS
   Base de datos: SolucionesEmpresarialesRD
   ========================================================= */

-- Procedimiento 1: Registrar cliente
CREATE PROCEDURE sp_RegistrarCliente
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Cedula VARCHAR(20),
    @Telefono VARCHAR(20),
    @Correo NVARCHAR(150),
    @Direccion NVARCHAR(250)
AS
BEGIN
    INSERT INTO Clientes
    (
        Nombre, 
        Apellido, 
        Cedula, 
        Telefono, 
        Correo, 
        Direccion
    )
    VALUES
    (
        @Nombre, 
        @Apellido, 
        @Cedula, 
        @Telefono, 
        @Correo, 
        @Direccion
    );
END;
GO


-- Procedimiento 2: Registrar producto
CREATE PROCEDURE sp_RegistrarProducto
    @NombreProducto NVARCHAR(150),
    @CategoriaID INT,
    @Precio DECIMAL(12,2),
    @Stock INT
AS
BEGIN
    INSERT INTO Productos
    (
        NombreProducto, 
        CategoriaID, 
        Precio, 
        Stock
    )
    VALUES
    (
        @NombreProducto, 
        @CategoriaID, 
        @Precio, 
        @Stock
    );
END;
GO


-- Procedimiento 3: Consultar ventas por cliente
CREATE PROCEDURE sp_ConsultarVentasPorCliente
    @ClienteID INT
AS
BEGIN
    SELECT 
        V.VentaID,
        V.FechaVenta,
        V.Total,
        V.Estado
    FROM Ventas V
    WHERE V.ClienteID = @ClienteID;
END;
GO


-- Procedimiento 4: Actualizar stock de producto
CREATE PROCEDURE sp_ActualizarStock
    @ProductoID INT,
    @Cantidad INT,
    @TipoMovimiento NVARCHAR(20),
    @Descripcion NVARCHAR(250)
AS
BEGIN
    IF @TipoMovimiento = 'Entrada'
    BEGIN
        UPDATE Productos
        SET Stock = Stock + @Cantidad
        WHERE ProductoID = @ProductoID;

        INSERT INTO InventarioMovimientos
        (
            ProductoID, 
            TipoMovimiento, 
            Cantidad, 
            Descripcion
        )
        VALUES
        (
            @ProductoID, 
            @TipoMovimiento, 
            @Cantidad, 
            @Descripcion
        );
    END
    ELSE IF @TipoMovimiento = 'Salida'
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM Productos
            WHERE ProductoID = @ProductoID
              AND Stock >= @Cantidad
        )
        BEGIN
            UPDATE Productos
            SET Stock = Stock - @Cantidad
            WHERE ProductoID = @ProductoID;

            INSERT INTO InventarioMovimientos
            (
                ProductoID, 
                TipoMovimiento, 
                Cantidad, 
                Descripcion
            )
            VALUES
            (
                @ProductoID, 
                @TipoMovimiento, 
                @Cantidad, 
                @Descripcion
            );
        END
        ELSE
        BEGIN
            PRINT 'No hay suficiente stock para realizar la salida.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Tipo de movimiento inválido. Use Entrada o Salida.';
    END
END;
GO


-- Procedimiento 5: Registrar venta de producto
CREATE PROCEDURE sp_RegistrarVentaProducto
    @ClienteID INT,
    @EmpleadoID INT,
    @ProductoID INT,
    @Cantidad INT
AS
BEGIN
    DECLARE @Precio DECIMAL(12,2);
    DECLARE @VentaID INT;
    DECLARE @StockActual INT;

    SELECT 
        @Precio = Precio,
        @StockActual = Stock
    FROM Productos
    WHERE ProductoID = @ProductoID;

    IF @StockActual >= @Cantidad
    BEGIN
        INSERT INTO Ventas
        (
            ClienteID, 
            EmpleadoID, 
            Estado
        )
        VALUES
        (
            @ClienteID, 
            @EmpleadoID, 
            'Completada'
        );

        SET @VentaID = SCOPE_IDENTITY();

        INSERT INTO DetalleVentas
        (
            VentaID, 
            ProductoID, 
            ServicioID,
            Cantidad, 
            PrecioUnitario
        )
        VALUES
        (
            @VentaID, 
            @ProductoID, 
            NULL,
            @Cantidad, 
            @Precio
        );

        UPDATE Ventas
        SET Total = (
            SELECT SUM(Subtotal)
            FROM DetalleVentas
            WHERE VentaID = @VentaID
        )
        WHERE VentaID = @VentaID;

        UPDATE Productos
        SET Stock = Stock - @Cantidad
        WHERE ProductoID = @ProductoID;

        INSERT INTO InventarioMovimientos
        (
            ProductoID, 
            TipoMovimiento, 
            Cantidad, 
            Descripcion
        )
        VALUES
        (
            @ProductoID, 
            'Salida', 
            @Cantidad, 
            'Venta de producto'
        );
    END
    ELSE
    BEGIN
        PRINT 'No hay suficiente stock para realizar la venta.';
    END
END;
GO


-- Procedimiento 6: Consultar productos con stock bajo
CREATE PROCEDURE sp_ConsultarProductosStockBajo
AS
BEGIN
    SELECT 
        ProductoID,
        NombreProducto,
        Precio,
        Stock
    FROM Productos
    WHERE Stock <= 5;
END;
GO


-- Procedimiento 7: Consultar ventas por rango de fechas
CREATE PROCEDURE sp_ConsultarVentasPorFecha
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT 
        V.VentaID,
        C.Nombre + ' ' + C.Apellido AS Cliente,
        E.Nombre + ' ' + E.Apellido AS Empleado,
        V.FechaVenta,
        V.Total,
        V.Estado
    FROM Ventas V
    INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
    INNER JOIN Empleados E ON V.EmpleadoID = E.EmpleadoID
    WHERE CAST(V.FechaVenta AS DATE) BETWEEN @FechaInicio AND @FechaFin;
END;
GO