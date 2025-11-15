<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Editar producto — Sistema de Ventas</title>

  <link rel="stylesheet" href="../CSS/Main.css"/>
  <link rel="stylesheet" href="../CSS/Navbar.css"/>
  <link rel="stylesheet" href="../CSS/Footer.css"/>
  <link rel="stylesheet" href="../CSS/Producto-Editar.css"/>
</head>
<body>

  <!-- NAVBAR -->
  <header id="navbar">
      <%-- Incluye el NAVBAR PÚBLICO --%> <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>
  <main class="wrap">
    <header class="page-head">
      <h2>✏️ Editar producto</h2>
      <p class="sub">
        <span class="pill">SKU:</span> ${producto.sku}
        • Última modificación automática
      </p>
    </header>

    <section class="grid">
      <!-- Columna 1: Formulario -->
      <div class="card panel">
        <form class="form"
              action="<c:url value='/producto/guardar'/>"
              method="post">

          <!-- Campo oculto ID -->
          <input type="hidden" name="idProducto" value="${producto.idProducto}"/>

          <div class="row2">
            <div class="field">
              <label>Nombre</label>
              <input class="input" name="nombre" value="${producto.nombre}" required/>
            </div>
            <div class="field">
              <label>SKU</label>
              <input class="input" name="sku" value="${producto.sku}" required/>
            </div>
          </div>

          <div class="row3">
            <div class="field">
              <label>Categoría</label>
              <select class="select" name="idCategoria" required>
                <c:forEach var="cat" items="${categorias}">
                  <option value="${cat.idCategoria}"
                          <c:if test="${cat.idCategoria == producto.idCategoria}">selected</c:if>>
                    ${cat.nombre}
                  </option>
                </c:forEach>
              </select>
            </div>

            <div class="field">
              <label>Precio (S/)</label>
              <input class="input" name="precio" type="number" step="0.01"
                     value="${producto.precio}" required/>
            </div>

            <div class="field">
              <label>Stock</label>
              <input class="input" name="stockActual" type="number" min="0"
                     value="${producto.stockActual}" required/>
            </div>
          </div>

          <div class="row2">
            <div class="field">
              <label>Stock mínimo</label>
              <input class="input" name="stockMinimo" type="number" min="0"
                     value="${producto.stockMinimo}"/>
            </div>

            <div class="field">
              <label>Estado</label>
              <select class="select" name="activo">
                <option value="true"  <c:if test="${producto.activo}">selected</c:if>>Activo</option>
                <option value="false" <c:if test="${!producto.activo}">selected</c:if>>Inactivo</option>
              </select>
            </div>
          </div>

          <!-- (Imagen y descripción quitados porque no existen en el modelo) -->

          <div class="actions">
            <a class="btn ghost" href="<c:url value='/producto/gestion'/>">Cancelar</a>
            <button class="btn primary" type="submit">Actualizar</button>
          </div>
        </form>

        <!-- Botón eliminar como formulario aparte (no anidado) -->
        <form action="<c:url value='/producto/eliminar/${producto.idProducto}'/>"
              method="post"
              onsubmit="return confirm('¿Eliminar este producto?');"
              style="margin-top: 10px">
          <button class="btn danger" type="submit">Eliminar</button>
        </form>
      </div>

      <!-- Columna 2: Vista previa SIMPLE -->
      <aside class="card preview">
        <figure class="thumb">
          <!-- Placeholder fijo porque no hay campo imagen en la BD -->
          <img src="<c:url value='/img/placeholder-producto.png'/>" alt="Vista previa"/>
        </figure>
        <div class="meta">
          <div><span class="pill">SKU</span> ${producto.sku}</div>
          <div><span class="pill">Estado</span>
            <c:out value="${producto.activo ? 'Activo' : 'Inactivo'}"/>
          </div>
        </div>
        <p class="sub">Vista previa básica del producto (sin imagen de BD).</p>
      </aside>
    </section>
  </main>

  <footer class="footer">
    <div class="footer-content">
      <p>© 2025 Sistema de Ventas</p>
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
