package com.example.bodega.Venta.controller;

import com.example.bodega.Venta.dto.MetricasDto;
import com.example.bodega.Venta.service.MetricasService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/metricas")
public class MetricasController {

    @Autowired
    private MetricasService metricasService;

    @GetMapping
    public String verMetricas(Model model) {
        MetricasDto metricas = metricasService.obtenerMetricas();
        
        // --- AGREGA ESTO ---
        System.out.println("================ DEBUG METRICAS ================");
        System.out.println("Pedidos Hoy: " + metricas.getPedidosHoy());
        System.out.println("Total Mes: " + metricas.getVentasTotalMes());
        System.out.println("Data Dias: " + metricas.getDiasData());
        System.out.println("Data Prod: " + metricas.getTopProductosData());
        System.out.println("================================================");
        // -------------------

        model.addAttribute("m", metricas);
        return "transaccion/Metricas";
    }
}