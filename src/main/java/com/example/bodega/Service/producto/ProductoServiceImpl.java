package com.example.bodega.Service.producto;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.bodega.model.producto.Producto;
import com.example.bodega.repository.producto.ProductoRepository;

@Service
public class ProductoServiceImpl implements ProductoService {

    private final ProductoRepository repo;

    public ProductoServiceImpl(ProductoRepository repo) {
        this.repo = repo;
    }

    @Override
    public List<Producto> listarTodos() {
        return repo.listar();
    }

    @Override
    public List<Producto> listarActivos() {
        return repo.listarActivos();
    }

    @Override
    public Producto obtenerPorId(Integer id) {
        return repo.obtenerPorId(id);
    }

    @Override
    public Producto guardar(Producto p) {

        // ================================
        // Limpieza básica (igual que JPA)
        // ================================
        if (p.getActivo() == null) p.setActivo(true);
        if (p.getStockMinimo() == null) p.setStockMinimo(0);
        if (p.getNombre() != null) p.setNombre(p.getNombre().trim());
        if (p.getSku() != null) p.setSku(p.getSku().trim());

        // =====================================
        // Crear o Actualizar según tenga ID
        // =====================================
        if (p.getIdProducto() == null) {
            repo.guardar(p); // INSERT
        } else {
            repo.actualizar(p); // UPDATE
        }

        return p; // Retornamos el objeto actualizado
    }

    @Override
    public void eliminarLogico(Integer id) {
        Producto p = repo.obtenerPorId(id);
        if (p != null) {
            p.setActivo(false);
            repo.actualizar(p); // UPDATE para desactivar
        }
    }

    @Override
    public boolean existeSku(String sku) {
        if (sku == null) return false;
        return repo.existeSkuIgnoreCase(sku.trim());
    }
}
