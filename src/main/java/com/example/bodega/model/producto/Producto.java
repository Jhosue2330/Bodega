package com.example.bodega.model.producto;

import java.math.BigDecimal;

public class Producto {

    private Integer idProducto;
    private String nombre;
    private String sku;
    private BigDecimal precio;
    private Integer stockActual;
    private Integer stockMinimo = 0;
    private Boolean activo = true;
    private Integer idCategoria;

    /* ===== Getters/Setters ===== */

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = (nombre == null ? null : nombre.trim());
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = (sku == null ? null : sku.trim());
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public Integer getStockActual() {
        return stockActual;
    }

    public void setStockActual(Integer stockActual) {
        this.stockActual = stockActual;
    }

    public Integer getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(Integer stockMinimo) {
        this.stockMinimo = (stockMinimo == null ? 0 : stockMinimo);
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = (activo == null ? true : activo);
    }

    public Integer getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(Integer idCategoria) {
        this.idCategoria = idCategoria;
    }
}
