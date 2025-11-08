package com.example.bodega.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PagesController {

  // Página inicial pública (Main.jsp)
  @GetMapping({"/", "/main"})
  public String home() {
    return "publico/Main";
  }

  // Páginas públicas
  @GetMapping("/catalogo")
  public String catalogo() { return "publico/Catalogo"; }

  @GetMapping("/publicidad")
  public String publicidad() { return "publico/Publicidad"; }

  @GetMapping("/contacto")
  public String contacto() { return "publico/Contacto"; }

  // Panel del bodeguero (protegido)
  @GetMapping("/bodeguero")
  public String bodeguero() { return "bodeguero/Bodeguero"; }
}
