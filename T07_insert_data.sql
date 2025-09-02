-- =====================================================================================
-- AgroConecta - Script de Inserción de Datos de Prueba
-- Autor: Team 07
-- Descripción: Este script inserta datos realistas en todas las tablas de la base de datos
--              AgroConecta para validar su estructura y funcionalidad.
-- =====================================================================================

USE AgroConectaDB;
GO

-- --------------------------------------------------------------------------
-- Inserción de 10 registros en la tabla 'Proveedores' (Maestra)
-- Simula el registro de agricultores de diferentes regiones de Perú.
-- --------------------------------------------------------------------------
INSERT INTO Maestros.Proveedores (ProveedorID, NombreFundo, NombreAgricultor, RUC, TelefonoCelular, Region)
VALUES
('PRV001', 'Fundo La Esperanza', 'Juan Pérez', '10123456789', '987654321', 'Lima'),
('PRV002', 'Chacra El Paraíso', 'María Gonzales', '10987654321', '912345678', 'Junín'),
('PRV003', 'Fundo San José', 'Carlos Vargas', '10555666777', '999888777', 'Ica'),
('PRV004', 'Granja El Sol', 'Ana Torres', '10111222333', '955443322', 'Lima'),
('PRV005', 'Huerto Verde', 'Pedro Ríos', '10444555666', '933221100', 'Ayacucho'),
('PRV006', 'Tierra Fértil', 'Sofía Castillo', '10777888999', '966778899', 'Cusco'),
('PRV007', 'Cultivos Andinos', 'Luis Mendoza', '10888999000', '977889900', 'Puno'),
('PRV008', 'La Huerta de Luis', 'Luis Valdivia', '10999000111', '988990011', 'Arequipa'),
('PRV009', 'El Edén', 'Clara Soto', '10222333444', '911223344', 'Lima'),
('PRV010', 'Campos Floridos', 'Jorge Ramos', '10333444555', '922334455', 'Piura');

-- --------------------------------------------------------------------------
-- Inserción de 10 registros en la tabla 'Productos' (Maestra)
-- Catálogo de productos variados que se podrían ofrecer.
-- --------------------------------------------------------------------------
INSERT INTO Maestros.Productos (NombreProducto, Descripcion, Categoria, UnidadMedida)
VALUES
('Tomate Río Grande', 'Tomate fresco de la mejor calidad.', 'Hortaliza', 'Kilo'),
('Papa Huayro', 'Papa andina, ideal para sancochados.', 'Tubérculo', 'Kilo'),
('Aguaymanto', 'Fruta exótica con sabor agridulce.', 'Fruta', 'Atado'),
('Zanahoria', 'Zanahoria fresca y crujiente.', 'Hortaliza', 'Kilo'),
('Cebolla Roja', 'Cebolla roja de buen tamaño.', 'Hortaliza', 'Unidad'),
('Palta Fuerte', 'Palta cremosa y deliciosa.', 'Fruta', 'Unidad'),
('Mango Kent', 'Mango dulce y jugoso de temporada.', 'Fruta', 'Kilo'),
('Lechuga Americana', 'Lechuga ideal para ensaladas.', 'Hortaliza', 'Unidad'),
('Espinaca', 'Hojas de espinaca frescas.', 'Hortaliza', 'Atado'),
('Maíz Choclo', 'Choclo tierno para ensaladas o sancochados.', 'Cereal', 'Unidad');

-- --------------------------------------------------------------------------
-- Inserción de 10 registros en la tabla 'Clientes' (Maestra)
-- Información de clientes registrados en la plataforma.
-- --------------------------------------------------------------------------
INSERT INTO Maestros.Clientes (ClienteID, Nombres, Apellidos, DNI, CorreoElectronico, Celular, Calle, NumeroCalle, Distrito, ReferenciaDireccion)
VALUES
('CLI001', 'Laura', 'Pérez', '12345678', 'laura.perez@email.com', '987654321', 'Avenida del Sol', '123', 'Miraflores', 'Frente al parque'),
('CLI002', 'Roberto', 'Gómez', '87654321', 'roberto.gomez@email.com', '912345678', 'Calle de las Rosas', '45', 'San Isidro', 'Al costado del banco'),
('CLI003', 'Sofía', 'Vargas', '11223344', 'sofia.vargas@email.com', '999888777', 'Jirón Los Pinos', '200', 'Surco', 'Cerca al mercado'),
('CLI004', 'Diego', 'Rojas', '55667788', 'diego.rojas@email.com', '955443322', 'Avenida Las Palmeras', '50', 'Barranco', 'Esquina con Calle El Roble'),
('CLI005', 'Carla', 'Mendoza', '99001122', 'carla.mendoza@email.com', '933221100', 'Calle Los Jazmines', '78', 'La Molina', 'Al lado de la tienda de abarrotes'),
('CLI006', 'Felipe', 'Quispe', '33445566', 'felipe.quispe@email.com', '966778899', 'Avenida La Marina', '300', 'San Miguel', 'Departamento en tercer piso'),
('CLI007', 'Ana', 'Sánchez', '77889900', 'ana.sanchez@email.com', '977889900', 'Jirón La Paz', '15', 'Lince', 'Casa de dos pisos con puerta azul'),
('CLI008', 'Paola', 'Castro', '22334455', 'paola.castro@email.com', '988990011', 'Calle Manco Inca', '60', 'Jesús María', 'Edificio de ladrillos rojos'),
('CLI009', 'Luis', 'Ramos', '66778899', 'luis.ramos@email.com', '911223344', 'Avenida El Bosque', '90', 'Pueblo Libre', 'Referencia: Tienda El Buen Pan'),
('CLI010', 'Diana', 'Torres', '44556677', 'diana.torres@email.com', '922334455', 'Jirón Tarapacá', '180', 'Breña', 'Casa de esquina, pared color blanco');

