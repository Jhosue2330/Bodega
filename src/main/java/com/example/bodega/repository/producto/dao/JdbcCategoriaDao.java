package com.example.bodega.repository.producto.dao;

import com.example.bodega.model.producto.Categoria;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

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
        String sql = "SELECT id_categoria, nombre, descripcion, activo FROM CATEGORIA WHERE activo = true";
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
            // Create
            String sql = "INSERT INTO CATEGORIA (nombre, descripcion, activo) VALUES (?, ?, ?)";
            jdbcTemplate.update(sql, categoria.getNombre(), categoria.getDescripcion(), categoria.getActivo());
        } else {
            // Update
            String sql = "UPDATE CATEGORIA SET nombre = ?, descripcion = ?, activo = ? WHERE id_categoria = ?";
            jdbcTemplate.update(sql, categoria.getNombre(), categoria.getDescripcion(), categoria.getActivo(), categoria.getIdCategoria());
        }
        return categoria;
    }

    @Override
    public void deleteById(int id) {
        String sql = "DELETE FROM CATEGORIA WHERE id_categoria = ?";
        jdbcTemplate.update(sql, id);
    }
}
