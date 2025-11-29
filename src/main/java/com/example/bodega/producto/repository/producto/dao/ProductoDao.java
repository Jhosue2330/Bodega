// src/main/java/com/example/bodega/repository/producto/dao/ProductoDao.java
package com.example.bodega.producto.repository.producto.dao;

import java.util.List;
import java.util.Optional;

import com.example.bodega.producto.model.producto.Producto;

public interface ProductoDao {

    List<Producto> findAll();
    List<Producto> findByActivoTrue();

    Optional<Producto> findById(Integer id);

    Producto save(Producto producto);   // inserta o actualiza
    void deleteLogico(Integer id);      // activo = false

    boolean existsBySkuIgnoreCase(String sku);
}
