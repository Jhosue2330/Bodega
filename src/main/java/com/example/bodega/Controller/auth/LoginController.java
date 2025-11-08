// src/main/java/com/example/bodega/Controller/auth/LoginController.java
package com.example.bodega.Controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.bodega.Service.AuthService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

  private final AuthService authService;

  public LoginController(AuthService authService) {
    this.authService = authService;
  }

  @GetMapping("/login")
  public String loginForm() {
    return "publico/Login"; // /WEB-INF/views/publico/Login.jsp
  }

  @PostMapping("/login")
  public String doLogin(
      @RequestParam String correo,
      @RequestParam String clave,
      HttpSession session,
      Model model) {

    return authService.autenticar(correo, clave)
        .map(u -> {
          session.setAttribute("AUTH_USER_ID", u.getId());
          session.setAttribute("AUTH_USER_NAME", u.getNombreCompleto());
          session.setAttribute("AUTH_USER_MAIL", u.getCorreo());
          session.setAttribute("AUTH_USER_ROLE", u.getIdRol());
          return "redirect:/bodeguero";
        })
        .orElseGet(() -> {
          model.addAttribute("error", "Correo o contraseña incorrectos");
          return "publico/Login";
        });
  }

  @GetMapping("/logout")
  public String logout(HttpSession session) {
    session.invalidate();
    return "redirect:/login";
  }
}
