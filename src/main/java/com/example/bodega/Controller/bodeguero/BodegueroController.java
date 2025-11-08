package com.example.bodega.Controller.bodeguero;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BodegueroController {
    @GetMapping("/bodeguero/Bodeguero")
    public String dashboard() {
        return "bodeguero/Bodeguero"; // -> /WEB-INF/views/bodeguero/dashboard.jsp
    }
}
