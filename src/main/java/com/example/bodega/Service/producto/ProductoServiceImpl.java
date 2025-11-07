package com.example.bodega.Service.producto;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.bodega.model.producto.Producto;
import com.example.bodega.repository.producto.ProductoRepository;

@Service
@Transactional
public class ProductoServiceImpl implements ProductoService {

    private final ProductoRepository repo;

    public ProductoServiceImpl(ProductoRepository repo) {
        this.repo = repo;
    }

    @Override @Transactional(readOnly = true)
    public List<Producto> listarTodos() {
        return repo.findAll();
    }

    @Override @Transactional(readOnly = true)
    public List<Producto> listarActivos() {
        return repo.findByActivoTrue();
    }

    @SuppressWarnings("null")
    @Override @Transactional(readOnly = true)
    public Producto obtenerPorId(Integer id) {
        return repo.findById(id).orElse(null);
    }

    @Override
    public Producto guardar(Producto p) {
        // defaults y limpieza básica
        if (p.getActivo() == null) p.setActivo(true);
        if (p.getStockMinimo() == null) p.setStockMinimo(0);
        if (p.getNombre() != null) p.setNombre(p.getNombre().trim());
        if (p.getSku() != null) p.setSku(p.getSku().trim());
        return repo.save(p); // create/update
    }

    @Override
    public void eliminarLogico(Integer id) {
        var p = obtenerPorId(id);
        if (p != null) {
            p.setActivo(false);
            repo.save(p);
        }
    }

    @Override @Transactional(readOnly = true)
    public boolean existeSku(String sku) {
        if (sku == null) return false;
        return repo.existsBySkuIgnoreCase(sku.trim());
    }
}
