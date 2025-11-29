package com.example.bodega.producto.Service.producto;

import java.util.List;

import com.example.bodega.producto.model.producto.Producto;

public interface ProductoService {

    List<Producto> listarTodos();
    List<Producto> listarActivos();

    Producto obtenerPorId(Integer id);

    Producto guardar(Producto p);          // create/update
    void eliminarLogico(Integer id);       // activo=false

    boolean existeSku(String sku);
}
