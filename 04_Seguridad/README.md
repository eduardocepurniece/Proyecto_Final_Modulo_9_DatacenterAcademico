/*
    Equipo #4 - Seguridad
    Script 01: usuarios de base de datos

    Se crean WITHOUT LOGIN para no almacenar contrasenas en el repositorio
    ni interferir con los logins administrados por el Equipo #1.
*/

USE SolucionesEmpresarialesRD;
GO

IF DATABASE_PRINCIPAL_ID(N'usr_admin_seguridad') IS NULL
    CREATE USER [usr_admin_seguridad] WITHOUT LOGIN;
GO

IF DATABASE_PRINCIPAL_ID(N'usr_ventas') IS NULL
    CREATE USER [usr_ventas] WITHOUT LOGIN;
GO

IF DATABASE_PRINCIPAL_ID(N'usr_inventario') IS NULL
    CREATE USER [usr_inventario] WITHOUT LOGIN;
GO

IF DATABASE_PRINCIPAL_ID(N'usr_consulta') IS NULL
    CREATE USER [usr_consulta] WITHOUT LOGIN;
GO

/*
    Para probar un usuario:

    EXECUTE AS USER = 'usr_consulta';
    SELECT USER_NAME() AS UsuarioActual;
    REVERT;

    En produccion, el DBA debe crear los logins y mapearlos a usuarios
    equivalentes aplicando CHECK_POLICY y CHECK_EXPIRATION.
*/
