package com.example.bodega.inventario.repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public class MovimientoRepo {

    @Autowired
    private JdbcTemplate jdbc;

    public static class Movimiento {
        public Integer idMovimiento;
        public java.time.LocalDateTime fecha;
        public String tipoMovimiento;
        public Integer cantidad;
        public String motivo;
        public Integer idProducto;
        public Integer idUsuario;
        public Integer idVenta;
    }

    public int insertarMovimiento(String tipo, int cantidad, String motivo, int idProducto, int idUsuario, Integer idVenta) {
        String sql = "INSERT INTO MOVIMIENTO_INVENTARIO (fecha, tipo_movimiento, cantidad, motivo, id_producto, id_usuario, id_venta) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        return jdbc.update(sql, ts, tipo, cantidad, motivo, idProducto, idUsuario, idVenta);
    }

    public List<Movimiento> listarPorProducto(int idProducto) {
        String sql = "SELECT id_movimiento, fecha, tipo_movimiento, cantidad, motivo, id_producto, id_usuario, id_venta FROM MOVIMIENTO_INVENTARIO WHERE id_producto = ? ORDER BY fecha DESC";
        return jdbc.query(sql, (rs, rn) -> {
            Movimiento m = new Movimiento();
            m.idMovimiento = rs.getInt("id_movimiento");
            java.sql.Timestamp t = rs.getTimestamp("fecha");
            m.fecha = t != null ? t.toLocalDateTime() : null;
            m.tipoMovimiento = rs.getString("tipo_movimiento");
            m.cantidad = rs.getInt("cantidad");
            m.motivo = rs.getString("motivo");
            m.idProducto = rs.getInt("id_producto");
            m.idUsuario = rs.getInt("id_usuario");
            m.idVenta = rs.getObject("id_venta") != null ? rs.getInt("id_venta") : null;
            return m;
        }, idProducto);
    }

    public List<Movimiento> listarRecientes(int limit) {
        String sql = "SELECT id_movimiento, fecha, tipo_movimiento, cantidad, motivo, id_producto, id_usuario, id_venta FROM MOVIMIENTO_INVENTARIO ORDER BY fecha DESC LIMIT ?";
        return jdbc.query(sql, (rs, rn) -> {
            Movimiento m = new Movimiento();
            m.idMovimiento = rs.getInt("id_movimiento");
            java.sql.Timestamp t = rs.getTimestamp("fecha");
            m.fecha = t != null ? t.toLocalDateTime() : null;
            m.tipoMovimiento = rs.getString("tipo_movimiento");
            m.cantidad = rs.getInt("cantidad");
            m.motivo = rs.getString("motivo");
            m.idProducto = rs.getInt("id_producto");
            m.idUsuario = rs.getInt("id_usuario");
            m.idVenta = rs.getObject("id_venta") != null ? rs.getInt("id_venta") : null;
            return m;
        }, limit);
    }
}