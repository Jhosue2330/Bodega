-- =======================================================
-- 1. LIMPIEZA TOTAL (Para iniciar siempre limpio y sin errores)
-- =======================================================
SET REFERENTIAL_INTEGRITY FALSE;
TRUNCATE TABLE DETALLE_VENTA;
TRUNCATE TABLE MOVIMIENTO_INVENTARIO;
TRUNCATE TABLE PROMOCION_PRODUCTO;
TRUNCATE TABLE VENTA;
TRUNCATE TABLE PRODUCTO;
TRUNCATE TABLE CATEGORIA;
TRUNCATE TABLE ESTADO_VENTA;
TRUNCATE TABLE USUARIO;
TRUNCATE TABLE ROL;
TRUNCATE TABLE PROMOCION;
SET REFERENTIAL_INTEGRITY TRUE;

-- =======================================================
-- 2. ROLES Y USUARIOS
-- =======================================================
INSERT INTO ROL (id_rol, nombre) VALUES (1, 'ADMINISTRADOR'), (2, 'VENDEDOR'), (3, 'REPARTIDOR');

INSERT INTO USUARIO (id_usuario, nombre_completo, correo, hash_password, telefono, id_rol, activo) VALUES 
(1, 'Josdin Admin', 'admin@bodega.com', '123', '999999999', 1, TRUE),
(2, 'Carlos Vendedor', 'carlos@bodega.com', '123', '988888888', 2, TRUE),
(3, 'Pepe Motorizado', 'moto@bodega.com', '123', '977777777', 3, TRUE);

-- =======================================================
-- 3. ESTADOS DE VENTA (Crucial para el flujo Delivery)
-- =======================================================
INSERT INTO ESTADO_VENTA (id_estado, nombre) VALUES 
(1, 'REGISTRADA'),  -- Venta normal en caja
(2, 'PENDIENTE'),   -- Delivery recién pedido
(3, 'EN CAMINO'),   -- Delivery salido
(4, 'ENTREGADO'),   -- Delivery finalizado
(5, 'CANCELADO');   -- Delivery fallido

-- =======================================================
-- 4. CATEGORÍAS
-- =======================================================
INSERT INTO CATEGORIA (id_categoria, nombre, descripcion, activo) VALUES 
(1, 'Abarrotes', 'Productos de primera necesidad', TRUE),
(2, 'Bebidas', 'Gaseosas, Aguas y Jugos', TRUE),
(3, 'Licores', 'Cervezas, Vinos y Destilados', TRUE),
(4, 'Snacks', 'Piqueos, Galletas y Dulces', TRUE),
(5, 'Limpieza', 'Detergentes y Aseo personal', TRUE),
(6, 'Tecnología', 'Accesorios y Periféricos', TRUE);

-- =======================================================
-- 5. PRODUCTOS (Con Stock variado para probar Alertas)
-- =======================================================
INSERT INTO PRODUCTO (id_producto, nombre, sku, precio, stock_actual, stock_minimo, id_categoria, activo) VALUES
-- ID 1-10: Productos Normales
(1, 'Arroz Costeño 5kg',    'ARR-005',  24.90, 50, 5, 1, TRUE),
(2, 'Aceite Primor 1L',     'ACE-001',  11.50, 60, 5, 1, TRUE),
(3, 'Azúcar Rubia 1kg',     'AZU-001',   4.20, 40, 5, 1, TRUE),
(4, 'Leche Gloria Azul',    'LAC-001',   4.50, 100, 10, 1, TRUE),
(5, 'Coca Cola 3L',         'GAS-001',  12.00, 35, 10, 2, TRUE),
(6, 'Inca Kola 1.5L',       'GAS-002',   7.50, 30, 5, 2, TRUE),
(7, 'Agua San Mateo 2.5L',  'AGU-001',   3.50, 40, 5, 2, TRUE),
(8, 'Cerveza Pilsen 650ml', 'LIC-001',   8.00, 120, 24, 3, TRUE),
(9, 'Papas Lays Clásicas',  'SNK-001',   6.00, 25, 5, 4, TRUE),
(10,'Detergente Bolívar',   'LIM-001',  15.00, 15, 5, 5, TRUE),

