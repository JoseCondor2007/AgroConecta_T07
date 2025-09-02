-- =====================================================================================
-- AgroConecta - Script de Filegroups y Particionamiento
-- Autor: Team 07
-- Descripción: Este script implementa una estrategia de particionamiento de datos
--              en las tablas 'Pedidos' y 'Detalle_Pedido' para optimizar el
--              rendimiento y la gestión de datos históricos.
-- =====================================================================================

USE master;
GO

-- Si la base de datos AgroConectaDB existe, la elimina para empezar desde cero.
IF DB_ID('AgroConectaDB') IS NOT NULL
BEGIN
    ALTER DATABASE AgroConectaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AgroConectaDB;
END
GO

-- --------------------------------------------------------------------------
-- 2. Recreación de la base de datos (con filegroups y particionamiento)
-- --------------------------------------------------------------------------
CREATE DATABASE AgroConectaDB;
GO

USE AgroConectaDB;
GO

-- Se crean los filegroups.
ALTER DATABASE AgroConectaDB ADD FILEGROUP FG_Pedidos_2023;
ALTER DATABASE AgroConectaDB ADD FILEGROUP FG_Pedidos_2024;
ALTER DATABASE AgroConectaDB ADD FILEGROUP FG_Pedidos_2025;
ALTER DATABASE AgroConectaDB ADD FILEGROUP FG_Pedidos_Futuros;

-- Se agregan archivos físicos a cada filegroup. Se usa una ruta genérica
-- para entornos Docker como Codespaces.
ALTER DATABASE AgroConectaDB ADD FILE (
    NAME = 'Pedidos_2023_Data',
    FILENAME = '/var/opt/mssql/data/Pedidos_2023_Data.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG_Pedidos_2023;

ALTER DATABASE AgroConectaDB ADD FILE (
    NAME = 'Pedidos_2024_Data',
    FILENAME = '/var/opt/mssql/data/Pedidos_2024_Data.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG_Pedidos_2024;

ALTER DATABASE AgroConectaDB ADD FILE (
    NAME = 'Pedidos_2025_Data',
    FILENAME = '/var/opt/mssql/data/Pedidos_2025_Data.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG_Pedidos_2025;

ALTER DATABASE AgroConectaDB ADD FILE (
    NAME = 'Pedidos_Futuros_Data',
    FILENAME = '/var/opt/mssql/data/Pedidos_Futuros_Data.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG_Pedidos_Futuros;
GO

-- --------------------------------------------------------------------------
-- 3. Creación de Partition Function y Partition Scheme
-- --------------------------------------------------------------------------
CREATE PARTITION FUNCTION fn_Pedidos_Fecha (DATETIME)
AS RANGE RIGHT FOR VALUES ('2023-12-31', '2024-12-31', '2025-12-31');
GO

CREATE PARTITION SCHEME ps_Pedidos_Fecha
AS PARTITION fn_Pedidos_Fecha
TO (FG_Pedidos_2023, FG_Pedidos_2024, FG_Pedidos_2025, FG_Pedidos_Futuros);
GO

-- --------------------------------------------------------------------------
-- 4. Creación de las tablas (simplificado para el ejemplo)
-- --------------------------------------------------------------------------
-- Se crean los tipos de datos personalizados
CREATE TYPE DBO.CodigoUnico FROM VARCHAR(10) NOT NULL;
CREATE TYPE DBO.Celular FROM VARCHAR(9) NOT NULL;
GO

-- Se crean las tablas Maestras
CREATE SCHEMA Maestros;
GO
CREATE TABLE Maestros.Clientes (
    ClienteID CodigoUnico PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL
);
GO
CREATE TABLE Maestros.Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(100) NOT NULL
);
GO
CREATE TABLE Maestros.ProveedorProducto (
    ProveedorID CodigoUnico,
    ProductoID INT,
    Precio DECIMAL(10, 2)
);
GO

-- Se crea el esquema Transaccional.
CREATE SCHEMA Transaccional;
GO

-- Se crea la tabla Pedidos con el esquema de partición.
CREATE TABLE Transaccional.Pedidos (
    PedidoID INT IDENTITY(1,1),
    ClienteID CodigoUnico,
    FechaPedido DATETIME NOT NULL,
    EstadoPedido VARCHAR(20) NOT NULL,
    PRIMARY KEY (PedidoID, FechaPedido)
) ON ps_Pedidos_Fecha (FechaPedido);
GO

-- Se crea la tabla DetallePedido.
CREATE TABLE Transaccional.DetallePedido (
    DetallePedidoID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    Cantidad DECIMAL(10, 2),
    PrecioUnitario DECIMAL(10, 2),
    CONSTRAINT FK_DetallePedido_Pedidos FOREIGN KEY (PedidoID) REFERENCES Transaccional.Pedidos(PedidoID)
);
GO