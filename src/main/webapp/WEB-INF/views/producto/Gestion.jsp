<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Gestión de Productos</title>
    <link rel="stylesheet" href="../CSS/Gestion.css" />
    <link rel="stylesheet" href="../CSS/Navbar.css" />
  </head>
  <body data-page="gestion">
    <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <main class="wrap">
      <c:if test="${not empty mensaje}"><div class="sv-alert success">${mensaje}</div></c:if>

      <header class="top">
        <div>
          <h1>Gestión de Catálogo</h1>
          <p class="muted">Define precios y productos nuevos.</p>
        </div>
        <a href="<c:url value='/producto/nuevo'/>" class="btn pri">+ Nuevo Producto</a>
      </header>

      <section class="bar">
        <form action="<c:url value='/producto/gestion'/>" method="get" class="bar">
          <input class="in" type="search" name="q" placeholder="Buscar producto…" />
          <select class="in" name="estado">
            <option value="">Todos</option>
            <option value="ACTIVO">Activos</option>
            <option value="INACTIVO">Inactivos</option>
          </select>
          <button class="btn">Filtrar</button>
        </form>
      </section>

      <section class="card">
        <div class="cardh">
          <h2>Listado de Productos</h2>
          <span class="badge"><c:out value="${empty productos ? 0 : fn:length(productos)}" /></span>
        </div>

        <div class="tblwrap">
          <table class="tbl">
            <thead>
              <tr>
                <th>Código</th>
                <th>Nombre</th>
                <th>Precio (S/)</th>
                <th>Alerta Mín.</th>
                <th>Stock Actual</th> <th>Estado</th>
                <th class="c">Editar</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${productos}">
                <tr>
                  <td>${p.sku}</td>
                  <td><strong>${p.nombre}</strong></td>
                  <td style="color: #2563eb; font-weight: bold;">S/ ${p.precio}</td>
                  <td>${p.stockMinimo} ud.</td>
                  <td class="muted">${p.stockActual}</td>
                  <td>
                    <span class="tag ${p.activo ? 'ok' : 'warn'}">
                      ${p.activo ? 'Activo' : 'Inactivo'}
                    </span>
                  </td>
                  <td class="c">
                    <a class="btn tiny" href="<c:url value='/producto/editar/${p.idProducto}'/>">Editar Datos</a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty productos}"><tr><td colspan="7">No hay productos.</td></tr></c:if>
            </tbody>
          </table>
        </div>
      </section>

      
    </main>
  </body>
</html>