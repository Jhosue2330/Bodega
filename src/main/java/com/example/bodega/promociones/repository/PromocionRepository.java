package com.example.bodega.promociones.repository;

import java.util.List;

import com.example.bodega.promociones.Model.Promocion;

public interface PromocionRepository {

    List<Promocion> findAll();

    List<Promocion> findActivas();

    Promocion findById(Integer id);

    void insert(Promocion p);

    void update(Promocion p);

    void desactivar(Integer id);

    void activar(Integer id);
}
