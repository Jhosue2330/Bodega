package com.example.bodega.Controller.bodeguero;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BodegueroController {
    @GetMapping("/bodeguero/dashboard")
    public String dashboard() {
        return "bodeguero/dashboard"; // -> /WEB-INF/views/bodeguero/dashboard.jsp
    }
}
