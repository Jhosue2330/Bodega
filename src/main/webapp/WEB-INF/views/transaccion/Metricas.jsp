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
    </style>
</head>
<body>

    <header id="navbar">
        <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <main class="wrap">
        <header class="page-head">
            <h2>📊 Métricas del Negocio</h2>
            <p class="page-sub">Indicadores actualizados en tiempo real.</p>
        </header>

        <section class="kpis">
            <div class="kpi card">
                <div class="kpi-value">${m.pedidosHoy}</div>
                <div class="kpi-label">Pedidos de hoy</div>
            </div>
            <div class="kpi card">
                <div class="kpi-value">
                    S/ <fmt:formatNumber value="${m.ventasTotalMes}" minFractionDigits="2" maxFractionDigits="2"/>
                </div>
                <div class="kpi-label">Ventas mes actual</div>
            </div>
            <div class="kpi card">
                <div class="kpi-value">
                     S/ <fmt:formatNumber value="${m.ticketPromedioMes}" minFractionDigits="2" maxFractionDigits="2"/>
                </div>
                <div class="kpi-label">Ticket promedio</div>
            </div>
            <div class="kpi card">
                <div class="kpi-value">100%</div>
                <div class="kpi-label">Estado Sistema</div>
            </div>
        </section>

        <input type="hidden" id="data-dias-labels" value="<c:out value='${m.diasLabels}' default='[]'/>" />
        <input type="hidden" id="data-dias-values" value="<c:out value='${m.diasData}' default='[]'/>" />

        <input type="hidden" id="data-meses-labels" value="<c:out value='${m.mesesLabels}' default='[]'/>" />
        <input type="hidden" id="data-meses-values" value="<c:out value='${m.mesesData}' default='[]'/>" />

        <input type="hidden" id="data-prod-labels" value="<c:out value='${m.topProductosLabels}' default='[]'/>" />
        <input type="hidden" id="data-prod-values" value="<c:out value='${m.topProductosData}' default='[]'/>" />


        <section class="card chart-section">
            <h3>Ventas: Últimos 7 Días</h3>
            <div class="canvas-container"><canvas id="chartDias"></canvas></div>
        </section>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <section class="card chart-section">
                <h3>Tendencia Mensual</h3>
                <div class="canvas-container"><canvas id="chartMeses"></canvas></div>
            </section>
            <section class="card chart-section">
                <h3>Top 5 Productos</h3>
                <div class="canvas-container"><canvas id="chartProductos"></canvas></div>
            </section>
        </div>

        <div style="text-align: center; margin-top: 20px; margin-bottom: 40px;">
            <button class="btn primary" type="button" onclick="window.print()">🖨️ Imprimir Reporte</button>
        </div>
    </main>

    <script>
        // Función auxiliar para convertir el string "[...]" a un Array real de JS
        function parseList(id) {
            var raw = document.getElementById(id).value;
            // Si está vacío o es nulo, retornar array vacío
            if (!raw || raw.trim() === "") return [];
            try {
                // Reemplazamos comillas simples por dobles para que sea JSON válido si fuera necesario,
                // pero como tu backend envía formato JS array ['a'], usamos una evaluación segura.
                // NOTA: Como el backend envía strings tipo "['Lun', 'Mar']", usamos new Function para parsearlo.
                return new Function("return " + raw)(); 
            } catch (e) {
                console.error("Error parseando datos para " + id, e);
                return [];
            }
        }

        // 1. LEER DATOS DESDE LOS INPUTS OCULTOS
        var labelsDias = parseList('data-dias-labels');
        var dataDias   = parseList('data-dias-values');

        var labelsMeses = parseList('data-meses-labels');
        var dataMeses   = parseList('data-meses-values');

        var labelsProd = parseList('data-prod-labels');
        var dataProd   = parseList('data-prod-values');

        // Configuración Global
        Chart.defaults.font.family = "'Segoe UI', 'Helvetica', 'Arial', sans-serif";
        Chart.defaults.color = '#666';

        // 2. RENDERIZAR
        
        // A) DIARIO
        var ctxDias = document.getElementById('chartDias');
        if (ctxDias) {
            new Chart(ctxDias, {
                type: 'line',
                data: {
                    labels: labelsDias,
                    datasets: [{
                        label: 'Ventas (S/)',
                        data: dataDias,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true } } }
            });
        }

        // B) MENSUAL
        var ctxMeses = document.getElementById('chartMeses');
        if (ctxMeses) {
            new Chart(ctxMeses, {
                type: 'bar',
                data: {
                    labels: labelsMeses,
                    datasets: [{
                        label: 'Total Mes (S/)',
                        data: dataMeses,
                        backgroundColor: 'rgba(255, 159, 64, 0.6)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1,
                        borderRadius: 4
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true } } }
            });
        }

        // C) PRODUCTOS
        var ctxProd = document.getElementById('chartProductos');
        if (ctxProd) {
            new Chart(ctxProd, {
                type: 'bar',
                data: {
                    labels: labelsProd,
                    datasets: [{
                        label: 'Vendido (S/)',
                        data: dataProd,
                        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF'],
                        borderWidth: 1
                    }]
                },
                options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
            });
        }
    </script>
</body>
</html>