/*
=======================================================================
  EQUIPO #5 - QA (CONTROL DE CALIDAD)
  Proyecto Final Módulo 9 - DataCenter Académico
  Empresa: Soluciones Empresariales RD
  Integrantes: RASQUEL MERCEDES, NOVAS ALCANTARA
               LUIS SILFREDO, POLANCO
  Fecha: Junio 2026
=======================================================================
  OBJETIVO: Pruebas, validación de resultados, revisión de scripts
            y detección de errores sobre la base de datos
            SolucionesEmpresarialesRD.
=======================================================================
*/

USE SolucionesEmpresarialesRD;
GO

PRINT '======================================================'
PRINT '  QA - CONTROL DE CALIDAD'
PRINT '  SolucionesEmpresarialesRD'
PRINT '======================================================'
PRINT ''

/* ======================================================
   BLOQUE 1: VERIFICACIÓN DE EXISTENCIA DE OBJETOS
   Valida que todas las tablas, vistas y procedimientos
   estén correctamente creados en la base de datos.
   ====================================================== */

PRINT '--- BLOQUE 1: Existencia de Tablas ---'
GO

-- QA-T01: Verificar que la tabla Clientes existe
IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL
    PRINT 'QA-T01 [OK] Tabla Clientes: EXISTE'
ELSE
    PRINT 'QA-T01 [ERROR] Tabla Clientes: NO EXISTE'
GO

-- QA-T02: Verificar que la tabla Empleados existe
IF OBJECT_ID('dbo.Empleados', 'U') IS NOT NULL
    PRINT 'QA-T02 [OK] Tabla Empleados: EXISTE'
ELSE
    PRINT 'QA-T02 [ERROR] Tabla Empleados: NO EXISTE'
GO

-- QA-T03: Verificar que la tabla Productos existe
IF OBJECT_ID('dbo.Productos', 'U') IS NOT NULL
    PRINT 'QA-T03 [OK] Tabla Productos: EXISTE'
ELSE
    PRINT 'QA-T03 [ERROR] Tabla Productos: NO EXISTE'
GO

-- QA-T04: Verificar que la tabla Servicios existe
IF OBJECT_ID('dbo.Servicios', 'U') IS NOT NULL
    PRINT 'QA-T04 [OK] Tabla Servicios: EXISTE'
ELSE
    PRINT 'QA-T04 [ERROR] Tabla Servicios: NO EXISTE'
GO

-- QA-T05: Verificar que la tabla Ventas existe
IF OBJECT_ID('dbo.Ventas', 'U') IS NOT NULL
    PRINT 'QA-T05 [OK] Tabla Ventas: EXISTE'
ELSE
    PRINT 'QA-T05 [ERROR] Tabla Ventas: NO EXISTE'
GO

-- QA-T06: Verificar que la tabla DetalleVentas existe
IF OBJECT_ID('dbo.DetalleVentas', 'U') IS NOT NULL
    PRINT 'QA-T06 [OK] Tabla DetalleVentas: EXISTE'
ELSE
    PRINT 'QA-T06 [ERROR] Tabla DetalleVentas: NO EXISTE'
GO

-- QA-T07: Verificar que la tabla Categorias existe
IF OBJECT_ID('dbo.Categorias', 'U') IS NOT NULL
    PRINT 'QA-T07 [OK] Tabla Categorias: EXISTE'
ELSE
    PRINT 'QA-T07 [ERROR] Tabla Categorias: NO EXISTE'
GO

-- QA-T08: Verificar que la tabla InventarioMovimientos existe
IF OBJECT_ID('dbo.InventarioMovimientos', 'U') IS NOT NULL
    PRINT 'QA-T08 [OK] Tabla InventarioMovimientos: EXISTE'
ELSE
    PRINT 'QA-T08 [ERROR] Tabla InventarioMovimientos: NO EXISTE'
GO

PRINT ''
PRINT '--- BLOQUE 1B: Existencia de Vistas ---'
GO

-- QA-V01: Vista de ventas generales
IF OBJECT_ID('dbo.vw_VentasGenerales', 'V') IS NOT NULL
    PRINT 'QA-V01 [OK] Vista vw_VentasGenerales: EXISTE'
ELSE
    PRINT 'QA-V01 [ERROR] Vista vw_VentasGenerales: NO EXISTE'
GO

