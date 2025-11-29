<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Métricas — Sistema de Ventas</title>
    <link rel="stylesheet" href="<c:url value='/CSS/Metricas.css'/>" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .chart-section { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .canvas-container { position: relative; height: 300px; width: 100%; }
        /* Grid de 2 columnas para gráficos medianos */
        .grid-charts { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    </style>
</head>
<body>

    <header id="navbar">
        <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <main class="wrap">
        <header class="page-head">
            <h2>📊 Dashboard de Ventas</h2>
            <p class="page-sub">Reporte de Días, Semanas y Meses</p>
        </header>

        <section class="kpis">
            <div class="kpi card">
                <div class="kpi-value">${m.pedidosHoy}</div>
                <div class="kpi-label">Pedidos Hoy</div>
            </div>
            <div class="kpi card">
                <div class="kpi-value">S/ <fmt:formatNumber value="${m.ventasTotalMes}" minFractionDigits="2"/></div>
                <div class="kpi-label">Ventas Mes Actual</div>
            </div>
            <div class="kpi card">
                <div class="kpi-value">S/ <fmt:formatNumber value="${m.ticketPromedioMes}" minFractionDigits="2"/></div>
                <div class="kpi-label">Ticket Promedio</div>
            </div>
        </section>

        <input type="hidden" id="d-dias-lbl" value="<c:out value='${m.diasLabels}' default='[]'/>" />
        <input type="hidden" id="d-dias-val" value="<c:out value='${m.diasData}' default='[]'/>" />

        <input type="hidden" id="d-sem-lbl" value="<c:out value='${m.semanasLabels}' default='[]'/>" />
        <input type="hidden" id="d-sem-val" value="<c:out value='${m.semanasData}' default='[]'/>" />

        <input type="hidden" id="d-mes-lbl" value="<c:out value='${m.mesesLabels}' default='[]'/>" />
        <input type="hidden" id="d-mes-val" value="<c:out value='${m.mesesData}' default='[]'/>" />

        <input type="hidden" id="d-top-lbl" value="<c:out value='${m.topProductosLabels}' default='[]'/>" />
        <input type="hidden" id="d-top-val" value="<c:out value='${m.topProductosData}' default='[]'/>" />

        <section class="card chart-section">
            <h3>📅 Ventas Diarias (Últimos 7 días)</h3>
            <div class="canvas-container"><canvas id="chartDias"></canvas></div>
        </section>

        <div class="grid-charts">
            <section class="card chart-section">
                <h3>📆 Rendimiento Semanal (Últimas 12 sem)</h3>
                <div class="canvas-container"><canvas id="chartSemanas"></canvas></div>
            </section>
            <section class="card chart-section">
                <h3>🗓️ Histórico Mensual (Últimos 12 meses)</h3>
                <div class="canvas-container"><canvas id="chartMeses"></canvas></div>
            </section>
        </div>

        <section class="card chart-section">
            <h3>🏆 Top 5 Productos Más Vendidos</h3>
            <div class="canvas-container"><canvas id="chartProductos"></canvas></div>
        </section>

    </main>

    <script>
        // Parser seguro
        function parseList(id) {
            var val = document.getElementById(id).value;
            if(!val || val.trim() === "") return [];
            try { return new Function("return " + val)(); } catch(e) { return []; }
        }

        // Leer datos
        var lblDias = parseList('d-dias-lbl'), valDias = parseList('d-dias-val');
        var lblSem  = parseList('d-sem-lbl'),  valSem  = parseList('d-sem-val');
        var lblMes  = parseList('d-mes-lbl'),  valMes  = parseList('d-mes-val');
        var lblTop  = parseList('d-top-lbl'),  valTop  = parseList('d-top-val');

        Chart.defaults.font.family = "'Segoe UI', 'sans-serif'";
        Chart.defaults.color = '#555';

        // 1. DIARIO (Línea)
        new Chart(document.getElementById('chartDias'), {
            type: 'line',
            data: {
                labels: lblDias,
                datasets: [{
                    label: 'Ventas (S/)', data: valDias,
                    borderColor: '#36A2EB', backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    fill: true, tension: 0.3
                }]
            },
            options: { maintainAspectRatio: false, scales: {y:{beginAtZero:true}} }
        });

        // 2. SEMANAL (Barra vertical)
        new Chart(document.getElementById('chartSemanas'), {
            type: 'bar',
            data: {
                labels: lblSem,
                datasets: [{
                    label: 'Total Semana (S/)', data: valSem,
                    backgroundColor: '#4BC0C0', borderRadius: 4
                }]
            },
            options: { maintainAspectRatio: false, scales: {y:{beginAtZero:true}} }
        });

        // 3. MENSUAL (Línea/Área)
        new Chart(document.getElementById('chartMeses'), {
            type: 'line',
            data: {
                labels: lblMes,
                datasets: [{
                    label: 'Total Mes (S/)', data: valMes,
                    borderColor: '#FF9F40', backgroundColor: 'rgba(255, 159, 64, 0.2)',
                    fill: true, tension: 0.4
                }]
            },
            options: { maintainAspectRatio: false, scales: {y:{beginAtZero:true}} }
        });

        // 4. TOP PRODUCTOS (Barra horizontal)
        new Chart(document.getElementById('chartProductos'), {
            type: 'bar',
            data: {
                labels: lblTop,
                datasets: [{
                    label: 'Vendido (S/)', data: valTop,
                    backgroundColor: ['#FF6384','#36A2EB','#FFCE56','#4BC0C0','#9966FF']
                }]
            },
            options: { indexAxis: 'y', maintainAspectRatio: false, plugins:{legend:{display:false}} }
        });
    </script>
</body>
</html>