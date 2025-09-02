-- =====================================================================================
-- AgroConecta - Script de Estructura de Base de Datos
-- Autor: Team 07
-- Descripción: Este script define la estructura de la base de datos para AgroConecta,
--              incluyendo esquemas, tipos de datos personalizados, tablas,
--              restricciones y relaciones.
-- =====================================================================================

-- Crea la base de datos principal para el proyecto.
CREATE DATABASE AgroConectaDB;
GO

-- Usa la base de datos recién creada.
USE AgroConectaDB;
GO

-- --------------------------------------------------------------------------
-- 2. Creación de esquemas
-- --------------------------------------------------------------------------
-- Crea el esquema 'Maestros' para almacenar tablas de datos estáticos o de referencia.
CREATE SCHEMA Maestros;
GO

-- Crea el esquema 'Transaccional' para las tablas que manejan las operaciones diarias como los pedidos.
CREATE SCHEMA Transaccional;
GO

-- --------------------------------------------------------------------------
-- 3. Definición de tipos de datos personalizados
-- --------------------------------------------------------------------------
-- Este tipo de dato se usa para códigos de identificación únicos.
CREATE TYPE DBO.CodigoUnico FROM VARCHAR(10) NOT NULL;
GO

-- Este tipo de dato se usa para guardar descripciones de productos, direcciones, etc.
CREATE TYPE DBO.DescripcionCorta FROM VARCHAR(255) NOT NULL;
GO

-- Este tipo de dato es para números de RUC de 11 dígitos.
CREATE TYPE DBO.RUC FROM VARCHAR(11) NOT NULL;
GO

-- Este tipo de dato es para números de celular de 9 dígitos.
CREATE TYPE DBO.Celular FROM VARCHAR(9) NOT NULL;
GO

-- --------------------------------------------------------------------------
-- 4. Definición y creación de tablas
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- Tabla de Proveedores (Maestros)
-- Almacena la información de los agricultores y sus fundos.
-- --------------------------------------------------------------------------
CREATE TABLE Maestros.Proveedores (
    ProveedorID CodigoUnico PRIMARY KEY,
    NombreFundo VARCHAR(100) NOT NULL,
    NombreAgricultor VARCHAR(100) NOT NULL,
    RUC RUC UNIQUE,
    TelefonoCelular Celular,
    Region VARCHAR(50) NOT NULL
);
GO

-- --------------------------------------------------------------------------
-- Tabla de Productos (Maestros)
-- Catálogo centralizado de productos que se ofrecen en la plataforma.
-- --------------------------------------------------------------------------
CREATE TABLE Maestros.Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(100) NOT NULL,
    Descripcion DescripcionCorta,
    Categoria VARCHAR(50) NOT NULL,
    UnidadMedida VARCHAR(20) NOT NULL
);
GO

-- --------------------------------------------------------------------------
-- Tabla de Clientes (Maestros)
-- Almacena la información de los consumidores finales.
-- --------------------------------------------------------------------------
CREATE TABLE Maestros.Clientes (
    ClienteID CodigoUnico PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DNI VARCHAR(8) UNIQUE NOT NULL,
    CorreoElectronico VARCHAR(100) UNIQUE NOT NULL,
    Celular Celular,
    Calle VARCHAR(100) NOT NULL,
    NumeroCalle VARCHAR(10) NOT NULL,
    Distrito VARCHAR(50) NOT NULL,
    ReferenciaDireccion VARCHAR(255)
);
GO

-- --------------------------------------------------------------------------
-- Tabla de ProveedorProducto (Maestros)
-- Relaciona a los proveedores con los productos que ofrecen y el precio de cada uno.
-- --------------------------------------------------------------------------
CREATE TABLE Maestros.ProveedorProducto (
    ProveedorID CodigoUnico,
    ProductoID INT,
    Precio DECIMAL(10, 2) NOT NULL CHECK (Precio > 0),
    PRIMARY KEY (ProveedorID, ProductoID),
    FOREIGN KEY (ProveedorID) REFERENCES Maestros.Proveedores(ProveedorID),
    FOREIGN KEY (ProductoID) REFERENCES Maestros.Productos(ProductoID)
);
GO

-- --------------------------------------------------------------------------
-- Tabla de Pedidos (Transaccional)
-- Registra los pedidos de los clientes.
-- --------------------------------------------------------------------------
CREATE TABLE Transaccional.Pedidos (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID CodigoUnico,
    FechaPedido DATETIME NOT NULL,
    EstadoPedido VARCHAR(20) NOT NULL CHECK (EstadoPedido IN ('Recibido', 'En preparación', 'En ruta', 'Entregado')),
    FOREIGN KEY (ClienteID) REFERENCES Maestros.Clientes(ClienteID)
);
GO

-- --------------------------------------------------------------------------
-- Tabla de DetallePedido (Transaccional)
-- Contiene los productos y la cantidad de cada uno en un pedido específico.
-- --------------------------------------------------------------------------
CREATE TABLE Transaccional.DetallePedido (
    DetallePedidoID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    Cantidad DECIMAL(10, 2) NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10, 2) NOT NULL CHECK (PrecioUnitario > 0),
    FOREIGN KEY (PedidoID) REFERENCES Transaccional.Pedidos(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Maestros.Productos(ProductoID)
);
GO