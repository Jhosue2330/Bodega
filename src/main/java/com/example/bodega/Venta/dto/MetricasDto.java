package com.example.bodega.Venta.dto;

public class MetricasDto {
    // --- KPIs (Tarjetas Superiores) ---
    private Integer pedidosHoy;
    private Double ventasTotalMes;
    private Double ticketPromedioMes;
    
    // --- Datos para Gráficos (Strings formateados para JS: "[1, 2, 3]") ---
    
    // 1. Días (Última semana)
    private String diasLabels; // Ejemplo: "'Lun', 'Mar', 'Mie'"
    private String diasData;   // Ejemplo: "120.50, 200.00, 50.00"

    // 2. Semanas
    private String semanasLabels;
    private String semanasData;

    // 3. Meses
    private String mesesLabels;
    private String mesesData;

    // 4. Top Productos
    private String topProductosLabels;
    private String topProductosData;

    // Constructor vacío
    public MetricasDto() {}

    // Getters y Setters
    public Integer getPedidosHoy() { return pedidosHoy; }
    public void setPedidosHoy(Integer pedidosHoy) { this.pedidosHoy = pedidosHoy; }

    public Double getVentasTotalMes() { return ventasTotalMes; }
    public void setVentasTotalMes(Double ventasTotalMes) { this.ventasTotalMes = ventasTotalMes; }

    public Double getTicketPromedioMes() { return ticketPromedioMes; }
    public void setTicketPromedioMes(Double ticketPromedioMes) { this.ticketPromedioMes = ticketPromedioMes; }

    public String getDiasLabels() { return diasLabels; }
    public void setDiasLabels(String diasLabels) { this.diasLabels = diasLabels; }

    public String getDiasData() { return diasData; }
    public void setDiasData(String diasData) { this.diasData = diasData; }

    public String getSemanasLabels() { return semanasLabels; }
    public void setSemanasLabels(String semanasLabels) { this.semanasLabels = semanasLabels; }

    public String getSemanasData() { return semanasData; }
    public void setSemanasData(String semanasData) { this.semanasData = semanasData; }

    public String getMesesLabels() { return mesesLabels; }
    public void setMesesLabels(String mesesLabels) { this.mesesLabels = mesesLabels; }

    public String getMesesData() { return mesesData; }
    public void setMesesData(String mesesData) { this.mesesData = mesesData; }

    public String getTopProductosLabels() { return topProductosLabels; }
    public void setTopProductosLabels(String topProductosLabels) { this.topProductosLabels = topProductosLabels; }

    public String getTopProductosData() { return topProductosData; }
    public void setTopProductosData(String topProductosData) { this.topProductosData = topProductosData; }
}