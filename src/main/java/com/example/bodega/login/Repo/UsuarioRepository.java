package com.example.bodega.login.Repo; // <--- Tu paquete exacto

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.Map;

@Repository
public class UsuarioRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Map<String, Object> buscarPorCorreo(String correo) {
        String sql = "SELECT * FROM USUARIO WHERE correo = ?";
        try {
            // Devuelve un mapa { "ID_USUARIO":1, "CORREO":"...", "HASH_PASSWORD":"..." }
            return jdbcTemplate.queryForMap(sql, correo);
        } catch (Exception e) {
            return null; // Si falla o no encuentra, retorna null
        }
    }  
}