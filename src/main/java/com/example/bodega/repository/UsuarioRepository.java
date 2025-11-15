package com.example.bodega.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.bodega.model.Usuario;

@Repository
public class UsuarioRepository {

    private final JdbcTemplate jdbcTemplate;

    public UsuarioRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // ========== Obtener usuario por correo y activo ==========
    // Equivalente a: findByCorreoAndActivoTrue(String correo)
    public Usuario buscarPorCorreoActivo(String correo) {
        String sql = """
            SELECT * 
            FROM USUARIO 
            WHERE CORREO = ? AND ACTIVO = TRUE
        """;

        List<Usuario> lista = jdbcTemplate.query(sql, this::mapRow, correo);

        return lista.isEmpty() ? null : lista.get(0);
    }

    // ========== Obtener por ID ==========
    public Usuario obtenerPorId(Integer id) {
        String sql = "SELECT * FROM USUARIO WHERE ID_USUARIO = ?";

        List<Usuario> lista = jdbcTemplate.query(sql, this::mapRow, id);

        return lista.isEmpty() ? null : lista.get(0);
    }

    // ========== Registrar usuario ==========
    public int guardar(Usuario u) {
        String sql = """
            INSERT INTO USUARIO 
            (NOMBRE_COMPLETO, CORREO, HASH_PASSWORD, TELEFONO, ACTIVO, ID_ROL)
            VALUES (?, ?, ?, ?, ?, ?)
        """;

        return jdbcTemplate.update(sql,
                u.getNombreCompleto(),
                u.getCorreo(),
                u.getHashPassword(),
                u.getTelefono(),
                u.getActivo(),
                u.getIdRol()
        );
    }

    // ========== Actualizar usuario ==========
    public int actualizar(Usuario u) {
        String sql = """
            UPDATE USUARIO
            SET NOMBRE_COMPLETO = ?, CORREO = ?, HASH_PASSWORD = ?, 
                TELEFONO = ?, ACTIVO = ?, ID_ROL = ?
            WHERE ID_USUARIO = ?
        """;

        return jdbcTemplate.update(sql,
                u.getNombreCompleto(),
                u.getCorreo(),
                u.getHashPassword(),
                u.getTelefono(),
                u.getActivo(),
                u.getIdRol(),
                u.getId()
        );
    }

    // ========== Eliminar usuario ==========
    public int eliminar(Integer id) {
        String sql = "DELETE FROM USUARIO WHERE ID_USUARIO = ?";
        return jdbcTemplate.update(sql, id);
    }

    // ========== RowMapper manual ==========
    private Usuario mapRow(java.sql.ResultSet rs, int rowNum) throws java.sql.SQLException {
        Usuario u = new Usuario();

        u.setId(rs.getInt("ID_USUARIO"));
        u.setNombreCompleto(rs.getString("NOMBRE_COMPLETO"));
        u.setCorreo(rs.getString("CORREO"));
        u.setHashPassword(rs.getString("HASH_PASSWORD"));
        u.setTelefono(rs.getString("TELEFONO"));
        u.setActivo(rs.getBoolean("ACTIVO"));
        u.setIdRol(rs.getInt("ID_ROL"));

        return u;
    }
}
