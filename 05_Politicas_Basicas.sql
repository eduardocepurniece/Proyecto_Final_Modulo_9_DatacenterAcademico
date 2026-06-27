/*
    Equipo #4 - Seguridad
    Script 04: matriz de permisos

    Principio aplicado: minimo privilegio. Los roles operativos no acceden
    directamente a las tablas; usan vistas y procedimientos autorizados.
*/

USE SolucionesEmpresarialesRD;
GO

-- Administracion de seguridad de la base de datos.
GRANT CONTROL ON DATABASE::SolucionesEmpresarialesRD TO [rol_admin_seguridad];
GO

-- Ventas: consulta limitada y ejecucion de operaciones del area.
GRANT SELECT ON OBJECT::[seguridad].[vw_ClientesContacto] TO [rol_ventas];
GRANT SELECT ON OBJECT::[seguridad].[vw_EmpleadosDirectorio] TO [rol_ventas];
GRANT SELECT ON OBJECT::[seguridad].[vw_VentasResumen] TO [rol_ventas];
GRANT SELECT ON OBJECT::[seguridad].[vw_ResumenVentasCliente] TO [rol_ventas];
GRANT EXECUTE ON OBJECT::[dbo].[sp_RegistrarCliente] TO [rol_ventas];
GRANT EXECUTE ON OBJECT::[dbo].[sp_RegistrarVentaProducto] TO [rol_ventas];
GRANT EXECUTE ON OBJECT::[dbo].[sp_ConsultarVentasPorCliente] TO [rol_ventas];
GRANT EXECUTE ON OBJECT::[dbo].[sp_ConsultarVentasPorFecha] TO [rol_ventas];
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[dbo] TO [rol_ventas];
GO

-- Inventario: catalogo visible y operaciones de inventario autorizadas.
GRANT SELECT ON OBJECT::[seguridad].[vw_InventarioConsulta] TO [rol_inventario];
GRANT EXECUTE ON OBJECT::[dbo].[sp_RegistrarProducto] TO [rol_inventario];
GRANT EXECUTE ON OBJECT::[dbo].[sp_ActualizarStock] TO [rol_inventario];
GRANT EXECUTE ON OBJECT::[dbo].[sp_ConsultarProductosStockBajo] TO [rol_inventario];
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[dbo] TO [rol_inventario];
GO

-- Consulta: acceso de solo lectura exclusivamente mediante vistas seguras.
GRANT SELECT ON SCHEMA::[seguridad] TO [rol_consulta];
DENY SELECT, INSERT, UPDATE, DELETE, EXECUTE ON SCHEMA::[dbo] TO [rol_consulta];
GO

-- Los roles operativos no pueden cambiar la definicion de la capa segura.
-- REVOKE elimina un posible DENY CONTROL aplicado por una version anterior,
-- ya que CONTROL tambien anularia indirectamente el permiso SELECT.
REVOKE CONTROL ON SCHEMA::[seguridad] FROM [rol_ventas];
REVOKE CONTROL ON SCHEMA::[seguridad] FROM [rol_inventario];
REVOKE CONTROL ON SCHEMA::[seguridad] FROM [rol_consulta];

DENY ALTER, TAKE OWNERSHIP, VIEW DEFINITION ON SCHEMA::[seguridad] TO [rol_ventas];
DENY ALTER, TAKE OWNERSHIP, VIEW DEFINITION ON SCHEMA::[seguridad] TO [rol_inventario];
DENY ALTER, TAKE OWNERSHIP, VIEW DEFINITION ON SCHEMA::[seguridad] TO [rol_consulta];
GO
