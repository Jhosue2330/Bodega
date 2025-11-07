-- =======================================================
-- MÓDULOS MAESTROS Y DE SEGURIDAD
-- =======================================================

-- 1. ROL (Maestro de Roles de Usuario)
CREATE TABLE IF NOT EXISTS ROL (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE
);

-- 2. USUARIO (Clientes y Personal: Vendedor, Repartidor, etc.)
CREATE TABLE IF NOT EXISTS USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    correo VARCHAR(120) UNIQUE,
    hash_password VARCHAR(200),
    telefono VARCHAR(20),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    id_rol INT NOT NULL,
    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

-- 3. ESTADO_VENTA (Pendiente, Registrada, Entregado, Cancelado, etc.)
CREATE TABLE IF NOT EXISTS ESTADO_VENTA (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

-- 4. CATEGORIA (Clasificación del Producto)
CREATE TABLE IF NOT EXISTS CATEGORIA (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

-- 5. PRODUCTO (Catálogo e Inventario)
CREATE TABLE IF NOT EXISTS PRODUCTO (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    sku VARCHAR(50) UNIQUE,
    precio DECIMAL(10, 2) NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria INT,
    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

-- =======================================================
-- MÓDULOS DE VENTA Y DELIVERY
-- =======================================================

-- 6. VENTA (Transacción Principal: POS o Delivery)
CREATE TABLE IF NOT EXISTS VENTA (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    tipo_venta VARCHAR(20) NOT NULL,
    total DECIMAL(12, 2) NOT NULL,
    descuento DECIMAL(10, 2),

    id_vendedor INT NOT NULL,
    id_cliente INT,
    id_repartidor INT,

    direccion_entrega VARCHAR(200),
    observaciones VARCHAR(200),
    hora_salida DATETIME,
    hora_entrega DATETIME,
    id_estado_venta INT NOT NULL,

    CONSTRAINT fk_venta_vendedor
        FOREIGN KEY (id_vendedor) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_venta_repartidor
        FOREIGN KEY (id_repartidor) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_venta_estado
        FOREIGN KEY (id_estado_venta) REFERENCES ESTADO_VENTA(id_estado)
);

-- 7. DETALLE_VENTA (Ítems de la Venta)
CREATE TABLE IF NOT EXISTS DETALLE_VENTA (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,

    CONSTRAINT fk_detalle_venta_venta
        FOREIGN KEY (id_venta) REFERENCES VENTA(id_venta),
    CONSTRAINT fk_detalle_venta_producto
        FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);

-- =======================================================
-- MÓDULO DE INVENTARIO Y TRAZABILIDAD
-- =======================================================

-- 8. MOVIMIENTO_INVENTARIO (Historial de Entradas y Salidas)
CREATE TABLE IF NOT EXISTS MOVIMIENTO_INVENTARIO (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    tipo_movimiento VARCHAR(10) NOT NULL, -- 'ENTRADA' / 'SALIDA'
    cantidad INT NOT NULL,
    motivo VARCHAR(160),

    id_producto INT NOT NULL,
    id_usuario INT NOT NULL,
    id_venta INT,

    CONSTRAINT fk_movinv_producto
        FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    CONSTRAINT fk_movinv_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_movinv_venta
        FOREIGN KEY (id_venta) REFERENCES VENTA(id_venta)
);

-- =======================================================
-- MÓDULO DE PROMOCIONES
-- =======================================================

-- 9. PROMOCION (Maestro de Promociones)
CREATE TABLE IF NOT EXISTS PROMOCION (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    descripcion VARCHAR(240),
    fecha_inicio DATE,
    fecha_fin DATE,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

-- 10. PROMOCION_PRODUCTO (n..m)
CREATE TABLE IF NOT EXISTS PROMOCION_PRODUCTO (
    id_promocion_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_promocion INT NOT NULL,
    id_producto INT NOT NULL,
    descuento_pct DECIMAL(5, 2) NOT NULL,

    CONSTRAINT fk_promopro_promo
        FOREIGN KEY (id_promocion) REFERENCES PROMOCION(id_promocion),
    CONSTRAINT fk_promopro_producto
        FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    CONSTRAINT uk_promo_producto UNIQUE (id_promocion, id_producto)
);

-- =======================================================
-- ÍNDICES RECOMENDADOS (performance en búsquedas y FKs)
-- =======================================================

CREATE INDEX IF NOT EXISTS ix_usuario_rol          ON USUARIO (id_rol);
CREATE INDEX IF NOT EXISTS ix_producto_categoria   ON PRODUCTO (id_categoria);
CREATE INDEX IF NOT EXISTS ix_producto_sku         ON PRODUCTO (sku);
CREATE INDEX IF NOT EXISTS ix_venta_estado         ON VENTA (id_estado_venta);
CREATE INDEX IF NOT EXISTS ix_venta_vendedor       ON VENTA (id_vendedor);
CREATE INDEX IF NOT EXISTS ix_venta_cliente        ON VENTA (id_cliente);
CREATE INDEX IF NOT EXISTS ix_venta_repartidor     ON VENTA (id_repartidor);
CREATE INDEX IF NOT EXISTS ix_detalle_venta_venta  ON DETALLE_VENTA (id_venta);
CREATE INDEX IF NOT EXISTS ix_detalle_venta_prod   ON DETALLE_VENTA (id_producto);
CREATE INDEX IF NOT EXISTS ix_movinv_producto      ON MOVIMIENTO_INVENTARIO (id_producto);
CREATE INDEX IF NOT EXISTS ix_movinv_usuario       ON MOVIMIENTO_INVENTARIO (id_usuario);
CREATE INDEX IF NOT EXISTS ix_movinv_venta         ON MOVIMIENTO_INVENTARIO (id_venta);
