package com.example.bodega.producto.repository.producto.dao;

import com.example.bodega.producto.model.producto.Categoria;

import java.util.List;
import java.util.Optional;

public interface CategoriaDao {
    List<Categoria> getAll();
    List<Categoria> findByActivoTrue();
    Optional<Categoria> findById(int id);
    Categoria save(Categoria categoria);
    void deleteById(int id);
}
