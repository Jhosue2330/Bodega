package com.example.bodega.repository.producto;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.bodega.model.producto.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Integer> {
    List<Producto> findByActivoTrue();
    boolean existsBySkuIgnoreCase(String sku);
}
