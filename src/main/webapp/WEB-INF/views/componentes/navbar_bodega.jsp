<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<nav class="navbar sv-navbar">
  <div class="logo">Sistema · Bodega</div>
  <ul class="nav-links">
    <li><a class="nav-link" href="Bodeguero.jsp">Bodega</a></li>
    <li><a class="nav-link" href="Venta.jsp">Ventas</a></li>
    <li><a class="nav-link" href="Delivery.jsp">Delivery</a></li>
    <li><a class="nav-link" href="Gestion.jsp">Gestión</a></li>

    <!-- Submenú -->
    <li class="has-sub">
      <a class="nav-link" href="#">Productos ▾</a>
      <ul class="sub">
        <li><a class="nav-link" href="Producto-Crear.jsp">Crear producto</a></li>
        <li><a class="nav-link" href="Producto-Editar.jsp">Editar producto</a></li>
      </ul>
    </li>

    <li><a class="nav-link" href="Metricas.jsp">Métricas</a></li>
    <li><a class="btn nav-link" href="Main.jsp" id="logoutBtn">Salir</a></li>
  </ul>
  <button class="menu-toggle" aria-label="Menú">☰</button>
</nav>
