<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Crear producto — Sistema de Ventas</title>

    <!-- Tus estilos (desde /static/css) -->
    <link rel="stylesheet" href="<c:url value='/css/Main.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/Navbar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/Footer.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/Producto-Crear.css'/>" />
  </head>
  <body>
    <!-- NAVBAR -->
    <header id="navbar">
      <%-- Incluye el NAVBAR PÚBLICO --%> <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <main class="wrap">
      <header class="page-head">
        <h2>➕ Crear producto</h2>
        <a class="btn" href="<c:url value='/bodeguero/dashboard'/>">Volver</a>
        <p class="sub">Formulario de alta conectado a la BD.</p>
      </header>

      <section class="card panel">
        <!-- IMPORTANTE: multipart solo si vas a procesar imagen luego -->
        <form
          class="form"
          action="<c:url value='/producto/guardar'/>"
          method="post"
          enctype="multipart/form-data"
        >
          <div class="row2">
            <div class="field">
              <label>Nombre</label>
              <input class="input" name="nombre" placeholder="p. ej., Arroz 1kg" required />
            </div>
            <div class="field">
              <label>SKU</label>
              <input class="input" name="sku" placeholder="ARZ-1KG" required />
            </div>
          </div>

          <div class="row3">
            <div class="field">
              <label>Categoría</label>
              <select class="select" name="idCategoria" required>
                <c:forEach var="cat" items="${categorias}">
                  <option value="${cat.idCategoria}">${cat.nombre}</option>
                </c:forEach>
              </select>
            </div>

            <div class="field">
              <label>Precio (S/)</label>
              <input
                class="input"
                name="precio"
                type="number"
                step="0.01"
                min="0"
                placeholder="0.00"
                required
              />
            </div>

            <div class="field">
              <label>Stock inicial</label>
              <input
                class="input"
                name="stockActual"
                type="number"
                min="0"
                placeholder="0"
                required
              />
            </div>
          </div>

          <div class="row2">
            <div class="field">
              <label>Stock mínimo</label>
              <input class="input" name="stockMinimo" type="number" min="0" value="0" />
            </div>

            <div class="field">
              <label>Estado</label>
              <select class="select" name="activo">
                <option value="true" selected>Activo</option>
                <option value="false">Inactivo</option>
              </select>
            </div>
          </div>

          <!-- Imagen: aún no la mapeamos en la entidad. Puedes dejarla para luego. -->
          <div class="row2">
            <div class="field">
              <label>Imagen</label>
              <input class="input" type="file" name="imagen" accept="image/*" />
              <small class="help">Sugerido 800×600px • carpeta ../Imagenes</small>
            </div>
          </div>

          <!-- Descripción: si planeas persistirla, agrégala luego al modelo -->
          <div class="field">
            <label>Descripción</label>
            <textarea
              class="input"
              name="descripcion"
              placeholder="Descripción breve del producto"
            ></textarea>
          </div>

          <div class="actions">
            <a class="btn ghost" href="<c:url value='/producto/gestion'/>">Cancelar</a>
            <button class="btn primary" type="submit">Guardar</button>
          </div>
        </form>
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
