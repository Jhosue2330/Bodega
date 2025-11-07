<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Vinculo CSS usando <c:url> para que funcione en cualquier carpeta -->
<link rel="stylesheet" href="<c:url value='/css/Navbar.css'/>" />

<nav class="navbar sv-navbar">
  <div class="logo">Sistema · Bodega</div>
  <ul class="nav-links">
    <li><a class="nav-link" href="<c:url value='/bodeguero/dashboard'/>">Bodega</a></li>
    <li><a class="nav-link" href="<c:url value='/venta/registro'/>">Ventas</a></li>
    <li><a class="nav-link" href="<c:url value='/delivery/pedidos'/>">Delivery</a></li>

    <li><a class="nav-link" href="<c:url value='/producto/gestion'/>">Gestión</a></li>

    <li class="has-sub">
      <a class="nav-link" href="#">Productos ▾</a>
      <ul class="sub">
        <li><a class="nav-link" href="<c:url value='/producto/crear'/>">Crear producto</a></li>
        <li><a class="nav-link" href="<c:url value='/producto/editar'/>">Editar producto</a></li>
      </ul>
    </li>

    <li><a class="nav-link" href="<c:url value='/metricas'/>">Métricas</a></li>
    <li><a class="btn nav-link" href="<c:url value='/logout'/>" id="logoutBtn">Salir</a></li>
  </ul>
  <button class="menu-toggle" aria-label="Menú">☰</button>
</nav>
