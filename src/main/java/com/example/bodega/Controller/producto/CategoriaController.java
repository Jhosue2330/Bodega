package com.example.bodega.Controller.producto;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bodega.Service.producto.CategoriaService;
import com.example.bodega.model.producto.Categoria;

@Controller
@RequestMapping("/categoria")
public class CategoriaController {

    private final CategoriaService service;
    public CategoriaController(CategoriaService service) { this.service = service; }

    // CREATE / UPDATE desde modal o formulario embebido en tus JSP
    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Categoria categoria, RedirectAttributes ra) {
        service.guardar(categoria);
        ra.addFlashAttribute("mensaje", "Categoría guardada.");
        return "redirect:/producto/gestion";   // ← volvemos a tu propia vista
    }

    // DESACTIVAR (delete lógico) desde botón en tu UI
    @PostMapping("/desactivar/{id}")
    public String desactivar(@PathVariable Integer id, RedirectAttributes ra) {
        service.desactivar(id);
        ra.addFlashAttribute("mensaje", "Categoría desactivada.");
        return "redirect:/producto/gestion";
    }
}
