package com.example.bodega.Service.producto;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.bodega.model.producto.Categoria;
import com.example.bodega.repository.producto.CategoriaRepository;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    private final CategoriaRepository repo;

    public CategoriaServiceImpl(CategoriaRepository repo) {
        this.repo = repo;
    }

    @Override
    public List<Categoria> listarActivas() {
        return repo.listarActivas();
    }

    @Override
    public Categoria guardar(Categoria categoria) {

        // Default para activo
        if (categoria.getActivo() == null) categoria.setActivo(true);

        // Crear o actualizar según ID
        if (categoria.getIdCategoria() == null) {
            repo.guardar(categoria);   // INSERT
        } else {
            repo.actualizar(categoria); // UPDATE
        }

        return categoria;
    }

    @Override
    public Categoria obtenerPorId(Integer id) {
        return repo.obtenerPorId(id);
    }

    @Override
    public void desactivar(Integer id) {
        Categoria categoria = repo.obtenerPorId(id);
        if (categoria != null) {
            categoria.setActivo(false);
            repo.actualizar(categoria); // update para desactivar
        }
    }
}
