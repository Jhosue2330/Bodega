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

        // 1. Cargar KPIs básicos
        Integer pedidosHoy = metricasRepository.contarPedidosHoy();
        Double ventasMes = metricasRepository.sumarVentasMesActual();
        
        // Evitar división por cero en ticket promedio
        Double ticketPromedio = (pedidosHoy > 0) ? (ventasMes / pedidosHoy) : 0.0; // Nota: Esto es un aprox simple, lo ideal es contar pedidos del mes

        dto.setPedidosHoy(pedidosHoy);
        dto.setVentasTotalMes(ventasMes);
        dto.setTicketPromedioMes(ticketPromedio);

        // 2. Procesar Gráfico DIARIO
        List<Map<String, Object>> dias = metricasRepository.ventasUltimos7Dias();
        dto.setDiasLabels(crearLabels(dias, "dia")); // Helper para extraer columna
        dto.setDiasData(crearData(dias, "total"));

        // 3. Procesar Gráfico MENSUAL
        List<Map<String, Object>> meses = metricasRepository.ventasUltimos6Meses();
        // Mapeo simple de número de mes a nombre (opcional, o dejar el número)
        dto.setMesesLabels(crearLabels(meses, "mes")); 
        dto.setMesesData(crearData(meses, "total"));

        // 4. Procesar Top Productos
        List<Map<String, Object>> tops = metricasRepository.top5Productos();
        dto.setTopProductosLabels(crearLabelsString(tops, "nombre")); // Nombres van entre comillas
        dto.setTopProductosData(crearData(tops, "totalVendido"));

        // Dejar semanas vacío o implementarlo similar a meses si se requiere
        dto.setSemanasLabels("[]");
        dto.setSemanasData("[]");

        return dto;
    }

    // --- Helpers para formatear Strings para JS ---

    // Crea lista de números: 100.50, 200.00, 50
    private String crearData(List<Map<String, Object>> lista, String keyColumna) {
        StringJoiner sj = new StringJoiner(", ", "[", "]");
        for (Map<String, Object> fila : lista) {
            Object val = fila.get(keyColumna);
            sj.add(val != null ? val.toString() : "0");
        }
        return sj.toString();
    }

    // Crea lista de etiquetas simple: 2023-11-01, 2023-11-02 (Sin comillas, ojo)
    // Para fechas o números que ChartJS acepta directo
    private String crearLabels(List<Map<String, Object>> lista, String keyColumna) {
        StringJoiner sj = new StringJoiner("', '", "['", "']"); // Envuelve en comillas simples
        for (Map<String, Object> fila : lista) {
            Object val = fila.get(keyColumna);
            sj.add(val != null ? val.toString() : "");
        }
        return sj.toString();
    }
    
    // Crea lista de etiquetas Texto: 'Cerveza', 'Coca Cola'
    private String crearLabelsString(List<Map<String, Object>> lista, String keyColumna) {
        StringJoiner sj = new StringJoiner("', '", "['", "']");
        for (Map<String, Object> fila : lista) {
            Object val = fila.get(keyColumna);
            sj.add(val != null ? val.toString().replace("'", "\\'") : ""); // Escapar comillas simples
        }
        return sj.toString();
    }
}