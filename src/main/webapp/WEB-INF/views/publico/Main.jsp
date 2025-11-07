<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Inicio – Sistema de Ventas</title>

    <link rel="stylesheet" href="/css/Main.css" />
    <link rel="stylesheet" href="/css/Navbar.css" />
    <link rel="stylesheet" href="/css/Footer.css" />
  </head>
  <body>
    <header id="navbar">
      <%-- INSERCIÓN JSP: Asume que Navbar.jsp está en /WEB-INF/views/componentes --%> <%@ include
      file="/componentes/Navbar.jsp" %>
    </header>

    <header class="hero">
      <h1>Bienvenido a la Bodega Josdin</h1>
      <p class="sub">Administra tu bodega Josdin: ventas e inventario — rápido y simple.</p>
      <div class="hero-actions">
        <a class="btn primary" href="Catalogo.jsp">Abrir Catálogo</a>
        <a class="btn ghost" href="Contacto.jsp">Contactos</a>
      </div>
    </header>

    <main class="wrapper">
      <section class="quick grid-4">
        <a class="qcard fade-up" style="--d: 0s" href="Catalogo.jsp">
          <span class="ico">🛒</span>
          <h3>Catálogo</h3>
          <p>Gestiona productos y stock mínimo.</p>
        </a>

        <a class="qcard fade-up" style="--d: 0.06s" href="Publicidad.jsp">
          <span class="ico">📢</span>
          <h3>Publicidad</h3>
          <p>Promociones y banners para tu tienda.</p>
        </a>

        <a class="qcard fade-up" style="--d: 0.12s" href="Catalogo.jsp#novedades">
          <span class="ico">🆕</span>
          <h3>Novedades</h3>
          <p>Lo último que llegó a la tienda.</p>
        </a>

        <a class="qcard fade-up" style="--d: 0.18s" href="Contacto.jsp">
          <span class="ico">📞</span>
          <h3>Contacto</h3>
          <p>Canales de atención y ubicación.</p>
        </a>
      </section>

      <section class="highlight fade-up" style="--d: 0.18s">
        <h2>Consejo</h2>
        <p>
          Activa tus combos (p. ej., “Pack desayuno”) y muestra promociones en la sección Publicidad
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
          <a class="btn primary" href="Publicidad.jsp">Ver Promos</a>
          <a class="btn ghost" href="Catalogo.jsp#novedades">Ver Novedades</a>
        </div>
      </section>
    </main>

    <footer id="footer">
      <%-- INSERCIÓN JSP: Asume que Footer.jsp está en /WEB-INF/views/componentes --%> <%@ include
      file="/componentes/Footer.jsp" %>
    </footer>

    <script>
      // **IMPORTANTE:** El JavaScript de fetch fue eliminado.

      // Se mantiene la lógica del menú hamburguesa, ya que depende del HTML
      // insertado por el JSP include.
      const t = document.querySelector('.menu-toggle'),
        l = document.querySelector('.nav-links')
      if (t && l) {
        t.addEventListener('click', () => l.classList.toggle('active'))
      }
    </script>
  </body>
</html>