-- QA-V02: Vista inventario de productos
IF OBJECT_ID('dbo.vw_InventarioProductos', 'V') IS NOT NULL
    PRINT 'QA-V02 [OK] Vista vw_InventarioProductos: EXISTE'
ELSE
    PRINT 'QA-V02 [ERROR] Vista vw_InventarioProductos: NO EXISTE'
GO

-- QA-V03: Vista detalle de ventas
IF OBJECT_ID('dbo.vw_DetalleVentas', 'V') IS NOT NULL
    PRINT 'QA-V03 [OK] Vista vw_DetalleVentas: EXISTE'
ELSE
    PRINT 'QA-V03 [ERROR] Vista vw_DetalleVentas: NO EXISTE'
GO

-- QA-V04: Vista productos por categoría
IF OBJECT_ID('dbo.vw_ProductosPorCategoria', 'V') IS NOT NULL
    PRINT 'QA-V04 [OK] Vista vw_ProductosPorCategoria: EXISTE'
ELSE
    PRINT 'QA-V04 [ERROR] Vista vw_ProductosPorCategoria: NO EXISTE'
GO

-- QA-V05: Vista resumen de ventas por cliente
IF OBJECT_ID('dbo.vw_ResumenVentasPorCliente', 'V') IS NOT NULL
    PRINT 'QA-V05 [OK] Vista vw_ResumenVentasPorCliente: EXISTE'
ELSE
    PRINT 'QA-V05 [ERROR] Vista vw_ResumenVentasPorCliente: NO EXISTE'
GO

PRINT ''
PRINT '--- BLOQUE 1C: Existencia de Procedimientos Almacenados ---'
GO

-- QA-P01: sp_RegistrarCliente
IF OBJECT_ID('dbo.sp_RegistrarCliente', 'P') IS NOT NULL
    PRINT 'QA-P01 [OK] Procedimiento sp_RegistrarCliente: EXISTE'
ELSE
    PRINT 'QA-P01 [ERROR] Procedimiento sp_RegistrarCliente: NO EXISTE'
GO

-- QA-P02: sp_RegistrarProducto
IF OBJECT_ID('dbo.sp_RegistrarProducto', 'P') IS NOT NULL
    PRINT 'QA-P02 [OK] Procedimiento sp_RegistrarProducto: EXISTE'
ELSE
    PRINT 'QA-P02 [ERROR] Procedimiento sp_RegistrarProducto: NO EXISTE'
GO

-- QA-P03: sp_ConsultarVentasPorCliente
IF OBJECT_ID('dbo.sp_ConsultarVentasPorCliente', 'P') IS NOT NULL
    PRINT 'QA-P03 [OK] Procedimiento sp_ConsultarVentasPorCliente: EXISTE'
ELSE
    PRINT 'QA-P03 [ERROR] Procedimiento sp_ConsultarVentasPorCliente: NO EXISTE'
GO

-- QA-P04: sp_ActualizarStock
IF OBJECT_ID('dbo.sp_ActualizarStock', 'P') IS NOT NULL
    PRINT 'QA-P04 [OK] Procedimiento sp_ActualizarStock: EXISTE'
ELSE
    PRINT 'QA-P04 [ERROR] Procedimiento sp_ActualizarStock: NO EXISTE'
GO

-- QA-P05: sp_RegistrarVentaProducto
IF OBJECT_ID('dbo.sp_RegistrarVentaProducto', 'P') IS NOT NULL
    PRINT 'QA-P05 [OK] Procedimiento sp_RegistrarVentaProducto: EXISTE'
ELSE
    PRINT 'QA-P05 [ERROR] Procedimiento sp_RegistrarVentaProducto: NO EXISTE'
GO

-- QA-P06: sp_ConsultarProductosStockBajo
IF OBJECT_ID('dbo.sp_ConsultarProductosStockBajo', 'P') IS NOT NULL
    PRINT 'QA-P06 [OK] Procedimiento sp_ConsultarProductosStockBajo: EXISTE'
ELSE
    PRINT 'QA-P06 [ERROR] Procedimiento sp_ConsultarProductosStockBajo: NO EXISTE'
GO

-- QA-P07: sp_ConsultarVentasPorFecha
IF OBJECT_ID('dbo.sp_ConsultarVentasPorFecha', 'P') IS NOT NULL
    PRINT 'QA-P07 [OK] Procedimiento sp_ConsultarVentasPorFecha: EXISTE'
