package com.example.bodega.Venta.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
public class MetricasRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 1. KPIs
    public Integer contarPedidosHoy() {
        try {
            return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM VENTA WHERE fecha >= CURRENT_DATE", Integer.class);
        } catch (Exception e) { return 0; }
    }

    public Double sumarVentasMesActual() {
        // Suma ventas del mes actual
        String sql = "SELECT COALESCE(SUM(total), 0) FROM VENTA " +
                     "WHERE EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE) " +
                     "AND EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM CURRENT_DATE)";
        return jdbcTemplate.queryForObject(sql, Double.class);
    }

    // 2. DIARIO (Últimos 7 días)
    public List<Map<String, Object>> ventasUltimos7Dias() {
        // Agrupa por día formateado (dd-MM)
        String sql = "SELECT FORMATDATETIME(fecha, 'dd-MM') as LABEL, SUM(total) as TOTAL " +
                     "FROM VENTA " +
                     "WHERE fecha >= DATEADD('DAY', -6, CURRENT_DATE) " +
                     "GROUP BY FORMATDATETIME(fecha, 'dd-MM'), CAST(fecha AS DATE) " +
                     "ORDER BY CAST(fecha AS DATE) ASC";
        return jdbcTemplate.queryForList(sql);
    }

    // 3. SEMANAL (Últimas 12 semanas) [CORREGIDO]
    public List<Map<String, Object>> ventasUltimas12Semanas() {
        // CORRECCIÓN: Usamos FORMATDATETIME para generar '2025-W48' directamente.
        // Y usamos -84 días (12 semanas) para asegurar compatibilidad.
        String sql = "SELECT FORMATDATETIME(fecha, 'YYYY-''W''ww') as LABEL, SUM(total) as TOTAL " +
                     "FROM VENTA " +
                     "WHERE fecha >= DATEADD('DAY', -84, CURRENT_DATE) " +
                     "GROUP BY LABEL " +
                     "ORDER BY LABEL ASC";
        return jdbcTemplate.queryForList(sql);
    }

    // 4. MENSUAL (Últimos 12 meses)
    public List<Map<String, Object>> ventasUltimos12Meses() {
        // Agrupa por Mes (yyyy-MM)
        String sql = "SELECT FORMATDATETIME(fecha, 'yyyy-MM') as LABEL, SUM(total) as TOTAL " +
                     "FROM VENTA " +
                     "WHERE fecha >= DATEADD('MONTH', -11, CURRENT_DATE) " +
                     "GROUP BY FORMATDATETIME(fecha, 'yyyy-MM') " +
                     "ORDER BY LABEL ASC";
        return jdbcTemplate.queryForList(sql);
    }

    // 5. TOP PRODUCTOS
    public List<Map<String, Object>> top5Productos() {
        String sql = "SELECT p.nombre as LABEL, SUM(dv.subtotal) as TOTAL " +
                     "FROM DETALLE_VENTA dv " +
                     "JOIN PRODUCTO p ON dv.id_producto = p.id_producto " +
                     "GROUP BY p.nombre " +
                     "ORDER BY TOTAL DESC " +
                     "LIMIT 5";
        return jdbcTemplate.queryForList(sql);
    }
}