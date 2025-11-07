package com.example.bodega.Service.producto;

import java.util.List;

import com.example.bodega.model.producto.Producto;

public interface ProductoService {

    List<Producto> listarTodos();
    List<Producto> listarActivos();

    Producto obtenerPorId(Integer id);

    Producto guardar(Producto p);          // create/update
    void eliminarLogico(Integer id);       // activo=false

    boolean existeSku(String sku);
}