ELSE
    PRINT 'QA-P07 [ERROR] Procedimiento sp_ConsultarVentasPorFecha: NO EXISTE'
GO


/* ======================================================
   BLOQUE 2: PRUEBAS DE INTEGRIDAD REFERENCIAL (LLAVES)
   Verifica que las relaciones entre tablas estén
   correctamente definidas mediante claves foráneas.
   ====================================================== */

PRINT ''
PRINT '--- BLOQUE 2: Integridad Referencial ---'
GO

-- QA-IR01: Ventas debe tener FK hacia Clientes
IF EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
        ON RC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
    WHERE KCU.TABLE_NAME = 'Ventas'
      AND KCU.COLUMN_NAME = 'ClienteID'
)
    PRINT 'QA-IR01 [OK] FK Ventas.ClienteID -> Clientes: EXISTE'
ELSE
    PRINT 'QA-IR01 [ADVERTENCIA] FK Ventas.ClienteID -> Clientes: NO ENCONTRADA'
GO

-- QA-IR02: Ventas debe tener FK hacia Empleados
IF EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
        ON RC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
    WHERE KCU.TABLE_NAME = 'Ventas'
      AND KCU.COLUMN_NAME = 'EmpleadoID'
)
    PRINT 'QA-IR02 [OK] FK Ventas.EmpleadoID -> Empleados: EXISTE'
ELSE
    PRINT 'QA-IR02 [ADVERTENCIA] FK Ventas.EmpleadoID -> Empleados: NO ENCONTRADA'
GO

-- QA-IR03: DetalleVentas debe tener FK hacia Ventas
IF EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
        ON RC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
    WHERE KCU.TABLE_NAME = 'DetalleVentas'
      AND KCU.COLUMN_NAME = 'VentaID'
)
    PRINT 'QA-IR03 [OK] FK DetalleVentas.VentaID -> Ventas: EXISTE'
ELSE
    PRINT 'QA-IR03 [ADVERTENCIA] FK DetalleVentas.VentaID -> Ventas: NO ENCONTRADA'
GO

-- QA-IR04: Productos debe tener FK hacia Categorias
IF EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
        ON RC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
    WHERE KCU.TABLE_NAME = 'Productos'
      AND KCU.COLUMN_NAME = 'CategoriaID'
)
    PRINT 'QA-IR04 [OK] FK Productos.CategoriaID -> Categorias: EXISTE'
ELSE
    PRINT 'QA-IR04 [ADVERTENCIA] FK Productos.CategoriaID -> Categorias: NO ENCONTRADA'
GO


/* ======================================================
   BLOQUE 3: PRUEBAS FUNCIONALES - PROCEDIMIENTOS
   Se prueban los stored procedures con datos de prueba
   reales. Se usan transacciones para no afectar los
   datos existentes.
   ====================================================== */

PRINT ''
PRINT '--- BLOQUE 3: Pruebas Funcionales de Procedimientos ---'
GO

-- QA-F01: Prueba sp_RegistrarCliente (caso exitoso)
BEGIN TRANSACTION;
BEGIN TRY
    EXEC sp_RegistrarCliente
        @Nombre     = 'QA_TEST',
        @Apellido   = 'PRUEBA',
        @Cedula     = '00000000000',
        @Telefono   = '809-000-0000',
        @Correo     = 'qa_test@test.com',
        @Direccion  = 'Dirección de Prueba QA';

    IF EXISTS (SELECT 1 FROM Clientes WHERE Cedula = '00000000000')
        PRINT 'QA-F01 [OK] sp_RegistrarCliente: CLIENTE INSERTADO CORRECTAMENTE'
    ELSE
        PRINT 'QA-F01 [ERROR] sp_RegistrarCliente: EL CLIENTE NO FUE INSERTADO'
END TRY
BEGIN CATCH
    PRINT 'QA-F01 [ERROR] sp_RegistrarCliente: ' + ERROR_MESSAGE()
END CATCH;
ROLLBACK TRANSACTION;
GO

