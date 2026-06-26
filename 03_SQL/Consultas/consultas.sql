USE SolucionesEmpresarialesRD;
GO

/* =========================================================
   CONSULTAS MULTITABLAS
   Base de datos: SolucionesEmpresarialesRD
   ========================================================= */

-- Consulta 1: Ventas con cliente y empleado
SELECT 
    V.VentaID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    E.Nombre + ' ' + E.Apellido AS Empleado,
    V.FechaVenta,
    V.Total,
    V.Estado
FROM Ventas V
INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
INNER JOIN Empleados E ON V.EmpleadoID = E.EmpleadoID;
GO


-- Consulta 2: Detalle completo de cada venta
SELECT 
    V.VentaID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    ISNULL(P.NombreProducto, S.NombreServicio) AS ArticuloOServicio,
    DV.Cantidad,
    DV.PrecioUnitario,
    DV.Subtotal
FROM DetalleVentas DV
INNER JOIN Ventas V ON DV.VentaID = V.VentaID
INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
LEFT JOIN Productos P ON DV.ProductoID = P.ProductoID
LEFT JOIN Servicios S ON DV.ServicioID = S.ServicioID;
GO


-- Consulta 3: Productos con su categoría
SELECT 
    P.ProductoID,
    P.NombreProducto,
    C.NombreCategoria,
    P.Precio,
    P.Stock
FROM Productos P
INNER JOIN Categorias C ON P.CategoriaID = C.CategoriaID;
GO


-- Consulta 4: Ventas realizadas por cada empleado
SELECT 
    E.EmpleadoID,
    E.Nombre + ' ' + E.Apellido AS Empleado,
    COUNT(V.VentaID) AS CantidadVentas,
    ISNULL(SUM(V.Total), 0) AS TotalVendido
FROM Empleados E
LEFT JOIN Ventas V ON E.EmpleadoID = V.EmpleadoID
GROUP BY E.EmpleadoID, E.Nombre, E.Apellido;
GO


-- Consulta 5: Clientes con total comprado
SELECT 
    C.ClienteID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    COUNT(V.VentaID) AS CantidadCompras,
    ISNULL(SUM(V.Total), 0) AS TotalComprado
FROM Clientes C
LEFT JOIN Ventas V ON C.ClienteID = V.ClienteID
GROUP BY C.ClienteID, C.Nombre, C.Apellido;
GO


/* =========================================================
   SUBCONSULTAS
   ========================================================= */

-- Subconsulta 1: Clientes que han comprado más que el promedio de ventas
SELECT 
    C.ClienteID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    SUM(V.Total) AS TotalComprado
FROM Clientes C
INNER JOIN Ventas V ON C.ClienteID = V.ClienteID
GROUP BY C.ClienteID, C.Nombre, C.Apellido
HAVING SUM(V.Total) > (
    SELECT AVG(Total)
    FROM Ventas
);
GO


-- Subconsulta 2: Productos con precio mayor al promedio
SELECT 
    ProductoID,
    NombreProducto,
    Precio
FROM Productos
WHERE Precio > (
    SELECT AVG(Precio)
    FROM Productos
);
GO


-- Subconsulta 3: Empleados que han realizado ventas
SELECT 
    EmpleadoID,
    Nombre,
    Apellido,
    Cargo
FROM Empleados
WHERE EmpleadoID IN (
    SELECT DISTINCT EmpleadoID
    FROM Ventas
);
GO


-- Subconsulta 4: Productos que nunca se han vendido
SELECT 
    ProductoID,
    NombreProducto,
    Stock
FROM Productos
WHERE ProductoID NOT IN (
    SELECT ProductoID
    FROM DetalleVentas
    WHERE ProductoID IS NOT NULL
);
GO


-- Subconsulta 5: Venta de mayor monto
SELECT 
    VentaID,
    ClienteID,
    EmpleadoID,
    FechaVenta,
    Total
FROM Ventas
WHERE Total = (
    SELECT MAX(Total)
    FROM Ventas
);
GO


/* =========================================================
   REPORTES Y CONSULTAS DE VALIDACIÓN
   ========================================================= */

-- Reporte de clientes activos
SELECT 
    ClienteID,
    Nombre,
    Apellido,
    Cedula,
    Telefono,
    Correo,
    Direccion,
    FechaRegistro
FROM Clientes
WHERE Estado = 1;
GO


-- Reporte de empleados activos
SELECT 
    EmpleadoID,
    Nombre,
    Apellido,
    Cargo,
    Departamento,
    Salario,
    FechaIngreso
FROM Empleados
WHERE Estado = 1;
GO


-- Reporte de ventas detalladas
SELECT 
    V.VentaID,
    V.FechaVenta,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    E.Nombre + ' ' + E.Apellido AS Empleado,
    ISNULL(P.NombreProducto, S.NombreServicio) AS Concepto,
    DV.Cantidad,
    DV.PrecioUnitario,
    DV.Subtotal,
    V.Total
FROM Ventas V
INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
INNER JOIN Empleados E ON V.EmpleadoID = E.EmpleadoID
INNER JOIN DetalleVentas DV ON V.VentaID = DV.VentaID
LEFT JOIN Productos P ON DV.ProductoID = P.ProductoID
LEFT JOIN Servicios S ON DV.ServicioID = S.ServicioID
ORDER BY V.VentaID;
GO


-- Productos con stock bajo
SELECT 
    ProductoID,
    NombreProducto,
    Stock
FROM Productos
WHERE Stock <= 5;
GO


-- Ventas completadas
SELECT *
FROM Ventas
WHERE Estado = 'Completada';
GO


-- Total vendido por mes
SELECT 
    YEAR(FechaVenta) AS Anio,
    MONTH(FechaVenta) AS Mes,
    SUM(Total) AS TotalVendido
FROM Ventas
WHERE Estado = 'Completada'
GROUP BY YEAR(FechaVenta), MONTH(FechaVenta)
ORDER BY Anio, Mes;
GO