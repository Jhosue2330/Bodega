<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value='/css/Navbar.css'/>" />

<nav class="navbar">
  <div class="logo">Sistema de Ventas</div>
  <ul class="nav-links">
    <li><a class="nav-link" href="<c:url value='/'/>">Inicio</a></li>
    <li><a class="nav-link" href="<c:url value='/catalogo'/>">Catálogo</a></li>
    <li><a class="nav-link" href="<c:url value='/contacto'/>">Contacto</a></li>
    <li><a class="nav-link" href="<c:url value='/publicidad'/>">Publicidad</a></li>
    <li><a class="btn nav-link" href="<c:url value='/login'/>">Login</a></li>
  </ul>
  <button class="menu-toggle" aria-label="Menú">☰</button>
</nav>

<script>
  const menuToggle = document.querySelector('.menu-toggle')
  const navLinks = document.querySelector('.nav-links')
  if (menuToggle && navLinks) {
    menuToggle.addEventListener('click', () => navLinks.classList.toggle('active'))
  }
</script>
