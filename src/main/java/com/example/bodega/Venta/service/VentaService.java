// src/main/java/com/example/bodega/venta/service/VentaService.java

package com.example.bodega.venta.service;

import com.example.bodega.venta.repository.VentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class VentaService {

    @Autowired
    private VentaRepository ventaRepository;

    public void registrarVenta(
        Integer idVendedor,
        String tipoVenta,
        List<Integer> productoIds,
        List<Integer> cantidades,
        List<Double> precios,
        Double descuento,
        Double total
    ) {
        ventaRepository.registrarVentaConDetalles(
            idVendedor, tipoVenta, productoIds, cantidades, precios, descuento, total
        );
    }

    public Map<String, Object> buscarProductoPorId(Integer idProducto) {
        return ventaRepository.findProductoById(idProducto);
    }

    public List<Map<String, Object>> buscarProductos(String q) {
        return ventaRepository.buscarProductos(q);
    }
}