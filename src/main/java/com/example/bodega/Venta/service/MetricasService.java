package com.example.bodega.Venta.service;

import com.example.bodega.Venta.dto.MetricasDto;
import com.example.bodega.Venta.repository.MetricasRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

@Service
public class MetricasService {

    @Autowired
    private MetricasRepository metricasRepository;

    public MetricasDto obtenerMetricas() {
        MetricasDto dto = new MetricasDto();

        // 1. KPIs
        Integer pedidosHoy = metricasRepository.contarPedidosHoy();
        Double ventasMes = metricasRepository.sumarVentasMesActual();
        Double ticketPromedio = (pedidosHoy > 0) ? (ventasMes / pedidosHoy) : 0.0;

        dto.setPedidosHoy(pedidosHoy);
        dto.setVentasTotalMes(ventasMes);
        dto.setTicketPromedioMes(ticketPromedio);

        // ==================================================================
        // AHORA TODO USA "LABEL" Y "TOTAL" (Ver Repositorio)
        // ==================================================================

        // 2. Gráfico DIARIO
        List<Map<String, Object>> dias = metricasRepository.ventasUltimos7Dias();
        dto.setDiasLabels(crearLabels(dias)); 
        dto.setDiasData(crearData(dias));    

        // 3. Gráfico SEMANAL (Nuevo)
        List<Map<String, Object>> semanas = metricasRepository.ventasUltimas12Semanas();
        dto.setSemanasLabels(crearLabels(semanas));
        dto.setSemanasData(crearData(semanas));

        // 4. Gráfico MENSUAL (12 Meses)
        List<Map<String, Object>> meses = metricasRepository.ventasUltimos12Meses();
        dto.setMesesLabels(crearLabels(meses));
        dto.setMesesData(crearData(meses));

        // 5. Top Productos
        List<Map<String, Object>> tops = metricasRepository.top5Productos();
        dto.setTopProductosLabels(crearLabelsString(tops));      
        dto.setTopProductosData(crearData(tops)); 

        return dto;
    }

    // --- Helpers Simplificados (Buscan siempre "LABEL" y "TOTAL") ---

    private String crearData(List<Map<String, Object>> lista) {
        StringJoiner sj = new StringJoiner(", ", "[", "]");
        for (Map<String, Object> fila : lista) {
            // Buscamos "TOTAL"
            Object val = getValueCaseInsensitive(fila, "TOTAL");
            sj.add(val != null ? val.toString() : "0");
        }
        return sj.toString();
    }

    private String crearLabels(List<Map<String, Object>> lista) {
        StringJoiner sj = new StringJoiner("', '", "['", "']");
        for (Map<String, Object> fila : lista) {
            // Buscamos "LABEL"
            Object val = getValueCaseInsensitive(fila, "LABEL");
            sj.add(val != null ? val.toString() : "");
        }
        return sj.toString();
    }
    
    // Para productos que tienen nombres con comillas potenciales
    private String crearLabelsString(List<Map<String, Object>> lista) {
        StringJoiner sj = new StringJoiner("', '", "['", "']");
        for (Map<String, Object> fila : lista) {
            Object val = getValueCaseInsensitive(fila, "LABEL");
            sj.add(val != null ? val.toString().replace("'", "\\'") : "");
        }
        return sj.toString();
    }

    private Object getValueCaseInsensitive(Map<String, Object> map, String key) {
        if (map.containsKey(key)) return map.get(key);
        if (map.containsKey(key.toUpperCase())) return map.get(key.toUpperCase());
        if (map.containsKey(key.toLowerCase())) return map.get(key.toLowerCase());
        return null;
    }
}