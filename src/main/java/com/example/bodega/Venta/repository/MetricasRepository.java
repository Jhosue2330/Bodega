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

    // 1. KPI: Pedidos de HOY
    public Integer contarPedidosHoy() {
        String sql = "SELECT COUNT(*) FROM VENTA WHERE CAST(fecha AS DATE) = CURRENT_DATE";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // 2. KPI: Total Ventas del Mes Actual
    public Double sumarVentasMesActual() {
        String sql = "SELECT COALESCE(SUM(total), 0) FROM VENTA " +
                     "WHERE EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE) " +
                     "AND EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM CURRENT_DATE)";
        return jdbcTemplate.queryForObject(sql, Double.class);
    }

    // 3. Gráfico: Ventas por Día (Últimos 7 días)
    public List<Map<String, Object>> ventasUltimos7Dias() {
        // Devuelve: FECHA | TOTAL
        String sql = "SELECT CAST(fecha AS DATE) as dia, SUM(total) as total " +
                     "FROM VENTA " +
                     "WHERE fecha >= DATEADD('DAY', -6, CURRENT_DATE) " +
                     "GROUP BY CAST(fecha AS DATE) " +
                     "ORDER BY dia ASC";
        return jdbcTemplate.queryForList(sql);
    }

    // 4. Gráfico: Ventas por Mes (Últimos 6 meses)
    public List<Map<String, Object>> ventasUltimos6Meses() {
        // Devuelve: MES (Número) | TOTAL
        String sql = "SELECT EXTRACT(MONTH FROM fecha) as mes, SUM(total) as total " +
                     "FROM VENTA " +
                     "WHERE fecha >= DATEADD('MONTH', -5, CURRENT_DATE) " +
                     "GROUP BY EXTRACT(MONTH FROM fecha) " +
                     "ORDER BY mes ASC";
        return jdbcTemplate.queryForList(sql);
    }

    // 5. Gráfico: Top 5 Productos (Histórico o último mes)
    public List<Map<String, Object>> top5Productos() {
        String sql = "SELECT p.nombre, SUM(dv.subtotal) as totalVendido " +
                     "FROM DETALLE_VENTA dv " +
                     "JOIN PRODUCTO p ON dv.id_producto = p.id_producto " +
                     "GROUP BY p.nombre " +
                     "ORDER BY totalVendido DESC " +
                     "LIMIT 5";
        return jdbcTemplate.queryForList(sql);
    }
}