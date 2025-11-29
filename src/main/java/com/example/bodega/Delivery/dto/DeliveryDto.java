package com.example.bodega.Delivery.dto;

import java.util.List;

public class DeliveryDto {
    // Client Data
    private String cliente;
    private String telefono;
    private String direccion;
    private String referencia;

    // Items (Lists because you have input arrays name="desc[]", etc.)
    private List<String> desc;
    private List<Integer> cant;
    private List<Double> prec;

    // Totals
    private Double subTotal;
    private Double costoDelivery;
    private Double total;

    // State
    private String estadoDelivery;

    // Getters and Setters
    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    public String getReferencia() { return referencia; }
    public void setReferencia(String referencia) { this.referencia = referencia; }
    public List<String> getDesc() { return desc; }
    public void setDesc(List<String> desc) { this.desc = desc; }
    public List<Integer> getCant() { return cant; }
    public void setCant(List<Integer> cant) { this.cant = cant; }
    public List<Double> getPrec() { return prec; }
    public void setPrec(List<Double> prec) { this.prec = prec; }
    public Double getSubTotal() { return subTotal; }
    public void setSubTotal(Double subTotal) { this.subTotal = subTotal; }
    public Double getCostoDelivery() { return costoDelivery; }
    public void setCostoDelivery(Double costoDelivery) { this.costoDelivery = costoDelivery; }
    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
    public String getEstadoDelivery() { return estadoDelivery; }
    public void setEstadoDelivery(String estadoDelivery) { this.estadoDelivery = estadoDelivery; }
}