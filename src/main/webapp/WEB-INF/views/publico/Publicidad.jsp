<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Publicidad · Sistema de Ventas</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
      rel="stylesheet"
    />

    <!-- CSS desde /webapp/css o /resources/static/css -->
    <link rel="stylesheet" href="../CSS/Navbar.css" />
    <link rel="stylesheet" href="../CSS/Publicidad.css" />
  </head>
  <body>
    <!-- NAVBAR (público) -->
    <nav class="navbar">
      <div class="logo">Sistema de Ventas</div>
      <ul class="nav-links">
        <li><a class="nav-link" href="<c:url value='/'/>">Inicio</a></li>
        <li><a class="nav-link" href="<c:url value='/catalogo'/>">Catálogo</a></li>
        <li><a class="nav-link" href="<c:url value='/contacto'/>">Contacto</a></li>
        <li><a class="nav-link active" href="<c:url value='/publicidad'/>">Publicidad</a></li>
        <li><a class="btn nav-link" href="<c:url value='/login'/>">Login</a></li>
      </ul>
      <button class="menu-toggle" aria-label="Menú">☰</button>
    </nav>

    <!-- Contenido principal -->
    <main class="main-content">
      <section class="hero">
        <div class="hero-content">
          <h1>Promociones<br />del Mes</h1>
          <p class="subtitle">Ofertas seleccionadas con precisión para tu negocio.</p>
        </div>
      </section>

      <section class="featured-grid">
        <div class="feature-card">
          <img
            src="<c:url value='/Imagenes/Aseo-Personal.jpg'/>"
            alt="Productos de aseo personal en oferta"
            loading="lazy"
          />
          <div class="card-content">
            <span class="badge">-25%</span>
            <h2>Aseo Personal</h2>
            <p>Lo esencial para el cuidado diario, al mejor precio.</p>
          </div>
        </div>

        <div class="feature-card">
          <img
            src="<c:url value='/Imagenes/Gaseosa.jpg'/>"
            alt="Gaseosas en variedad de sabores"
            loading="lazy"
          />
          <div class="card-content">
            <span class="badge">Oferta</span>
            <h2>Gaseosas</h2>
            <p>Refresca tu inventario con nuestras gaseosas favoritas.</p>
          </div>
        </div>

        <div class="feature-card">
          <!-- renombra el archivo a 'utiles-escolares.jpg' -->
          <img
            src="<c:url value='/Imagenes/utiles-escolares.jpg'/>"
            alt="Útiles escolares de calidad"
            loading="lazy"
          />
          <div class="card-content">
            <span class="badge">Escolar</span>
            <h2>Útiles Escolares</h2>
            <p>Todo lo necesario para el regreso a clases.</p>
          </div>
        </div>
      </section>

      <section class="catalog-section">
        <h2 class="section-title">Catálogo de Promociones</h2>
        <div class="product-grid">
          <article class="product-item">
            <img
              src="<c:url value='/Imagenes/Electronicos.webp'/>"
              alt="Electrónicos en promoción"
              loading="lazy"
            />
            <h3>Electrónicos</h3>
            <p>Tecnología para tu negocio.</p>
          </article>
          <article class="product-item">
            <img
              src="<c:url value='/Imagenes/Bebidas.jpg'/>"
              alt="Bebidas alcohólicas seleccionadas"
              loading="lazy"
            />
            <h3>Bebidas</h3>
            <p>Variedad para todo tipo de cliente.</p>
          </article>
          <article class="product-item">
            <img src="<c:url value='/Imagenes/Dulces.png'/>" alt="Dulces surtidos" loading="lazy" />
            <h3>Dulces</h3>
            <p>Los favoritos de tus consumidores.</p>
          </article>
          <article class="product-item">
            <img
              src="<c:url value='/Imagenes/Recargas.jpg'/>"
              alt="Recargas de celular"
              loading="lazy"
            />
            <h3>Recargas</h3>
            <p>Todas las operadoras, sin complicaciones.</p>
          </article>
          <article class="product-item">
            <img
              src="<c:url value='/Imagenes/Pelota.webp'/>"
              alt="Artículos deportivos"
              loading="lazy"
            />
            <h3>Deportivos</h3>
            <p>Equipamiento para entusiastas.</p>
          </article>
          <article class="product-item">
            <img
              src="<c:url value='/Imagenes/Regalos.jpg'/>"
              alt="Ideas de regalo"
              loading="lazy"
            />
            <h3>Regalos</h3>
            <p>Detalles que generan fidelidad.</p>
          </article>
        </div>
      </section>

      <section class="brands">
        <p class="brands-label">Marcas destacadas este mes</p>
        <div class="brand-logos">
          <img src="https://dummyimage.com/140x50/1fccd2/0f172a&text=EKU" alt="EKU" />
          <img src="https://dummyimage.com/140x50/22d3ee/0f172a&text=BYTE" alt="BYTE" />
          <img src="https://dummyimage.com/140x50/1fccd2/0f172a&text=PRO" alt="PRO" />
          <img src="https://dummyimage.com/140x50/22d3ee/0f172a&text=SHOP" alt="SHOP" />
          <img src="https://dummyimage.com/140x50/1fccd2/0f172a&text=EKU" alt="EKU" />
          <img src="https://dummyimage.com/140x50/22d3ee/0f172a&text=BYTE" alt="BYTE" />
          <img src="https://dummyimage.com/140x50/1fccd2/0f172a&text=PRO" alt="PRO" />
          <img src="https://dummyimage.com/140x50/22d3ee/0f172a&text=SHOP" alt="SHOP" />
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <div class="container">
        <p>&copy; 2025 Sistema de Ventas. Todos los derechos reservados.</p>
      </div>
    </footer>
  </body>
</html>
