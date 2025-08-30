-- =====================================================================================
-- AgroConecta - Script de Estructura de Base de Datos
-- Autor: Equipo de Arquitectura de Soluciones
-- Descripción: Este script define la estructura de la base de datos para AgroConecta,
--              incluyendo esquemas, tipos de datos personalizados, tablas,
--              restricciones y relaciones.
-- =====================================================================================

-- Creación de la base de datos
-- DROP DATABASE IF EXISTS AgroConecta;
CREATE DATABASE AgroConecta;
GO

USE AgroConecta;
GO

-- =====================================================================================
-- 1. Creación de Esquemas
-- =====================================================================================
-- Se crea un esquema 'Agro' para organizar todas las tablas de la aplicación.
CREATE SCHEMA Agro;
GO

-- =====================================================================================
-- 2. Creación de Tipos de Datos Personalizados
-- =====================================================================================
-- Se definen tipos de datos optimizados para mejorar la consistencia y el control
-- sobre los datos que se van a almacenar.

-- Tipo para números de teléfono, asegurando un formato consistente.
CREATE TYPE tipo_telefono FROM VARCHAR(20);
GO

-- Tipo para números de RUC, validando una longitud fija para empresas en Perú.
CREATE TYPE tipo_ruc FROM CHAR(11);
GO

-- Tipo para números de DNI, validando una longitud fija para identificaciones en Perú.
CREATE TYPE tipo_dni FROM CHAR(8);
GO

-- Tipo para valores monetarios, asegurando precisión decimal para precios y totales.
CREATE TYPE tipo_moneda FROM DECIMAL(10, 2);
GO

-- =====================================================================================
-- 3. Creación de Tablas y Restricciones
-- =====================================================================================

-- Tabla para gestionar la información de los proveedores (agricultores).
-- Es una tabla maestra.
CREATE TABLE Agro.Proveedores (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria autoincremental
    nombre_fundo VARCHAR(100) NOT NULL,
    nombre_agricultor VARCHAR(100) NOT NULL,
    ruc tipo_ruc UNIQUE NOT NULL, -- El RUC debe ser único
    telefono tipo_telefono NOT NULL,
    region VARCHAR(50) NOT NULL,
    fecha_registro DATETIME DEFAULT GETDATE() -- Fecha de registro para control
);
GO

-- Tabla para el catálogo central de productos.
-- Es una tabla maestra.
CREATE TABLE Agro.Productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria autoincremental
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria VARCHAR(50) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL, -- Ejemplo: Kilo, Atado, Unidad
    CONSTRAINT CHK_UnidadMedida CHECK (unidad_medida IN ('Kilo', 'Atado', 'Unidad'))
);
GO

-- Tabla intermedia que relaciona proveedores con productos y sus precios.
-- Esto permite que un mismo producto tenga distintos precios según el proveedor.
CREATE TABLE Agro.Precios_Proveedor_Producto (
    id_precio INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria
    id_proveedor INT NOT NULL,
    id_producto INT NOT NULL,
    precio tipo_moneda NOT NULL,
    fecha_actualizacion DATE DEFAULT GETDATE(), -- Fecha de última actualización del precio
    -- Restricción para asegurar que un precio sea mayor a cero
    CONSTRAINT CHK_PrecioPositivo CHECK (precio > 0),
    -- Clave foránea a la tabla Proveedores
    CONSTRAINT FK_Precios_Proveedor_Producto_Proveedores FOREIGN KEY (id_proveedor) REFERENCES Agro.Proveedores(id_proveedor),
    -- Clave foránea a la tabla Productos
    CONSTRAINT FK_Precios_Proveedor_Producto_Productos FOREIGN KEY (id_producto) REFERENCES Agro.Productos(id_producto),
    -- Restricción para evitar duplicados de (proveedor, producto)
    CONSTRAINT UQ_Proveedor_Producto UNIQUE (id_proveedor, id_producto)
);
GO

-- Tabla para almacenar la información de los clientes.
-- Es una tabla maestra.
CREATE TABLE Agro.Clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria autoincremental
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    dni tipo_dni UNIQUE NOT NULL, -- El DNI debe ser único
    email VARCHAR(100) UNIQUE NOT NULL, -- El email debe ser único
    celular tipo_telefono NOT NULL,
    calle_direccion VARCHAR(100) NOT NULL,
    numero_direccion VARCHAR(20),
    distrito_direccion VARCHAR(50) NOT NULL,
    referencia_direccion TEXT
);
GO

-- Tabla para gestionar los pedidos de los clientes.
-- Es una tabla transaccional.
CREATE TABLE Agro.Pedidos (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria autoincremental
    id_cliente INT NOT NULL,
    fecha_hora DATETIME DEFAULT GETDATE(),
    estado_pedido VARCHAR(50) NOT NULL,
    -- Restricción para el estado del pedido, garantizando la integridad de los datos
    CONSTRAINT CHK_EstadoPedido CHECK (estado_pedido IN ('Recibido', 'En preparación', 'En ruta', 'Entregado', 'Cancelado')),
    -- Clave foránea a la tabla Clientes
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (id_cliente) REFERENCES Agro.Clientes(id_cliente)
);
GO

-- Tabla para los detalles de cada pedido.
-- Es una tabla transaccional.
CREATE TABLE Agro.Detalle_Pedido (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad DECIMAL(10, 2) NOT NULL,
    precio_compra tipo_moneda NOT NULL, -- Precio del producto al momento de la compra
    -- Restricción para asegurar que la cantidad sea mayor a cero
    CONSTRAINT CHK_CantidadPositiva CHECK (cantidad > 0),
    -- Clave foránea a la tabla Pedidos
    CONSTRAINT FK_Detalle_Pedido_Pedidos FOREIGN KEY (id_pedido) REFERENCES Agro.Pedidos(id_pedido),
    -- Clave foránea a la tabla Productos
    CONSTRAINT FK_Detalle_Pedido_Productos FOREIGN KEY (id_producto) REFERENCES Agro.Productos(id_producto)
);
GO
