package com.example.bodega.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PagesController {

    @GetMapping({"/", "/main"})
    public String home() {
        return "publico/Main"; // Página principal
    }

    @GetMapping("/catalogo")
    public String catalogo() {
        return "publico/Catalogo"; // Página del catálogo
    }

    @GetMapping("/publicidad")
    public String publicidad() {
        return "publico/Publicidad"; // Página de publicidad
    }

    @GetMapping("/contacto")
    public String contacto() {
        return "publico/Contacto"; // Página de contacto
    }

    @GetMapping("/bodega/bodeguero")
    public String bodeguero() {
        return "bodega/Bodeguero"; // Panel principal
    }

    @GetMapping("/transaccion/venta")
    public String venta() {
        return "transaccion/Venta"; // Página de ventas
    }

    @GetMapping("/transaccion/delivery")
    public String delivery() {
        return "transaccion/Delivery"; // Página de pedidos delivery
    }

    @GetMapping("/gestion")
    public String gestion() {
        return "producto/Gestion"; // Página de gestión de productos
    }

    @GetMapping("/transaccion/metricas")
    public String metricas() {
        return "transaccion/Metricas"; // Página de métricas
    }
}
