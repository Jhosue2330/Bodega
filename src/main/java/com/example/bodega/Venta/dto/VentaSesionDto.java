package com.example.bodega.Venta.dto;

import java.util.ArrayList;
import java.util.List;

public class VentaSesionDto {
    // La lista de productos que el usuario está agregando
    private List<DetalleSesionDto> detalles = new ArrayList<>();
    
    // Totales calculados
    private Double subtotalSinIgv = 0.0;
    private Double igv = 0.0;
    private Double descuentoGlobal = 0.0;
    private Double total = 0.0;

    public VentaSesionDto() {
    }

    // Getters y Setters
    public List<DetalleSesionDto> getDetalles() { return detalles; }
    public void setDetalles(List<DetalleSesionDto> detalles) { this.detalles = detalles; }

    public Double getSubtotalSinIgv() { return subtotalSinIgv; }
    public void setSubtotalSinIgv(Double subtotalSinIgv) { this.subtotalSinIgv = subtotalSinIgv; }

    public Double getIgv() { return igv; }
    public void setIgv(Double igv) { this.igv = igv; }

    public Double getDescuentoGlobal() { return descuentoGlobal; }
    public void setDescuentoGlobal(Double descuentoGlobal) { this.descuentoGlobal = descuentoGlobal; }

    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
}