-- QA-F02: Prueba sp_RegistrarCliente con Cedula duplicada (debe fallar)
BEGIN TRANSACTION;
BEGIN TRY
    -- Insertar primero
    EXEC sp_RegistrarCliente
        @Nombre    = 'DUPLICADO',
        @Apellido  = 'TEST',
        @Cedula    = '99999999999',
        @Telefono  = '000-000-0001',
        @Correo    = 'dup1@test.com',
        @Direccion = 'Dir 1';

    -- Insertar de nuevo con la misma cédula
    EXEC sp_RegistrarCliente
        @Nombre    = 'DUPLICADO2',
        @Apellido  = 'TEST2',
        @Cedula    = '99999999999',
        @Telefono  = '000-000-0002',
        @Correo    = 'dup2@test.com',
        @Direccion = 'Dir 2';

    PRINT 'QA-F02 [ERROR] sp_RegistrarCliente: Acepto cedula duplicada - FALLA DE RESTRICCION UNIQUE'
END TRY
BEGIN CATCH
    PRINT 'QA-F02 [OK] sp_RegistrarCliente: Rechazo cedula duplicada correctamente (UNIQUE constraint)'
END CATCH;
ROLLBACK TRANSACTION;
GO

-- QA-F03: Prueba sp_ActualizarStock - Entrada de inventario
BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @ProdID INT;
    SELECT TOP 1 @ProdID = ProductoID FROM Productos;

    IF @ProdID IS NULL
    BEGIN
        PRINT 'QA-F03 [OMITIDO] sp_ActualizarStock: No hay productos en la BD para probar'
    END
    ELSE
    BEGIN
        DECLARE @StockAntes INT;
        SELECT @StockAntes = Stock FROM Productos WHERE ProductoID = @ProdID;

        EXEC sp_ActualizarStock
            @ProductoID      = @ProdID,
            @Cantidad        = 10,
            @TipoMovimiento  = 'Entrada',
            @Descripcion     = 'Prueba QA - Entrada de inventario';

        DECLARE @StockDespues INT;
        SELECT @StockDespues = Stock FROM Productos WHERE ProductoID = @ProdID;

        IF @StockDespues = @StockAntes + 10
            PRINT 'QA-F03 [OK] sp_ActualizarStock (Entrada): Stock actualizado correctamente (+10)'
        ELSE
            PRINT 'QA-F03 [ERROR] sp_ActualizarStock (Entrada): Stock no actualizado correctamente'
    END
END TRY
BEGIN CATCH
    PRINT 'QA-F03 [ERROR] sp_ActualizarStock: ' + ERROR_MESSAGE()
END CATCH;
ROLLBACK TRANSACTION;
GO

-- QA-F04: Prueba sp_ActualizarStock - Salida sin stock suficiente (debe imprimir advertencia)
BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @ProdID INT;
    SELECT TOP 1 @ProdID = ProductoID FROM Productos WHERE Stock = 0;

    IF @ProdID IS NULL
        PRINT 'QA-F04 [OMITIDO] sp_ActualizarStock (Salida sin stock): No hay producto con Stock=0 para probar'
    ELSE
    BEGIN
        EXEC sp_ActualizarStock
            @ProductoID      = @ProdID,
            @Cantidad        = 999,
            @TipoMovimiento  = 'Salida',
            @Descripcion     = 'Prueba QA - Salida sin stock';
        PRINT 'QA-F04 [OK] sp_ActualizarStock (Salida sin stock): Procedimiento ejecutó lógica de protección'
    END
END TRY
BEGIN CATCH
    PRINT 'QA-F04 [ERROR] sp_ActualizarStock (Salida sin stock): ' + ERROR_MESSAGE()
END CATCH;
ROLLBACK TRANSACTION;
GO

-- QA-F05: Prueba sp_ActualizarStock - Tipo de movimiento inválido
BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @ProdID INT;
    SELECT TOP 1 @ProdID = ProductoID FROM Productos;

    IF @ProdID IS NOT NULL
    BEGIN
        EXEC sp_ActualizarStock
            @ProductoID      = @ProdID,
            @Cantidad        = 5,
            @TipoMovimiento  = 'INVALIDO',
            @Descripcion     = 'Prueba QA - Tipo invalido';
        PRINT 'QA-F05 [OK] sp_ActualizarStock (tipo invalido): Procedimiento manejo el tipo invalido'
    END
    ELSE
        PRINT 'QA-F05 [OMITIDO] No hay productos para probar'
