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
        
        // --- DEBUG: MIRA ESTO EN LA CONSOLA ---
        System.out.println("DEBUG DATOS DIAS: " + metricas.getDiasData());
        System.out.println("DEBUG DATOS LABELS: " + metricas.getDiasLabels());
        // --------------------------------------

        model.addAttribute("m", metricas);
        return "transaccion/Metricas";
    }
}