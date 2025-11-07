package com.example.bodega.Service.producto;

import java.util.List;

import com.example.bodega.model.producto.Categoria;

public interface CategoriaService {
    List<Categoria> listarActivas();
    Categoria guardar(Categoria categoria);
    Categoria obtenerPorId(Integer id);
    void desactivar(Integer id);
}
