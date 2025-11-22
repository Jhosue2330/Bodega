// src/main/java/com/example/bodega/venta/repository/VentaRepository.java

package com.example.bodega.venta.repository;

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
        // 1. Insertar la VENTA
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

        // 3. Insertar cada DETALLE_VENTA
        String sqlDetalle = "INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) " +
                            "VALUES (?, ?, ?, ?, ?)";
        for (int i = 0; i < productoIds.size(); i++) {
            Integer idProducto = productoIds.get(i);
            Integer cantidad = cantidades.get(i);
            Double precioUnitario = precios.get(i);
            Double subtotal = cantidad * precioUnitario;

            jdbcTemplate.update(sqlDetalle,
                idVenta, idProducto, cantidad, precioUnitario, subtotal
            );

            // 4. Actualizar stock_actual en PRODUCTO
            jdbcTemplate.update(
                "UPDATE PRODUCTO SET stock_actual = stock_actual - ? WHERE id_producto = ?",
                cantidad, idProducto
            );

            // 5. Registrar movimiento de inventario (SALIDA)
            jdbcTemplate.update(
                "INSERT INTO MOVIMIENTO_INVENTARIO (fecha, tipo_movimiento, cantidad, motivo, id_producto, id_usuario) " +
                "VALUES (?, 'SALIDA', ?, 'Venta POS', ?, ?)",
                LocalDateTime.now(), cantidad, idProducto, idVendedor
            );
        }
    }

    // Método auxiliar: obtener nombre y precio de un producto
    public Map<String, Object> findProductoById(Integer idProducto) {
        return jdbcTemplate.queryForMap(
            "SELECT nombre, precio, sku, stock_actual FROM PRODUCTO WHERE id_producto = ? AND activo = TRUE",
            idProducto
        );
    }

    // Método para buscar productos por código o nombre
    public List<Map<String, Object>> buscarProductos(String query) {
        String sql = "SELECT id_producto, nombre, sku, precio, stock_actual " +
                     "FROM PRODUCTO " +
                     "WHERE activo = TRUE AND (sku LIKE ? OR nombre LIKE ?) " +
                     "ORDER BY nombre LIMIT 10";
        return jdbcTemplate.queryForList(sql, "%" + query + "%", "%" + query + "%");
    }
}
