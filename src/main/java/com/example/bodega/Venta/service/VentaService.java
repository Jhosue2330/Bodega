package com.example.bodega.Venta.service;

import com.example.bodega.Venta.repository.VentaRepository;
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

    public List<Map<String, Object>> buscarProductos(String q) {
        return ventaRepository.buscarProductos(q);
    }

    // Nuevo método para el historial
    public List<Map<String, Object>> listarUltimasVentas() {
        return ventaRepository.listarUltimasVentas();
    }
}