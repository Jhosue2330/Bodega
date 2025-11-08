<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inicio – Sistema de Ventas</title>
    <link rel="stylesheet" href="../CSS/Navbar.css" />
    <link rel="stylesheet" href="../CSS/Main.css" />
    <link rel="stylesheet" href="../CSS/Footer.css" />
  </head>
  <body>
    <header id="navbar">
      <%-- Incluye el NAVBAR PÚBLICO --%> <%@ include file="../componentes/navbar.jsp" %>
    </header>

    <header class="hero">
      <h1>Bienvenido a la Bodega Josdin</h1>
      <p class="sub">Administra tu bodega: ventas e inventario — rápido y simple.</p>
      <div class="hero-actions">
        <a class="btn primary" href="<c:url value='/catalogo'/>">Abrir Catálogo</a>
        <a class="btn ghost" href="<c:url value='/contacto'/>">Contactos</a>
      </div>
    </header>

    <main class="wrapper">
      <section class="quick grid-4">
        <a class="qcard fade-up" style="--d: 0s" href="<c:url value='/catalogo'/>">
          <span class="ico">🛒</span>
          <h3>Catálogo</h3>
          <p>Gestiona productos y stock mínimo.</p>
        </a>

        <a class="qcard fade-up" style="--d: 0.06s" href="<c:url value='/publicidad'/>">
          <span class="ico">📢</span>
          <h3>Publicidad</h3>
          <p>Promociones y banners para tu tienda.</p>
        </a>

        <a class="qcard fade-up" style="--d: 0.12s" href="<c:url value='/catalogo#novedades'/>">
          <span class="ico">🆕</span>
          <h3>Novedades</h3>
          <p>Lo último que llegó a la tienda.</p>
        </a>

        <a class="qcard fade-up" style="--d: 0.18s" href="<c:url value='/contacto'/>">
          <span class="ico">📞</span>
          <h3>Contacto</h3>
          <p>Canales de atención y ubicación.</p>
        </a>
      </section>

      <section class="highlight fade-up" style="--d: 0.18s">
        <h2>Consejo</h2>
        <p>
          Activa combos (p. ej., “Pack desayuno”) y muestra promociones en <b>Publicidad</b>
          para aumentar el ticket promedio.
        </p>
      </section>

      <section class="highlight fade-up" style="--d: 0.22s">
        <h2>Promociones</h2>
        <p>
          Revisa las ofertas vigentes y prepara campañas estacionales (vuelta a clases, fiestas,
          etc.) desde <b>Publicidad</b>.
        </p>
        <div class="hero-actions">
          <a class="btn primary" href="<c:url value='/publicidad'/>">Ver Promos</a>
          <a class="btn ghost" href="<c:url value='/catalogo#novedades'/>">Ver Novedades</a>
        </div>
      </section>
    </main>

    <footer id="footer">
      <%-- Incluye el FOOTER --%> <%@ include file="../componentes/footer.jsp" %>
    </footer>

    <script>
      // Hamburguesa (sigue funcionando con el include del navbar)
      const t = document.querySelector('.menu-toggle'),
        l = document.querySelector('.nav-links')
      if (t && l) t.addEventListener('click', () => l.classList.toggle('active'))
    </script>
  </body>
</html>
