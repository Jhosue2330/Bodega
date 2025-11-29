package com.example.bodega.inventario.web;

import com.example.bodega.inventario.repo.MovimientoRepo;
import com.example.bodega.inventario.service.MovimientoService;
import com.example.bodega.Venta.repository.VentaRepository;

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
    private VentaRepository productoRepo;

    @Autowired
    private MovimientoService movimientoService;

    @Autowired
    private MovimientoRepo movimientoRepo;

    // --- DASHBOARD ---
    // En BodegueroController.java

    @GetMapping({"/dashboard", ""})
    public String dashboard(Model model,
                            @RequestParam(value = "q", required = false) String q,
                            @ModelAttribute("mensaje") String mensaje,
                            @ModelAttribute("error") String error) {

        // CORRECCIÓN: Usamos el nuevo método listarInventarioCompleto
        // Si q es null, enviamos "" para que traiga todo
        List<?> productos = productoRepo.listarInventarioCompleto(q == null ? "" : q);
        
        // Calcular KPI de Bajo Stock aquí (Más robusto que en el JSP)
        int bajosStock = 0;
        
        // Casteo seguro para contar en Java
        for (Object obj : productos) {
            java.util.Map row = (java.util.Map) obj;
            // Convertimos a Number para evitar errores entre Integer/Long/BigDecimal de la BD
            int actual = ((Number) row.get("stockActual")).intValue();
            int minimo = ((Number) row.get("stockMinimo")).intValue();
            
            if (actual <= minimo) {
                bajosStock++;
            }
        }

        model.addAttribute("productos", productos);
        model.addAttribute("categorias", java.util.Collections.emptyList()); // O tu servicio de categorías
        model.addAttribute("usuarios", java.util.Collections.emptyList());
        
        // Pasamos el KPI ya calculado al JSP
        model.addAttribute("kpiBajos", bajosStock);

        if (mensaje != null && !mensaje.isBlank()) model.addAttribute("mensaje", mensaje);
        if (error != null && !error.isBlank()) model.addAttribute("error", error);
        
        return "bodega/Bodeguero";
    }

    // --- ENTRADA INDIVIDUAL ---
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

    // --- SALIDA INDIVIDUAL ---
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

    // --- HISTORIAL (CORREGIDO) ---
    @GetMapping("/historial")
    public String historial(Model model) {
        // AHORA SÍ LLAMAMOS AL SERVICIO PARA TRAER DATOS REALES
        List<?> movimientos = movimientoService.verHistorial();
        model.addAttribute("movimientos", movimientos);
        return "inventario/Historial";
    }

    // --- MOVIMIENTO MASIVO ---
    @GetMapping("/movimientos/nuevo")
    public String nuevoMovimientoMasivo(Model model) {
        List<?> productos = productoRepo.buscarProductos("");
        model.addAttribute("productos", productos);
        model.addAttribute("usuarios", java.util.Collections.emptyList());
        return "inventario/MovimientoMasivo"; 
    }

    @PostMapping("/movimientos/guardar-masivo")
    public String guardarMasivo(
            @RequestParam(value = "idProducto", required = false) List<Integer> idsProductos,
            @RequestParam(value = "cantidad", required = false) List<Integer> cantidades,
            @RequestParam(value = "tipo", required = false) List<String> tipos, 
            @RequestParam(value = "motivo", required = false) String motivo,
            @RequestParam(value = "idUsuario", required = false) Integer idUsuario,
            RedirectAttributes ra) {

        int contExito = 0;
        try {
            if (idsProductos != null) {
                for (int i = 0; i < idsProductos.size(); i++) {
                    Integer idProd = idsProductos.get(i);
                    Integer cant = cantidades.get(i);
                    String tipo = tipos.get(i); 

                    if (idProd != null && cant != null && cant > 0) {
                        if ("ENTRADA".equals(tipo)) {
                            movimientoService.registrarEntrada(idProd, cant, motivo == null || motivo.isBlank() ? "Entrada Masiva" : motivo, idUsuario);
                        } else {
                            movimientoService.registrarSalida(idProd, cant, motivo == null || motivo.isBlank() ? "Salida Masiva" : motivo, idUsuario, null);
                        }
                        contExito++;
                    }
                }
            }
            ra.addFlashAttribute("mensaje", "Se registraron " + contExito + " movimientos correctamente.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Error en carga masiva: " + e.getMessage());
        }
        return "redirect:/bodeguero/dashboard";
    }
}