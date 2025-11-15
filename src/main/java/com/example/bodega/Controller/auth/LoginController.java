package com.example.bodega.Controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.bodega.Service.AuthService;
import com.example.bodega.model.Usuario;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    private final AuthService authService;

    public LoginController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/login")
    public String loginForm() {
        return "publico/Login";  // /WEB-INF/views/publico/Login.jsp
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam String correo,
            @RequestParam String clave,
            HttpSession session,
            Model model) {

        // JDBC → retorna Usuario o null
        Usuario u = authService.autenticar(correo, clave);

        if (u != null) {
            // Guardar datos en sesión
            session.setAttribute("AUTH_USER_ID", u.getId());
            session.setAttribute("AUTH_USER_NAME", u.getNombreCompleto());
            session.setAttribute("AUTH_USER_MAIL", u.getCorreo());
            session.setAttribute("AUTH_USER_ROLE", u.getIdRol());

            return "redirect:/bodeguero"; // ruta de dashboard
        }

        // Si llega aquí → no autenticó
        model.addAttribute("error", "Correo o contraseña incorrectos");
        return "publico/Login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
