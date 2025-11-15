<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>➖ Nueva salida — Bodega</title>
  <link rel="stylesheet" href="<c:url value='/CSS/Main.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Footer.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Movimientos.css'/>">
</head>
<body class="bodega-page">
  <%@ include file="../componentes/navbar_bodega.jsp" %>

  <main class="wrap">
    <header class="page-head"><h2>➖ Nueva salida</h2><p class="sub">Registro sin JS</p></header>

    <section class="card form-pane">
      <form class="form" action="<c:url value='/bodeguero/movimientos/salida-form'/>" method="post">
        <c:if test="${not empty _csrf}">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>

        <div class="row3">
          <div class="field">
            <label>Producto (SKU · Nombre)</label>
            <select class="input" name="idProducto" required>
              <c:forEach var="p" items="${productos}">
                <c:choose>
                  <c:when test="${not empty preselectId and preselectId == p.idProducto}">
                    <option value="${p.idProducto}" selected>${p.sku} · ${p.nombre}</option>
                  </c:when>
                  <c:otherwise>
                    <option value="${p.idProducto}">${p.sku} · ${p.nombre}</option>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </select>
          </div>

          <div class="field">
            <label>Cantidad</label>
            <input class="input" name="cantidad" type="number" min="1" value="1" required>
          </div>

          <div class="field">
            <label>Fecha</label>
            <input class="input" name="fecha" type="date" value="${preselectDate}" />
          </div>
        </div>

        <div class="field">
          <label>Referencia</label>
          <input class="input" name="motivo" placeholder="Venta / Delivery / Nota">
        </div>

        <div class="field">
          <label>Usuario (responsable)</label>
          <select class="input" name="idUsuario" required>
            <c:forEach var="u" items="${usuarios}">
              <option value="${u.idUsuario}">${u.nombreCompleto}</option>
            </c:forEach>
          </select>
        </div>

        <div class="field">
          <label>Id venta (opcional)</label>
          <input class="input" name="idVenta" type="number" min="1" placeholder="ID venta relacionada (opcional)">
        </div>

        <div class="actions">
          <a class="btn ghost" href="<c:url value='/bodeguero/dashboard'/>">Cancelar</a>
          <button class="btn primary" type="submit">Guardar</button>
        </div>
      </form>
    </section>
  </main>

  <footer class="footer"><div class="footer-content"><p>© 2025 Sistema de Ventas – Bodega</p></div></footer>
</body>
</html>