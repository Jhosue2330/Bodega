package com.example.bodega.Venta.web.dto;

import java.io.Serializable;
import java.util.Objects;

public class DetalleVentaDto implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idDetalleVenta;
    private Integer idProducto;
    private String nombreProducto;
    private Integer cantidad;
    private Double precioUnitario;
    private Double subtotal;

    public DetalleVentaDto() {
    }

    public DetalleVentaDto(Integer idDetalleVenta, Integer idProducto, String nombreProducto,
                           Integer cantidad, Double precioUnitario, Double subtotal) {
        this.idDetalleVenta = idDetalleVenta;
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = subtotal;
    }

    public Integer getIdDetalleVenta() {
        return idDetalleVenta;
    }

    public void setIdDetalleVenta(Integer idDetalleVenta) {
        this.idDetalleVenta = idDetalleVenta;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
        recomputeSubtotalIfPossible();
    }

    public Double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(Double precioUnitario) {
        this.precioUnitario = precioUnitario;
        recomputeSubtotalIfPossible();
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    /**
     * Calcula el subtotal a partir de cantidad y precioUnitario.
     * Si alguno es nulo no hace nada.
     */
    public void recomputeSubtotalIfPossible() {
        if (this.cantidad != null && this.precioUnitario != null) {
            this.subtotal = this.cantidad * this.precioUnitario;
        }
    }

    @Override
    public String toString() {
        return "DetalleVentaDto{" +
                "idDetalleVenta=" + idDetalleVenta +
                ", idProducto=" + idProducto +
                ", nombreProducto='" + nombreProducto + '\'' +
                ", cantidad=" + cantidad +
                ", precioUnitario=" + precioUnitario +
                ", subtotal=" + subtotal +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DetalleVentaDto that = (DetalleVentaDto) o;
        return Objects.equals(idDetalleVenta, that.idDetalleVenta)
                && Objects.equals(idProducto, that.idProducto)
                && Objects.equals(cantidad, that.cantidad)
                && Objects.equals(precioUnitario, that.precioUnitario)
                && Objects.equals(subtotal, that.subtotal);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idDetalleVenta, idProducto, cantidad, precioUnitario, subtotal);
    }
}