package com.example.bodega.Venta.web.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

public class VentaDto implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idVenta;
    private LocalDateTime fecha;
    private String tipoVenta;
    private Double total;
    private Double descuento;
    private Integer idVendedor;
    private Integer idCliente;
    private Integer idRepartidor;
    private Integer idEstadoVenta;
    private String direccionEntrega;
    private String observaciones;
    private LocalDateTime horaSalida;
    private LocalDateTime horaEntrega;
    private List<DetalleVentaDto> detalles;

    public VentaDto() {
    }

    public VentaDto(Integer idVenta, LocalDateTime fecha, String tipoVenta, Double total, Double descuento,
                    Integer idVendedor, Integer idCliente, Integer idRepartidor, Integer idEstadoVenta,
                    String direccionEntrega, String observaciones, LocalDateTime horaSalida, LocalDateTime horaEntrega,
                    List<DetalleVentaDto> detalles) {
        this.idVenta = idVenta;
        this.fecha = fecha;
        this.tipoVenta = tipoVenta;
        this.total = total;
        this.descuento = descuento;
        this.idVendedor = idVendedor;
        this.idCliente = idCliente;
        this.idRepartidor = idRepartidor;
        this.idEstadoVenta = idEstadoVenta;
        this.direccionEntrega = direccionEntrega;
        this.observaciones = observaciones;
        this.horaSalida = horaSalida;
        this.horaEntrega = horaEntrega;
        this.detalles = detalles;
    }

    public Integer getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(Integer idVenta) {
        this.idVenta = idVenta;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public String getTipoVenta() {
        return tipoVenta;
    }

    public void setTipoVenta(String tipoVenta) {
        this.tipoVenta = tipoVenta;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getDescuento() {
        return descuento;
    }

    public void setDescuento(Double descuento) {
        this.descuento = descuento;
    }

    public Integer getIdVendedor() {
        return idVendedor;
    }

    public void setIdVendedor(Integer idVendedor) {
        this.idVendedor = idVendedor;
    }

    public Integer getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public Integer getIdRepartidor() {
        return idRepartidor;
    }

    public void setIdRepartidor(Integer idRepartidor) {
        this.idRepartidor = idRepartidor;
    }

    public Integer getIdEstadoVenta() {
        return idEstadoVenta;
    }

    public void setIdEstadoVenta(Integer idEstadoVenta) {
        this.idEstadoVenta = idEstadoVenta;
    }

    public String getDireccionEntrega() {
        return direccionEntrega;
    }

    public void setDireccionEntrega(String direccionEntrega) {
        this.direccionEntrega = direccionEntrega;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public LocalDateTime getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(LocalDateTime horaSalida) {
        this.horaSalida = horaSalida;
    }

    public LocalDateTime getHoraEntrega() {
        return horaEntrega;
    }

    public void setHoraEntrega(LocalDateTime horaEntrega) {
        this.horaEntrega = horaEntrega;
    }

    public List<DetalleVentaDto> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetalleVentaDto> detalles) {
        this.detalles = detalles;
    }

    /**
     * Recalcula total a partir de los detalles y aplica descuento si existe.
     * Si no hay detalles no modifica total.
     */
    public void recomputeTotalFromDetalles() {
        if (detalles == null || detalles.isEmpty()) return;
        double sum = detalles.stream()
                             .filter(d -> d != null && d.getSubtotal() != null)
                             .mapToDouble(DetalleVentaDto::getSubtotal)
                             .sum();
        if (descuento != null) {
            sum = sum - descuento;
        }
        this.total = sum;
    }

    @Override
    public String toString() {
        return "VentaDto{" +
                "idVenta=" + idVenta +
                ", fecha=" + fecha +
                ", tipoVenta='" + tipoVenta + '\'' +
                ", total=" + total +
                ", descuento=" + descuento +
                ", idVendedor=" + idVendedor +
                ", idCliente=" + idCliente +
                ", idRepartidor=" + idRepartidor +
                ", idEstadoVenta=" + idEstadoVenta +
                ", direccionEntrega='" + direccionEntrega + '\'' +
                ", observaciones='" + observaciones + '\'' +
                ", horaSalida=" + horaSalida +
                ", horaEntrega=" + horaEntrega +
                ", detalles=" + detalles +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        VentaDto ventaDto = (VentaDto) o;
        return Objects.equals(idVenta, ventaDto.idVenta);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idVenta);
    }
}