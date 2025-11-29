package com.example.bodega.Venta.dto;

public class DetalleSesionDto {
    private Integer idProducto;
    private String sku;
    private String nombre;
    private Double precioVenta; // Precio unitario
    private Integer cantidad;
    private Double subtotal;    // precio * cantidad

    // Constructor vacío
    public DetalleSesionDto() {}

    // Constructor lleno (para crear rápido)
    public DetalleSesionDto(Integer idProducto, String sku, String nombre, Double precioVenta, Integer cantidad) {
        this.idProducto = idProducto;
        this.sku = sku;
        this.nombre = nombre;
        this.precioVenta = precioVenta;
        this.cantidad = cantidad;
        this.subtotal = precioVenta * cantidad;
    }

    // Getters y Setters (Obligatorios para que JSP pueda leerlos)
    public Integer getIdProducto() { return idProducto; }
    public void setIdProducto(Integer idProducto) { this.idProducto = idProducto; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public Double getPrecioVenta() { return precioVenta; }
    public void setPrecioVenta(Double precioVenta) { this.precioVenta = precioVenta; }

    public Integer getCantidad() { return cantidad; }
    public void setCantidad(Integer cantidad) { this.cantidad = cantidad; }

    public Double getSubtotal() { return subtotal; }
    public void setSubtotal(Double subtotal) { this.subtotal = subtotal; }
}