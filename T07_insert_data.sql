-- =====================================================================================
-- AgroConecta - Script de Inserción de Datos de Prueba
-- Autor: Equipo de Arquitectura de Soluciones
-- Descripción: Este script inserta datos realistas en todas las tablas de la base de datos
--              AgroConecta para validar su estructura y funcionalidad.
-- =====================================================================================

USE AgroConecta;
GO

-- Comentario: Inserción de datos en las tablas maestras.

-- Inserción de datos en la tabla 'Proveedores' (mínimo 10 registros).
-- Los datos reflejan agricultores de distintas regiones, con sus respectivos fundos.
INSERT INTO Agro.Proveedores (nombre_fundo, nombre_agricultor, ruc, telefono, region) VALUES
('Fundo El Manantial', 'José Antezana Quispe', '10478901234', '987654321', 'Junín'),
('Chacra de los Apus', 'María Gonzales Tello', '10123456789', '998877665', 'Cusco'),
('Huerta La Esmeralda', 'Pedro Vargas Huamán', '10567890123', '976543210', 'Lima'),
('Fundo Los Andes', 'Ana Pizarro Rojas', '10901234567', '954321098', 'Arequipa'),
('Chacra del Sol', 'Juan Mamani Choque', '10345678901', '932109876', 'Puno'),
('Fundo La Esperanza', 'Rosa Medina Soto', '10876543210', '910987654', 'Piura'),
('Huerta El Paraíso', 'Carlos Ledesma Ruiz', '10210987654', '923456789', 'La Libertad'),
('Fundo La Abundancia', 'Sofía Castillo Diaz', '10654321098', '945678901', 'Lambayeque'),
('Chacra Verde', 'David Alarcón Pérez', '10098765432', '967890123', 'Huancayo'),
('Fundo El Buen Sabor', 'Juana Robles Gómez', '10789012345', '989012345', 'Ayacucho'),
('Chacra Fresca', 'Luis Ramos Castro', '10987654321', '901234567', 'Ucayali');
GO

-- Inserción de datos en la tabla 'Productos' (mínimo 10 registros).
-- Se incluyen productos de diversas categorías y unidades de medida.
INSERT INTO Agro.Productos (nombre, descripcion, categoria, unidad_medida) VALUES
('Tomate Río Grande', 'Tomate fresco de gran tamaño, ideal para ensaladas.', 'Hortaliza', 'Kilo'),
('Papa Huayro', 'Papa andina de alta calidad, perfecta para guisos.', 'Tubérculo', 'Kilo'),
('Manzana Delicia', 'Manzana dulce y jugosa, excelente para postres.', 'Fruta', 'Unidad'),
('Lechuga Americana', 'Lechuga crujiente, base para ensaladas frescas.', 'Hortaliza', 'Unidad'),
('Zanahoria', 'Zanahoria fresca y dulce, cosechada en los andes.', 'Hortaliza', 'Kilo'),
('Espinaca', 'Atado de espinaca fresca y nutritiva.', 'Hortaliza', 'Atado'),
('Plátano de la Isla', 'Plátano dulce y cremoso, de origen amazónico.', 'Fruta', 'Kilo'),
('Limón Sutil', 'Limón pequeño y muy jugoso, indispensable en la cocina peruana.', 'Fruta', 'Kilo'),
('Ají Amarillo', 'Ají picante pero sabroso, base de muchos platillos peruanos.', 'Hortaliza', 'Kilo'),
('Palta Hass', 'Palta cremosa, con alto valor nutricional.', 'Fruta', 'Unidad'),
('Cebolla Roja', 'Cebolla roja de sabor intenso, esencial para aderezos.', 'Hortaliza', 'Kilo');
GO

