package com.example.bodega.producto.repository.producto.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bodega.producto.model.producto.Categoria;

@Repository
public class JdbcCategoriaDao implements CategoriaDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcCategoriaDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Categoria> rowMapper = (rs, rowNum) -> {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(rs.getInt("id_categoria"));
        categoria.setNombre(rs.getString("nombre"));
        categoria.setDescripcion(rs.getString("descripcion"));
        categoria.setActivo(rs.getBoolean("activo"));
        return categoria;
    };

    @Override
    public List<Categoria> getAll() {
        String sql = "SELECT id_categoria, nombre, descripcion, activo FROM CATEGORIA";
        return jdbcTemplate.query(sql, rowMapper);
    }

    @Override
    public List<Categoria> findByActivoTrue() {
        String sql = "SELECT id_categoria, nombre, descripcion, activo FROM CATEGORIA WHERE activo = TRUE";
        return jdbcTemplate.query(sql, rowMapper);
    }

    @Override
    public Optional<Categoria> findById(int id) {
        String sql = "SELECT id_categoria, nombre, descripcion, activo FROM CATEGORIA WHERE id_categoria = ?";
        List<Categoria> results = jdbcTemplate.query(sql, rowMapper, id);
        return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
    }

    @Override
    public Categoria save(Categoria categoria) {
        if (categoria.getIdCategoria() == null) {
            // INSERT
            String sql = "INSERT INTO CATEGORIA (nombre, descripcion, activo) VALUES (?, ?, ?)";
            jdbcTemplate.update(sql,
                    categoria.getNombre(),
                    categoria.getDescripcion(),
                    categoria.getActivo());
        } else {
            // UPDATE
            String sql = "UPDATE CATEGORIA SET nombre = ?, descripcion = ?, activo = ? WHERE id_categoria = ?";
            jdbcTemplate.update(sql,
                    categoria.getNombre(),
                    categoria.getDescripcion(),
                    categoria.getActivo(),
                    categoria.getIdCategoria());
        }
        return categoria;
    }

    @Override
    public void deleteById(int id) {
        // Borrado lógico
        String sql = "UPDATE CATEGORIA SET activo = FALSE WHERE id_categoria = ?";
        jdbcTemplate.update(sql, id);
    }
}
