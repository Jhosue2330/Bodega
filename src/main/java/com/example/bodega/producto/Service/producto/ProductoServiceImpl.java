// src/main/java/com/example/bodega/Service/producto/ProductoServiceImpl.java
package com.example.bodega.producto.Service.producto;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.bodega.producto.model.producto.Producto;
import com.example.bodega.producto.repository.producto.dao.ProductoDao;

@Service
public class ProductoServiceImpl implements ProductoService {

    private final ProductoDao productoDao;

    public ProductoServiceImpl(ProductoDao productoDao) {
        this.productoDao = productoDao;
    }

    @Override
    public List<Producto> listarTodos() {
        return productoDao.findAll();
    }

    @Override
    public List<Producto> listarActivos() {
        return productoDao.findByActivoTrue();
    }

    @Override
    public Producto obtenerPorId(Integer id) {
        return productoDao.findById(id).orElse(null);
    }

    @Override
    public Producto guardar(Producto p) {
        // defaults y limpieza básica
        if (p.getActivo() == null) p.setActivo(true);
        if (p.getStockMinimo() == null) p.setStockMinimo(0);
        if (p.getNombre() != null) p.setNombre(p.getNombre().trim());
        if (p.getSku() != null) p.setSku(p.getSku().trim());

        return productoDao.save(p); // JDBC
    }

    @Override
    public void eliminarLogico(Integer id) {
        productoDao.deleteLogico(id);
    }

    @Override
    public boolean existeSku(String sku) {
        if (sku == null || sku.trim().isEmpty()) return false;
        return productoDao.existsBySkuIgnoreCase(sku.trim());
    }
}
