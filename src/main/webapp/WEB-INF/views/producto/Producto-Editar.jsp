<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Editar producto — Sistema de Ventas</title>
  <link rel="stylesheet" href="../../CSS/Main.css"/>
  <link rel="stylesheet" href="../../CSS/Navbar.css"/>
  <link rel="stylesheet" href="../../CSS/Footer.css"/>
  <style>
    .input.readonly { background-color: #f3f4f6; color: #6b7280; cursor: not-allowed; border-color: #e5e7eb; }
    .note-warning { font-size: 0.85rem; color: #d97706; margin-top: 4px; display: block; }
  </style>
</head>
<body>

  <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
  </header>
  
  <main class="wrap">
    <header class="page-head">
      <h2>✏️ Editar Datos del Producto</h2>
      <p class="sub">Modifica precios, nombres y alertas. El stock se controla en Bodega.</p>
    </header>

    <section class="grid" style="display: grid; grid-template-columns: 1fr 300px; gap: 20px;">
      <div class="card panel">
        <form class="form" action="<c:url value='/producto/guardar'/>" method="post">
          <input type="hidden" name="idProducto" value="${producto.idProducto}"/>

          <div class="row2" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
            <div class="field">
              <label>Nombre</label>
              <input class="input" name="nombre" value="${producto.nombre}" required/>
            </div>
            <div class="field">
              <label>SKU (Código)</label>
              <input class="input" name="sku" value="${producto.sku}" required/>
            </div>
          </div>

          <div class="row3" style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; margin-top: 15px;">
            <div class="field">
              <label>Categoría</label>
              <select class="select" name="idCategoria" required>
                <c:forEach var="cat" items="${categorias}">
                  <option value="${cat.idCategoria}" <c:if test="${cat.idCategoria == producto.idCategoria}">selected</c:if>>
                    ${cat.nombre}
                  </option>
                </c:forEach>
              </select>
            </div>

            <div class="field">
              <label>Precio (S/)</label>
              <input class="input" name="precio" type="number" step="0.01" value="${producto.precio}" required style="font-weight: bold; color: #2563eb;"/>
            </div>

            <div class="field">
              <label>Stock Actual</label>
              <input class="input readonly" name="stockActual" type="number" 
                     value="${producto.stockActual}" readonly />
              <small class="note-warning">⚠ Gestionar en Bodega</small>
            </div>
          </div>

          <div class="row2" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 15px;">
            <div class="field">
              <label>Alerta Stock Mínimo</label>
              <input class="input" name="stockMinimo" type="number" min="0" value="${producto.stockMinimo}"/>
              <small style="color:#666; font-size:0.8em">Avisar cuando quede menos de...</small>
            </div>

            <div class="field">
              <label>Estado</label>
              <select class="select" name="activo">
                <option value="true"  <c:if test="${producto.activo}">selected</c:if>>Activo</option>
                <option value="false" <c:if test="${!producto.activo}">selected</c:if>>Inactivo</option>
              </select>
            </div>
          </div>

          <div class="actions" style="margin-top: 20px; display: flex; justify-content: flex-end; gap: 10px;">
            <a class="btn ghost" href="<c:url value='/producto/gestion'/>">Cancelar</a>
            <button class="btn primary" type="submit">Guardar Cambios</button>
          </div>
        </form>

        <form action="<c:url value='/producto/eliminar/${producto.idProducto}'/>" method="post" onsubmit="return confirm('¿Eliminar producto?');" style="margin-top: 20px; border-top: 1px solid #eee; padding-top: 10px;">
          <button class="btn danger" type="submit" style="background:none; border:none; color: red; cursor: pointer; text-decoration: underline;">Eliminar producto permanentemente</button>
        </form>
      </div>

      <aside class="card preview">
        <div style="text-align:center; padding: 20px;">
            <h3>Vista Previa</h3>
            <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">${producto.nombre}</div>
            <div style="font-size: 1.5rem; color: #2563eb;">S/ ${producto.precio}</div>
            <div style="margin-top: 10px; color: #666;">SKU: ${producto.sku}</div>
        </div>
      </aside>
    </section>
  </main>
</body>
</html>