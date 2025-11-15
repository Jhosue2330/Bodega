package com.example.bodega.inventario.service;

import com.example.bodega.inventario.repo.MovimientoRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import com.example.bodega.inventario.repo.MovimientoRepo.Movimiento;;

@Service
public class MovimientoService {

    @Autowired
    private MovimientoRepo repo;

    @Autowired
    private JdbcTemplate jdbc;

    @Transactional
    public void registrarEntrada(int idProducto, int cantidad, String motivo, int idUsuario) {
        jdbc.update("UPDATE PRODUCTO SET stock_actual = stock_actual + ? WHERE id_producto = ?", cantidad, idProducto);
        repo.insertarMovimiento("ENTRADA", cantidad, motivo, idProducto, idUsuario, null);
    }

    @Transactional
    public void registrarSalida(int idProducto, int cantidad, String motivo, int idUsuario, Integer idVenta) {
        Integer stock = jdbc.queryForObject("SELECT stock_actual FROM PRODUCTO WHERE id_producto = ?", Integer.class, idProducto);
        if (stock == null) throw new IllegalArgumentException("Producto no existe: " + idProducto);
        if (stock < cantidad) throw new IllegalStateException("Stock insuficiente. Actual: " + stock + ", solicitado: " + cantidad);
        jdbc.update("UPDATE PRODUCTO SET stock_actual = stock_actual - ? WHERE id_producto = ?", cantidad, idProducto);
        repo.insertarMovimiento("SALIDA", cantidad, motivo, idProducto, idUsuario, idVenta);
    }

    public List<Movimiento> listarPorProducto(int idProducto) { return repo.listarPorProducto(idProducto); }
    public List<Movimiento> listarRecientes(int limit) { return repo.listarRecientes(limit); }
}