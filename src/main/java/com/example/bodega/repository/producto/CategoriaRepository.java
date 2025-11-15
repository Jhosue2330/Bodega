package com.example.bodega.repository.producto;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.bodega.model.producto.Categoria;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {
    List<Categoria> findByActivoTrue();
}
