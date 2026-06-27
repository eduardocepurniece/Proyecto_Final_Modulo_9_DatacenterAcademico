# Fase de Diseño de Base de Datos - Soluciones Empresariales RD

## Información del Proyecto
* **Empresa:** Soluciones Empresariales RD  
* **Módulo:** Modulo 9 - Diseño e Implementación de Bases de Datos  
* **Equipo Responsable:** Equipo #2 - Diseño de Base de Datos  
* **Diseñador Técnico:** Elvis Samuel Ferreras Reyes  
* **Profesora:** Kesia Ferreras  
* **Fecha:** Junio 2026  

---

## 1. Análisis del Caso y Planteamiento del Problema
Debido a un rápido crecimiento operativo, la empresa **"Soluciones Empresariales RD"** presenta problemas de fragmentación, redundancia e inseguridad en el manejo de su información comercial. Las operaciones de registro de clientes, gestión de nómina/empleados, control de inventario físico y facturación fiscal se realizaban de forma aislada.

### Alcance del Sistema de Datos Diseñado:
* **Módulo de Entidades Maestras:** Centralización de los registros de **Clientes** y **Empleados**, garantizando la unicidad mediante llaves primarias independientes y restricciones de documentos únicos (Cédula y RNC).
* **Módulo de Catálogo e Inventario:** Control unificado de bienes en la tabla **Productos_Servicios**, diferenciando con precisión los ítems físicos (afectos a control de `Stock_Actual` y `Stock_Minimo`) de los servicios profesionales intangibles.
* **Módulo Transaccional y de Control Fiscal:** Arquitectura de facturación dividida en cabecera (**Ventas**) y desglose (**Detalle_Ventas**). Cumple con las normativas de la **DGII** en la República Dominicana mediante la validación del **NCF (Número de Comprobante Fiscal)** de 11 caracteres y el cálculo transparente del **ITBIS**.

---

## 2. Proceso de Normalización Aplicado
Para eliminar anomalías de inserción, actualización y borrado, la estructura se sometió rigurosamente a las tres primeras Formas Normales (1FN, 2FN, 3FN):

1. **Primera Forma Normal (1FN - Atomicidad):** Se eliminaron por completo los grupos repetitivos. Todos los atributos contienen valores atómicos. La separación de la venta en una cabecera global (`Ventas`) y filas independientes de artículos (`Detalle_Ventas`) evita el almacenamiento de arrays o listas en una sola celda.
2. **Segunda Forma Normal (2FN - Dependencia Completa):** Al definir Llaves Primarias (`PRIMARY KEY`) simples y auto-incrementales (`IDENTITY(1,1)`) en todas las tablas (`ID_Cliente`, `ID_Empleado`, `ID_Elemento`, `ID_Venta`), se garantiza que todos los atributos no-llave dependan de forma completa de la clave de su respectiva tabla.
3. **Tercera Forma Normal (3FN - Eliminación de Dependencias Transitivas):** Se aislaron las dependencias indirectas. En `Detalle_Ventas`, el campo `Precio_Unitario` se almacena directamente de forma histórica en el momento de la transacción. Esto evita una dependencia transitiva hacia `Productos_Servicios`, impidiendo que una alteración futura en el catálogo de precios modifique contablemente los registros históricos de ventas previas.

---

## 3. Diccionario de Datos (Estructura de Tablas)

### 1. Tabla: Clientes
| Campo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `ID_Cliente` | `INT` | `PRIMARY KEY IDENTITY(1,1)` | Identificador único del cliente. |
| `Nombre` | `VARCHAR(100)` | `NOT NULL` | Nombre del cliente o razón social. |
| `Apellido` | `VARCHAR(100)` | `NULL` | Apellido del cliente (opcional para empresas). |
| `Documento_Identidad`| `VARCHAR(11)` | `NOT NULL UNIQUE` | Cédula o RNC del cliente en RD. |
| `Telefono` | `VARCHAR(15)` | `NOT NULL` | Número telefónico de contacto. |
| `Correo` | `VARCHAR(150)` | `NULL` | Dirección de correo electrónico. |
| `Dirección` | `VARCHAR(255)` | `NULL` | Dirección física del cliente. |
| `Fecha_Registro` | `DATETIME` | `DEFAULT GETDATE()` | Fecha automática de alta en el sistema. |

### 2. Tabla: Empleados
| Campo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `ID_Empleado` | `INT` | `PRIMARY KEY IDENTITY(1,1)` | Identificador único del empleado. |
| `Nombre` | `VARCHAR(100)` | `NOT NULL` | Nombres del trabajador. |
| `Apellido` | `VARCHAR(100)` | `NOT NULL` | Apellidos del trabajador. |
| `Cédula` | `VARCHAR(11)` | `NOT NULL UNIQUE` | Cédula de identidad y electoral del empleado. |
| `Teléfono` | `VARCHAR(15)` | `NOT NULL` | Teléfono de contacto. |
| `Cargo` | `VARCHAR(50)` | `NOT NULL` | Puesto o rol dentro de la empresa. |
| `Sueldo` | `DECIMAL(10,2)` | `NOT NULL CHECK(Sueldo > 0)` | Salario base mensual en DOP. |
| `Fecha_Ingreso` | `DATE` | `NOT NULL` | Fecha de contratación formal. |

