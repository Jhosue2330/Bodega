// src/main/java/com/example/bodega/model/Usuario.java
package com.example.bodega.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "USUARIO")
public class Usuario {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "ID_USUARIO")
  private Integer id;

  @Column(name = "NOMBRE_COMPLETO")
  private String nombreCompleto;

  @Column(name = "CORREO", nullable = false, unique = true)
  private String correo;

  @Column(name = "HASH_PASSWORD", nullable = false)
  private String hashPassword;

  @Column(name = "TELEFONO")
  private String telefono;

  @Column(name = "ACTIVO")
  private Boolean activo;

  @Column(name = "ID_ROL")
  private Integer idRol;

  // getters & setters
  public Integer getId() { return id; }
  public void setId(Integer id) { this.id = id; }
  public String getNombreCompleto() { return nombreCompleto; }
  public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }
  public String getCorreo() { return correo; }
  public void setCorreo(String correo) { this.correo = correo; }
  public String getHashPassword() { return hashPassword; }
  public void setHashPassword(String hashPassword) { this.hashPassword = hashPassword; }
  public String getTelefono() { return telefono; }
  public void setTelefono(String telefono) { this.telefono = telefono; }
  public Boolean getActivo() { return activo; }
  public void setActivo(Boolean activo) { this.activo = activo; }
  public Integer getIdRol() { return idRol; }
  public void setIdRol(Integer idRol) { this.idRol = idRol; }
}
