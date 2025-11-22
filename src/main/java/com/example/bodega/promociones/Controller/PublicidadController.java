package com.example.bodega.promociones.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.bodega.promociones.Service.PublicidadService;

@Controller
public class PublicidadController {

    private final PublicidadService publicidadService;

    public PublicidadController(PublicidadService publicidadService) {
        this.publicidadService = publicidadService;
    }

    @GetMapping("/publicidad")
    public String verPublicidad(Model model) {
        model.addAttribute("promos", publicidadService.obtenerPromocionesPublicas());
        // JSP: /WEB-INF/views/publico/Publicidad.jsp
        return "publico/Publicidad";
    }
}