### 3. Tabla: Productos_Servicios
| Campo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `ID_Elemento` | `INT` | `PRIMARY KEY IDENTITY(1,1)` | Identificador único del producto o servicio. |
| `Nombre` | `VARCHAR(150)` | `NOT NULL` | Nombre comercial del ítem. |
| `Descripción` | `VARCHAR(MAX)` | `NULL` | Detalle o especificaciones técnicas. |
| `Tipo` | `VARCHAR(10)` | `CHECK(Tipo IN ('Producto','Servicio'))` | Clasificación del ítem del catálogo. |
| `Precio_Venta` | `DECIMAL(10,2)` | `NOT NULL CHECK(Precio_Venta >= 0)` | Precio base de venta al público. |
| `Stock_Actual` | `INT` | `DEFAULT 0` | Existencias actuales en almacén (0 para servicios).|
| `Stock_Mínimo` | `INT` | `DEFAULT 0` | Límite crítico para alertas de reabastecimiento.|

### 4. Tabla: Ventas
| Campo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `ID_Venta` | `INT` | `PRIMARY KEY IDENTITY(1,1)` | Número correlativo único de factura. |
| `ID_Cliente` | `INT` | `FOREIGN KEY REFERENCES Clientes` | Cliente que efectúa la compra. |
| `ID_Empleado` | `INT` | `FOREIGN KEY REFERENCES Empleados` | Cajero/Vendedor que procesa la venta. |
| `Fecha_Venta` | `DATETIME` | `DEFAULT GETDATE()` | Registro exacto del momento de la venta. |
| `NCF` | `VARCHAR(11)` | `NULL UNIQUE` | Número de Comprobante Fiscal (Estándar DGII). |
| `Total_parcial` | `DECIMAL(12,2)` | `NOT NULL` | Subtotal neto antes de impuestos. |
| `ITBIS` | `DECIMAL(12,2)` | `NOT NULL` | Impuesto sobre Transferencias de Bienes Industriales.|
| `Total` | `DECIMAL(12,2)` | `NOT NULL` | Monto neto final cobrado (Subtotal + ITBIS). |

### 5. Tabla: Detalle_Ventas
| Campo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `ID_Detalle` | `INT` | `PRIMARY KEY IDENTITY(1,1)` | Código único de la línea de detalle. |
| `ID_Venta` | `INT` | `FOREIGN KEY REFERENCES Ventas` | Vinculación con la factura cabecera. |
| `ID_Elemento` | `INT` | `FOREIGN KEY REFERENCES Productos_Servicios` | Item del catálogo vendido. |
| `Cantidad` | `INT` | `NOT NULL CHECK(Cantidad > 0)` | Cantidad física o unidades transaccionadas. |
| `Precio_Unitario`| `DECIMAL(10,2)` | `NOT NULL` | Precio de adjudicación en el momento exacto. |
| `Descuento` | `DECIMAL(10,2)` | `DEFAULT 0.00` | Monto rebajado de la línea si aplica. |

---

## 4. Matriz de Relaciones e Integridad Referencial
El modelo gráfico implementado en la solución define rigurosamente las siguientes reglas de negocio:

* **Clientes (1) ─── 🔑 ─── (N) Ventas:** Un cliente puede poseer múltiples facturas registradas a lo largo del tiempo, pero una venta obligatoriamente debe asociarse a un único cliente registrado.
* **Empleados (1) ─── 🔑 ─── (N) Ventas:** Un empleado tiene la capacidad de facturar múltiples transacciones, pero una venta específica responde a un único empleado responsable del cuadre físico de caja.
* **Ventas (1) ─── 🔑 ─── (N) Detalle_Ventas:** Una factura cabecera contiene uno o muchos ítems desglosados de manera independiente en su detalle.
* **Productos_Servicios (1) ─── 🔑 ─── (N) Detalle_Ventas:** Un producto o servicio puede ser comercializado múltiples veces y figurar en infinitos detalles de facturas diferentes, pero cada registro del detalle apunta a un solo elemento del catálogo.

---

## 5. Modelo Entidad-Relación (MER)
El diseño lógico estructurado bajo la notación *Crow's Foot* (Pata de Gallo) ha sido exportado en formato de imagen de alta fidelidad y se encuentra disponible en la raíz de esta documentación técnica con el nombre:
`Modelo_Entidad_Relacion.png`

---
*Documento preparado con éxito por el **Equipo #2 de Diseño** para el pase formal al **Equipo #3 (Desarrollo SQL)**.*
