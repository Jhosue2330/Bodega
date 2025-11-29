<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Movimiento Masivo — Bodega</title>
  
  <link rel="stylesheet" href="<c:url value='/CSS/Main.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Bodeguero.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Footer.css'/>">

  <style>
    /* Estilos específicos para la tabla de registro masivo */
    .masivo-table { width: 100%; border-collapse: collapse; margin-top: 10px; background: white; }
    .masivo-table th { text-align: left; padding: 12px; background: #f9fafb; border-bottom: 2px solid #e5e7eb; color: #374151; font-size: 0.9em; font-weight: 600; }
    .masivo-table td { padding: 10px; border-bottom: 1px solid #e5e7eb; vertical-align: middle; }
    
    /* Inputs dentro de la tabla */
    .masivo-table select, .masivo-table input { 
        width: 100%; 
        padding: 8px; 
        border: 1px solid #d1d5db; 
        border-radius: 4px;
        box-sizing: border-box; /* Importante para que no se salgan de la celda */
    }

    .row-num { color: #9ca3af; font-weight: bold; text-align: center; }
    
    /* Colores para distinguir visualmente */
    .opt-in { color: #059669; font-weight: bold; }
    .opt-out { color: #dc2626; font-weight: bold; }
  </style>
</head>
<body class="bodega-page">
  
  <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
  </header>

  <main class="wrap">
    <header class="page-head">
      <h2>📦 Registrar Movimientos Múltiples</h2>
      <p class="sub">Registra hasta 5 entradas o salidas simultáneamente.</p>
    </header>

    <section class="card form-pane" style="max-width: 1000px;">
      <form class="form" action="<c:url value='/bodeguero/movimientos/guardar-masivo'/>" method="post">
        
        <div style="display: grid; grid-template-columns: 1fr auto; gap: 20px; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #eee;">
            <div>
                <label style="display:block; margin-bottom:5px; font-weight:bold; color:#4b5563;">Referencia General (Opcional)</label>
                <input class="input" name="motivo" placeholder="Ej: Reposición semanal / Ajuste de inventario" style="width: 100%;">
            </div>
            
            <input type="hidden" name="idUsuario" value="1">
        </div>

        <table class="masivo-table">
            <thead>
                <tr>
                    <th style="width: 50px;">#</th>
                    <th>Producto</th>
                    <th style="width: 150px;">Acción</th>
                    <th style="width: 120px;">Cantidad</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach begin="1" end="5" var="i">
                    <tr>
                        <td class="row-num">${i}</td>
                        <td>
                            <select name="idProducto">
                                <option value="">-- Seleccionar (Ignorar) --</option>
                                <c:forEach var="p" items="${productos}">
                                    <option value="${p.idProducto}">
                                        ${p.sku} — ${p.nombre} (Stock: ${p.stockActual})
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <select name="tipo">
                                <option value="ENTRADA" class="opt-in">(+) Entrada</option>
                                <option value="SALIDA" class="opt-out">(-) Salida</option>
                            </select>
                        </td>
                        <td>
                            <input type="number" name="cantidad" min="1" placeholder="0">
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <p style="font-size: 0.85em; color: #6b7280; margin-top: 10px;">
            * Deja el producto en "-- Seleccionar --" para las filas que no uses.
        </p>

        <div class="actions" style="margin-top: 20px; text-align: right;">
          <a class="btn ghost" href="<c:url value='/bodeguero/dashboard'/>">Cancelar</a>
          <button class="btn primary" type="submit">Guardar Movimientos</button>
        </div>
      </form>
    </section>
  </main>

  <footer class="footer">
      <div class="footer-content"><p>© 2025 Sistema de Ventas</p></div>
  </footer>
</body>
</html>