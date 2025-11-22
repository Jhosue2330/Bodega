package com.example.bodega.promociones.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bodega.promociones.Model.Promocion;

@Repository
public class PromocionRepositoryImpl implements PromocionRepository {

    private final JdbcTemplate jdbc;

    public PromocionRepositoryImpl(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    private static class PromocionRowMapper implements RowMapper<Promocion> {
        @Override
        public Promocion mapRow(ResultSet rs, int rowNum) throws SQLException {
            Promocion p = new Promocion();
            p.setIdPromocion(rs.getInt("id_promocion"));
            p.setTitulo(rs.getString("titulo"));
            p.setDescripcion(rs.getString("descripcion"));

            java.sql.Date fi = rs.getDate("fecha_inicio");
            java.sql.Date ff = rs.getDate("fecha_fin");
            p.setFechaInicio(fi != null ? fi.toLocalDate() : null);
            p.setFechaFin(ff != null ? ff.toLocalDate() : null);

            p.setActivo(rs.getBoolean("activo"));
            return p;
        }
    }

    @Override
    public List<Promocion> findAll() {
        String sql = "SELECT * FROM PROMOCION ORDER BY id_promocion DESC";
        return jdbc.query(sql, new PromocionRowMapper());
    }

    @Override
    public List<Promocion> findActivas() {
        String sql = """
            SELECT * FROM PROMOCION
            WHERE activo = TRUE
              AND (fecha_inicio IS NULL OR fecha_inicio <= CURRENT_DATE)
              AND (fecha_fin    IS NULL OR fecha_fin    >= CURRENT_DATE)
            ORDER BY id_promocion DESC
            """;
        return jdbc.query(sql, new PromocionRowMapper());
    }

    @Override
    public Promocion findById(Integer id) {
        String sql = "SELECT * FROM PROMOCION WHERE id_promocion = ?";
        return jdbc.queryForObject(sql, new PromocionRowMapper(), id);
    }

    @Override
    public void insert(Promocion p) {
        String sql = """
            INSERT INTO PROMOCION (titulo, descripcion, fecha_inicio, fecha_fin, activo)
            VALUES (?, ?, ?, ?, ?)
            """;
        jdbc.update(sql,
                p.getTitulo(),
                p.getDescripcion(),
                p.getFechaInicio(),
                p.getFechaFin(),
                p.isActivo());
    }

    @Override
    public void update(Promocion p) {
        String sql = """
            UPDATE PROMOCION
               SET titulo       = ?,
                   descripcion  = ?,
                   fecha_inicio = ?,
                   fecha_fin    = ?,
                   activo       = ?
             WHERE id_promocion = ?
            """;
        jdbc.update(sql,
                p.getTitulo(),
                p.getDescripcion(),
                p.getFechaInicio(),
                p.getFechaFin(),
                p.isActivo(),
                p.getIdPromocion());
    }

    @Override
    public void desactivar(Integer id) {
        String sql = "UPDATE PROMOCION SET activo = FALSE WHERE id_promocion = ?";
        jdbc.update(sql, id);
    }

    @Override
    public void activar(Integer id) {
        String sql = "UPDATE PROMOCION SET activo = TRUE WHERE id_promocion = ?";
        jdbc.update(sql, id);
    }
}
