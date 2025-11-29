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
        // Usa el método que SÍ existe en CategoriaDao
        return categoriaDao.findByActivoTrue();
    }

    @Override
    public Categoria guardar(Categoria categoria) {
        if (categoria.getActivo() == null) {
            categoria.setActivo(true);
        }

        // Tu DAO tiene un solo método save() que hace insert o update
        return categoriaDao.save(categoria);
    }

    @Override
    public Categoria obtenerPorId(Integer id) {
        // findById devuelve Optional<Categoria>, aquí lo conviertes a Categoria
        return categoriaDao.findById(id)
                .orElse(null);
    }

    @Override
    public void desactivar(Integer id) {
        // Aquí decides: desactivar = deleteById (borrado físico o lógico según tu DAO)
        categoriaDao.deleteById(id);
    }
}
