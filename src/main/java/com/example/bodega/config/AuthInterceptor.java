package com.example.bodega.config;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthInterceptor implements HandlerInterceptor {

  private boolean isPublic(String uri) {
    return uri.equals("/")
        || uri.startsWith("/main")
        || uri.startsWith("/login")
        || uri.startsWith("/logout") // opcional
        || uri.startsWith("/css") || uri.startsWith("/js") || uri.startsWith("/img")
        || uri.startsWith("/h2-console");
  }

  private boolean isPrivate(String uri) {
    // Protegidas: módulos internos del sistema
    return uri.startsWith("/bodeguero")
        || uri.startsWith("/producto")
        || uri.startsWith("/venta")
        || uri.startsWith("/delivery")
        || uri.startsWith("/metricas")
        || uri.startsWith("/inventario");
  }

  @Override
  public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
    String uri = req.getRequestURI();

    if (isPublic(uri)) return true;

    if (isPrivate(uri)) {
      HttpSession s = req.getSession(false);
      boolean logged = (s != null && s.getAttribute("usuario") != null);
      if (!logged) {
        res.sendRedirect("/login");
        return false;
      }
      return true;
    }

    // Rutas no clasificadas: trátalas como públicas
    return true;
  }
}
