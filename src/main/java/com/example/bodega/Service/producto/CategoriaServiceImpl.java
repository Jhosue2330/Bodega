package com.example.bodega.Service.producto;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.bodega.model.producto.Categoria;
import com.example.bodega.repository.producto.CategoriaRepository;

@Service
@Transactional
public class CategoriaServiceImpl implements CategoriaService {

    private final CategoriaRepository categoriaRepository;

    public CategoriaServiceImpl(CategoriaRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    @Override
    public List<Categoria> listarActivas() {
        return categoriaRepository.findByActivoTrue();
    }

    @Override
    public Categoria guardar(Categoria categoria) {
        if (categoria.getActivo() == null) categoria.setActivo(true);
        return categoriaRepository.save(categoria);
    }

    @Override
    public Categoria obtenerPorId(Integer id) {
        Optional<Categoria> categoriaOpt = categoriaRepository.findById(id);
        return categoriaOpt.orElse(null);
    }

    @Override
    public void desactivar(Integer id) {
        Categoria categoria = obtenerPorId(id);
        if (categoria != null) {
            categoria.setActivo(false);
            categoriaRepository.save(categoria);
        }
    }
}
