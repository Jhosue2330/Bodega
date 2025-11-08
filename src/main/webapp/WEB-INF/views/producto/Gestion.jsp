<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Gestión de Productos</title>
    <!-- CSS estático desde /static/css -->
    <link rel="stylesheet" href="<c:url value='/css/Gestion.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/Navbar.css'/>" />
  </head>
  <body data-page="gestion">
    <!-- NAVBAR global (fragmento) -->
    <jsp:include page="/WEB-INF/views/componentes/navbar_bodega.jsp" />

    <main class="wrap">
      <!-- Mensaje flash -->
      <c:if test="${not empty mensaje}">
        <div class="sv-alert success">${mensaje}</div>
      </c:if>

      <!-- Encabezado -->
      <header class="top">
        <div>
          <h1>Gestión de Productos</h1>
          <p class="muted">Catálogo, stock y precios.</p>
        </div>
        <a href="#nuevo" class="btn pri">+ Nuevo</a>
      </header>

      <!-- Barra de búsqueda (si luego agregas endpoint, cambia href/action) -->
      <section class="bar">
        <form action="<c:url value='/producto/gestion'/>" method="get" class="bar">
          <input class="in" type="search" name="q" placeholder="Buscar por nombre o código…" />
          <select class="in" name="estado">
            <option value="">Todos</option>
            <option value="ACTIVO">Activos</option>
            <option value="INACTIVO">Inactivos</option>
          </select>
          <a class="btn" href="<c:url value='/producto/export/json'/>">Exportar JSON</a>
        </form>
      </section>

      <!-- Tabla de productos -->
      <section class="card">
        <div class="cardh">
          <h2>Listado</h2>
          <span class="badge">
            <c:out value="${empty productos ? 0 : fn:length(productos)}" />
          </span>
        </div>

        <div class="tblwrap">
          <table class="tbl">
            <thead>
              <tr>
                <th>Código</th>
                <th>Nombre</th>
                <th>Precio (S/)</th>
                <th>Stock</th>
                <th>Estado</th>
                <th class="c">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${productos}">
                <tr>
                  <td>${p.sku}</td>
                  <td>${p.nombre}</td>
                  <td>${p.precio}</td>
                  <td>${p.stockActual}</td>
                  <td>
                    <span class="tag ${p.activo ? 'ok' : 'warn'}">
                      <c:out value="${p.activo ? 'Activo' : 'Inactivo'}" />
                    </span>
                  </td>
                  <td class="c">
                    <a
                      class="icon"
                      title="Editar"
                      href="<c:url value='/producto/editar/${p.idProducto}'/>"
                      >✎</a
                    >

                    <form
                      action="<c:url value='/producto/eliminar/${p.idProducto}'/>"
                      method="post"
                      style="display: inline"
                      onsubmit="return confirm('¿Eliminar este producto?');"
                    >
                      <button class="icon" type="submit" title="Eliminar">🗑</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty productos}">
                <tr>
                  <td colspan="6">No hay productos.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </section>

      <!-- Crear nuevo producto (conectado a BD) -->
      <details id="nuevo" class="newbox">
        <summary class="btn link">➕ Crear nuevo producto</summary>

        <form class="form" action="<c:url value='/producto/guardar'/>" method="post">
          <div class="grid">
            <label>
              <span>Código (SKU)*</span>
              <input class="in" name="sku" required />
            </label>

            <label>
              <span>Nombre</span>
              <input class="in" name="nombre" required />
            </label>

            <label>
              <span>Precio*</span>
              <input class="in" name="precio" type="number" step="0.01" min="0" required />
            </label>

            <label>
              <span>Stock</span>
              <input class="in" name="stockActual" type="number" min="0" required />
            </label>

            <label>
              <span>Stock mínimo</span>
              <input class="in" name="stockMinimo" type="number" min="0" value="0" />
            </label>

            <label>
              <span>Categoría</span>
              <select class="in" name="idCategoria" required>
                <c:forEach var="cat" items="${categorias}">
                  <option value="${cat.idCategoria}">${cat.nombre}</option>
                </c:forEach>
              </select>
            </label>

            <label>
              <span>Estado</span>
              <select class="in" name="activo">
                <option value="true" selected>Activo</option>
                <option value="false">Inactivo</option>
              </select>
            </label>

            <!-- Si quieres mantener “Descripción” visual, pero no está en la entidad:
          <label class="span-2">
            <span>Descripción</span>
            <textarea class="in" rows="3" name="descripcion"></textarea>
          </label>
          --></div>

          <div class="actions">
            <a class="btn" href="#top">Cancelar</a>
            <button class="btn pri" type="submit">Guardar</button>
          </div>
        </form>
      </details>
    </main>
  </body>
</html>
