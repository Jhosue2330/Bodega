package com.example.bodega.repository.producto;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.bodega.model.producto.Producto;

@Repository
public class ProductoRepository {

    private final JdbcTemplate jdbcTemplate;

    public ProductoRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // ===== Listar todos =====
    public List<Producto> listar() {
        String sql = "SELECT * FROM PRODUCTO";
        return jdbcTemplate.query(sql, this::mapRowToProducto);
    }

    // ===== Listar activos (equivalente findByActivoTrue) =====
    public List<Producto> listarActivos() {
        String sql = "SELECT * FROM PRODUCTO WHERE activo = true";
        return jdbcTemplate.query(sql, this::mapRowToProducto);
    }

    // ===== Obtener por ID =====
    public Producto obtenerPorId(Integer id) {
        String sql = "SELECT * FROM PRODUCTO WHERE id_producto = ?";
        List<Producto> lista = jdbcTemplate.query(sql, this::mapRowToProducto, id);
        return lista.isEmpty() ? null : lista.get(0);
    }

    // ===== Verificar si existe SKU (equivalente existsBySkuIgnoreCase) =====
    public boolean existeSkuIgnoreCase(String sku) {
        String sql = "SELECT COUNT(*) FROM PRODUCTO WHERE LOWER(sku) = LOWER(?)";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, sku);
        return count != null && count > 0;
    }

    // ===== Crear =====
    public int guardar(Producto p) {
        String sql = """
            INSERT INTO PRODUCTO 
            (nombre, sku, precio, stock_actual, stock_minimo, activo, id_categoria)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;

        return jdbcTemplate.update(sql,
                p.getNombre(),
                p.getSku(),
                p.getPrecio(),
                p.getStockActual(),
                p.getStockMinimo(),
                p.getActivo(),
                p.getIdCategoria()
        );
    }

    // ===== Actualizar =====
    public int actualizar(Producto p) {
        String sql = """
            UPDATE PRODUCTO
            SET nombre = ?, sku = ?, precio = ?, stock_actual = ?, 
                stock_minimo = ?, activo = ?, id_categoria = ?
            WHERE id_producto = ?
        """;

        return jdbcTemplate.update(sql,
                p.getNombre(),
                p.getSku(),
                p.getPrecio(),
                p.getStockActual(),
                p.getStockMinimo(),
                p.getActivo(),
                p.getIdCategoria(),
                p.getIdProducto()
        );
    }

    // ===== Eliminar =====
    public int eliminar(Integer id) {
        String sql = "DELETE FROM PRODUCTO WHERE id_producto = ?";
        return jdbcTemplate.update(sql, id);
    }

    // ===== RowMapper inline =====
    private Producto mapRowToProducto(java.sql.ResultSet rs, int rowNum) throws java.sql.SQLException {
        Producto p = new Producto();
        p.setIdProducto(rs.getInt("id_producto"));
        p.setNombre(rs.getString("nombre"));
        p.setSku(rs.getString("sku"));
        p.setPrecio(rs.getBigDecimal("precio"));
        p.setStockActual(rs.getInt("stock_actual"));
        p.setStockMinimo(rs.getInt("stock_minimo"));
        p.setActivo(rs.getBoolean("activo"));
        p.setIdCategoria(rs.getInt("id_categoria"));
        return p;
    }
}
