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
-- 2) ESTADOS Y CATEGORÍAS (IMPORTANTE: IDs EXPLICITOS)
-- =======================================================
INSERT INTO ESTADO_VENTA (id_estado, nombre) VALUES (1, 'REGISTRADA');

-- Aquí forzamos el ID para que coincida con tus productos
INSERT INTO CATEGORIA (id_categoria, nombre, descripcion, activo) VALUES 
(1, 'Abarrotes', 'Arroz, Azucar, Aceite', TRUE),
(2, 'Bebidas', 'Gaseosas y Jugos', TRUE),
(3, 'Snacks', 'Piqueos y Galletas', TRUE),
(4, 'Limpieza', 'Detergentes y Jabones', TRUE),
(5, 'Licores', 'Cervezas y Vinos', TRUE),
(6, 'Tecnología', 'Accesorios varios', TRUE);

-- =======================================================
-- 3) PRODUCTOS (Ahora sí coinciden con las categorías de arriba)
-- =======================================================
INSERT INTO PRODUCTO (nombre, sku, precio, stock_actual, stock_minimo, id_categoria, activo) VALUES
-- CATEGORIA 1: ABARROTES
('Arroz Costeño 5kg',    'ARR-001',  24.90, 40, 5, 1, TRUE),
('Aceite Primor 1L',     'ACE-001',  11.50, 60, 5, 1, TRUE),

-- CATEGORIA 2: BEBIDAS
('Coca Cola 3L',         'GASE-001', 12.00, 50, 5, 2, TRUE),
('Inca Kola 1.5L',       'GASE-002',  8.50, 40, 5, 2, TRUE),

-- CATEGORIA 3: SNACKS
('Papas Lays Clásicas',  'SNK-001',   6.00, 30, 5, 3, TRUE),

-- CATEGORIA 5: LICORES (Esto fallaba antes porque no existía la cat 5)
('Cerveza Pilsen 650ml', 'CERV-001', 7.50, 100, 10, 5, TRUE),
('Six Pack Cerveza',     'CERV-004', 35.00, 20,  8, 5, TRUE),

-- CATEGORIA 6: TECNOLOGIA (Para tus audífonos y mouse)
('Audífonos Pro',        'P-0001',   89.90, 10,  1, 6, true),
('Mouse Inalámbrico',    'P-0002',   49.50, 20,  2, 6, true),
('Teclado Mecánico',     'P-0003',  199.00,  5,  1, 6, true);

-- =======================================================
-- 4) VENTAS HISTÓRICAS
-- =======================================================
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (1, '2025-09-15 10:00:00', 'POS', 150.00, 0, 1, 1);

INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (2, '2025-10-20 15:30:00', 'POS', 249.00, 0, 1, 1);

-- =======================================================
-- 5) VENTAS RECIENTES CON DETALLE
-- =======================================================
-- Venta 3
INSERT INTO VENTA (id_venta, fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) 
VALUES (3, '2025-11-23 09:00:00', 'POS', 22.50, 0, 1, 1);
-- OJO: Asegúrate que el id_producto (en este caso 1) exista en la lista de arriba.
-- Arriba, el producto 1 es "Arroz Costeño" (porque es el primero que insertamos).
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
VALUES (3, 1, 3, 7.50, 22.50);