-- --------------------------------------------------------------------------
-- Inserción de 10 registros en la tabla 'ProveedorProducto' (Maestra)
-- Relaciona productos con proveedores y sus precios.
-- --------------------------------------------------------------------------
INSERT INTO Maestros.ProveedorProducto (ProveedorID, ProductoID, Precio)
VALUES
('PRV001', 1, 3.50), -- Tomate Río Grande
('PRV002', 2, 2.80), -- Papa Huayro
('PRV003', 3, 7.50), -- Aguaymanto
('PRV004', 1, 3.20), -- Tomate Río Grande
('PRV005', 4, 1.50), -- Zanahoria
('PRV006', 5, 2.00), -- Cebolla Roja
('PRV007', 6, 4.00), -- Palta Fuerte
('PRV008', 7, 5.50), -- Mango Kent
('PRV009', 8, 1.80), -- Lechuga Americana
('PRV010', 9, 2.20); -- Espinaca

-- --------------------------------------------------------------------------
-- Inserción de 10 registros en la tabla 'Pedidos' (Transaccional)
-- Simula los pedidos realizados por los clientes en diferentes fechas.
-- --------------------------------------------------------------------------
INSERT INTO Transaccional.Pedidos (ClienteID, FechaPedido, EstadoPedido)
VALUES
('CLI001', GETDATE(), 'Recibido'),
('CLI002', GETDATE(), 'En preparación'),
('CLI003', DATEADD(DAY, -1, GETDATE()), 'En ruta'),
('CLI004', DATEADD(DAY, -2, GETDATE()), 'Entregado'),
('CLI005', DATEADD(DAY, -3, GETDATE()), 'Recibido'),
('CLI006', GETDATE(), 'Recibido'),
('CLI007', DATEADD(DAY, -4, GETDATE()), 'Entregado'),
('CLI008', DATEADD(DAY, -1, GETDATE()), 'En preparación'),
('CLI009', DATEADD(DAY, -2, GETDATE()), 'En ruta'),
('CLI010', GETDATE(), 'Recibido');

-- --------------------------------------------------------------------------
-- Inserción de 10 registros en la tabla 'DetallePedido' (Transaccional)
-- Asocia productos y cantidades a los pedidos creados.
-- --------------------------------------------------------------------------
INSERT INTO Transaccional.DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario)
VALUES
(1, 1, 2.5, 3.50), -- Pedido 1: 2.5 kilos de Tomate Río Grande
(1, 2, 3.0, 2.80), -- Pedido 1: 3 kilos de Papa Huayro
(2, 4, 1.0, 1.50), -- Pedido 2: 1 kilo de Zanahoria
(3, 5, 2.0, 2.00), -- Pedido 3: 2 unidades de Cebolla Roja
(4, 6, 1.0, 4.00), -- Pedido 4: 1 unidad de Palta Fuerte
(5, 7, 2.0, 5.50), -- Pedido 5: 2 kilos de Mango Kent
(6, 8, 1.0, 1.80), -- Pedido 6: 1 unidad de Lechuga Americana
(7, 9, 3.0, 2.20), -- Pedido 7: 3 atados de Espinaca
(8, 1, 1.5, 3.20), -- Pedido 8: 1.5 kilos de Tomate Río Grande
(9, 2, 5.0, 2.80), -- Pedido 9: 5 kilos de Papa Huayro
(10, 3, 2.0, 7.50); -- Pedido 10: 2 atados de Aguaymanto