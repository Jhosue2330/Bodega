package com.example.bodega.inventario.web.Dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

public class MovimientoDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer idMovimiento;
    private LocalDateTime fecha;
    private String tipoMovimiento; // "ENTRADA" or "SALIDA"
    private Integer cantidad;
    private String motivo;
    private Integer idProducto;
    private Integer idUsuario;
    private Integer idVenta;

    public MovimientoDto() { }

    public MovimientoDto(Integer idMovimiento, LocalDateTime fecha, String tipoMovimiento,
                         Integer cantidad, String motivo, Integer idProducto,
                         Integer idUsuario, Integer idVenta) {
        this.idMovimiento = idMovimiento;
        this.fecha = fecha;
        this.tipoMovimiento = tipoMovimiento;
        this.cantidad = cantidad;
        this.motivo = motivo;
        this.idProducto = idProducto;
        this.idUsuario = idUsuario;
        this.idVenta = idVenta;
    }

    public Integer getIdMovimiento() { return idMovimiento; }
    public void setIdMovimiento(Integer idMovimiento) { this.idMovimiento = idMovimiento; }

    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }

    public String getTipoMovimiento() { return tipoMovimiento; }
    public void setTipoMovimiento(String tipoMovimiento) { this.tipoMovimiento = tipoMovimiento; }

    public Integer getCantidad() { return cantidad; }
    public void setCantidad(Integer cantidad) { this.cantidad = cantidad; }

    public String getMotivo() { return motivo; }
    public void setMotivo(String motivo) { this.motivo = motivo; }

    public Integer getIdProducto() { return idProducto; }
    public void setIdProducto(Integer idProducto) { this.idProducto = idProducto; }

    public Integer getIdUsuario() { return idUsuario; }
    public void setIdUsuario(Integer idUsuario) { this.idUsuario = idUsuario; }

    public Integer getIdVenta() { return idVenta; }
    public void setIdVenta(Integer idVenta) { this.idVenta = idVenta; }

    @Override
    public String toString() {
        return "MovimientoDto{" +
                "idMovimiento=" + idMovimiento +
                ", fecha=" + fecha +
                ", tipoMovimiento='" + tipoMovimiento + '\'' +
                ", cantidad=" + cantidad +
                ", motivo='" + motivo + '\'' +
                ", idProducto=" + idProducto +
                ", idUsuario=" + idUsuario +
                ", idVenta=" + idVenta +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MovimientoDto that = (MovimientoDto) o;
        return Objects.equals(idMovimiento, that.idMovimiento) &&
               Objects.equals(idProducto, that.idProducto) &&
               Objects.equals(idUsuario, that.idUsuario) &&
               Objects.equals(idVenta, that.idVenta) &&
               Objects.equals(tipoMovimiento, that.tipoMovimiento) &&
               Objects.equals(cantidad, that.cantidad) &&
               Objects.equals(motivo, that.motivo) &&
               Objects.equals(fecha, that.fecha);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idMovimiento, fecha, tipoMovimiento, cantidad, motivo, idProducto, idUsuario, idVenta);
    }
}