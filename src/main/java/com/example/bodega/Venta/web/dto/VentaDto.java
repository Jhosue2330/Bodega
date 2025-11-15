package com.example.bodega.Venta.web.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class VentaDto implements Serializable {
    private Integer idVenta;
    private LocalDateTime fecha;
    private String tipoVenta;
    private BigDecimal total;
    private BigDecimal descuento;
    private Integer idVendedor;
    private Integer idCliente;
    private String direccionEntrega;
    private String observaciones;
    private Integer idEstadoVenta;
    private List<DetalleVentaDto> detalles = new ArrayList<>();

    public Integer getIdVenta() { return idVenta; }
    public void setIdVenta(Integer idVenta) { this.idVenta = idVenta; }

    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }

    public String getTipoVenta() { return tipoVenta; }
    public void setTipoVenta(String tipoVenta) { this.tipoVenta = tipoVenta; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }

    public BigDecimal getDescuento() { return descuento; }
    public void setDescuento(BigDecimal descuento) { this.descuento = descuento; }

    public Integer getIdVendedor() { return idVendedor; }
    public void setIdVendedor(Integer idVendedor) { this.idVendedor = idVendedor; }

    public Integer getIdCliente() { return idCliente; }
    public void setIdCliente(Integer idCliente) { this.idCliente = idCliente; }

    public String getDireccionEntrega() { return direccionEntrega; }
    public void setDireccionEntrega(String direccionEntrega) { this.direccionEntrega = direccionEntrega; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public Integer getIdEstadoVenta() { return idEstadoVenta; }
    public void setIdEstadoVenta(Integer idEstadoVenta) { this.idEstadoVenta = idEstadoVenta; }

    public List<DetalleVentaDto> getDetalles() { return detalles; }
    public void setDetalles(List<DetalleVentaDto> detalles) { this.detalles = detalles; }
}
