package com.example.bodega.Delivery.controller;

import com.example.bodega.Delivery.repository.DeliveryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {

    @Autowired
    private DeliveryRepository deliveryRepo;

    // 1. LISTAR (Dashboard)
    @GetMapping
    public String listarDeliveries(@RequestParam(value = "filtro", defaultValue = "PENDIENTES") String filtro, Model model) {
        model.addAttribute("pedidos", deliveryRepo.listarDeliveries(filtro));
        model.addAttribute("filtroActual", filtro);
        return "transaccion/Delivery";
    }

    // 2. AVANZAR ESTADO (De Pendiente -> En Camino -> Entregado)
    @PostMapping("/avanzar")
    public String avanzarEstado(@RequestParam Integer idVenta, @RequestParam Integer estadoActual, RedirectAttributes ra) {
        // Lógica simple de estados:
        // 2 (Pendiente) -> 3 (En Camino)
        // 3 (En Camino) -> 4 (Entregado)
        int siguiente = estadoActual == 2 ? 3 : 4;
        
        deliveryRepo.actualizarEstado(idVenta, siguiente);
        ra.addFlashAttribute("mensaje", "Estado del pedido #" + idVenta + " actualizado.");
        return "redirect:/delivery";
    }

    // 3. EDITAR DATOS (Dirección/Teléfono)
    @PostMapping("/editar")
    public String editarDatos(@RequestParam Integer idVenta, 
                              @RequestParam String direccion, 
                              @RequestParam String observaciones,
                              RedirectAttributes ra) {
        deliveryRepo.actualizarDelivery(idVenta, direccion, observaciones);
        ra.addFlashAttribute("mensaje", "Datos del pedido #" + idVenta + " corregidos.");
        return "redirect:/delivery";
    }

    // 4. ANULAR (Soft Delete)
    @PostMapping("/anular")
    public String anularPedido(@RequestParam Integer idVenta, RedirectAttributes ra) {
        // Estado 5 = CANCELADO
        deliveryRepo.actualizarEstado(idVenta, 5); 
        ra.addFlashAttribute("error", "Pedido #" + idVenta + " ha sido anulado.");
        return "redirect:/delivery";
    }
}