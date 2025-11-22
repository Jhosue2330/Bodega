package com.example.bodega.login.Control;

import com.example.bodega.login.Service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/login")
    public String mostrarLogin() {
        return "publico/Login"; 
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam("Correo") String correo,
                                @RequestParam("password") String password,
                                HttpSession session,
                                Model model) {
        
        Map<String, Object> usuario = loginService.autenticar(correo, password);

        if (usuario != null) {
            session.setAttribute("usuario", usuario);
            
            // CAMBIO AQUÍ: Redirigimos a la ruta del NUEVO controlador
            // El nuevo controlador maneja "/bodeguero/dashboard"
            return "redirect:/bodeguero/dashboard"; 
        } else {
            return "redirect:/login?error=true";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // --- ELIMINADO: public String mostrarBodeguero(...) ---
    // Ya no necesitamos ese método aquí, el BodegueroController se encarga.
}