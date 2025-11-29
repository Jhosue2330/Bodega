<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ventas</title>
  <link rel="stylesheet" href="<c:url value='/CSS/Venta.css'/>" />
  <style>
    /* Pequeño ajuste para que los modales funcionen solo con CSS (:target) */
    .modal { display: none; opacity: 0; pointer-events: none; transition: opacity 0.3s; }
    .modal:target { display: flex; opacity: 1; pointer-events: auto; }
  </style>
</head>

<body>
  <header id="navbar">
    <%@ include file="../componentes/navbar_bodega.jsp" %>
  </header>

  <main class="wrap">
    <header class="top">
      <div>
        <h1>Ventas</h1>
        <p class="muted">Registra una venta y genera el comprobante</p>
      </div>
      <a href="<c:url value='/ventas/nueva'/>" class="btn pri">+ Nueva venta</a>
    </header>

    <section class="bar">
      <form action="<c:url value='/ventas/actualizar'/>" method="post" style="display:flex; gap:10px; width:100%;">
          <div style="flex:1"></div>
          <label class="muted">Desc. Global S/</label>
          <input class="in small" name="descuentoGlobal" type="number" min="0" step="0.01" value="${sessionScope.ventaActual.descuentoGlobal}" />
          <button type="submit" class="btn">Aplicar</button>
      </form>
      <a href="#m-agregar" class="btn">+ Agregar Producto</a>
    </section>

    <section class="grid" style="display:grid;grid-template-columns:1fr 320px;gap:16px;">
      
      <div class="card">
        <div style="display:flex;align-items:center;justify-content:space-between;">
          <h2>Detalle de venta</h2>
          <span class="badge" id="badgeItems">${empty sessionScope.ventaActual.detalles ? 0 : sessionScope.ventaActual.detalles.size()}</span>
        </div>

        <table class="tbl" id="tblDetalle">
          <thead>
            <tr>
              <th>Código</th>
              <th>Producto</th>
              <th>Precio</th>
              <th>Cant.</th>
              <th>Subtotal</th>
              <th class="c">Acciones</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="det" items="${sessionScope.ventaActual.detalles}" varStatus="status">
              <tr>
                <td><c:out value="${det.sku}"/></td>
                <td><c:out value="${det.nombre}"/></td>
                <td>S/ <fmt:formatNumber value="${det.precioVenta}" minFractionDigits="2"/></td>
                <td><c:out value="${det.cantidad}"/></td>
                <td>S/ <fmt:formatNumber value="${det.subtotal}" minFractionDigits="2"/></td>
                <td class="c">
                   <a href="<c:url value='/ventas/item/eliminar?index=${status.index}'/>" class="btn icon" style="text-decoration:none; color:red;">🗑</a>
                </td>
              </tr>
            </c:forEach>
            
            <c:if test="${empty sessionScope.ventaActual.detalles}">
                <tr><td colspan="6" class="muted c">El carrito está vacío</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <aside class="side">
        <div class="card">
          <h3>Totales</h3>
          <div class="row">
              <span>Sub. sin IGV</span>
              <b>S/ <fmt:formatNumber value="${sessionScope.ventaActual.subtotalSinIgv}" minFractionDigits="2"/></b>
          </div>
          <div class="row">
              <span>IGV (18%)</span>
              <b>S/ <fmt:formatNumber value="${sessionScope.ventaActual.igv}" minFractionDigits="2"/></b>
          </div>
          <div class="row">
              <span>Descuento</span>
              <b>- S/ <fmt:formatNumber value="${sessionScope.ventaActual.descuentoGlobal}" minFractionDigits="2"/></b>
          </div>
          <div class="row total">
              <span>Total a pagar</span>
              <b>S/ <fmt:formatNumber value="${sessionScope.ventaActual.total}" minFractionDigits="2"/></b>
          </div>
        </div>

        <form action="<c:url value='/ventas/registrar'/>" method="post">
          <input type="hidden" name="idVendedor" value="1" />
          
          <div style="background: #f8fafc; padding: 10px; border: 1px solid #e2e8f0; border-radius: 6px; margin-bottom: 15px;">
            <p style="margin: 0 0 5px 0; font-weight: bold; color: #475569; font-size: 0.9em;">🛵 Datos Delivery (Opcional)</p>
            
            <input class="in" name="nombreCliente" placeholder="Nombre Cliente" style="margin-bottom: 5px; font-size: 0.9em; padding: 5px;" />
            <input class="in" name="direccion" placeholder="Dirección Exacta" style="margin-bottom: 5px; font-size: 0.9em; padding: 5px;" />
            <input class="in" name="telefono" placeholder="Teléfono / WhatsApp" style="font-size: 0.9em; padding: 5px;" />
          </div>

          <div class="actions r">
            <button type="submit" class="btn pri" ${empty sessionScope.ventaActual.detalles ? 'disabled' : ''}>
                ✅ Registrar Venta / Pedido
            </button>
          </div>
        </form>
      </aside>
    </section>

    <section style="margin-top:18px;">
      <div class="card">
        <h3>Últimas ventas registradas</h3>
        <table class="tbl">
          <thead><tr><th>ID</th><th>Fecha</th><th>Tipo</th><th>Total</th></tr></thead>
          <tbody>
            <c:forEach var="v" items="${listaVentas}">
              <tr>
                <td>${v.idVenta}</td>
                <td><c:out value="${v.fecha}"/></td>
                <td>${v.tipoVenta}</td>
                <td>S/ <fmt:formatNumber value="${v.total}" minFractionDigits="2"/></td>
              </tr>
            </c:forEach>
            <c:if test="${empty listaVentas}">
              <tr><td colspan="4" class="muted">No hay ventas registradas hoy</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </section>
  </main>

  <section id="m-agregar" class="modal">
    <div class="box" style="max-width: 600px;">
      <a href="#" class="x">×</a> <h3>Agregar producto</h3>
      
      <form action="<c:url value='/ventas/buscar#m-agregar'/>" method="get" style="display:flex;gap:8px;margin-bottom:15px;">
        <input name="q" class="in" placeholder="Buscar por nombre o código..." value="${param.q}" required/>
        <button type="submit" class="btn">Buscar</button>
      </form>

      <div class="search-results-server" style="max-height:300px; overflow-y:auto; border:1px solid #eee; padding:5px;">
        <c:forEach var="prod" items="${resultadosBusqueda}">
            <div style="border-bottom:1px solid #eee; padding: 8px; display:flex; justify-content:space-between; align-items:center;">
                <div>
                    <strong>${prod.sku}</strong> - ${prod.nombre}<br>
                    <small class="muted">Stock: ${prod.stockActual} | Precio: S/ ${prod.precio}</small>
                </div>
                
                <form action="<c:url value='/ventas/item/agregar'/>" method="post" style="display:flex; gap:5px; align-items:center;">
                    <input type="hidden" name="idProducto" value="${prod.idProducto}">
                    <input type="hidden" name="sku" value="${prod.sku}">
                    <input type="hidden" name="nombre" value="${prod.nombre}">
                    <input type="hidden" name="precio" value="${prod.precio}">
                    
                    <input type="number" name="cantidad" value="1" min="1" max="${prod.stockActual}" style="width:60px; padding:5px;" class="in">
                    <button type="submit" class="btn pri">Agregar</button>
                </form>
            </div>
        </c:forEach>
        
        <c:if test="${not empty param.q and empty resultadosBusqueda}">
            <p class="muted">No se encontraron productos para "${param.q}"</p>
        </c:if>
        
        <c:if test="${empty param.q and empty resultadosBusqueda}">
            <p class="muted">Realiza una búsqueda para ver productos.</p>
        </c:if>
      </div>

      <div class="actions r" style="margin-top:12px;">
        <a href="#" class="btn">Cerrar</a>
      </div>
    </div>
  </section>

</body>
</html>