-- ID 11-13: Productos ALERTA STOCK BAJO (Para probar KPI Bodeguero)
(11,'Audífonos Bluetooth',  'TEC-001',  45.00, 2, 5, 6, TRUE), -- Stock 2, Min 5 -> ALERTA
(12,'Mouse Gamer RGB',      'TEC-002',  35.00, 1, 3, 6, TRUE), -- Stock 1, Min 3 -> ALERTA
(13,'Cif Crema Limón',      'LIM-002',  12.50, 0, 5, 5, TRUE); -- Stock 0 -> SIN STOCK

-- =======================================================
-- 6. VENTAS HISTÓRICAS (Para llenar gráficos de Métricas)
--    Usamos DATEADD para que siempre sean relativas a "HOY"
-- =======================================================

-- HACE 2 MESES (Para gráfico mensual)
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (1, DATEADD('MONTH', -2, CURRENT_TIMESTAMP()), 'POS', 150.00, 0, 1, 1);

-- HACE 1 MES (Para gráfico mensual)
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (2, DATEADD('MONTH', -1, CURRENT_TIMESTAMP()), 'POS', 249.00, 0, 1, 1);

-- HACE 5 DÍAS (Para gráfico semanal)
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (3, DATEADD('DAY', -5, CURRENT_TIMESTAMP()), 'POS', 45.00, 0, 1, 1);
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (3, 10, 3, 15.00, 45.00); -- 3 Detergentes

-- HACE 3 DÍAS
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (4, DATEADD('DAY', -3, CURRENT_TIMESTAMP()), 'POS', 80.00, 0, 1, 1);
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (4, 8, 10, 8.00, 80.00); -- 10 Cervezas (Para subir al Top Productos)

-- AYER (Delivery entregado)
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta, direccion_entrega, observaciones) 
VALUES (5, DATEADD('DAY', -1, CURRENT_TIMESTAMP()), 'DELIVERY', 120.00, 5.00, 1, 4, 'Calle Las Begonias 450 - San Isidro', 'Cliente: Carlos Ruiz | Historial');
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (5, 5, 10, 12.00, 120.00); -- 10 Coca Colas

-- =======================================================
-- 7. VENTAS DE HOY (Para KPI "Pedidos de Hoy")
-- =======================================================

-- Venta POS Mañana
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (6, CURRENT_TIMESTAMP(), 'POS', 24.00, 0, 1, 1);
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (6, 5, 2, 12.00, 24.00);

-- =======================================================
-- 8. GESTIÓN DE DELIVERY (Escenarios para probar el Dashboard)
-- =======================================================

-- CASO A: Pedido Recién Llegado (PENDIENTE - Amarillo)
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta, direccion_entrega, observaciones) 
VALUES (7, CURRENT_TIMESTAMP(), 'DELIVERY', 49.80, 0, 1, 2, 'Av. Arequipa 123 - Lince', 'Cliente: Juan Pérez | Tel: 999-000-111');
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (7, 1, 2, 24.90, 49.80); -- 2 Arroz

-- CASO B: Pedido en Ruta (EN CAMINO - Azul)
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta, direccion_entrega, observaciones) 
VALUES (8, DATEADD('MINUTE', -45, CURRENT_TIMESTAMP()), 'DELIVERY', 96.00, 0, 1, 3, 'Jr. De la Unión 500 - Cercado', 'Cliente: Maria Lopez | Tel: 988-777-666');
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (8, 8, 12, 8.00, 96.00); -- 12 Cervezas (Pack)

-- =======================================================
-- 9. PROMOCIONES (Datos dummy)
-- =======================================================
INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo) VALUES 
('Verano Pilsen', 'Lleva 3 paga 2 en cervezas seleccionadas', '2025-01-01', '2030-12-31', TRUE),
('Pack Desayuno', 'Descuento en Leche y Café', '2025-02-01', '2030-03-30', TRUE),
('Limpieza Total', '15% dscto en detergentes los martes', '2025-01-01', '2030-12-31', TRUE);

-- =======================================================
-- 10. REINICIAR CONTADORES (Vital para H2)
-- =======================================================
-- Como insertamos manualmente hasta el ID 13 en Productos y 8 en Ventas,
-- le decimos a la base de datos que empiece a contar desde el siguiente.
ALTER TABLE PRODUCTO ALTER COLUMN id_producto RESTART WITH 20;
ALTER TABLE VENTA ALTER COLUMN id_venta RESTART WITH 100;
ALTER TABLE CATEGORIA ALTER COLUMN id_categoria RESTART WITH 10;