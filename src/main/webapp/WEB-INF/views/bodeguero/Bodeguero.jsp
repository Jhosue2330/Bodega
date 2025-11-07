<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Panel del Bodeguero</title>

    <!-- CSS desde /static/css -->
    <link rel="stylesheet" href="<c:url value='/css/Bodeguero.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/Navbar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/Footer.css'/>" />
  </head>
  <body class="bodega-page">
    <!-- NAVBAR -->
    <!-- Si tienes el fragmento, usa este include: -->
    <!-- <jsp:include page="/WEB-INF/views/componentes/navbar_bodega.jsp"/> -->

    <!-- O deja tu navbar tal cual pero con rutas Spring: -->
    <nav class="navbar sv-navbar">
      <div class="logo">Sistema · Bodega</div>
      <ul class="nav-links">
        <li><a class="nav-link active" href="<c:url value='/bodeguero/dashboard'/>">Bodega</a></li>
        <li><a class="nav-link" href="<c:url value='/venta/registro'/>">Ventas</a></li>
        <li><a class="nav-link" href="<c:url value='/delivery/pedidos'/>">Delivery</a></li>
        <li><a class="nav-link" href="<c:url value='/producto/gestion'/>">Gestión</a></li>
        <li class="has-sub">
          <a class="nav-link" href="#">Productos ▾</a>
          <ul class="sub">
            <li><a class="nav-link" href="<c:url value='/producto/crear'/>">Crear producto</a></li>
            <li>
              <a class="nav-link" href="<c:url value='/producto/gestion'/>">Editar producto</a>
            </li>
          </ul>
        </li>
        <li><a class="nav-link" href="<c:url value='/metricas'/>">Métricas</a></li>
        <li><a class="btn nav-link" href="<c:url value='/logout'/>">Salir</a></li>
      </ul>
      <button class="menu-toggle" aria-label="Menú">☰</button>
    </nav>

    <div class="bodega-wrap">
      <!-- Título + acción principal -->
      <div class="bodega-top">
        <div class="bodega-title">
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" aria-hidden="true">
            <path
              d="M3 3h18v4H3V3zm2 6h14l-1.2 9.6a2 2 0 0 1-2 1.4H8.2a2 2 0 0 1-2-1.4L5 9z"
              fill="url(#g)"
            />
            <defs>
              <linearGradient id="g" x1="0" y1="0" x2="24" y2="24">
                <stop stop-color="#5eead4" />
                <stop offset="1" stop-color="#7c3aed" />
              </linearGradient>
            </defs>
          </svg>
          <div>
            <div style="font-size: 22px; line-height: 1">Bodega</div>
            <div class="badge">Operaciones</div>
          </div>
        </div>
        <div class="actions">
          <!-- Deja como placeholder o apunta a tu ruta cuando la tengas -->
          <a href="#" class="btn">+ Nuevo movimiento (varios productos)</a>
        </div>
      </div>

      <!-- KPIs (dinámicos si hay productos) -->
      <div class="kpis">
        <div class="card kpi">
          <div class="label">Productos</div>
          <div class="value">
            <c:out value="${empty productos ? 0 : fn:length(productos)}" />
          </div>
        </div>
        <div class="card kpi">
          <div class="label">Bajo stock</div>
          <div class="value">
            <c:choose>
              <c:when test="${not empty productos}">
                <c:set var="low" value="0" />
                <c:forEach var="p" items="${productos}">
                  <c:if test="${p.stockActual <= p.stockMinimo}">
                    <c:set var="low" value="${low + 1}" />
                  </c:if>
                </c:forEach>
                ${low}
              </c:when>
              <c:otherwise>0</c:otherwise>
            </c:choose>
          </div>
        </div>
        <div class="card kpi">
          <div class="label">Pedidos delivery</div>
          <div class="value">0</div>
        </div>
        <div class="card kpi">
          <div class="label">Ventas hoy</div>
          <div class="value">S/ 0.00</div>
        </div>
      </div>

      <!-- Tabs -->
      <div class="tabs">
        <span class="tab active">Stock</span>
        <a class="tab" href="<c:url value='/bodeguero/historial'/>">Historial</a>
        <a class="tab" href="<c:url value='/delivery/pedidos'/>">Pedidos Delivery</a>
        <a class="tab" href="<c:url value='/venta/registro'/>">Ventas</a>
      </div>

      <!-- STOCK -->
      <section class="section active">
        <!-- Filtros -->
        <div class="tools" id="stock-tools">
          <form method="get" action="<c:url value='/bodeguero/dashboard'/>">
            <input class="input" type="search" name="q" placeholder="Buscar por nombre o SKU..." />
            <select class="select" name="cat">
              <option value="">Todas las categorías</option>
              <c:forEach var="cat" items="${categorias}">
                <option value="${cat.idCategoria}">${cat.nombre}</option>
              </c:forEach>
            </select>
            <button class="btn tiny" type="submit">Filtrar</button>
          </form>
        </div>

        <div class="card" style="margin-bottom: 10px">
          <p class="sub" style="margin: 0">
            Usa <strong>Entrada rápida</strong>/<strong>Salida rápida</strong> por producto. Si te
            equivocas, en <em>Acciones</em> tienes <strong>Corregir mov.</strong> o
            <strong>Anular mov.</strong> (maqueta).
          </p>
        </div>

        <div class="table-wrap">
          <table class="table">
            <thead>
              <tr>
                <th>SKU</th>
                <th>Producto</th>
                <th>Categoría</th>
                <th>Stock</th>
                <th>Mín.</th>
                <th>Estado</th>
                <th style="text-align: right">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <!-- Dinámico si hay productos -->
              <c:forEach var="p" items="${productos}">
                <tr>
                  <td>${p.sku}</td>
                  <td>${p.nombre}</td>
                  <td>
                    <c:forEach var="cat" items="${categorias}">
                      <c:if test="${cat.idCategoria == p.idCategoria}">${cat.nombre}</c:if>
                    </c:forEach>
                  </td>
                  <td>${p.stockActual}</td>
                  <td>${p.stockMinimo}</td>
                  <td>
                    <span class="status ${p.activo ? 'ok' : 'off'}">
                      <c:out value="${p.activo ? 'OK' : 'Inactivo'}" />
                    </span>
                  </td>
                  <td style="text-align: right">
                    <!-- Placeholders de movimiento -->
                    <a class="btn tiny" href="#">Entrada rápida</a>
                    <a class="btn tiny outline" href="#">Salida rápida</a>
                    <a class="btn tiny light" href="#">Corregir mov.</a>
                    <a class="btn tiny danger" href="#">Anular mov.</a>
                  </td>
                </tr>
              </c:forEach>

              <!-- Fallback estático si no hay datos -->
              <c:if test="${empty productos}">
                <tr>
                  <td>P-0001</td>
                  <td>Arroz 5Kg</td>
                  <td>Abarrotes</td>
                  <td>12</td>
                  <td>5</td>
                  <td><span class="status ok">OK</span></td>
                  <td style="text-align: right">
                    <a class="btn tiny" href="#">Entrada rápida</a>
                    <a class="btn tiny outline" href="#">Salida rápida</a>
                    <a class="btn tiny light" href="#">Corregir mov.</a>
                    <a class="btn tiny danger" href="#">Anular mov.</a>
                  </td>
                </tr>
                <tr>
                  <td>P-0002</td>
                  <td>Azúcar 1Kg</td>
                  <td>Abarrotes</td>
                  <td>40</td>
                  <td>10</td>
                  <td><span class="status ok">OK</span></td>
                  <td style="text-align: right">
                    <a class="btn tiny" href="#">Entrada rápida</a>
                    <a class="btn tiny outline" href="#">Salida rápida</a>
                    <a class="btn tiny light" href="#">Corregir mov.</a>
                    <a class="btn tiny danger" href="#">Anular mov.</a>
                  </td>
                </tr>
                <tr>
                  <td>P-0003</td>
                  <td>Aceite 1L</td>
                  <td>Abarrotes</td>
                  <td>8</td>
                  <td>6</td>
                  <td><span class="status off">Inactivo</span></td>
                  <td style="text-align: right">
                    <a class="btn tiny" href="#">Entrada rápida</a>
                    <a class="btn tiny outline" href="#">Salida rápida</a>
                    <a class="btn tiny light" href="#">Corregir mov.</a>
                    <a class="btn tiny danger" href="#">Anular mov.</a>
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <p class="note">
          Si necesitas cambiar precio/nombre/estado del producto, ve a
          <a href="<c:url value='/producto/gestion'/>">Gestión</a>.
        </p>
      </section>
    </div>

    <!-- FOOTER (si tienes fragmento, inclúyelo) -->
    <!-- <jsp:include page="/WEB-INF/views/componentes/footer.jsp"/> -->
    <footer class="footer">
      <div class="footer-content">
        <p>© 2025 Sistema de Ventas – Maqueta</p>
        <ul class="social-links">
          <li><a href="#">Facebook</a></li>
          <li><a href="#">Instagram</a></li>
          <li><a href="#">LinkedIn</a></li>
          <li><a href="#">WhatsApp</a></li>
        </ul>
      </div>
    </footer>
  </body>
</html>
