<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Delivery — Bodega</title>
  <link rel="stylesheet" href="<c:url value='/CSS/Main.css'/>">
  <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>">
  <style>
    /* Estilos propios de Delivery */
    .delivery-page { background: #f1f5f9; min-height: 100vh; }
    .status-badge { padding: 4px 10px; border-radius: 20px; font-weight: bold; font-size: 0.85em; text-transform: uppercase; }
    
    /* Colores de Estado */
    .st-2 { background: #fef9c3; color: #854d0e; border: 1px solid #fde047; } /* Pendiente */
    .st-3 { background: #dbeafe; color: #1e40af; border: 1px solid #93c5fd; } /* En Camino */
    .st-4 { background: #dcfce7; color: #166534; border: 1px solid #86efac; } /* Entregado */
    .st-5 { background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; text-decoration: line-through; } /* Cancelado */

    .delivery-card { 
        background: white; border-radius: 8px; padding: 20px; margin-bottom: 15px; 
        box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
        display: grid; grid-template-columns: 1fr auto; gap: 20px; align-items: start;
        border-left: 5px solid transparent;
    }
    .delivery-card.st-2 { border-left-color: #eab308; }
    .delivery-card.st-3 { border-left-color: #3b82f6; }
    .delivery-card.st-4 { border-left-color: #22c55e; }
    .delivery-card.st-5 { border-left-color: #ef4444; opacity: 0.7; }

    .del-header h3 { margin: 0; font-size: 1.1em; color: #1e293b; display: flex; align-items: center; gap: 10px; }
    .del-details { margin-top: 10px; color: #475569; font-size: 0.95em; line-height: 1.6; }
    .del-details strong { color: #334155; }
    
    .del-actions { display: flex; flex-direction: column; gap: 8px; min-width: 140px; }

    /* Modal simple con CSS */
    .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); align-items: center; justify-content: center; z-index: 100; }
    .modal:target { display: flex; }
    .modal-box { background: white; padding: 25px; border-radius: 8px; width: 90%; max-width: 400px; position: relative; }
    .close-modal { position: absolute; top: 10px; right: 15px; text-decoration: none; font-size: 20px; font-weight: bold; color: #666; }
  </style>
</head>
<body class="delivery-page">

  <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
  </header>

  <main class="wrap" style="max-width: 900px; margin: 20px auto;">
    
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <div>
            <h2 style="margin:0; color:#0f172a;">🛵 Despacho de Pedidos</h2>
            <p style="margin:5px 0 0; color:#64748b;">Gestiona el flujo de entregas.</p>
        </div>
        <a href="<c:url value='/ventas'/>" class="btn pri">➕ Nuevo Pedido</a>
    </div>

    <div style="margin-bottom: 20px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px;">
        <a href="?filtro=PENDIENTES" class="btn ${filtroActual == 'PENDIENTES' ? 'pri' : 'ghost'}">⏳ Por Atender</a>
        <a href="?filtro=TODOS" class="btn ${filtroActual == 'TODOS' ? 'pri' : 'ghost'}">🗂️ Historial Completo</a>
    </div>

    <c:if test="${not empty mensaje}"><div class="sv-alert success" style="margin-bottom:15px;">${mensaje}</div></c:if>
    <c:if test="${not empty error}"><div class="sv-alert error" style="margin-bottom:15px; background:#fee2e2; color:#991b1b; padding:10px; border-radius:6px;">${error}</div></c:if>

    <section>
        <c:forEach var="p" items="${pedidos}">
            <div class="delivery-card st-${p.ESTADO_ID}">
                
                <div class="del-info">
                    <div class="del-header">
                        <h3>
                            #${p.ID_VENTA} 
                            <span class="status-badge st-${p.ESTADO_ID}">${p.ESTADO_NOMBRE}</span>
                        </h3>
                    </div>
                    <div class="del-details">
                        <div>📅 <fmt:formatDate value="${p.FECHA}" pattern="dd/MM/yyyy HH:mm"/></div>
                        <div>👤 ${p.OBSERVACIONES}</div> <div style="font-size: 1.1em; margin-top: 5px;">📍 <strong>${p.DIRECCION_ENTREGA}</strong></div>
                        <div style="margin-top: 8px; font-weight: bold; color: #0f172a;">
                            💰 Total a Cobrar: S/ <fmt:formatNumber value="${p.TOTAL}" minFractionDigits="2"/>
                        </div>
                    </div>
                </div>

                <div class="del-actions">
                    <c:if test="${p.ESTADO_ID == 2}">
                        <form action="<c:url value='/delivery/avanzar'/>" method="post">
                            <input type="hidden" name="idVenta" value="${p.ID_VENTA}">
                            <input type="hidden" name="estadoActual" value="2">
                            <button class="btn" style="width:100%; background:#3b82f6; color:white;">🛵 Enviar Moto</button>
                        </form>
                        <a href="#modal-edit-${p.ID_VENTA}" class="btn outline" style="text-align:center;">✏️ Editar</a>
                    </c:if>

                    <c:if test="${p.ESTADO_ID == 3}">
                        <form action="<c:url value='/delivery/avanzar'/>" method="post">
                            <input type="hidden" name="idVenta" value="${p.ID_VENTA}">
                            <input type="hidden" name="estadoActual" value="3">
                            <button class="btn success" style="width:100%;">✅ Confirmar Entrega</button>
                        </form>
                    </c:if>

                    <c:if test="${p.ESTADO_ID == 2 || p.ESTADO_ID == 3}">
                        <form action="<c:url value='/delivery/anular'/>" method="post" onsubmit="return confirm('¿Seguro que deseas anular este pedido?');">
                            <input type="hidden" name="idVenta" value="${p.ID_VENTA}">
                            <button class="btn danger" style="width:100%; font-size:0.8em;">🚫 Anular</button>
                        </form>
                    </c:if>

                    <a href="#" onclick="alert('Imprimir ticket #${p.ID_VENTA}')" class="btn ghost" style="text-align:center; font-size:0.8em;">🖨️ Ticket</a>
                </div>
            </div>

            <div id="modal-edit-${p.ID_VENTA}" class="modal">
                <div class="modal-box">
                    <a href="#" class="close-modal">×</a>
                    <h3>Editar Pedido #${p.ID_VENTA}</h3>
                    <form action="<c:url value='/delivery/editar'/>" method="post">
                        <input type="hidden" name="idVenta" value="${p.ID_VENTA}">
                        
                        <label style="display:block; margin-top:10px;">Dirección:</label>
                        <input class="in" name="direccion" value="${p.DIRECCION_ENTREGA}" style="width:100%; margin-bottom:10px;">
                        
                        <label style="display:block;">Datos Cliente / Obs:</label>
                        <textarea class="in" name="observaciones" style="width:100%; height:60px;">${p.OBSERVACIONES}</textarea>
                        
                        <div style="text-align:right; margin-top:15px;">
                            <a href="#" class="btn ghost">Cancelar</a>
                            <button class="btn pri">Guardar Cambios</button>
                        </div>
                    </form>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty pedidos}">
            <div style="text-align:center; padding:50px; color:#94a3b8;">
                <h3>No hay pedidos en esta lista</h3>
                <p>Cambia el filtro o registra un nuevo delivery.</p>
            </div>
        </c:if>
    </section>
  </main>
</body>
</html>