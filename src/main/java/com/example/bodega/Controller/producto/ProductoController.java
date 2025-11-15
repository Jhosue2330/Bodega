package com.example.bodega.Controller.producto;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bodega.Service.producto.CategoriaService;
import com.example.bodega.Service.producto.ProductoService;
import com.example.bodega.model.producto.Producto;

@Controller
@RequestMapping("/producto")
public class ProductoController {

    private final ProductoService productoService;
    private final CategoriaService categoriaService;

    public ProductoController(ProductoService productoService, CategoriaService categoriaService) {
        this.productoService = productoService;
        this.categoriaService = categoriaService;
    }

    // LISTAR → usa tu JSP: /WEB-INF/views/producto/Gestion.jsp
    @GetMapping({"/gestion", "/listar"})
    public String gestion(Model model) {
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarActivas());
        return "producto/Gestion";
    }

    // CREAR (form) → /WEB-INF/views/producto/Producto-Crear.jsp
    @GetMapping("/crear")
    public String crear(Model model) {
        model.addAttribute("producto", new Producto());
        model.addAttribute("categororias", categoriaService.listarActivas()); // nota: si en JSP usas "categorias", mantén el nombre tal cual
        model.addAttribute("categorias", categoriaService.listarActivas());
        return "producto/Producto-Crear";
    }
    @GetMapping("/editar")
    public String editarSinId(Model model) {

        // Producto vacío para que JSP no falle
        model.addAttribute("producto", new Producto());

        // Categorías disponibles
        model.addAttribute("categorias", categoriaService.listarActivas());

        return "producto/Producto-Editar";
    }

    // EDITAR (form) → /WEB-INF/views/producto/Producto-Editar.jsp
    @GetMapping("/editar/{id}")
    public String editar(@PathVariable Integer id, Model model, RedirectAttributes ra) {
        var p = productoService.obtenerPorId(id);
        if (p == null) {
            ra.addFlashAttribute("mensaje", "El producto no existe.");
            return "redirect:/producto/gestion";
        }
        model.addAttribute("producto", p);
        model.addAttribute("categorias", categoriaService.listarActivas());
        return "producto/Producto-Editar";
    }

    // GUARDAR (create/update) → redirige a tu Gestión
    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Producto producto, RedirectAttributes ra) {
        productoService.guardar(producto);
        ra.addFlashAttribute("mensaje", "Producto guardado.");
        return "redirect:/producto/gestion";
    }

    // ELIMINAR (lógico) desde botón de tu tabla
    @PostMapping("/eliminar/{id}")
    public String eliminar(@PathVariable Integer id, RedirectAttributes ra) {
        productoService.eliminarLogico(id);
        ra.addFlashAttribute("mensaje", "Producto eliminado.");
        return "redirect:/producto/gestion";
    }
}