END TRY
BEGIN CATCH
    PRINT 'QA-F05 [ERROR] sp_ActualizarStock (tipo invalido): ' + ERROR_MESSAGE()
END CATCH;
ROLLBACK TRANSACTION;
GO

-- QA-F06: Prueba sp_ConsultarVentasPorCliente
BEGIN TRY
    DECLARE @ClienteExistente INT;
    SELECT TOP 1 @ClienteExistente = ClienteID FROM Clientes;

    IF @ClienteExistente IS NULL
        PRINT 'QA-F06 [OMITIDO] sp_ConsultarVentasPorCliente: No hay clientes en la BD'
    ELSE
    BEGIN
        EXEC sp_ConsultarVentasPorCliente @ClienteID = @ClienteExistente;
        PRINT 'QA-F06 [OK] sp_ConsultarVentasPorCliente: Ejecutado sin errores para ClienteID = ' + CAST(@ClienteExistente AS VARCHAR)
    END
END TRY
BEGIN CATCH
    PRINT 'QA-F06 [ERROR] sp_ConsultarVentasPorCliente: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-F07: Prueba sp_ConsultarProductosStockBajo
BEGIN TRY
    EXEC sp_ConsultarProductosStockBajo;
    PRINT 'QA-F07 [OK] sp_ConsultarProductosStockBajo: Ejecutado correctamente'
END TRY
BEGIN CATCH
    PRINT 'QA-F07 [ERROR] sp_ConsultarProductosStockBajo: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-F08: Prueba sp_ConsultarVentasPorFecha con rango válido
BEGIN TRY
    EXEC sp_ConsultarVentasPorFecha
        @FechaInicio = '2024-01-01',
        @FechaFin    = '2026-12-31';
    PRINT 'QA-F08 [OK] sp_ConsultarVentasPorFecha: Ejecutado correctamente con rango 2024-2026'
END TRY
BEGIN CATCH
    PRINT 'QA-F08 [ERROR] sp_ConsultarVentasPorFecha: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-F09: Prueba sp_RegistrarVentaProducto (flujo completo)
BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @ClienteID INT, @EmpleadoID INT, @ProductoID INT;
    SELECT TOP 1 @ClienteID  = ClienteID  FROM Clientes;
    SELECT TOP 1 @EmpleadoID = EmpleadoID FROM Empleados;
    SELECT TOP 1 @ProductoID = ProductoID FROM Productos WHERE Stock >= 1;

    IF @ClienteID IS NULL OR @EmpleadoID IS NULL OR @ProductoID IS NULL
        PRINT 'QA-F09 [OMITIDO] sp_RegistrarVentaProducto: Faltan datos base (cliente, empleado o producto con stock)'
    ELSE
    BEGIN
        DECLARE @VentasAntes INT;
        SELECT @VentasAntes = COUNT(*) FROM Ventas;

        EXEC sp_RegistrarVentaProducto
            @ClienteID  = @ClienteID,
            @EmpleadoID = @EmpleadoID,
            @ProductoID = @ProductoID,
            @Cantidad   = 1;

        DECLARE @VentasDespues INT;
        SELECT @VentasDespues = COUNT(*) FROM Ventas;

        IF @VentasDespues = @VentasAntes + 1
            PRINT 'QA-F09 [OK] sp_RegistrarVentaProducto: Venta registrada correctamente'
        ELSE
            PRINT 'QA-F09 [ERROR] sp_RegistrarVentaProducto: La venta no fue registrada'
    END
END TRY
BEGIN CATCH
    PRINT 'QA-F09 [ERROR] sp_RegistrarVentaProducto: ' + ERROR_MESSAGE()
END CATCH;
ROLLBACK TRANSACTION;
GO


/* ======================================================
   BLOQUE 4: VALIDACIÓN DE VISTAS
   Confirma que las vistas retornan datos sin errores
   y tienen las columnas esperadas.
   ====================================================== */

PRINT ''
PRINT '--- BLOQUE 4: Validación de Vistas ---'
GO

-- QA-VIS01: vw_VentasGenerales
BEGIN TRY
    DECLARE @RowCount INT;
    SELECT @RowCount = COUNT(*) FROM vw_VentasGenerales;
    PRINT 'QA-VIS01 [OK] vw_VentasGenerales: Retorna ' + CAST(@RowCount AS VARCHAR) + ' registros sin errores'