-- Inserción de datos en la tabla 'Clientes' (mínimo 10 registros).
-- Se incluyen clientes de diferentes distritos de la ciudad.
INSERT INTO Agro.Clientes (nombres, apellidos, dni, email, celular, calle_direccion, numero_direccion, distrito_direccion, referencia_direccion) VALUES
('Martín', 'Ruiz Salas', '47890123', 'martin.ruiz@email.com', '999111222', 'Av. La Molina', '123', 'La Molina', 'Frente al parque Los Sauces'),
('Lucía', 'Gómez Castro', '12345678', 'lucia.gomez@email.com', '988222333', 'Jr. Pardo', '456', 'Miraflores', 'A una cuadra de la Av. Larco'),
('Andrea', 'Soto Pérez', '90123456', 'andrea.soto@email.com', '977333444', 'Calle San Martín', '789', 'Barranco', 'Esquina con Jirón Grau'),
('Miguel', 'Linares Flores', '23456789', 'miguel.linares@email.com', '966444555', 'Av. Arequipa', '101', 'Lince', 'Cerca al Hospital del Niño'),
('Carla', 'Ochoa Cárdenas', '34567890', 'carla.ochoa@email.com', '955555666', 'Calle Las Magnolias', '202', 'San Isidro', 'Al costado del supermercado'),
('Roberto', 'Quispe Huamán', '45678901', 'roberto.quispe@email.com', '944666777', 'Jr. Cusco', '303', 'Cercado de Lima', 'Cerca a la Plaza Mayor'),
('Diana', 'Benites Castro', '56789012', 'diana.benites@email.com', '933777888', 'Av. Caminos del Inca', '404', 'Santiago de Surco', 'Frente a la municipalidad'),
('Jorge', 'Salazar Díaz', '67890123', 'jorge.salazar@email.com', '922888999', 'Av. Túpac Amaru', '505', 'Independencia', 'A una cuadra del centro comercial'),
('Valeria', 'Rojas Torres', '78901234', 'valeria.rojas@email.com', '911999000', 'Calle Los Jazmines', '606', 'Chorrillos', 'Al lado del colegio San Miguel'),
('Fernando', 'Torres López', '89012345', 'fernando.torres@email.com', '900100200', 'Av. El Sol', '707', 'San Juan de Miraflores', 'Cerca a la estación del tren');
GO

-- Comentario: Inserción de datos en las tablas transaccionales y de relación.

-- Inserción de datos en la tabla 'Precios_Proveedor_Producto' (mínimo 10 registros).
-- Se asignan precios a productos de distintos proveedores. Note que algunos productos
-- tienen más de un proveedor.
INSERT INTO Agro.Precios_Proveedor_Producto (id_proveedor, id_producto, precio) VALUES
(1, 1, 3.50), -- José Antezana vende Tomate Río Grande
(2, 2, 2.80), -- María Gonzales vende Papa Huayro
(3, 3, 1.20), -- Pedro Vargas vende Manzana Delicia
(4, 4, 1.50), -- Ana Pizarro vende Lechuga Americana
(5, 5, 2.00), -- Juan Mamani vende Zanahoria
(1, 6, 2.50), -- José Antezana también vende Espinaca
(7, 7, 4.00), -- Carlos Ledesma vende Plátano de la Isla
(8, 8, 3.00), -- Sofía Castillo vende Limón Sutil
(9, 9, 5.00), -- David Alarcón vende Ají Amarillo
(10, 10, 6.00),-- Juana Robles vende Palta Hass
(2, 1, 3.20); -- María Gonzales también vende Tomate Río Grande, a un precio diferente
GO

-- Inserción de datos en la tabla 'Pedidos' (mínimo 10 registros).
-- Se simulan pedidos realizados por varios clientes en diferentes fechas y con distintos estados.
INSERT INTO Agro.Pedidos (id_cliente, fecha_hora, estado_pedido) VALUES
(1, '2024-05-01 10:00:00', 'Entregado'), -- Pedido antiguo
(2, '2024-05-02 11:30:00', 'Entregado'),
(3, '2024-05-03 12:45:00', 'Entregado'),
(4, '2024-05-04 15:00:00', 'Entregado'),
(5, '2024-05-05 09:15:00', 'En preparación'),
(6, '2024-05-06 14:00:00', 'En ruta'),
(7, '2024-05-07 16:30:00', 'Recibido'),
(8, '2024-05-08 17:00:00', 'Recibido'),
(9, '2024-05-09 18:00:00', 'Recibido'),
(10, '2024-05-10 19:00:00', 'Cancelado'); -- Pedido cancelado
GO

-- Inserción de datos en la tabla 'Detalle_Pedido' (mínimo 10 registros).
-- Cada registro asocia un pedido con un producto y la cantidad solicitada.
-- Se usa el precio del producto al momento de la compra (precio_compra).
INSERT INTO Agro.Detalle_Pedido (id_pedido, id_producto, cantidad, precio_compra) VALUES
(1, 1, 2.5, 3.50), -- Cliente 1 pidió 2.5kg de tomate
(1, 2, 1.0, 2.80), -- y 1kg de papa
(2, 3, 5, 1.20), -- Cliente 2 pidió 5 manzanas
(3, 4, 2, 1.50), -- Cliente 3 pidió 2 lechugas
(4, 5, 3, 2.00), -- Cliente 4 pidió 3kg de zanahoria
(5, 6, 2, 2.50), -- Cliente 5 pidió 2 atados de espinaca
(6, 7, 1.5, 4.00), -- Cliente 6 pidió 1.5kg de plátano
(7, 8, 1, 3.00), -- Cliente 7 pidió 1kg de limón
(8, 9, 0.5, 5.00), -- Cliente 8 pidió 0.5kg de ají
(9, 10, 3, 6.00),-- Cliente 9 pidió 3 paltas
(10, 1, 1, 3.20); -- El pedido 10 (cancelado) también tiene un detalle
GO
