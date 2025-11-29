-- =======================================================
-- LIMPIEZA INICIAL
-- =======================================================
SET REFERENTIAL_INTEGRITY FALSE;
TRUNCATE TABLE DETALLE_VENTA;
TRUNCATE TABLE MOVIMIENTO_INVENTARIO;
TRUNCATE TABLE VENTA;
TRUNCATE TABLE PRODUCTO;
TRUNCATE TABLE CATEGORIA;
TRUNCATE TABLE USUARIO;
TRUNCATE TABLE ROL;
TRUNCATE TABLE ESTADO_VENTA;
SET REFERENTIAL_INTEGRITY TRUE;

-- =======================================================
-- 1) ROLES Y USUARIOS
-- =======================================================
INSERT INTO ROL (id_rol, nombre) VALUES (1, 'ADMINISTRADOR'), (2, 'VENDEDOR');
INSERT INTO USUARIO (id_usuario, nombre_completo, correo, hash_password, telefono, id_rol, activo) VALUES 
(1, 'Josdin Admin', 'admin@bodega.com', '123', '999999999', 1, TRUE);

-- =======================================================
-- 2) ESTADOS Y CATEGORÍAS
-- =======================================================
INSERT INTO ESTADO_VENTA (id_estado, nombre) VALUES (1, 'REGISTRADA');

INSERT INTO CATEGORIA (nombre, descripcion, activo) VALUES 
('Bebidas', 'Gaseosas y Cervezas', TRUE),
('Abarrotes', 'Arroz, Azucar, Aceite', TRUE),
('Snacks', 'Piqueos', TRUE);

-- =======================================================
-- 3) PRODUCTOS
-- =======================================================
INSERT INTO PRODUCTO (nombre, sku, precio, stock_actual, stock_minimo, id_categoria, activo) VALUES
('Cerveza Pilsen 650ml', 'CERV-001', 7.50, 100, 10, 1, TRUE),  -- ID 1
('Coca Cola 3L',         'GASE-001', 12.00, 50, 5, 1, TRUE),  -- ID 2
('Arroz Costeño 5kg',    'ARR-001',  24.90, 40, 5, 2, TRUE),  -- ID 3
('Aceite Primor 1L',     'ACE-001',  11.50, 60, 5, 2, TRUE),  -- ID 4
('Papas Lays Clásicas',  'SNK-001',   6.00, 30, 5, 3, TRUE);  -- ID 5

-- =======================================================
-- 4) VENTAS HISTÓRICAS (IDS FORZADOS MANUALMENTE)
-- =======================================================

-- Venta 1: SEPTIEMBRE
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (1, '2025-09-15 10:00:00', 'POS', 150.00, 0, 1, 1);
-- (Sin detalles para simplificar, solo para sumar al mes)

-- Venta 2: OCTUBRE
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (2, '2025-10-20 15:30:00', 'POS', 249.00, 0, 1, 1);

-- =======================================================
-- 5) VENTAS RECIENTES (Semana Actual) - IDS FORZADOS
-- =======================================================

-- Venta 3: Hace 5 días
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (3, '2025-11-23 09:00:00', 'POS', 22.50, 0, 1, 1);

INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (3, 1, 3, 7.50, 22.50); 

-- Venta 4: Hace 3 días
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (4, '2025-11-25 18:00:00', 'POS', 49.80, 0, 1, 1);

INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (4, 3, 2, 24.90, 49.80);

-- Venta 5: Ayer
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (5, '2025-11-27 20:00:00', 'POS', 12.00, 0, 1, 1);

INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (5, 2, 1, 12.00, 12.00);

-- =======================================================
-- 5) PRODUCTOS (referencian CATEGORIA)
--    Nota: asume IDs autogenerados de categoría: 
--          1=Abarrotes, 2=Bebidas, 3=Snacks y Dulces, 4=Limpieza, 5=Licores
-- =======================================================
INSERT INTO PRODUCTO (nombre, sku, precio, stock_actual, stock_minimo, id_categoria, activo) VALUES
  ('Arroz Costeño ','001',  24.50, 50, 10, 1, TRUE),
  ('Aceite Primor ','002',  11.90, 30,  5, 1, TRUE),
  ('Gaseosa Coca-Cola ','003', 10.00, 45, 15, 2, TRUE),
  ('Six Pack Cerveza Pilsen','004',  35.00, 20,  8, 5, TRUE);

INSERT INTO PRODUCTO (sku, nombre, precio, stock_actual, stock_minimo, activo) VALUES
('P-0001','Audífonos Pro',89.90,10,1,true),
('P-0002','Mouse Inalámbrico',49.50,20,2,true),
('P-0003','Teclado Mecánico',199.00,5,1,true);
-- (Opcional) Semillas para PROMOCION si quieres probar el módulo:
-- INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo) VALUES
--   ('Promo Verano', 'Descuentos en bebidas', DATE '2025-01-01', DATE '2025-02-15', TRUE);
-- INSERT INTO PROMOCION_PRODUCTO (id_promocion, id_producto, descuento_pct) VALUES
--   (1, 3, 10.00);