END TRY
BEGIN CATCH
    PRINT 'QA-VIS01 [ERROR] vw_VentasGenerales: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-VIS02: vw_InventarioProductos
BEGIN TRY
    DECLARE @RowCount INT;
    SELECT @RowCount = COUNT(*) FROM vw_InventarioProductos;
    PRINT 'QA-VIS02 [OK] vw_InventarioProductos: Retorna ' + CAST(@RowCount AS VARCHAR) + ' registros sin errores'
END TRY
BEGIN CATCH
    PRINT 'QA-VIS02 [ERROR] vw_InventarioProductos: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-VIS03: vw_DetalleVentas
BEGIN TRY
    DECLARE @RowCount INT;
    SELECT @RowCount = COUNT(*) FROM vw_DetalleVentas;
    PRINT 'QA-VIS03 [OK] vw_DetalleVentas: Retorna ' + CAST(@RowCount AS VARCHAR) + ' registros sin errores'
END TRY
BEGIN CATCH
    PRINT 'QA-VIS03 [ERROR] vw_DetalleVentas: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-VIS04: vw_ProductosPorCategoria
BEGIN TRY
    DECLARE @RowCount INT;
    SELECT @RowCount = COUNT(*) FROM vw_ProductosPorCategoria;
    PRINT 'QA-VIS04 [OK] vw_ProductosPorCategoria: Retorna ' + CAST(@RowCount AS VARCHAR) + ' registros sin errores'
END TRY
BEGIN CATCH
    PRINT 'QA-VIS04 [ERROR] vw_ProductosPorCategoria: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-VIS05: vw_ResumenVentasPorCliente - Validar que TotalComprado no sea negativo
BEGIN TRY
    DECLARE @Negativos INT;
    SELECT @Negativos = COUNT(*) FROM vw_ResumenVentasPorCliente WHERE TotalComprado < 0;

    IF @Negativos = 0
        PRINT 'QA-VIS05 [OK] vw_ResumenVentasPorCliente: Ningun total comprado es negativo'
    ELSE
        PRINT 'QA-VIS05 [ERROR] vw_ResumenVentasPorCliente: Existen ' + CAST(@Negativos AS VARCHAR) + ' registros con total negativo'
END TRY
BEGIN CATCH
    PRINT 'QA-VIS05 [ERROR] vw_ResumenVentasPorCliente: ' + ERROR_MESSAGE()
END CATCH;
GO

-- QA-VIS06: vw_InventarioProductos - Verificar que EstadoInventario sea correcto
BEGIN TRY
    DECLARE @Incorrectos INT;
    SELECT @Incorrectos = COUNT(*)
    FROM vw_InventarioProductos
    WHERE EstadoInventario NOT IN ('Agotado', 'Stock Bajo', 'Disponible');

    IF @Incorrectos = 0
        PRINT 'QA-VIS06 [OK] vw_InventarioProductos: Todos los estados de inventario son válidos'
    ELSE
        PRINT 'QA-VIS06 [ERROR] vw_InventarioProductos: ' + CAST(@Incorrectos AS VARCHAR) + ' registros con estado invalido'
END TRY
BEGIN CATCH
    PRINT 'QA-VIS06 [ERROR] vw_InventarioProductos: ' + ERROR_MESSAGE()
END CATCH;
GO


/* ======================================================
   BLOQUE 5: VALIDACIÓN DE DATOS - INTEGRIDAD DE NEGOCIO
   Detecta inconsistencias lógicas en los datos.
   ====================================================== */

PRINT ''
PRINT '--- BLOQUE 5: Integridad de Datos de Negocio ---'
GO

-- QA-D01: Ventas con Total NULL o cero (posible error de cálculo)
DECLARE @VentasSinTotal INT;
SELECT @VentasSinTotal = COUNT(*)
FROM Ventas
WHERE Total IS NULL OR Total = 0;

IF @VentasSinTotal = 0
    PRINT 'QA-D01 [OK] Ventas: Ninguna venta tiene Total NULL o 0'
ELSE
    PRINT 'QA-D01 [ADVERTENCIA] Ventas: ' + CAST(@VentasSinTotal AS VARCHAR) + ' ventas tienen Total NULL o 0 - Revisar sp_RegistrarVentaProducto'
GO

