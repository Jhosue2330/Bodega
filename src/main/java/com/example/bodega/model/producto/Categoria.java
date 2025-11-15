package com.example.bodega.model.producto;

public class Categoria {

    private Integer idCategoria;
    private String nombre;
    private String descripcion;
    private Boolean activo = true;

    // ===== Getters & Setters =====

    public Integer getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(Integer idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = (nombre == null ? null : nombre.trim());
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = (descripcion == null ? null : descripcion.trim());
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = (activo == null ? true : activo);
    }
}
