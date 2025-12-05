<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="../CSS/Navbar.css" />

<nav class="navbar">
  <div class="logo">Sistema · Bodega</div>
  <ul class="nav-links">
    <li><a class="nav-link" href="<c:url value='/bodeguero/dashboard'/>">Bodega</a></li>
    <li><a class="nav-link" href="<c:url value='/ventas'/>">Venta</a></li>
    <li><a class="nav-link" href="<c:url value='/delivery'/>">Delivery</a></li>
    <li><a class="nav-link" href="<c:url value='/producto/gestion'/>">Gestión</a></li>
    <li><a class="nav-link" href="<c:url value='/bodega/promociones'/>">Promoción</a></li>
    <li><a class="nav-link" href="<c:url value='/metricas'/>">Métricas</a></li>
    <li><a class="btn nav-link" href="<c:url value='/logout'/>" id="logoutBtn">Salir</a></li>
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