-- QA-D02: DetalleVentas con Subtotal incorrecto
-- El subtotal debe ser igual a Cantidad * PrecioUnitario
DECLARE @SubtotalIncorrecto INT;
SELECT @SubtotalIncorrecto = COUNT(*)
FROM DetalleVentas
WHERE ABS(Subtotal - (Cantidad * PrecioUnitario)) > 0.01;  -- tolerancia de 1 centavo

IF @SubtotalIncorrecto = 0
    PRINT 'QA-D02 [OK] DetalleVentas: Todos los subtotales son correctos (Cantidad * PrecioUnitario)'
ELSE
    PRINT 'QA-D02 [ERROR] DetalleVentas: ' + CAST(@SubtotalIncorrecto AS VARCHAR) + ' registros con Subtotal incorrecto'
GO

-- QA-D03: Productos con precio negativo o cero
DECLARE @PrecioInvalido INT;
SELECT @PrecioInvalido = COUNT(*)
FROM Productos
WHERE Precio <= 0;

IF @PrecioInvalido = 0
    PRINT 'QA-D03 [OK] Productos: Ningún producto tiene precio <= 0'
ELSE
    PRINT 'QA-D03 [ERROR] Productos: ' + CAST(@PrecioInvalido AS VARCHAR) + ' productos tienen precio invalido (<=0)'
GO

-- QA-D04: Productos con Stock negativo
DECLARE @StockNegativo INT;
SELECT @StockNegativo = COUNT(*)
FROM Productos
WHERE Stock < 0;

IF @StockNegativo = 0
    PRINT 'QA-D04 [OK] Productos: Ningún producto tiene stock negativo'
ELSE
    PRINT 'QA-D04 [ERROR] Productos: ' + CAST(@StockNegativo AS VARCHAR) + ' productos tienen stock negativo'
GO

-- QA-D05: Clientes sin correo ni teléfono (datos de contacto vacíos)
DECLARE @SinContacto INT;
SELECT @SinContacto = COUNT(*)
FROM Clientes
WHERE (Telefono IS NULL OR Telefono = '')
  AND (Correo IS NULL OR Correo = '');

IF @SinContacto = 0
    PRINT 'QA-D05 [OK] Clientes: Todos tienen al menos un dato de contacto'
ELSE
    PRINT 'QA-D05 [ADVERTENCIA] Clientes: ' + CAST(@SinContacto AS VARCHAR) + ' clientes sin teléfono ni correo'
GO

-- QA-D06: DetalleVentas sin ProductoID ni ServicioID (línea huérfana)
DECLARE @DetalleHuerfano INT;
SELECT @DetalleHuerfano = COUNT(*)
FROM DetalleVentas
WHERE ProductoID IS NULL AND ServicioID IS NULL;

IF @DetalleHuerfano = 0
    PRINT 'QA-D06 [OK] DetalleVentas: Ninguna línea está sin producto ni servicio'
ELSE
    PRINT 'QA-D06 [ERROR] DetalleVentas: ' + CAST(@DetalleHuerfano AS VARCHAR) + ' líneas sin ProductoID ni ServicioID'
GO

-- QA-D07: Verificar que los movimientos de inventario registren salidas por ventas
DECLARE @VentasSinMovimiento INT;
SELECT @VentasSinMovimiento = COUNT(DISTINCT DV.VentaID)
FROM DetalleVentas DV
WHERE DV.ProductoID IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM InventarioMovimientos IM
      WHERE IM.ProductoID = DV.ProductoID
        AND IM.TipoMovimiento = 'Salida'
  );

IF @VentasSinMovimiento = 0
    PRINT 'QA-D07 [OK] InventarioMovimientos: Todos los productos vendidos tienen registro de salida'
ELSE
    PRINT 'QA-D07 [ADVERTENCIA] InventarioMovimientos: ' + CAST(@VentasSinMovimiento AS VARCHAR) + ' ventas sin movimiento de salida registrado'
GO


/* ======================================================
   BLOQUE 6: VALIDACIÓN DE SEGURIDAD
   Revisa que la configuración del equipo 4 esté aplicada
   y que el usuario invitado no tenga acceso.
   ====================================================== */

PRINT ''
PRINT '--- BLOQUE 6: Validación de Configuración de Seguridad ---'
GO

