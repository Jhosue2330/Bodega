package com.example.bodega.Venta.web.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;

public class DetalleVentaDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer idDetalleVenta;
    private Integer idProducto;
    private String nombreProducto;
    private Integer cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subtotal;

    public Integer getIdDetalleVenta() { return idDetalleVenta; }
    public void setIdDetalleVenta(Integer idDetalleVenta) { this.idDetalleVenta = idDetalleVenta; }

    public Integer getIdProducto() { return idProducto; }
    public void setIdProducto(Integer idProducto) { this.idProducto = idProducto; }

    public String getNombreProducto() { return nombreProducto; }
    public void setNombreProducto(String nombreProducto) { this.nombreProducto = nombreProducto; }

    public Integer getCantidad() { return cantidad; }
    public void setCantidad(Integer cantidad) { this.cantidad = cantidad; recomputeSubtotalIfPossible(); }

    public BigDecimal getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(BigDecimal precioUnitario) { this.precioUnitario = precioUnitario; recomputeSubtotalIfPossible(); }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }

    public void recomputeSubtotalIfPossible() {
        if (this.cantidad != null && this.precioUnitario != null) {
            this.subtotal = this.precioUnitario.multiply(new BigDecimal(this.cantidad)).setScale(2, BigDecimal.ROUND_HALF_UP);
        }
    }

    @Override
    public boolean equals(Object o) { /* generated */ 
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DetalleVentaDto that = (DetalleVentaDto) o;
        return Objects.equals(idDetalleVenta, that.idDetalleVenta) &&
                Objects.equals(idProducto, that.idProducto) &&
                Objects.equals(cantidad, that.cantidad) &&
                Objects.equals(precioUnitario, that.precioUnitario) &&
                Objects.equals(subtotal, that.subtotal);
    }

    @Override
    public int hashCode() { return Objects.hash(idDetalleVenta, idProducto, cantidad, precioUnitario, subtotal); }
}
