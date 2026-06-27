/*
    Equipo #4 - Seguridad
    Script 06: pruebas de acceso

    Cada bloque demuestra una operacion permitida. Las pruebas marcadas como
    "debe fallar" validan que el acceso directo a tablas esta bloqueado.
*/

USE SolucionesEmpresarialesRD;
GO

-- Usuario de consulta: puede leer una vista segura.
EXECUTE AS USER = 'usr_consulta';
SELECT TOP (5) * FROM seguridad.vw_VentasResumen;
REVERT;
GO

-- Usuario de consulta: debe fallar porque Ventas es una tabla directa.
DECLARE @ConsultaBloqueada BIT = 0;

BEGIN TRY
    EXECUTE AS USER = 'usr_consulta';
    SELECT TOP (5) * FROM dbo.Ventas;
    REVERT;
END TRY
BEGIN CATCH
    IF USER_NAME() = N'usr_consulta'
        REVERT;
    SET @ConsultaBloqueada = 1;
END CATCH;

IF @ConsultaBloqueada = 1
    PRINT N'Prueba correcta: se bloqueo el acceso directo a dbo.Ventas.';
ELSE
    THROW 51000, 'ERROR: usr_consulta pudo leer dbo.Ventas.', 1;
GO

-- Usuario de inventario: puede consultar la vista de inventario.
EXECUTE AS USER = 'usr_inventario';
SELECT TOP (5) * FROM seguridad.vw_InventarioConsulta;
REVERT;
GO

-- Inventario no puede modificar directamente la tabla Productos.
DECLARE @ActualizacionBloqueada BIT = 0;

BEGIN TRY
    EXECUTE AS USER = 'usr_inventario';
    UPDATE dbo.Productos SET Stock = Stock;
    REVERT;
END TRY
BEGIN CATCH
    IF USER_NAME() = N'usr_inventario'
        REVERT;
    SET @ActualizacionBloqueada = 1;
END CATCH;

IF @ActualizacionBloqueada = 1
    PRINT N'Prueba correcta: se bloqueo la actualizacion directa de Productos.';
ELSE
    THROW 51001, 'ERROR: usr_inventario pudo actualizar dbo.Productos.', 1;
GO

-- Resumen de membresias configuradas.
SELECT
    R.name AS Rol,
    M.name AS Usuario
FROM sys.database_role_members AS RM
INNER JOIN sys.database_principals AS R
    ON R.principal_id = RM.role_principal_id
INNER JOIN sys.database_principals AS M
    ON M.principal_id = RM.member_principal_id
WHERE R.name LIKE N'rol[_]%'
ORDER BY R.name, M.name;
GO
