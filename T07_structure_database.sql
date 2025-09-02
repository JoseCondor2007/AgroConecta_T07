-- =====================================================================================
-- AgroConecta - Script de Estructura de Base de Datos
-- Autor: Team 07
-- Descripción: Este script define la estructura de la base de datos para AgroConecta,
--              incluyendo esquemas, tipos de datos personalizados, tablas,
--              restricciones y relaciones.
-- =====================================================================================
USE master;
GO

-- Cerrar todas las conexiones a AgroConecta
ALTER DATABASE AgroConecta SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Eliminar la base de datos existente
DROP DATABASE AgroConecta;
GO