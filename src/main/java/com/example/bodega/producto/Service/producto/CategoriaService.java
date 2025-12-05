package com.example.bodega.producto.Service.producto;

import java.util.List;

import com.example.bodega.producto.model.producto.Categoria;

public interface CategoriaService {
    List<Categoria> listarActivas();
    List<Categoria> listarTodas(); // <--- NUEVO
    Categoria guardar(Categoria categoria);
    Categoria obtenerPorId(Integer id);
    void desactivar(Integer id);
    void activar(Integer id);      // <--- NUEVO
}
    