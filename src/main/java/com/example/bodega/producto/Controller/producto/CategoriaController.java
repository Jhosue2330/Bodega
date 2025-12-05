package com.example.bodega.producto.Controller.producto;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.bodega.producto.Service.producto.CategoriaService;
import com.example.bodega.producto.model.producto.Categoria;

@Controller
@RequestMapping("/categoria")
public class CategoriaController {

    private final CategoriaService service;

    public CategoriaController(CategoriaService service) {
        this.service = service;
    }

    // 1. LISTAR (AHORA TRAE TODO)
    @GetMapping("/listar")
    public String listar(Model model) {
        // CAMBIO: Usamos listarTodas() para ver inactivos también
        model.addAttribute("categorias", service.listarTodas());
        return "categoria/lista";
    }

    @GetMapping("/crear")
    public String crear(Model model) {
        model.addAttribute("categoria", new Categoria());
        return "categoria/crear";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable Integer id, Model model, RedirectAttributes ra) {
        Categoria cat = service.obtenerPorId(id);
        if (cat == null) {
            ra.addFlashAttribute("error", "Categoría no encontrada");
            return "redirect:/categoria/listar";
        }
        model.addAttribute("categoria", cat);
        return "categoria/crear";
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Categoria categoria, RedirectAttributes ra) {
        service.guardar(categoria);
        ra.addFlashAttribute("mensaje", "Categoría guardada correctamente.");
        return "redirect:/categoria/listar";
    }

    // DESACTIVAR
    @GetMapping("/desactivar/{id}")
    public String desactivar(@PathVariable Integer id, RedirectAttributes ra) {
        service.desactivar(id);
        ra.addFlashAttribute("mensaje", "Categoría desactivada (Oculta).");
        return "redirect:/categoria/listar";
    }

    // NUEVO: ACTIVAR
    @GetMapping("/activar/{id}")
    public String activar(@PathVariable Integer id, RedirectAttributes ra) {
        service.activar(id);
        ra.addFlashAttribute("mensaje", "Categoría reactivada con éxito.");
        return "redirect:/categoria/listar";
    }
}