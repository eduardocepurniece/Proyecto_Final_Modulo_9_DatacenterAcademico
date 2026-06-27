/*
    Equipo #4 - Seguridad
    Script 05: configuracion basica de seguridad

    Requiere una cuenta con permisos de administracion sobre la base de datos.
*/

USE master;
GO

-- Evita que codigo de la base de datos obtenga privilegios del servidor.
ALTER DATABASE [SolucionesEmpresarialesRD] SET TRUSTWORTHY OFF;
GO

-- Evita cadenas de propiedad entre bases de datos.
ALTER DATABASE [SolucionesEmpresarialesRD] SET DB_CHAINING OFF;
GO

USE SolucionesEmpresarialesRD;
GO

-- El usuario invitado no debe conectarse a la base empresarial.
REVOKE CONNECT FROM [guest];
GO

/*
    Politicas operativas complementarias:

    1. Aplicar minimo privilegio y asignar permisos solo mediante roles.
    2. No compartir cuentas entre personas.
    3. No guardar contrasenas en scripts, GitHub ni documentacion.
    4. En los logins reales usar CHECK_POLICY = ON y CHECK_EXPIRATION = ON.
    5. Revisar trimestralmente usuarios, roles y permisos no utilizados.
    6. Revocar de inmediato el acceso de personal desvinculado.
    7. Realizar respaldos periodicos y probar su restauracion.
    8. Registrar y revisar cambios de usuarios, roles y permisos.
*/
