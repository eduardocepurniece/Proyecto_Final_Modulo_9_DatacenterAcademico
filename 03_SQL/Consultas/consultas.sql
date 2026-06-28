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
   CONSULTAS MULTITABLAS Y SUBCONSULTAS
   ========================================================= */

-- Ventas con cliente y empleado
SELECT 
    V.VentaID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    E.Nombre + ' ' + E.Apellido AS Empleado,
    V.FechaVenta,
    V.Total,
    V.Estado
FROM dbo.Ventas V
INNER JOIN dbo.Clientes C ON V.ClienteID = C.ClienteID
INNER JOIN dbo.Empleados E ON V.EmpleadoID = E.EmpleadoID;
GO

-- Detalle completo de ventas
SELECT 
    V.VentaID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    ISNULL(P.NombreProducto, S.NombreServicio) AS Concepto,
    DV.Cantidad,
    DV.PrecioUnitario,
    DV.Subtotal
FROM dbo.DetalleVentas DV
INNER JOIN dbo.Ventas V ON DV.VentaID = V.VentaID
INNER JOIN dbo.Clientes C ON V.ClienteID = C.ClienteID
LEFT JOIN dbo.Productos P ON DV.ProductoID = P.ProductoID
LEFT JOIN dbo.Servicios S ON DV.ServicioID = S.ServicioID;
GO

-- Productos con categoría
SELECT 
    P.ProductoID,
    P.NombreProducto,
    C.NombreCategoria,
    P.Precio,
    P.Stock
FROM dbo.Productos P
INNER JOIN dbo.Categorias C ON P.CategoriaID = C.CategoriaID;
GO

-- Ventas por empleado
SELECT 
    E.EmpleadoID,
    E.Nombre + ' ' + E.Apellido AS Empleado,
    COUNT(V.VentaID) AS CantidadVentas,
    ISNULL(SUM(V.Total), 0) AS TotalVendido
FROM dbo.Empleados E
LEFT JOIN dbo.Ventas V ON E.EmpleadoID = V.EmpleadoID
GROUP BY E.EmpleadoID, E.Nombre, E.Apellido;
GO

-- Clientes con total comprado
SELECT 
    C.ClienteID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    COUNT(V.VentaID) AS CantidadCompras,
    ISNULL(SUM(V.Total), 0) AS TotalComprado
FROM dbo.Clientes C
LEFT JOIN dbo.Ventas V ON C.ClienteID = V.ClienteID
GROUP BY C.ClienteID, C.Nombre, C.Apellido;
GO

-- Productos con precio mayor al promedio
SELECT 
    ProductoID,
    NombreProducto,
    Precio
FROM dbo.Productos
WHERE Precio > (
    SELECT AVG(Precio)
    FROM dbo.Productos
);
GO

-- Empleados que han realizado ventas
SELECT 
    EmpleadoID,
    Nombre,
    Apellido,
    Cargo
FROM dbo.Empleados
WHERE EmpleadoID IN (
    SELECT DISTINCT EmpleadoID
    FROM dbo.Ventas
);
GO

-- Productos que nunca se han vendido
SELECT 
    ProductoID,
    NombreProducto,
    Stock
FROM dbo.Productos
WHERE ProductoID NOT IN (
    SELECT ProductoID
    FROM dbo.DetalleVentas
    WHERE ProductoID IS NOT NULL
);
GO

-- Venta de mayor monto
SELECT 
    VentaID,
    ClienteID,
    EmpleadoID,
    FechaVenta,
    Total
FROM dbo.Ventas
WHERE Total = (
    SELECT MAX(Total)
    FROM dbo.Ventas
);
GO
