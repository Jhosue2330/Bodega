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

    <!-- CSS -->
    <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Publicidad.css'/>" />
  </head>
  <body>
    <!-- NAVBAR -->
    <header id="navbar"><%@ include file="../componentes/navbar.jsp" %></header>

    <!-- CONTENIDO -->
    <main class="main-content">
      <!-- HERO -->
      <section class="hero">
        <div class="hero-content">
          <h1>Promociones<br />del Mes</h1>
          <p class="subtitle">
            Ofertas seleccionadas con precisión para tu negocio, actualizadas desde el sistema del
            bodeguero.
          </p>
        </div>
      </section>

      <!-- DESTACADAS (máx. 3 promos activas) -->
      <section class="featured-grid">
        <c:if test="${not empty promos}">
          <c:forEach var="p" items="${promos}" varStatus="st">
            <c:if test="${st.index lt 3}">
              <div class="feature-card">
                <!-- Imagen por defecto -->
                <img
                  src="<c:url value='/Imagenes/promo-default.jpg'/>"
                  alt="Promoción"
                  class="promo-img"
                />

                <div class="card-content">
                  <span class="badge">Activa</span>
                  <h2><c:out value="${p.titulo}" /></h2>
                  <p><c:out value="${p.descripcion}" /></p>
                  <p class="promo-dates">
                    <small>
                      Vigencia:
                      <c:out value="${p.fechaInicio}" /> -
                      <c:out value="${p.fechaFin}" />
                    </small>
                  </p>
                </div>
              </div>
            </c:if>
          </c:forEach>
        </c:if>

        <c:if test="${empty promos}">
          <p class="no-promos">No hay promociones activas por el momento.</p>
        </c:if>
      </section>

      <!-- CATÁLOGO COMPLETO -->
      <section class="catalog-section">
        <h2 class="section-title">Catálogo de Promociones</h2>

        <div class="product-grid">
          <c:forEach var="p" items="${promos}">
            <article class="product-item">
              <!-- Imagen genérica de catálogo -->
              <img
                src="<c:url value='/Imagenes/promo-default.jpg'/>"
                alt="Promoción"
                class="promo-img-small"
              />

              <h3><c:out value="${p.titulo}" /></h3>
              <p><c:out value="${p.descripcion}" /></p>
              <p class="promo-dates">
                <small>
                  Vigencia:
                  <c:out value="${p.fechaInicio}" /> -
                  <c:out value="${p.fechaFin}" />
                </small>
              </p>
            </article>
          </c:forEach>

          <c:if test="${empty promos}">
            <p style="grid-column: 1/-1; text-align: center; opacity: 0.8">
              No hay promociones registradas.
            </p>
          </c:if>
        </div>
      </section>

      <!-- MARCAS -->
      <section class="brands">
        <p class="brands-label">Marcas destacadas este mes</p>
        <div class="brand-logos">
          <img src="https://dummyimage.com/140x50/1fccd2/0f172a&text=EKU" />
          <img src="https://dummyimage.com/140x50/22d3ee/0f172a&text=BYTE" />
          <img src="https://dummyimage.com/140x50/1fccd2/0f172a&text=PRO" />
          <img src="https://dummyimage.com/140x50/22d3ee/0f172a&text=SHOP" />
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
