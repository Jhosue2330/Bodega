<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="es_PE" />
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Ventas</title>
    <link rel="stylesheet" href="<c:url value='/CSS/Venta.css'/>" />
    <style>
      body { font-family: Arial, sans-serif; background:#f6f7fb; margin:0; padding:18px; color:#222; }
      .wrap { max-width:1100px; margin:0 auto; }
      .tbl { width:100%; border-collapse:collapse; }
      .tbl th, .tbl td { padding:8px; border-bottom:1px solid #eaeaea; text-align:left; }
      .card { background:#fff; padding:12px; border-radius:6px; box-shadow:0 1px 3px rgba(0,0,0,.05); }
      .actions.r { display:flex; justify-content:flex-end; gap:8px; margin-top:12px; }
      .btn { padding:8px 12px; border-radius:4px; text-decoration:none; display:inline-block; cursor:pointer; }
      .btn.pri { background:#0b74de; color:#fff; border:none; }
      .btn.outline { border:1px solid #0b74de; background:transparent; color:#0b74de; }
      .muted { color:#666; }
      .modal .box { max-width:520px; margin:40px auto; background:#fff; padding:16px; border-radius:8px; }
      .modal { display:none; position:fixed; inset:0; background:rgba(0,0,0,.5); z-index:30; }
      .modal:target { display:block; }
      .grid-mini { display:grid; grid-template-columns: 1fr 80px 100px; gap:8px; align-items:center; }
      .in { padding:8px; width:100%; box-sizing:border-box; }
      .small { width:80px; }
      .badge { background:#eee; padding:4px 8px; border-radius:12px; }
      .row.total b { font-size:1.1rem; }
      header.top { display:flex; align-items:center; justify-content:space-between; gap:12px; margin-bottom:12px; }
      section.bar { display:flex; gap:8px; align-items:center; margin-bottom:12px; }
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
        <a href="#m-nueva" class="btn pri">+ Nueva venta</a>
      </header>

      <section class="bar">
        <input id="buscarProducto" class="in" type="search" placeholder="Buscar producto..." />
        <input id="buscarCantidad" class="in small" type="number" min="1" value="1" />
        <a href="#m-agregar" class="btn" id="btnAbrirAgregar">+ Agregar</a>
        <div style="flex:1"></div>
        <label class="muted">Desc. S/</label>
        <input class="in small" id="inputDescuentoVisible" type="number" min="0" value="0" />
      </section>

      <section class="grid" style="display:grid;grid-template-columns:1fr 320px; gap:16px;">
        <div class="card">
          <div style="display:flex;align-items:center;justify-content:space-between;">
            <h2>Detalle de venta</h2>
            <span class="badge" id="badgeItems">0</span>
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
            <tbody id="tbodyDetalle">
            </tbody>
          </table>
        </div>

        <aside class="side">
          <div class="card">
            <h3>Totales</h3>
            <div class="row"><span>Sub. sin IGV</span><b id="subSinIgv">S/ 0.00</b></div>
            <div class="row"><span>IGV (18%)</span><b id="igv">S/ 0.00</b></div>
            <div class="row"><span>Descuento</span><b id="descuento">- S/ 0.00</b></div>
            <div class="row total"><span>Total a pagar</span><b id="totalPagar">S/ 0.00</b></div>
          </div>

          <form id="formVenta" action="<c:url value='/ventas/registrar'/>" method="post">
            <input type="hidden" name="tipoVenta" value="POS" />
            <input type="hidden" name="descuento" id="inputDescuento" value="0" />
            <input type="hidden" name="idVendedor" value="1" />
            <div id="hiddenDetalle"></div>

            <div class="actions r">
              <button type="button" id="btnRegistrar" class="btn pri">Registrar venta</button>
              <button type="button" id="btnImprimir" class="btn outline">Imprimir</button>
            </div>
          </form>
        </aside>
      </section>

      <section style="margin-top:18px;">
        <div class="card">
          <h3>Ventas registradas</h3>
          <table class="tbl">
            <thead>
              <tr><th>ID</th><th>Fecha</th><th>Tipo</th><th>Total</th></tr>
            </thead>
            <tbody>
              <c:forEach var="v" items="${ventas}">
                <tr>
                  <td>${v.idVenta}</td>
                  <td><c:out value="${v.fecha}"/></td>
                  <td>${v.tipoVenta}</td>
                  <td>S/ <fmt:formatNumber value="${v.total}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>
              </c:forEach>
              <c:if test="${empty ventas}">
                <tr><td colspan="4" class="muted">No hay ventas registradas</td></tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </section>
    </main>

    <section id="m-agregar" class="modal">
      <div class="box">
        <a href="#" class="x">×</a>
        <h3>Agregar producto</h3>
        <p class="muted">Ingresa los datos del producto. Puedes usar el buscador para autocompletar (si lo implementas).</p>

        <div class="grid-mini" style="margin-top:8px;">
          <input id="modal_producto_id" type="hidden" />
          <input id="modal_codigo" class="in" placeholder="Código (p. ej. P-0001)" />
          <input id="modal_cantidad" class="in small" type="number" min="1" value="1" />
          <input id="modal_precio" class="in" type="number" step="0.01" value="0.00" />
          <input id="modal_nombre" class="in" placeholder="Nombre del producto" style="grid-column:1 / span 3;" />
        </div>

        <div class="actions r" style="margin-top:12px;">
          <a href="#" class="btn">Cancelar</a>
          <button type="button" class="btn pri" id="btnAgregarModal">Agregar</button>
        </div>
      </div>
    </section>

    <section id="m-registrar" class="modal">
      <div class="box">
        <a href="#" class="x">×</a>
        <h3>Registrar venta</h3>
        <ul class="summary">
          <li id="summaryItems">Items: 0</li>
          <li id="summaryTotal">Total: S/ 0.00</li>
        </ul>
        <div class="actions r">
          <a href="#" class="btn">Cancelar</a>
          <a href="#" id="confirmarRegistro" class="btn pri">Confirmar</a>
        </div>
      </div>
    </section>

    <section id="m-imprimir" class="modal">
      <div class="box">
        <a href="#" class="x">×</a>
        <h3>Imprimir ticket</h3>
        <div class="ticket" id="ticketContent" style="white-space:pre-wrap;"></div>
        <div class="actions r">
          <a href="#" class="btn">Cerrar</a>
          <a href="#" class="btn pri" id="btnImprimirConfirm">Imprimir</a>
        </div>
      </div>
    </section>

    <section id="m-ok" class="modal">
      <div class="box ok">
        <a href="#" class="x">×</a>
        <h3>Acción completada</h3>
        <p>Operación simulada correctamente.</p>
        <div class="actions r"><a href="#" class="btn pri">Volver</a></div>
      </div>
    </section>

    <script>
      const detalles = [];

      function toCurrency(v) { return 'S/ ' + Number(v || 0).toFixed(2); }

      function agregarAlCarrito(obj) {
        let exist = detalles.find(x =>
          (x.idProducto && obj.idProducto && x.idProducto === obj.idProducto) ||
          (x.codigo && obj.codigo && x.codigo === obj.codigo)
        );
        if (exist) {
          exist.cantidad = Number(exist.cantidad) + Number(obj.cantidad);
          exist.subtotal = +(exist.cantidad * exist.precio).toFixed(2);
        } else {
          obj.subtotal = +(obj.cantidad * obj.precio).toFixed(2);
          detalles.push(obj);
        }
        renderCarrito();
      }

      function quitarDelCarrito(idx) {
        detalles.splice(idx,1);
        renderCarrito();
      }

      function renderCarrito() {
        const tbody = document.getElementById('tbodyDetalle');
        tbody.innerHTML = '';
        let total = 0;
        detalles.forEach((d, i) => {
          total += d.subtotal;
          const tr = document.createElement('tr');
          tr.innerHTML = `
            <td>${d.codigo || ''}</td>
            <td>${d.nombre || ''}</td>
            <td>${Number(d.precio).toFixed(2)}</td>
            <td>${d.cantidad}</td>
            <td>${Number(d.subtotal).toFixed(2)}</td>
            <td class="c">
              <button type="button" class="icon" onclick="quitarDelCarrito(${i})">🗑</button>
            </td>`;
          tbody.appendChild(tr);
        });

        document.getElementById('badgeItems').textContent = detalles.length;
        const sub = total;
        const igv = +(sub * 0.18).toFixed(2);
        const descuentoVisible = parseFloat(document.getElementById('inputDescuentoVisible').value || 0);
        document.getElementById('subSinIgv').textContent = toCurrency(sub);
        document.getElementById('igv').textContent = toCurrency(igv);
        document.getElementById('descuento').textContent = '- ' + toCurrency(descuentoVisible);
        const totalPagar = +(sub + igv - descuentoVisible).toFixed(2);
        document.getElementById('totalPagar').textContent = toCurrency(totalPagar);

        buildHiddenInputs();

        document.getElementById('summaryItems').textContent = 'Items: ' + detalles.length;
        document.getElementById('summaryTotal').textContent = 'Total: ' + toCurrency(totalPagar);
      }

      function buildHiddenInputs() {
        const container = document.getElementById('hiddenDetalle');
        container.innerHTML = '';
        detalles.forEach(d => {
          const pid = d.idProducto != null ? d.idProducto : '';
          container.insertAdjacentHTML('beforeend', `<input type="hidden" name="productoIds[]" value="${pid}" />`);
          container.insertAdjacentHTML('beforeend', `<input type="hidden" name="cantidades[]" value="${d.cantidad}" />`);
          container.insertAdjacentHTML('beforeend', `<input type="hidden" name="precios[]" value="${d.precio}" />`);
        });
        const descuentoVal = parseFloat(document.getElementById('inputDescuentoVisible').value || 0);
        document.getElementById('inputDescuento').value = descuentoVal;
      }

      document.getElementById('btnAgregarModal').addEventListener('click', function(){
        const idProd = document.getElementById('modal_producto_id').value ? parseInt(document.getElementById('modal_producto_id').value,10) : null;
        const codigo = document.getElementById('modal_codigo').value.trim();
        const nombre = document.getElementById('modal_nombre').value.trim();
        const cantidad = parseInt(document.getElementById('modal_cantidad').value,10) || 1;
        const precio = parseFloat(document.getElementById('modal_precio').value) || 0.0;

        if (!nombre && !codigo) { alert('Ingresa código o nombre del producto'); return; }
        if (cantidad <= 0) { alert('Cantidad inválida'); return; }
        if (precio < 0) { alert('Precio inválido'); return; }

        agregarAlCarrito({ idProducto: idProd, codigo: codigo, nombre: nombre, cantidad: cantidad, precio: precio });

        document.getElementById('modal_producto_id').value = '';
        document.getElementById('modal_codigo').value = '';
        document.getElementById('modal_nombre').value = '';
        document.getElementById('modal_cantidad').value = 1;
        document.getElementById('modal_precio').value = '0.00';
        window.location.hash = '';
      });

      document.getElementById('btnRegistrar').addEventListener('click', function(){
        if (detalles.length === 0) { alert('Agrega al menos un producto'); return; }
        location.hash = 'm-registrar';
      });

      document.getElementById('confirmarRegistro').addEventListener('click', function(e){
        location.hash = '';
        document.getElementById('formVenta').submit();
      });

      document.getElementById('btnImprimir').addEventListener('click', function(){
        if (detalles.length === 0) { alert('Agrega al menos un producto'); return; }
        let lines = [];
        lines.push('Sistema · Bodega');
        lines.push('-----------------------------');
        detalles.forEach(d => lines.push(`${d.nombre} x${d.cantidad} — S/ ${Number(d.subtotal).toFixed(2)}`));
        lines.push('-----------------------------');
        lines.push('Total: ' + document.getElementById('totalPagar').textContent);
        document.getElementById('ticketContent').textContent = lines.join('\n');
        location.hash = 'm-imprimir';
      });

      document.getElementById('btnImprimirConfirm').addEventListener('click', function(){
        window.print();
      });

      document.addEventListener('DOMContentLoaded', function(){
        renderCarrito();
      });
    </script>
  </body>
</html>