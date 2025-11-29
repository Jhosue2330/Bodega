<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Historial de movimientos — Bodega</title>

  <link rel="stylesheet" href="<c:url value='/CSS/Main.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/CSS/Bodeguero.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/CSS/Footer.css'/>"/>
  
  <style>
      /* Estilos para las etiquetas de Entrada/Salida */
      .chip { padding: 4px 8px; border-radius: 12px; font-size: 0.85em; font-weight: bold; text-transform: uppercase; }
      .chip.in { background-color: #dcfce7; color: #166534; }  /* Verde */
      .chip.out { background-color: #fee2e2; color: #991b1b; } /* Rojo */
      
      /* Ajuste tabla */
      .table th { background: #f9fafb; color: #374151; font-weight: 600; }
      .table td { vertical-align: middle; }
  </style>
</head>
<body class="bodega-page">

  <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
  </header>

  <main class="wrap">
    <div class="tabs" style="margin-top:10px;">
      <a class="tab" href="<c:url value='/bodeguero/dashboard'/>">Stock Actual</a>
      <span class="tab active">Historial (Kardex)</span>
    </div>

    <header class="page-head">
      <div>
        <h2 style="margin:0">Historial de Movimientos</h2>
        <p class="sub" style="margin:6px 0 0">
           Registro completo de entradas y salidas de inventario.
        </p>
      </div>
      <div class="actions">
        <a class="btn" href="<c:url value='/bodeguero/movimientos/nuevo'/>">+ Movimiento Masivo</a>
      </div>
    </header>

    <section class="card">
      
      <div class="table-wrap">
        <table class="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Fecha y Hora</th>
              <th>Tipo</th>
              <th>SKU</th>
              <th>Producto</th>
              <th>Cantidad</th>
              <th>Referencia / Motivo</th>
              <th>Responsable</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="m" items="${movimientos}">
                <tr>
                  <td class="muted">#${m.ID_MOVIMIENTO}</td>
                  
                  <td>
                    <c:catch>
                        <fmt:parseDate value="${m.FECHA}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                    </c:catch>
                    <c:if test="${empty parsedDate}">${m.FECHA}</c:if>
                  </td>

                  <td>
                    <c:choose>
                        <c:when test="${m.TIPO_MOVIMIENTO == 'ENTRADA'}">
                            <span class="chip in">Entrada</span>
                        </c:when>
                        <c:otherwise>
                            <span class="chip out">Salida</span>
                        </c:otherwise>
                    </c:choose>
                  </td>

                  <td>${m.SKU}</td>
                  <td><strong>${m.NOMBRE_PRODUCTO}</strong></td>
                  
                  <td style="font-weight: bold; font-size: 1.1em;">
                    ${m.CANTIDAD}
                  </td>
                  
                  <td class="muted">
                    <c:out value="${m.MOTIVO}" default="-" />
                  </td>
                  
                  <td>
                    <small style="color:#6b7280;">${m.USUARIO}</small>
                  </td>
                </tr>
            </c:forEach>

            <c:if test="${empty movimientos}">
                <tr>
                    <td colspan="8" style="text-align:center; padding: 30px; color: #6b7280;">
                        No se encontraron movimientos registrados en el historial.
                        <br>
                        <a href="<c:url value='/bodeguero/movimientos/nuevo'/>" style="color:#2563eb;">Registrar el primero ahora</a>
                    </td>
                </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="footer-content"><p>© 2025 Sistema de Ventas</p></div>
  </footer>

</body>
</html>