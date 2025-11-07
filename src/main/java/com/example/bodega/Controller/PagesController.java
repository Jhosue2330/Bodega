package com.example.bodega.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PagesController {

  // Home y dashboard bodeguero (vista ya en JSP)
  @GetMapping({"/", "/bodeguero/dashboard"})
  public String bodeguero() {
    return "bodeguero/Bodeguero";
  }

  // Módulos aún estáticos o con lógica mínima
  @GetMapping("/venta/registro")
  public String venta() {
    return "transaccion/Venta"; // crea el JSP si aún es html -> pásalo a /WEB-INF/views/transaccion/Venta.jsp
  }

  @GetMapping("/delivery/pedidos")
  public String delivery() {
    return "transaccion/Delivery";
  }

  @GetMapping("/metricas")
  public String metricas() {
    return "transaccion/Metricas";
  }

  @GetMapping("/inventario/historial")
  public String historial() {
    return "inventario/Historial";
  }

  // ========= IMPORTANTE =========
  // NO mapear aquí: /producto/gestion, /producto/crear, /producto/editar/{id}
  // Esas las maneja ProductoController para evitar "Ambiguous mapping".
  // =============================

  // (Opcional) Rutas proxy de desarrollo (no chocan porque el path es distinto)
  // Te permiten navegar aunque te hayas quedado con links antiguos.
  @GetMapping("/ui/producto/gestion")
  public String uiGestionRedirect() {
    return "redirect:/producto/gestion";
  }

  @GetMapping("/ui/producto/crear")
  public String uiCrearRedirect() {
    return "redirect:/producto/crear";
  }
}
