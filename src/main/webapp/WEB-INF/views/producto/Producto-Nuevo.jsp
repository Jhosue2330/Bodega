<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Nuevo Producto — Gestión</title>
  <link rel="stylesheet" href="<c:url value='/CSS/Main.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Gestion.css'/>">
</head>
<body data-page="gestion">
  
  <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
  </header>

  <main class="wrap">
    <header class="page-head">
      <h2>✨ Registrar Nuevo Producto</h2>
      <p class="sub">Paso 1: Crea la ficha (Precio/Nombre). Paso 2: El sistema te llevará a Bodega.</p>
    </header>

    <section class="card form-pane" style="max-width: 600px; margin: 0 auto;">
      <form class="form" action="<c:url value='/producto/guardar'/>" method="post">
        
        <div class="row2" style="display:grid; grid-template-columns: 1fr 1fr; gap: 15px;">
            <div class="field">
                <label>Código (SKU) *</label>
                <input class="input" name="sku" placeholder="Ej: GAL-VAI-01" required />
            </div>
            <div class="field">
                <label>Categoría *</label>
                <select class="input" name="idCategoria" required>
                    <option value="">-- Seleccionar --</option>
                    <c:forEach var="cat" items="${categorias}">
                        <option value="${cat.idCategoria}">${cat.nombre}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="field" style="margin-top: 15px;">
            <label>Nombre del Producto *</label>
            <input class="input" name="nombre" placeholder="Ej: Galletas Vainilla Paquete 6und" required />
        </div>

        <div class="row2" style="display:grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 15px;">
            <div class="field">
                <label>Precio Venta (S/) *</label>
                <input class="input" name="precio" type="number" step="0.01" min="0" placeholder="0.00" required />
            </div>
            
            <div class="field">
                <label>Alerta Stock Mínimo</label>
                <input class="input" name="stockMinimo" type="number" min="0" value="5" />
                <small style="color:#666; font-size:0.8em">Para avisar en Bodega.</small>
            </div>
        </div>

        <div class="field" style="margin-top: 15px;">
            <label>Estado Inicial</label>
            <select class="input" name="activo">
                <option value="true" selected>Activo (Disponible)</option>
                <option value="false">Inactivo (Oculto)</option>
            </select>
        </div>

        <div style="margin-top: 20px; background: #f0fdf4; padding: 15px; border-radius: 4px; border-left: 4px solid #16a34a; color: #166534; font-size: 0.9em;">
            <strong>🚀 Siguiente paso:</strong><br>
            Al guardar, serás redirigido automáticamente a <strong>Bodega</strong> para registrar la cantidad inicial que ha llegado.
        </div>

        <div class="actions" style="margin-top: 20px; text-align: right;">
          <a class="btn ghost" href="<c:url value='/producto/gestion'/>">Cancelar</a>
          <button class="btn primary" type="submit">Guardar y Continuar</button>
        </div>
      </form>
    </section>
  </main>
</body>
</html>