-- =======================================================
-- LIMPIEZA (evita duplicados al reiniciar la app)
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
-- 1) ROLES
-- =======================================================
INSERT INTO ROL (id_rol, nombre) VALUES
  (1, 'ADMINISTRADOR'),
  (2, 'VENDEDOR'),
  (3, 'REPARTIDOR'),
  (4, 'CLIENTE');

-- =======================================================
-- 2) ESTADOS DE VENTA
-- =======================================================
INSERT INTO ESTADO_VENTA (id_estado, nombre) VALUES
  (1, 'PENDIENTE'),
  (2, 'REGISTRADA'),
  (3, 'EN CAMINO'),
  (4, 'ENTREGADO'),
  (5, 'CANCELADO');

-- =======================================================
-- 3) CATEGORÍAS (incluye una desactivada para pruebas)
-- =======================================================
INSERT INTO CATEGORIA (nombre, descripcion, activo) VALUES
  ('Abarrotes', 'Productos secos, granos y enlatados', TRUE),
  ('Bebidas', 'Gaseosas, jugos y aguas', TRUE),
  ('Snacks y Dulces', 'Frituras, galletas y golosinas', TRUE),
  ('Limpieza', 'Productos para aseo del hogar', TRUE),
  ('Licores', 'Cervezas y destilados', TRUE);

INSERT INTO CATEGORIA (nombre, descripcion, activo) VALUES
  ('Antiguo', 'Clasificación descontinuada (FLAG de prueba)', FALSE);

-- =======================================================
-- 4) USUARIOS (ADMIN, REPARTIDOR, CLIENTE)
-- =======================================================
INSERT INTO USUARIO (id_usuario, nombre_completo, correo, hash_password, telefono, id_rol, activo) VALUES
  (1, 'Josdin Administrador', 'admin@bodega.com', 'pass_seguro', '900000001', 1, TRUE);

INSERT INTO USUARIO (id_usuario, nombre_completo, correo, hash_password, telefono, id_rol, activo) VALUES
  (2, 'Carlos Repartidor', 'carlos@delivery.com', 'pass_seguro', '900000002', 3, TRUE);

INSERT INTO USUARIO (id_usuario, nombre_completo, correo, hash_password, telefono, id_rol, activo) VALUES
  (3, 'Maria Cliente', 'maria@cliente.com', 'pass_seguro', '900000003', 4, TRUE);

-- =======================================================
-- 5) PRODUCTOS (referencian CATEGORIA)
--    Nota: asume IDs autogenerados de categoría: 
--          1=Abarrotes, 2=Bebidas, 3=Snacks y Dulces, 4=Limpieza, 5=Licores
-- =======================================================
INSERT INTO PRODUCTO (nombre, sku, precio, stock_actual, stock_minimo, id_categoria, activo) VALUES
  ('Arroz Costeño 5Kg',      'ARC-5K',  24.50, 50, 10, 1, TRUE),
  ('Aceite Primor 1L',       'ACE-1L',  11.90, 30,  5, 1, TRUE),
  ('Gaseosa Coca-Cola 3L',   'GAS-C3L', 10.00, 45, 15, 2, TRUE),
  ('Six Pack Cerveza Pilsen','CER-SP',  35.00, 20,  8, 5, TRUE);

-- (Opcional) Semillas para PROMOCION si quieres probar el módulo:
-- INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo) VALUES
--   ('Promo Verano', 'Descuentos en bebidas', DATE '2025-01-01', DATE '2025-02-15', TRUE);
-- INSERT INTO PROMOCION_PRODUCTO (id_promocion, id_producto, descuento_pct) VALUES
--   (1, 3, 10.00);