-- QA-S01: Verificar que TRUSTWORTHY esté desactivado
IF EXISTS (
    SELECT 1 FROM sys.databases
    WHERE name = 'SolucionesEmpresarialesRD'
      AND is_trustworthy_on = 0
)
    PRINT 'QA-S01 [OK] Seguridad: TRUSTWORTHY = OFF (correcto)'
ELSE
    PRINT 'QA-S01 [ERROR] Seguridad: TRUSTWORTHY = ON - Revisar script del Equipo 4'
GO

-- QA-S02: Verificar que DB_CHAINING esté desactivado
IF EXISTS (
    SELECT 1 FROM sys.databases
    WHERE name = 'SolucionesEmpresarialesRD'
      AND is_db_chaining_on = 0
)
    PRINT 'QA-S02 [OK] Seguridad: DB_CHAINING = OFF (correcto)'
ELSE
    PRINT 'QA-S02 [ERROR] Seguridad: DB_CHAINING = ON - Revisar script del Equipo 4'
GO

-- QA-S03: Verificar que el usuario AdminEmpresa existe
IF EXISTS (
    SELECT 1 FROM sys.database_principals
    WHERE name = 'AdminEmpresa' AND type = 'S'
)
    PRINT 'QA-S03 [OK] Seguridad: Usuario AdminEmpresa existe en la BD'
ELSE
    PRINT 'QA-S03 [ADVERTENCIA] Seguridad: Usuario AdminEmpresa no encontrado'
GO

-- QA-S04: Verificar que el usuario guest no tiene permiso CONNECT
IF NOT EXISTS (
    SELECT 1 FROM sys.database_permissions dp
    JOIN sys.database_principals pr ON dp.grantee_principal_id = pr.principal_id
    WHERE pr.name = 'guest'
      AND dp.permission_name = 'CONNECT'
      AND dp.state = 'G'
)
    PRINT 'QA-S04 [OK] Seguridad: Usuario guest no tiene permiso CONNECT (correcto)'
ELSE
    PRINT 'QA-S04 [ERROR] Seguridad: Usuario guest tiene CONNECT - Revisar REVOKE del Equipo 4'
GO

-- QA-S05: Verificar modo de recuperación FULL (configurado por Equipo 1)
IF EXISTS (
    SELECT 1 FROM sys.databases
    WHERE name = 'SolucionesEmpresarialesRD'
      AND recovery_model_desc = 'FULL'
)
    PRINT 'QA-S05 [OK] DBA: Recovery Model = FULL (correcto)'
ELSE
    PRINT 'QA-S05 [ADVERTENCIA] DBA: Recovery Model NO es FULL - Revisar script del Equipo 1'
GO


/* ======================================================
   BLOQUE 7: REPORTE FINAL DE CONTEO
   Muestra un resumen del estado actual de los datos
   para validar que el sistema tiene información real.
   ====================================================== */

PRINT ''
PRINT '--- BLOQUE 7: Reporte de Conteo de Datos ---'
GO

SELECT
    'Clientes'             AS Tabla, COUNT(*) AS TotalRegistros FROM Clientes
UNION ALL SELECT
    'Empleados',                     COUNT(*) FROM Empleados
UNION ALL SELECT
    'Categorias',                    COUNT(*) FROM Categorias
UNION ALL SELECT
    'Productos',                     COUNT(*) FROM Productos
UNION ALL SELECT
    'Servicios',                     COUNT(*) FROM Servicios
UNION ALL SELECT
    'Ventas',                        COUNT(*) FROM Ventas
UNION ALL SELECT
    'DetalleVentas',                 COUNT(*) FROM DetalleVentas
UNION ALL SELECT
    'InventarioMovimientos',         COUNT(*) FROM InventarioMovimientos;
GO

PRINT ''
PRINT '--- Resumen Estadístico de Ventas ---'
GO

SELECT
    COUNT(*)          AS TotalVentas,
    SUM(Total)        AS SumaTotal,
    AVG(Total)        AS PromedioVenta,
    MAX(Total)        AS VentaMasAlta,
    MIN(Total)        AS VentaMasBaja
FROM Ventas
WHERE Estado = 'Completada';
GO

PRINT ''
PRINT '======================================================'
PRINT '  FIN DEL SCRIPT QA - CONTROL DE CALIDAD'
PRINT '  Equipo #5 - SolucionesEmpresarialesRD'
PRINT '======================================================'
GO
