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

INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo)
VALUES 
('2x1 en gaseosas', 'Solo hasta fin de mes', '2025-02-01', '2025-02-28', TRUE);

INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo)
VALUES 
('Descuento del 15% en limpieza', 'Promoción válida para productos de aseo', '2025-02-01', '2025-02-20', TRUE);

INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo)
VALUES ('2x1 en gaseosas', 'Solo hasta fin de mes', '2025-02-01', '2025-02-28', TRUE);
