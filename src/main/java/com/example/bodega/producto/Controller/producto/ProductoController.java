 package com.example.bodega.producto.Controller.producto;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bodega.producto.Service.producto.CategoriaService;
import com.example.bodega.producto.Service.producto.ProductoService;
import com.example.bodega.producto.model.producto.Producto;

@Controller
@RequestMapping("/producto")
public class ProductoController {

    private final ProductoService productoService;
    private final CategoriaService categoriaService;

    public ProductoController(ProductoService productoService, CategoriaService categoriaService) {
        this.productoService = productoService;
        this.categoriaService = categoriaService;
    }

    // LISTAR → Gestión
    @GetMapping({"/gestion", "/listar"})
    public String gestion(Model model) {
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarActivas());
        return "producto/Gestion";
    }

    // CREAR (Este método es redundante si usas /nuevo, pero lo dejamos corregido por si acaso)
    @GetMapping("/crear")
    public String crear(Model model) {
        model.addAttribute("producto", new Producto());
        model.addAttribute("categorias", categoriaService.listarActivas());
        return "producto/Producto-Crear";
    }
    
    // EDITAR SIN ID (Protección)
    @GetMapping("/editar")
    public String editarSinId(Model model) {
        model.addAttribute("producto", new Producto());
        model.addAttribute("categorias", categoriaService.listarActivas());
        return "producto/Producto-Editar";
    }

    // EDITAR CON ID
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

    // ==========================================
    // NUEVO PRODUCTO (El flujo que querías)
    // ==========================================
    @GetMapping("/nuevo")
    public String nuevoProductoForm(Model model) {
        // CORRECCIÓN: Usamos categoriaService en lugar de productoRepo
        model.addAttribute("categorias", categoriaService.listarActivas()); 
        
        // Objeto vacío para el form
        model.addAttribute("producto", new Producto()); 
        
        return "producto/Producto-Nuevo"; 
    }

    // GUARDAR Y REDIRIGIR INTELIGENTE
    @PostMapping("/guardar")
    public String guardarProducto(@ModelAttribute Producto producto, RedirectAttributes ra) {
        try {
            boolean esNuevo = (producto.getIdProducto() == null);
            
            // Si es nuevo, forzamos Stock 0 para respetar a Bodega
            if (esNuevo) {
                producto.setStockActual(0);
            }
            
            productoService.guardar(producto);

            if (esNuevo) {
                // FLUJO INTELIGENTE:
                // Redirigir a Bodega filtrando por el SKU del nuevo producto
                ra.addFlashAttribute("mensaje", "¡Ficha creada! Ahora registra la entrada física del producto.");
                return "redirect:/bodeguero/dashboard?q=" + producto.getSku();
            } else {
                // Si solo era una edición (cambio de precio/nombre), volvemos a gestión
                ra.addFlashAttribute("mensaje", "Producto actualizado correctamente.");
                return "redirect:/pro ducto/gestion";
            }

        } catch (Exception e) {
            ra.addFlashAttribute("error", "Error al guardar: " + e.getMessage());
            // Si falla, intentamos volver a gestión para no perder al usuario
            return "redirect:/producto/gestion"; 
        }
    }

    // ELIMINAR
    @PostMapping("/eliminar/{id}")
    public String eliminar(@PathVariable Integer id, RedirectAttributes ra) {
        try {
            productoService.eliminarLogico(id);
            ra.addFlashAttribute("mensaje", "Producto eliminado.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "No se pudo eliminar el producto.");
        }
        return "redirect:/producto/gestion";
    }
}