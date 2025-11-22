// src/main/java/com/example/bodega/venta/controller/VentaController.java

package com.example.bodega.venta.controller;

import com.example.bodega.venta.service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/ventas")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    @GetMapping("/registrar")
    public String paginaVenta() {
        return "transaccion/Venta"; // Ajusta según tu estructura de vistas
    }

    @PostMapping("/registrar")
    public String registrarVenta(
        @RequestParam("tipoVenta") String tipoVenta,
        @RequestParam("idVendedor") Integer idVendedor,
        @RequestParam("descuento") Double descuento,
        @RequestParam("productoIds[]") List<Integer> productoIds,
        @RequestParam("cantidades[]") List<Integer> cantidades,
        @RequestParam("precios[]") List<Double> precios
    ) {
        double total = 0.0;
        for (int i = 0; i < cantidades.size(); i++) {
            total += cantidades.get(i) * precios.get(i);
        }
        total = total * 1.18 - (descuento != null ? descuento : 0.0);

        ventaService.registrarVenta(
            idVendedor, tipoVenta, productoIds, cantidades, precios, descuento, total
        );

        return "redirect:/ventas/registrar?exito=true";
    }

    @GetMapping("/buscar-productos")
    @ResponseBody
    public List<Map<String, Object>> buscarProductos(@RequestParam("q") String query) {
        return ventaService.buscarProductos(query);
    }
}