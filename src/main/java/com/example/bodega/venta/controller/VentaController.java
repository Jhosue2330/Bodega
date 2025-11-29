package com.example.bodega.Venta.controller;

import com.example.bodega.Venta.dto.DetalleSesionDto;
import com.example.bodega.Venta.dto.VentaSesionDto;
import com.example.bodega.Venta.service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession; // Usa javax.servlet.http.HttpSession si tu Spring Boot es antiguo (versión 2.x)
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/ventas")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    // --- 1. PANTALLA PRINCIPAL ---
    @GetMapping
    public String paginaVenta(Model model, HttpSession session) {
        // Inicializar carrito si no existe
        initSession(session);

        // Cargar historial de ventas para la tabla inferior
        model.addAttribute("listaVentas", ventaService.listarUltimasVentas());

        return "transaccion/Venta"; // Asegúrate que tu JSP se llame así y esté en esa carpeta
    }

    // --- 2. INICIAR NUEVA VENTA (Limpiar) ---
    @GetMapping("/nueva")
    public String nuevaVenta(HttpSession session) {
        session.setAttribute("ventaActual", new VentaSesionDto());
        return "redirect:/ventas";
    }

    // --- 3. BUSCAR PRODUCTOS (Para el Modal) ---
    @GetMapping("/buscar")
    public String buscarProductos(@RequestParam("q") String query, Model model, HttpSession session) {
        initSession(session); // Asegurar sesión por si acaso

        // Buscar en BD
        List<Map<String, Object>> resultados = ventaService.buscarProductos(query);
        model.addAttribute("resultadosBusqueda", resultados);
        
        // Mantener el historial visible
        model.addAttribute("listaVentas", ventaService.listarUltimasVentas());

        // Volver a la misma página (el JSP mostrará los resultados si existen)
        return "transaccion/Venta"; 
    }

    // --- 4. AGREGAR ITEM AL CARRITO ---
    @PostMapping("/item/agregar")
    public String agregarItem(
            @RequestParam Integer idProducto,
            @RequestParam String sku,
            @RequestParam String nombre,
            @RequestParam Double precio,
            @RequestParam Integer cantidad,
            HttpSession session
    ) {
        VentaSesionDto venta = initSession(session);

        // Buscar si ya existe el producto en el carrito para sumar cantidad
        boolean existe = false;
        for (DetalleSesionDto d : venta.getDetalles()) {
            if (d.getIdProducto().equals(idProducto)) {
                d.setCantidad(d.getCantidad() + cantidad);
                d.setSubtotal(d.getCantidad() * d.getPrecioVenta());
                existe = true;
                break;
            }
        }

        // Si no existe, agregarlo nuevo
        if (!existe) {
            venta.getDetalles().add(new DetalleSesionDto(idProducto, sku, nombre, precio, cantidad));
        }

        recalcularTotales(venta);
        return "redirect:/ventas"; // Recargar página limpia
    }

    // --- 5. ELIMINAR ITEM ---
    @GetMapping("/item/eliminar")
    public String eliminarItem(@RequestParam("index") int index, HttpSession session) {
        VentaSesionDto venta = initSession(session);
        
        if (index >= 0 && index < venta.getDetalles().size()) {
            venta.getDetalles().remove(index);
            recalcularTotales(venta);
        }
        return "redirect:/ventas";
    }

    // --- 6. ACTUALIZAR DESCUENTO ---
    @PostMapping("/actualizar")
    public String actualizarDescuento(@RequestParam(required = false, defaultValue = "0") Double descuentoGlobal, HttpSession session) {
        VentaSesionDto venta = initSession(session);
        venta.setDescuentoGlobal(descuentoGlobal);
        recalcularTotales(venta);
        return "redirect:/ventas";
    }

    // --- 7. REGISTRAR VENTA (FINAL) ---
    @PostMapping("/registrar")
    public String registrarVenta(@RequestParam("idVendedor") Integer idVendedor, HttpSession session) {
        VentaSesionDto venta = initSession(session);

        if (venta.getDetalles().isEmpty()) {
            return "redirect:/ventas?error=carrito_vacio";
        }

        // Preparar listas para el Service (adaptador entre DTO y lógica antigua)
        List<Integer> ids = new ArrayList<>();
        List<Integer> cants = new ArrayList<>();
        List<Double> precios = new ArrayList<>();

        for (DetalleSesionDto d : venta.getDetalles()) {
            ids.add(d.getIdProducto());
            cants.add(d.getCantidad());
            precios.add(d.getPrecioVenta());
        }

        // Guardar en BD
        ventaService.registrarVenta(
            idVendedor, 
            "POS", 
            ids, 
            cants, 
            precios, 
            venta.getDescuentoGlobal(), 
            venta.getTotal()
        );

        // Limpiar sesión tras éxito
        session.setAttribute("ventaActual", new VentaSesionDto());

        return "redirect:/ventas?exito=true";
    }
    
    // --- IMPRIMIR (Placeholder) ---
    @GetMapping("/imprimir-ultimo")
    public String imprimirUltimo() {
        // Aquí podrías redirigir a una vista dedicada al ticket
        return "redirect:/ventas?msg=impresion_enviada"; 
    }

    // --- MÉTODOS PRIVADOS AUXILIARES ---
    
    private VentaSesionDto initSession(HttpSession session) {
        VentaSesionDto venta = (VentaSesionDto) session.getAttribute("ventaActual");
        if (venta == null) {
            venta = new VentaSesionDto();
            session.setAttribute("ventaActual", venta);
        }
        return venta;
    }

    private void recalcularTotales(VentaSesionDto v) {
        double sumaSubtotal = 0.0;
        for (DetalleSesionDto d : v.getDetalles()) {
            sumaSubtotal += d.getSubtotal();
        }
        
        // Lógica: Subtotal es base imponible, luego se suma IGV
        // Si tus precios ya incluyen IGV, la lógica sería al revés. Asumimos precios SIN IGV.
        v.setSubtotalSinIgv(sumaSubtotal);
        v.setIgv(sumaSubtotal * 0.18);
        
        double total = (sumaSubtotal + v.getIgv()) - (v.getDescuentoGlobal() != null ? v.getDescuentoGlobal() : 0.0);
        v.setTotal(Math.max(0, total)); // Evitar negativos
    }
}