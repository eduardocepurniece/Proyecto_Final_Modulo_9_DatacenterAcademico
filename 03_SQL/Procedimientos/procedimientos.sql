USE SolucionesEmpresarialesRD;
GO

/* =========================================================
   CREACIÓN DE TABLAS BASE
   Base de datos: SolucionesEmpresarialesRD
   ========================================================= */

IF OBJECT_ID(N'dbo.Clientes', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Clientes (
        ClienteID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(100) NOT NULL,
        Apellido NVARCHAR(100) NOT NULL,
        Cedula VARCHAR(20) NOT NULL UNIQUE,
        Telefono VARCHAR(20),
        Correo NVARCHAR(150) UNIQUE,
        Direccion NVARCHAR(250),
        FechaRegistro DATETIME DEFAULT GETDATE(),
        Estado BIT DEFAULT 1
    );
END;
GO

IF OBJECT_ID(N'dbo.Empleados', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Empleados (
        EmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(100) NOT NULL,
        Apellido NVARCHAR(100) NOT NULL,
        Cedula VARCHAR(20) NOT NULL UNIQUE,
        Cargo NVARCHAR(100) NOT NULL,
        Departamento NVARCHAR(100) NOT NULL,
        Salario DECIMAL(12,2) NOT NULL CHECK (Salario > 0),
        FechaIngreso DATE NOT NULL,
        Estado BIT DEFAULT 1
    );
END;
GO

IF OBJECT_ID(N'dbo.Categorias', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Categorias (
        CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
        NombreCategoria NVARCHAR(100) NOT NULL UNIQUE,
        Descripcion NVARCHAR(250)
    );
END;
GO

IF OBJECT_ID(N'dbo.Productos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Productos (
        ProductoID INT IDENTITY(1,1) PRIMARY KEY,
        NombreProducto NVARCHAR(150) NOT NULL,
        CategoriaID INT NOT NULL,
        Precio DECIMAL(12,2) NOT NULL CHECK (Precio > 0),
        Stock INT NOT NULL CHECK (Stock >= 0),
        Estado BIT DEFAULT 1,

        CONSTRAINT FK_Productos_Categorias
        FOREIGN KEY (CategoriaID) 
        REFERENCES dbo.Categorias(CategoriaID)
    );
END;
GO

IF OBJECT_ID(N'dbo.Servicios', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Servicios (
        ServicioID INT IDENTITY(1,1) PRIMARY KEY,
        NombreServicio NVARCHAR(150) NOT NULL,
        Descripcion NVARCHAR(250),
        Precio DECIMAL(12,2) NOT NULL CHECK (Precio > 0),
        Estado BIT DEFAULT 1
    );
END;
GO

IF OBJECT_ID(N'dbo.Ventas', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Ventas (
        VentaID INT IDENTITY(1,1) PRIMARY KEY,
        ClienteID INT NOT NULL,
        EmpleadoID INT NOT NULL,
        FechaVenta DATETIME DEFAULT GETDATE(),
        Total DECIMAL(12,2) DEFAULT 0 CHECK (Total >= 0),
        Estado NVARCHAR(20) DEFAULT 'Completada',

        CONSTRAINT FK_Ventas_Clientes
        FOREIGN KEY (ClienteID) 
        REFERENCES dbo.Clientes(ClienteID),

        CONSTRAINT FK_Ventas_Empleados
        FOREIGN KEY (EmpleadoID) 
        REFERENCES dbo.Empleados(EmpleadoID),

        CONSTRAINT CK_Ventas_Estado
        CHECK (Estado IN ('Completada', 'Anulada', 'Pendiente'))
    );
END;
GO

IF OBJECT_ID(N'dbo.DetalleVentas', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DetalleVentas (
        DetalleID INT IDENTITY(1,1) PRIMARY KEY,
        VentaID INT NOT NULL,
        ProductoID INT NULL,
        ServicioID INT NULL,
        Cantidad INT NOT NULL CHECK (Cantidad > 0),
        PrecioUnitario DECIMAL(12,2) NOT NULL CHECK (PrecioUnitario > 0),
        Subtotal AS (Cantidad * PrecioUnitario) PERSISTED,

        CONSTRAINT FK_DetalleVentas_Ventas
        FOREIGN KEY (VentaID) 
        REFERENCES dbo.Ventas(VentaID),

        CONSTRAINT FK_DetalleVentas_Productos
        FOREIGN KEY (ProductoID) 
        REFERENCES dbo.Productos(ProductoID),

        CONSTRAINT FK_DetalleVentas_Servicios
        FOREIGN KEY (ServicioID) 
        REFERENCES dbo.Servicios(ServicioID),

        CONSTRAINT CK_DetalleVentas_ProductoOServicio
        CHECK (
            (ProductoID IS NOT NULL AND ServicioID IS NULL)
            OR
            (ProductoID IS NULL AND ServicioID IS NOT NULL)
        )
    );
END;
GO

IF OBJECT_ID(N'dbo.InventarioMovimientos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.InventarioMovimientos (
        MovimientoID INT IDENTITY(1,1) PRIMARY KEY,
        ProductoID INT NOT NULL,
        TipoMovimiento NVARCHAR(20) NOT NULL,
        Cantidad INT NOT NULL CHECK (Cantidad > 0),
        FechaMovimiento DATETIME DEFAULT GETDATE(),
        Descripcion NVARCHAR(250),

        CONSTRAINT FK_InventarioMovimientos_Productos
        FOREIGN KEY (ProductoID) 
        REFERENCES dbo.Productos(ProductoID),

        CONSTRAINT CK_Inventario_TipoMovimiento
        CHECK (TipoMovimiento IN ('Entrada', 'Salida'))
    );
END;
GO

/* =========================================================
   PROCEDIMIENTOS ALMACENADOS
   ========================================================= */

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarCliente
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Cedula VARCHAR(20),
    @Telefono VARCHAR(20),
    @Correo NVARCHAR(150),
    @Direccion NVARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Clientes
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

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarProducto
    @NombreProducto NVARCHAR(150),
    @CategoriaID INT,
    @Precio DECIMAL(12,2),
    @Stock INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Productos
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

CREATE OR ALTER PROCEDURE dbo.sp_ConsultarVentasPorCliente
    @ClienteID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        V.VentaID,
        V.FechaVenta,
        V.Total,
        V.Estado
    FROM dbo.Ventas V
    WHERE V.ClienteID = @ClienteID;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_ActualizarStock
    @ProductoID INT,
    @Cantidad INT,
    @TipoMovimiento NVARCHAR(20),
    @Descripcion NVARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;

    IF @TipoMovimiento = 'Entrada'
    BEGIN
        UPDATE dbo.Productos
        SET Stock = Stock + @Cantidad
        WHERE ProductoID = @ProductoID;

        INSERT INTO dbo.InventarioMovimientos
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
            FROM dbo.Productos
            WHERE ProductoID = @ProductoID
              AND Stock >= @Cantidad
        )
        BEGIN
            UPDATE dbo.Productos
            SET Stock = Stock - @Cantidad
            WHERE ProductoID = @ProductoID;

            INSERT INTO dbo.InventarioMovimientos
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

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarVentaProducto
    @ClienteID INT,
    @EmpleadoID INT,
    @ProductoID INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Precio DECIMAL(12,2);
    DECLARE @VentaID INT;
    DECLARE @StockActual INT;

    SELECT 
        @Precio = Precio,
        @StockActual = Stock
    FROM dbo.Productos
    WHERE ProductoID = @ProductoID;

    IF @Precio IS NULL
    BEGIN
        PRINT 'El producto indicado no existe.';
        RETURN;
    END;

    IF @StockActual >= @Cantidad
    BEGIN
        INSERT INTO dbo.Ventas
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

        INSERT INTO dbo.DetalleVentas
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

        UPDATE dbo.Ventas
        SET Total = (
            SELECT SUM(Subtotal)
            FROM dbo.DetalleVentas
            WHERE VentaID = @VentaID
        )
        WHERE VentaID = @VentaID;

        UPDATE dbo.Productos
        SET Stock = Stock - @Cantidad
        WHERE ProductoID = @ProductoID;

        INSERT INTO dbo.InventarioMovimientos
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

CREATE OR ALTER PROCEDURE dbo.sp_ConsultarProductosStockBajo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ProductoID,
        NombreProducto,
        Precio,
        Stock
    FROM dbo.Productos
    WHERE Stock <= 5;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_ConsultarVentasPorFecha
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        V.VentaID,
        C.Nombre + ' ' + C.Apellido AS Cliente,
        E.Nombre + ' ' + E.Apellido AS Empleado,
        V.FechaVenta,
        V.Total,
        V.Estado
    FROM dbo.Ventas V
    INNER JOIN dbo.Clientes C ON V.ClienteID = C.ClienteID
    INNER JOIN dbo.Empleados E ON V.EmpleadoID = E.EmpleadoID
    WHERE CAST(V.FechaVenta AS DATE) BETWEEN @FechaInicio AND @FechaFin;
END;
GO
