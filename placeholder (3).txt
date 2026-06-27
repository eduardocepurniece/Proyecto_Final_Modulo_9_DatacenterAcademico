/*
    Equipo #4 - Seguridad
    Script 02: roles y membresias
*/

USE SolucionesEmpresarialesRD;
GO

IF DATABASE_PRINCIPAL_ID(N'rol_admin_seguridad') IS NULL
    CREATE ROLE [rol_admin_seguridad] AUTHORIZATION [dbo];
GO

IF DATABASE_PRINCIPAL_ID(N'rol_ventas') IS NULL
    CREATE ROLE [rol_ventas] AUTHORIZATION [dbo];
GO

IF DATABASE_PRINCIPAL_ID(N'rol_inventario') IS NULL
    CREATE ROLE [rol_inventario] AUTHORIZATION [dbo];
GO

IF DATABASE_PRINCIPAL_ID(N'rol_consulta') IS NULL
    CREATE ROLE [rol_consulta] AUTHORIZATION [dbo];
GO

IF IS_ROLEMEMBER(N'rol_admin_seguridad', N'usr_admin_seguridad') <> 1
    ALTER ROLE [rol_admin_seguridad] ADD MEMBER [usr_admin_seguridad];
GO

IF IS_ROLEMEMBER(N'rol_ventas', N'usr_ventas') <> 1
    ALTER ROLE [rol_ventas] ADD MEMBER [usr_ventas];
GO

IF IS_ROLEMEMBER(N'rol_inventario', N'usr_inventario') <> 1
    ALTER ROLE [rol_inventario] ADD MEMBER [usr_inventario];
GO

IF IS_ROLEMEMBER(N'rol_consulta', N'usr_consulta') <> 1
    ALTER ROLE [rol_consulta] ADD MEMBER [usr_consulta];
GO
