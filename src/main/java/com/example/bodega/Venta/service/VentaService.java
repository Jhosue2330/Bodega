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

    // Old method (you can keep it for compatibility or remove it if not used)
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

    // --- NEW METHOD FOR DELIVERY AND POS ---
    public void registrarVentaCompleta(
        Integer idVendedor,
        String tipoVenta,
        List<Integer> productoIds,
        List<Integer> cantidades,
        List<Double> precios,
        Double descuento,
        Double total,
        String cliente,
        String direccion,
        String telefono
    ) {
        // Pass everything to the repository
        ventaRepository.registrarVentaCompleta(
            idVendedor, tipoVenta, productoIds, cantidades, precios, 
            descuento, total, cliente, direccion, telefono
        );
    }

    public List<Map<String, Object>> buscarProductos(String q) {
        return ventaRepository.buscarProductos(q);
    }

    public List<Map<String, Object>> listarUltimasVentas() {
        return ventaRepository.listarUltimasVentas();
    }
}