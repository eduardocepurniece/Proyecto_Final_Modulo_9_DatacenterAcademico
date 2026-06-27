# Equipo #4 - Seguridad

Este directorio contiene el aporte de seguridad para la base de datos
`SolucionesEmpresarialesRD`: usuarios, roles, vistas de acceso controlado,
permisos de mínimo privilegio, políticas básicas y pruebas.

## Orden de ejecución

1. `Usuarios/01_Crear_Usuarios.sql`
2. `Roles/02_Crear_Roles.sql`
3. `Vistas_seguras/03_Crear_Vistas_Seguras.sql`
4. `Permisos/04_Asignar_Permisos.sql`
5. `Politicas/05_Politicas_Basicas.sql`
6. `Politicas/06_Pruebas_Seguridad.sql`

Antes de ejecutar estos archivos deben existir la base de datos, sus tablas,
las vistas del Equipo #3 y sus procedimientos almacenados.

## Matriz de acceso

| Rol | Acceso autorizado |
| --- | --- |
| `rol_admin_seguridad` | Administración de seguridad de la base de datos |
| `rol_ventas` | Vistas de clientes, empleados y ventas; procedimientos de ventas |
| `rol_inventario` | Vista de inventario; procedimientos de productos y existencias |
| `rol_consulta` | Solo lectura mediante las vistas del esquema `seguridad` |

Los usuarios incluidos son cuentas de demostración sin login. Esto permite
probar los permisos con `EXECUTE AS USER` sin almacenar contraseñas en el
repositorio. La creación de logins reales corresponde al DBA.
