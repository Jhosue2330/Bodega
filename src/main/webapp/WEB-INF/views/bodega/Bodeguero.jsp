<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inventario — Bodega</title>
    <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Bodeguero.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Footer.css'/>" />
    <style>
        /* Estilo simple para alertas de stock */
        .stock-ok { color: green; font-weight: bold; }
        .stock-low { color: #d97706; font-weight: bold; background: #fef3c7; padding: 2px 6px; border-radius: 4px;}
        .stock-crit { color: red; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 4px;}
    </style>
  </head>
  <body class="bodega-page">
    <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <div class="bodega-wrap">
      <div class="bodega-top">
         <div class="bodega-title">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                <line x1="12" y1="22.08" x2="12" y2="12"></line>
            </svg>
            <div>
                <div style="font-size: 22px; line-height: 1">Inventario</div>
                <div class="badge">Control de Stock</div>
            </div>
        </div>
        <div class="actions">
          <a href="<c:url value='/bodeguero/movimientos/nuevo'/>" class="btn pri">+ Movimiento Masivo</a>
        </div>
      </div>

      <div class="kpis">
        <div class="card kpi">
          <div class="label">Total Productos</div>
          <div class="value"><c:out value="${empty productos ? 0 : fn:length(productos)}" /></div>
        </div>
        <div class="card kpi">
          <div class="label">Alertas (Bajo Stock)</div>
          <div class="value" style="color: #d97706;">
             <c:set var="low" value="0" />
             <c:if test="${not empty productos}">
                <c:forEach var="p" items="${productos}">
                  <c:if test="${p.stockActual <= p.stockMinimo}"><c:set var="low" value="${low + 1}" /></c:if>
                </c:forEach>
             </c:if>
             ${low}
          </div>
        </div>
      </div>

      <div class="tabs">
        <span class="tab active">Stock Actual</span>
        <a class="tab" href="<c:url value='/bodeguero/historial'/>">Historial (Kardex)</a>
      </div>

      <section class="section active">
        <div class="tools" id="stock-tools">
          <form method="get" action="<c:url value='/bodeguero/dashboard'/>">
            <input class="input" type="search" name="q" placeholder="Buscar SKU o nombre..." />
            <select class="select" name="cat">
              <option value="">Categoría...</option>
              <c:forEach var="cat" items="${categorias}">
                <option value="${cat.idCategoria}">${cat.nombre}</option>
              </c:forEach>
            </select>
            <button class="btn tiny" type="submit">Buscar</button>
          </form>
        </div>

        <c:if test="${not empty mensaje}"><div class="sv-alert success">${mensaje}</div></c:if>

        <div class="table-wrap">
          <table class="table">
            <thead>
              <tr>
                <th>SKU</th>
                <th>Producto</th>
                <th>Stock Físico</th>
                <th>Estado Stock</th> <th style="text-align: right">Registrar Movimiento</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${productos}">
                <tr>
                  <td>${p.sku}</td>
                  <td>${p.nombre}</td>
                  
                  <td style="font-size: 1.1em;">
                    ${p.stockActual}
                  </td>

                  <td>
                    <c:choose>
                        <c:when test="${p.stockActual == 0}">
                            <span class="stock-crit">SIN STOCK</span>
                        </c:when>
                        <c:when test="${p.stockActual <= p.stockMinimo}">
                            <span class="stock-low">BAJO (Mín: ${p.stockMinimo})</span>
                        </c:when>
                        <c:otherwise>
                            <span class="stock-ok">Normal</span>
                        </c:otherwise>
                    </c:choose>
                  </td>

                  <td style="text-align: right">
                    <a class="btn tiny" href="<c:url value='/bodeguero/entrada?id=${p.idProducto}'/>">Entrada (+)</a>
                    <a class="btn tiny outline" href="<c:url value='/bodeguero/salida?id=${p.idProducto}'/>">Salida (-)</a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty productos}"><tr><td colspan="5">No hay productos registrados.</td></tr></c:if>
            </tbody>
          </table>
        </div>
      </section>
    </div>

    <footer class="footer">
      <div class="footer-content">
        <p>© 2025 Sistema de Ventas</p>
      </div>
    </footer>
  </body>
</html>