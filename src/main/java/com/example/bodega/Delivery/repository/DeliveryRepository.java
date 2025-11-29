package com.example.bodega.Delivery.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DeliveryRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // LISTAR (Read)
    public List<Map<String, Object>> listarDeliveries(String filtro) {
        String sql = "SELECT v.id_venta AS ID_VENTA, v.fecha AS FECHA, v.total AS TOTAL, " +
                     "v.direccion_entrega AS DIRECCION_ENTREGA, v.observaciones AS OBSERVACIONES, " +
                     "e.nombre AS ESTADO_NOMBRE, e.id_estado AS ESTADO_ID " + // Necesitamos el ID para lógica de colores
                     "FROM VENTA v " +
                     "JOIN ESTADO_VENTA e ON v.id_estado_venta = e.id_estado " +
                     "WHERE v.tipo_venta = 'DELIVERY' ";

        if ("PENDIENTES".equals(filtro)) {
            // Muestra Pendientes (2) y En Camino (3)
            sql += "AND v.id_estado_venta IN (2, 3) ";
        }
        // Si es "TODOS", no agregamos filtro extra (trae entregados y anulados también)

        sql += "ORDER BY v.id_venta DESC";
        return jdbcTemplate.queryForList(sql);
    }

    // OBTENER UNO (Para editar)
    public Map<String, Object> obtenerPorId(Integer id) {
        String sql = "SELECT * FROM VENTA WHERE id_venta = ?";
        return jdbcTemplate.queryForMap(sql, id);
    }

    // EDITAR DATOS (Update)
    public void actualizarDelivery(Integer idVenta, String direccion, String observaciones) {
        String sql = "UPDATE VENTA SET direccion_entrega = ?, observaciones = ? WHERE id_venta = ?";
        jdbcTemplate.update(sql, direccion, observaciones, idVenta);
    }

    // CAMBIAR ESTADO (Para avanzar flujo o Anular)
    public void actualizarEstado(Integer idVenta, int nuevoEstadoId) {
        String sql = "UPDATE VENTA SET id_estado_venta = ? WHERE id_venta = ?";
        jdbcTemplate.update(sql, nuevoEstadoId, idVenta);
    }
}