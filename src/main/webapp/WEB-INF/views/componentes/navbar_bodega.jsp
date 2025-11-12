<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="../CSS/Navbar.css" />

<nav class="navbar">
  <div class="logo">Sistema · Bodega</div>
  <ul class="nav-links">
    <li><a class="nav-link" href="<c:url value='/bodega/bodeguero'/>">Bodega</a></li>
    <li><a class="nav-link" href="<c:url value='/transaccion/venta'/>">Venta</a></li>
    <li><a class="nav-link" href="<c:url value='/transaccion/delivery'/>">Delivery</a></li>
    <li><a class="nav-link" href="<c:url value='/producto/gestion'/>">Gestión</a></li>

    <!-- Submenú -->
    <li class="has-sub">
      <a class="nav-link" href="#">Productos ▾</a>
      <ul class="sub">
        <li>
          <a class="nav-link" href="<c:url value='/producto/producto-crear'/>">Crear producto</a>
        </li>
        <li>
          <a class="nav-link" href="<c:url value='/producto/producto-editar'/>">Editar producto</a>
        </li>
      </ul>
    </li>

    <li><a class="nav-link" href="<c:url value='/transaccion/metricas'/>">Métricas</a></li>
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
