package com.example.bodega.repository.producto;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.bodega.model.producto.Categoria;

@Repository
public class CategoriaRepository {

    private final JdbcTemplate jdbcTemplate;

    public CategoriaRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Listar todas las categorías
    public List<Categoria> listar() {
        String sql = "SELECT * FROM CATEGORIA";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Categoria c = new Categoria();
            c.setIdCategoria(rs.getInt("id_categoria"));
            c.setNombre(rs.getString("nombre"));
            c.setDescripcion(rs.getString("descripcion"));
            c.setActivo(rs.getBoolean("activo"));
            return c;
        });
    }

    // Listar solo activas (equivalente a findByActivoTrue)
    public List<Categoria> listarActivas() {
        String sql = "SELECT * FROM CATEGORIA WHERE activo = true";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Categoria c = new Categoria();
            c.setIdCategoria(rs.getInt("id_categoria"));
            c.setNombre(rs.getString("nombre"));
            c.setDescripcion(rs.getString("descripcion"));
            c.setActivo(rs.getBoolean("activo"));
            return c;
        });
    }

    // Obtener por ID
    public Categoria obtenerPorId(Integer id) {
        String sql = "SELECT * FROM CATEGORIA WHERE id_categoria = ?";
        List<Categoria> lista = jdbcTemplate.query(sql, (rs, n) -> {
            Categoria c = new Categoria();
            c.setIdCategoria(rs.getInt("id_categoria"));
            c.setNombre(rs.getString("nombre"));
            c.setDescripcion(rs.getString("descripcion"));
            c.setActivo(rs.getBoolean("activo"));
            return c;
        }, id);

        return lista.isEmpty() ? null : lista.get(0);
    }

    // Crear
    public int guardar(Categoria c) {
        String sql = """
            INSERT INTO CATEGORIA (nombre, descripcion, activo)
            VALUES (?, ?, ?)
        """;

        return jdbcTemplate.update(sql,
                c.getNombre(),
                c.getDescripcion(),
                c.getActivo()
        );
    }

    // Actualizar
    public int actualizar(Categoria c) {
        String sql = """
            UPDATE CATEGORIA
            SET nombre = ?, descripcion = ?, activo = ?
            WHERE id_categoria = ?
        """;

        return jdbcTemplate.update(sql,
                c.getNombre(),
                c.getDescripcion(),
                c.getActivo(),
                c.getIdCategoria()
        );
    }

    // Eliminar
    public int eliminar(Integer id) {
        String sql = "DELETE FROM CATEGORIA WHERE id_categoria = ?";
        return jdbcTemplate.update(sql, id);
    }
}
