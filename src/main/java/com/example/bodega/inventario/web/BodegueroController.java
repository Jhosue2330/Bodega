package com.example.bodega.inventario.web;

import com.example.bodega.inventario.repo.MovimientoRepo;
import com.example.bodega.inventario.service.MovimientoService;
import com.example.bodega.Venta.repo.VentaRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/bodeguero")
public class BodegueroController {

    @Autowired
    private VentaRepo productoRepo;

    @Autowired
    private MovimientoService movimientoService;

    @Autowired
    private MovimientoRepo movimientoRepo;

    @GetMapping({"/dashboard", ""})
    public String dashboard(Model model,
                            @RequestParam(value = "q", required = false) String q,
                            @RequestParam(value = "cat", required = false) Integer catId,
                            @ModelAttribute("mensaje") String mensaje,
                            @ModelAttribute("error") String error) {

        List<?> productos = (q != null && !q.trim().isEmpty()) ? productoRepo.buscarProductos(q) : productoRepo.buscarProductos("");
        List<?> categorias = java.util.Collections.emptyList();
        List<?> usuarios = java.util.Collections.emptyList();

        model.addAttribute("productos", productos);
        model.addAttribute("categorias", categorias);
        model.addAttribute("usuarios", usuarios);
        if (mensaje != null && !mensaje.isBlank()) model.addAttribute("mensaje", mensaje);
        if (error != null && !error.isBlank()) model.addAttribute("error", error);
        return "bodega/Bodeguero";
    }

    @GetMapping("/entrada")
    public String entradaForm(@RequestParam(value = "id", required = false) Integer idProducto, Model model) {
        List<?> productos = productoRepo.buscarProductos("");
        List<?> usuarios = java.util.Collections.emptyList();
        String preselectDate = LocalDate.now().toString();

        model.addAttribute("productos", productos);
        model.addAttribute("usuarios", usuarios);
        model.addAttribute("preselectId", idProducto);
        model.addAttribute("preselectDate", preselectDate);
        return "inventario/Entrada";
    }

    @PostMapping("/movimientos/entrada-form")
    public String procesarEntrada(@RequestParam("idProducto") Integer idProducto,
                                  @RequestParam("cantidad") Integer cantidad,
                                  @RequestParam(value = "motivo", required = false) String motivo,
                                  @RequestParam("idUsuario") Integer idUsuario,
                                  RedirectAttributes ra) {
        try {
            movimientoService.registrarEntrada(idProducto, cantidad, motivo == null ? "Entrada manual" : motivo, idUsuario);
            ra.addFlashAttribute("mensaje", "Entrada registrada correctamente");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "No se pudo registrar entrada: " + ex.getMessage());
        }
        return "redirect:/bodeguero/dashboard";
    }

    @GetMapping("/salida")
    public String salidaForm(@RequestParam(value = "id", required = false) Integer idProducto, Model model) {
        List<?> productos = productoRepo.buscarProductos("");
        List<?> usuarios = java.util.Collections.emptyList();
        String preselectDate = LocalDate.now().toString();

        model.addAttribute("productos", productos);
        model.addAttribute("usuarios", usuarios);
        model.addAttribute("preselectId", idProducto);
        model.addAttribute("preselectDate", preselectDate);
        return "inventario/Salida";
    }

    @PostMapping("/movimientos/salida-form")
    public String procesarSalida(@RequestParam("idProducto") Integer idProducto,
                                 @RequestParam("cantidad") Integer cantidad,
                                 @RequestParam(value = "motivo", required = false) String motivo,
                                 @RequestParam("idUsuario") Integer idUsuario,
                                 @RequestParam(value = "idVenta", required = false) Integer idVenta,
                                 RedirectAttributes ra) {
        try {
            movimientoService.registrarSalida(idProducto, cantidad, motivo == null ? "Salida manual" : motivo, idUsuario, idVenta);
            ra.addFlashAttribute("mensaje", "Salida registrada correctamente");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "No se pudo registrar salida: " + ex.getMessage());
        }
        return "redirect:/bodeguero/dashboard";
    }

    @GetMapping("/historial")
    public String historial(Model model) {
        model.addAttribute("movimientos", java.util.Collections.emptyList());
        return "inventario/Historial";
    }
}