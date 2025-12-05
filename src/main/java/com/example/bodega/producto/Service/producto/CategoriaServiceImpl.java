package com.example.bodega.producto.Service.producto;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.bodega.producto.model.producto.Categoria;
import com.example.bodega.producto.repository.producto.dao.CategoriaDao;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    private final CategoriaDao categoriaDao;

    public CategoriaServiceImpl(CategoriaDao categoriaDao) {
        this.categoriaDao = categoriaDao;
    }

    @Override
    public List<Categoria> listarActivas() {
        return categoriaDao.findByActivoTrue();
    }

    // NUEVO: Trae todo (activos e inactivos)
    @Override
    public List<Categoria> listarTodas() {
        return categoriaDao.getAll(); 
    }

    @Override
    public Categoria guardar(Categoria categoria) {
        if (categoria.getActivo() == null) {
            categoria.setActivo(true);
        }
        return categoriaDao.save(categoria);
    }

    @Override
    public Categoria obtenerPorId(Integer id) {
        return categoriaDao.findById(id).orElse(null);
    }

    @Override
    public void desactivar(Integer id) {
        categoriaDao.deleteById(id); // Esto pone activo = false
    }

    // NUEVO: Reactivar categoría
    @Override
    public void activar(Integer id) {
        // Truco: Recuperamos, cambiamos el flag en Java y guardamos.
        // (O podrías crear un método updateActivo en el DAO, pero esto es más rápido)
        categoriaDao.findById(id).ifPresent(c -> {
            c.setActivo(true);
            categoriaDao.save(c);
        });
    }
}
