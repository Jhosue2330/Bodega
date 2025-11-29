package com.example.bodega.Venta.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Repository
public class VentaRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Transactional
    public void registrarVentaConDetalles(
        Integer idVendedor,
        String tipoVenta,
        List<Integer> productoIds,
        List<Integer> cantidades,
        List<Double> precios,
        Double descuento,
        Double total
    ) {
        // 1. Insertar la VENTA (Estado 1 = PENDIENTE/REGISTRADA)
        String sqlVenta = "INSERT INTO VENTA (fecha, tipo_venta, total, descuento, id_vendedor, id_estado_venta) " +
                          "VALUES (?, ?, ?, ?, ?, 1)";
        
        jdbcTemplate.update(sqlVenta,
            LocalDateTime.now(),
            tipoVenta,
            total,
            descuento != null ? descuento : 0.0,
            idVendedor
        );

        // 2. Obtener el ID de la venta recién insertada
        Integer idVenta = jdbcTemplate.queryForObject(
            "SELECT MAX(id_venta) FROM VENTA WHERE id_vendedor = ?", Integer.class, idVendedor
        );

        // 3. Insertar detalles y Kardex
        String sqlDetalle = "INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)";
        String sqlKardex  = "INSERT INTO MOVIMIENTO_INVENTARIO (fecha, tipo_movimiento, cantidad, motivo, id_producto, id_usuario, id_venta) VALUES (?, 'SALIDA', ?, 'Venta POS', ?, ?, ?)";

        for (int i = 0; i < productoIds.size(); i++) {
            Integer idProducto = productoIds.get(i);
            Integer cantidad = cantidades.get(i);
            Double precioUnitario = precios.get(i);
            Double subtotal = cantidad * precioUnitario;

            // Detalle
            jdbcTemplate.update(sqlDetalle, idVenta, idProducto, cantidad, precioUnitario, subtotal);

            // Actualizar Stock
            jdbcTemplate.update("UPDATE PRODUCTO SET stock_actual = stock_actual - ? WHERE id_producto = ?", cantidad, idProducto);

            // Kardex (Movimiento)
            jdbcTemplate.update(sqlKardex, LocalDateTime.now(), cantidad, idProducto, idVendedor, idVenta);
        }
    }

    // Método para buscar productos por código o nombre
    public List<Map<String, Object>> buscarProductos(String query) {
        // CORRECCIÓN AQUÍ: Agregamos "AS idProducto" y "AS stockActual"
        String sql = "SELECT id_producto AS idProducto, nombre, sku, precio, stock_actual AS stockActual " +
                     "FROM PRODUCTO " +
                     "WHERE activo = TRUE AND (sku LIKE ? OR nombre LIKE ?) " +
                     "ORDER BY nombre LIMIT 100";
        return jdbcTemplate.queryForList(sql, "%" + query + "%", "%" + query + "%");
    }

    // Nuevo método para mostrar tabla inferior
    public List<Map<String, Object>> listarUltimasVentas() {
        String sql = "SELECT id_venta AS idVenta, fecha, tipo_venta AS tipoVenta, total " +
                     "FROM VENTA ORDER BY id_venta DESC LIMIT 5";
        return jdbcTemplate.queryForList(sql);
    }

    // --- NUEVO MÉTODO PARA BODEGUERO (INVENTARIO COMPLETO) ---
    public List<Map<String, Object>> listarInventarioCompleto(String query) {
        String sql = "SELECT " +
                     "id_producto AS idProducto, " +
                     "nombre, " +
                     "sku, " +
                     "precio, " +
                     "stock_actual AS stockActual, " +
                     "stock_minimo AS stockMinimo, " + // IMPORTANTE PARA EL KPI
                     "activo " +
                     "FROM PRODUCTO " +
                     "WHERE activo = TRUE AND (sku LIKE ? OR nombre LIKE ?) " +
                     "ORDER BY nombre ASC"; // SIN LIMIT (O un limit muy alto como 500)
        
        String param = "%" + (query != null ? query : "") + "%";
        return jdbcTemplate.queryForList(sql, param, param);
    }
}