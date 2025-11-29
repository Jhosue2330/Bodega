// src/main/java/com/example/bodega/repository/producto/dao/JdbcProductoDao.java
package com.example.bodega.producto.repository.producto.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bodega.producto.model.producto.Producto;

@Repository
public class JdbcProductoDao implements ProductoDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcProductoDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Producto> rowMapper = (rs, rowNum) -> {
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
    };

    @Override
    public List<Producto> findAll() {
        String sql = "SELECT * FROM PRODUCTO";
        return jdbcTemplate.query(sql, rowMapper);
    }

    @Override
    public List<Producto> findByActivoTrue() {
        String sql = "SELECT * FROM PRODUCTO WHERE activo = TRUE";
        return jdbcTemplate.query(sql, rowMapper);
    }

    @Override
    public Optional<Producto> findById(Integer id) {
        String sql = "SELECT * FROM PRODUCTO WHERE id_producto = ?";
        List<Producto> list = jdbcTemplate.query(sql, rowMapper, id);
        return list.isEmpty() ? Optional.empty() : Optional.of(list.get(0));
    }

    @Override
    public Producto save(Producto p) {
        if (p.getIdProducto() == null) {
            // INSERT
            String sql = """
                    INSERT INTO PRODUCTO 
                    (nombre, sku, precio, stock_actual, stock_minimo, activo, id_categoria)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                    """;
            jdbcTemplate.update(sql,
                    p.getNombre(),
                    p.getSku(),
                    p.getPrecio(),
                    p.getStockActual(),
                    p.getStockMinimo(),
                    p.getActivo(),
                    p.getIdCategoria());
        } else {
            // UPDATE
            String sql = """
                    UPDATE PRODUCTO SET
                      nombre = ?, sku = ?, precio = ?, stock_actual = ?, 
                      stock_minimo = ?, activo = ?, id_categoria = ?
                    WHERE id_producto = ?
                    """;
            jdbcTemplate.update(sql,
                    p.getNombre(),
                    p.getSku(),
                    p.getPrecio(),
                    p.getStockActual(),
                    p.getStockMinimo(),
                    p.getActivo(),
                    p.getIdCategoria(),
                    p.getIdProducto());
        }
        return p;
    }

    @Override
    public void deleteLogico(Integer id) {
        String sql = "UPDATE PRODUCTO SET activo = FALSE WHERE id_producto = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public boolean existsBySkuIgnoreCase(String sku) {
        String sql = "SELECT COUNT(*) FROM PRODUCTO WHERE LOWER(sku) = LOWER(?)";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, sku);
        return count != null && count > 0;
    }
}
