-- Script de tablas temporales para el análisis de ventas en AgroConecta
-- Autor: Team 07
-- Descripción: Este script crea tablas temporales para generar reportes y análisis
-- sobre los datos de ventas y productos.


USE AgroConectaDB;
GO

-- --------------------------------------------------------------------------
-- Caso de uso 1: Tabla Temporal Local (#CarritoCompras)
-- ##########################################################################
-- Descripción:
-- Simula un carrito de compras temporal para un usuario.
-- Ventajas:
-- - Rápido: Se crea y destruye en la sesión del usuario.
-- - Aislamiento: Cada usuario tiene su propio carrito, sin conflictos.
-- Riesgos:
-- - Pérdida de datos: Si la conexión se interrumpe, el carrito se pierde.
-- --------------------------------------------------------------------------
-- Simula el proceso de un cliente añadiendo productos a su carrito.
CREATE TABLE #CarritoCompras (
    ProductoID INT,
    NombreProducto VARCHAR(100),
    Cantidad DECIMAL(10, 2),
    PrecioUnitario DECIMAL(10, 2)
);

-- Inserta productos en el carrito temporal para el cliente.
INSERT INTO #CarritoCompras (ProductoID, NombreProducto, Cantidad, PrecioUnitario)
VALUES
(1, 'Tomate Río Grande', 2.5, 3.50),
(4, 'Zanahoria', 1.0, 1.50),
(6, 'Palta Fuerte', 3.0, 4.00);

-- Muestra el contenido del carrito.
SELECT * FROM #CarritoCompras;

-- Al finalizar la sesión o ejecutar el script, la tabla temporal #CarritoCompras se elimina automáticamente.
GO

-- --------------------------------------------------------------------------
-- Caso de uso 2: Tabla Temporal Local (#ResumenPedidosCliente)
-- ##########################################################################
-- Descripción:
-- Crea un resumen temporal de los pedidos y el monto total de un cliente.
-- Ventajas:
-- - Eficiencia: Permite realizar cálculos complejos una sola vez y consultar los resultados.
-- - Reutilización: La tabla se puede usar en múltiples consultas dentro de la sesión.
-- Riesgos:
-- - Uso de memoria: Puede consumir recursos si se usan datos muy grandes.
-- --------------------------------------------------------------------------
-- Simula la creación de un resumen de pedidos para el cliente 'CLI001'.
CREATE TABLE #ResumenPedidosCliente (
    PedidoID INT,
    TotalPedido DECIMAL(10, 2)
);

-- Calcula el total de cada pedido del cliente 'CLI001' y lo inserta en la tabla temporal.
INSERT INTO #ResumenPedidosCliente (PedidoID, TotalPedido)
SELECT
    P.PedidoID,
    SUM(DP.Cantidad * DP.PrecioUnitario) AS TotalPedido
FROM
    Transaccional.Pedidos AS P
INNER JOIN
    Transaccional.DetallePedido AS DP ON P.PedidoID = DP.PedidoID
WHERE
    P.ClienteID = 'CLI001'
GROUP BY
    P.PedidoID;

-- Muestra el resumen de los pedidos.
SELECT * FROM #ResumenPedidosCliente;

-- La tabla se elimina al terminar la sesión.
GO

-- --------------------------------------------------------------------------
-- Caso de uso 3: Tabla Temporal Global (##PedidosDiarios)
-- ##########################################################################
-- Descripción:
-- Consolida los pedidos realizados en el día para que sean visibles por todos los usuarios conectados.
-- Ventajas:
-- - Compartida: Accesible desde cualquier sesión de SQL Server.
-- - Centralizada: Permite una visión consolidada para reportes o procesos batch.
-- Riesgos:
-- - Colisión de nombres: El nombre debe ser único entre todas las sesiones.
-- - Permanencia: Persiste hasta que la última conexión que la usa se cierra.
-- --------------------------------------------------------------------------
-- Crea la tabla global para almacenar el resumen de pedidos diarios.
CREATE TABLE ##PedidosDiarios (
    Fecha DATE,
    TotalPedidos INT,
    MontoTotal DECIMAL(10, 2)
);

-- Inserta el resumen de pedidos del día actual.
INSERT INTO ##PedidosDiarios (Fecha, TotalPedidos, MontoTotal)
SELECT
    CAST(FechaPedido AS DATE),
    COUNT(DISTINCT P.PedidoID),
    SUM(DP.Cantidad * DP.PrecioUnitario)
FROM
    Transaccional.Pedidos AS P
INNER JOIN
    Transaccional.DetallePedido AS DP ON P.PedidoID = DP.PedidoID
WHERE
    CAST(FechaPedido AS DATE) = CAST(GETDATE() AS DATE)
GROUP BY
    CAST(FechaPedido AS DATE);

-- Muestra el resumen global.
SELECT * FROM ##PedidosDiarios;

-- La tabla persistirá hasta que la última sesión que la esté usando se cierre.
GO

-- --------------------------------------------------------------------------
-- Caso de uso 4: Tabla Temporal Global (##TopProductosVendidos)
-- ##########################################################################
-- Descripción:
-- Genera un ranking global de los productos más vendidos en un período.
-- Ventajas:
-- - Visión de negocio: Proporciona información valiosa que puede ser usada por diferentes áreas.
-- - Escalabilidad: Permite que múltiples procesos accedan a la misma información.
-- Riesgos:
-- - Sincronización: Si otro proceso la modifica, puede afectar los resultados de otra sesión.
-- --------------------------------------------------------------------------
-- Crea una tabla temporal global para el ranking de productos.
CREATE TABLE ##TopProductosVendidos (
    ProductoID INT,
    NombreProducto VARCHAR(100),
    CantidadTotal DECIMAL(10, 2)
);

-- Llena la tabla con los productos más vendidos del último mes.
INSERT INTO ##TopProductosVendidos (ProductoID, NombreProducto, CantidadTotal)
SELECT TOP 10
    P.ProductoID,
    P.NombreProducto,
    SUM(DP.Cantidad) AS CantidadTotal
FROM
    Transaccional.DetallePedido AS DP
INNER JOIN
    Transaccional.Pedidos AS PE ON DP.PedidoID = PE.PedidoID
INNER JOIN
    Maestros.Productos AS P ON DP.ProductoID = P.ProductoID
WHERE
    PE.FechaPedido >= DATEADD(MONTH, -1, GETDATE())
GROUP BY
    P.ProductoID, P.NombreProducto
ORDER BY
    CantidadTotal DESC;

-- Muestra el ranking.
SELECT * FROM ##TopProductosVendidos;

-- Esta tabla se eliminará cuando la última sesión que la usa termine.
GO