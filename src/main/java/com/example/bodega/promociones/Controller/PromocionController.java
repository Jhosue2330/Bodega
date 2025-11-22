package com.example.bodega.promociones.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.bodega.promociones.Model.Promocion;
import com.example.bodega.promociones.Service.PromocionService;

@Controller
@RequestMapping("/bodega/promociones")
public class PromocionController {

    private final PromocionService promocionService;

    public PromocionController(PromocionService promocionService) {
        this.promocionService = promocionService;
    }

    // Mostrar CRUD (lista + formulario)
    @GetMapping
    public String listar(Model model) {
        model.addAttribute("lista", promocionService.listarTodas());
        model.addAttribute("promocion", new Promocion());
        return "promocion/promociones";
    }

    // Cargar datos para editar
    @GetMapping("/editar/{id}")
    public String editar(@PathVariable Integer id, Model model) {
        model.addAttribute("lista", promocionService.listarTodas());
        model.addAttribute("promocion", promocionService.obtenerPorId(id));
        return "promocion/promociones";
    }

    // Guardar (crear / actualizar)
    @PostMapping("/guardar")
    public String guardar(Promocion p,
                          @RequestParam(required = false, defaultValue = "false") boolean activo) {
        p.setActivo(activo);
        promocionService.guardar(p);
        return "redirect:/bodega/promociones";
    }

    // Desactivar (borrado lógico)
    @GetMapping("/desactivar/{id}")
    public String desactivar(@PathVariable Integer id) {
        promocionService.desactivar(id);
        return "redirect:/bodega/promociones";
    }
        
    @GetMapping("/activar/{id}")
    public String activar(@PathVariable Integer id) {
        promocionService.activar(id);
        return "redirect:/bodega/promociones";
    }
} 
