<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Panel del Bodeguero</title>

    <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Bodeguero.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Footer.css'/>" />
  </head>
  <body class="bodega-page">
    <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <div class="bodega-wrap">
      <div class="bodega-top">
        <div class="bodega-title">
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" aria-hidden="true">
            <path d="M3 3h18v4H3V3zm2 6h14l-1.2 9.6a2 2 0 0 1-2 1.4H8.2a2 2 0 0 1-2-1.4L5 9z" fill="url(#g)"/>
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
          <a href="<c:url value='/bodeguero/movimientos/nuevo'/>" class="btn">+ Nuevo movimiento (varios productos)</a>
        </div>
      </div>

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

      <div class="tabs">
        <span class="tab active">Stock</span>
        <a class="tab" href="<c:url value='/bodeguero/historial'/>">Historial</a>
        <a class="tab" href="<c:url value='/delivery/pedidos'/>">Pedidos Delivery</a>
        <a class="tab" href="<c:url value='/venta/registro'/>">Ventas</a>
      </div>

      <section class="section active">
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
            Usa <strong>Entrada</strong> / <strong>Salida</strong> por producto. (Los enlaces abren formularios server-side.)
          </p>
        </div>

        <c:if test="${not empty mensaje}">
          <div class="card" style="background:#e6ffed;border:1px solid #b7f0c6;padding:10px;margin-bottom:12px">
            <strong>OK:</strong> <c:out value="${mensaje}"/>
          </div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="card" style="background:#ffecec;border:1px solid #f7c6c6;padding:10px;margin-bottom:12px">
            <strong>Error:</strong> <c:out value="${error}"/>
          </div>
        </c:if>

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
              <c:forEach var="p" items="${productos}">
                <tr data-id-producto="${p.idProducto}">
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
                    <a class="btn tiny" href="<c:url value='/bodeguero/entrada?id=${p.idProducto}'/>">Entrada</a>
                    <a class="btn tiny outline" href="<c:url value='/bodeguero/salida?id=${p.idProducto}'/>">Salida</a>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty productos}">
                <tr>
                  <td>P-0001</td>
                  <td>Arroz 5Kg</td>
                  <td>Abarrotes</td>
                  <td>12</td>
                  <td>5</td>
                  <td><span class="status ok">OK</span></td>
                  <td style="text-align: right">
                    <a class="btn tiny" href="<c:url value='/bodeguero/entrada'/>">Entrada</a>
                    <a class="btn tiny outline" href="<c:url value='/bodeguero/salida'/>">Salida</a>
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
                    <a class="btn tiny" href="<c:url value='/bodeguero/entrada'/>">Entrada</a>
                    <a class="btn tiny outline" href="<c:url value='/bodeguero/salida'/>">Salida</a>
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
                    <a class="btn tiny" href="<c:url value='/bodeguero/entrada'/>">Entrada</a>
                    <a class="btn tiny outline" href="<c:url value='/bodeguero/salida'/>">Salida</a>
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