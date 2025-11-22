<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Publicidad y Promociones</title>

    <!-- Estilos CORRECTOS -->
    <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Promociones.css'/>" />
  </head>
  <body>
    <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="main-content">
      <div class="wrapper">
        <h1>Gestión de Publicidad y Promociones</h1>
        <p class="muted">
          Aquí el bodeguero puede crear, editar y desactivar promociones y avisos de publicidad que
          luego se mostrarán en la parte pública del sistema.
        </p>

        <section class="crud-layout">
          <!-- PANEL IZQUIERDO: FORMULARIO -->
          <section class="panel card-form">
            <h2>
              <c:choose>
                <c:when test="${promocion.idPromocion != null}">
                  Editar promoción #${promocion.idPromocion}
                </c:when>
                <c:otherwise>Registrar nueva promoción</c:otherwise>
              </c:choose>
            </h2>

            <form action="<c:url value='/bodega/promociones/guardar'/>" method="post">
              <!-- ID oculto (solo cuando edites) -->
              <c:if test="${promocion.idPromocion != null}">
                <input type="hidden" name="idPromocion" value="${promocion.idPromocion}" />
              </c:if>

              <!-- Tipo (solo visual, aún no se guarda en BD) -->
              <div>
                <label for="tipo"><strong>Tipo:</strong></label><br />
                <select id="tipo" name="tipo" class="form-select">
                  <option value="PROMOCION">Promoción</option>
                  <option value="PUBLICIDAD">Publicidad</option>
                </select>
              </div>

              <!-- Título -->
              <div>
                <label for="titulo"><strong>Título:</strong></label><br />
                <input
                  type="text"
                  id="titulo"
                  name="titulo"
                  placeholder="Ej: 2x1 en gaseosas"
                  class="form-input"
                  value="${promocion.titulo}"
                  required
                />
              </div>

              <!-- Descripción -->
              <div>
                <label for="descripcion"><strong>Descripción:</strong></label><br />
                <textarea
                  id="descripcion"
                  name="descripcion"
                  rows="3"
                  placeholder="Ej: Válido solo fines de semana para marcas seleccionadas."
                  class="form-textarea"
                ><c:out value="${promocion.descripcion}"/></textarea>
              </div>

              <!-- Fechas -->
              <div class="date-row">
                <div>
                  <label for="fechaInicio"><strong>Fecha inicio:</strong></label><br />
                  <input
                    type="date"
                    id="fechaInicio"
                    name="fechaInicio"
                    class="form-input"
                    value="${promocion.fechaInicio}"
                  />
                </div>
                <div>
                  <label for="fechaFin"><strong>Fecha fin:</strong></label><br />
                  <input
                    type="date"
                    id="fechaFin"
                    name="fechaFin"
                    class="form-input"
                    value="${promocion.fechaFin}"
                  />
                </div>
              </div>

              <!-- Activo -->
              <div class="form-check">
                <input
                  type="checkbox"
                  id="activo"
                  name="activo"
                  <c:if test="${promocion.activo}">checked</c:if>
                />
                <label for="activo"><strong>Activo</strong> (visible en publicidad)</label>
              </div>

              <!-- Botones -->
              <div style="display:flex; gap:10px; flex-wrap:wrap;">
                <button type="submit" class="btn primary">Guardar</button>
                <a href="<c:url value='/bodega/promociones'/>" class="btn ghost">Nuevo</a>
              </div>
            </form>
          </section>

          <!-- PANEL DERECHO: LISTADO -->
          <section class="panel card-table">
            <h2>Listado de Publicidad y Promociones</h2>
            <p>
              Aquí se muestran las campañas que el bodeguero ha configurado. Solo las
              <strong>activas</strong> se verán en la página pública de publicidad.
            </p>

            <div class="table-container">
              <table class="table-custom">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Vigencia</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="p" items="${lista}">
                    <tr>
                      <td>${p.idPromocion}</td>
                      <td>${p.titulo}</td>
                      <td>
                        <c:out value="${p.fechaInicio}" /> -
                        <c:out value="${p.fechaFin}" />
                      </td>
                      <td class="${p.activo ? 'status-activa' : 'status-inactiva'}">
                        <c:choose>
                          <c:when test="${p.activo}">Activa</c:when>
                          <c:otherwise>Inactiva</c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <a
                          href="<c:url value='/bodega/promociones/editar/${p.idPromocion}'/>"
                          class="btn-mini btn-edit"
                        >Editar</a>

                        <c:choose>
                          <c:when test="${p.activo}">
                            <a
                              href="<c:url value='/bodega/promociones/desactivar/${p.idPromocion}'/>"
                              class="btn-mini btn-delete"
                            >Desactivar</a>
                          </c:when>
                          <c:otherwise>
                            <a
                              href="<c:url value='/bodega/promociones/activar/${p.idPromocion}'/>"
                              class="btn-mini btn-activate"
                            >Activar</a>
                          </c:otherwise>
                        </c:choose>
                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty lista}">
                    <tr>
                      <td colspan="5" style="text-align:center; opacity:.8;">
                        Aún no hay promociones registradas.
                      </td>
                    </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </section>
        </section>

        <div class="highlight-info">
          <p class="muted" style="margin:0;">
            Tip: solo las campañas <strong>activas</strong> se mostrarán en la página pública de
            <strong>Publicidad</strong>.
          </p>
        </div>
      </div>
    </main> 
  </body>
</html>
