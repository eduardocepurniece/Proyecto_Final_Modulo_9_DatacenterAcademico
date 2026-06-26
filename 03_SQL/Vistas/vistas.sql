USE SolucionesEmpresarialesRD;
GO

/* =========================================================
   VISTAS
   Base de datos: SolucionesEmpresarialesRD
   ========================================================= */

-- Vista 1: Vista general de ventas
CREATE VIEW vw_VentasGenerales
AS
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


-- Vista 2: Inventario de productos
CREATE VIEW vw_InventarioProductos
AS
SELECT 
    P.ProductoID,
    P.NombreProducto,
    C.NombreCategoria,
    P.Precio,
    P.Stock,
    CASE 
        WHEN P.Stock = 0 THEN 'Agotado'
        WHEN P.Stock <= 5 THEN 'Stock Bajo'
        ELSE 'Disponible'
    END AS EstadoInventario
FROM Productos P
INNER JOIN Categorias C ON P.CategoriaID = C.CategoriaID;
GO


-- Vista 3: Detalle de ventas
CREATE VIEW vw_DetalleVentas
AS
SELECT 
    V.VentaID,
    V.FechaVenta,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    ISNULL(P.NombreProducto, S.NombreServicio) AS Concepto,
    DV.Cantidad,
    DV.PrecioUnitario,
    DV.Subtotal
FROM DetalleVentas DV
INNER JOIN Ventas V ON DV.VentaID = V.VentaID
INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
LEFT JOIN Productos P ON DV.ProductoID = P.ProductoID
LEFT JOIN Servicios S ON DV.ServicioID = S.ServicioID;
GO


-- Vista 4: Productos por categoría
CREATE VIEW vw_ProductosPorCategoria
AS
SELECT 
    P.ProductoID,
    P.NombreProducto,
    C.NombreCategoria,
    P.Precio,
    P.Stock,
    P.Estado
FROM Productos P
INNER JOIN Categorias C ON P.CategoriaID = C.CategoriaID;
GO


-- Vista 5: Resumen de ventas por cliente
CREATE VIEW vw_ResumenVentasPorCliente
AS
SELECT 
    C.ClienteID,
    C.Nombre + ' ' + C.Apellido AS Cliente,
    COUNT(V.VentaID) AS CantidadVentas,
    ISNULL(SUM(V.Total), 0) AS TotalComprado
FROM Clientes C
LEFT JOIN Ventas V ON C.ClienteID = V.ClienteID
GROUP BY C.ClienteID, C.Nombre, C.Apellido;
GO