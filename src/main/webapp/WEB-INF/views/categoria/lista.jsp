<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <title>Gestión de Categorías</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="<c:url value='/CSS/Gestion.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>" />
    <style>
        /* Estilos para las etiquetas de estado */
        .tag { padding: 4px 8px; border-radius: 12px; font-size: 0.85em; font-weight: bold; text-transform: uppercase; }
        .tag.ok { background-color: #dcfce7; color: #166534; border: 1px solid #bbf7d0; } /* Verde */
        .tag.warn { background-color: #fee2e2; color: #991b1b; border: 1px solid #fecaca; } /* Rojo */
        
        /* Fila inactiva un poco más transparente */
        tr.inactive td { color: #9ca3af; }
    </style>
  </head>
  <body data-page="gestion">
    
    <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <main class="wrap">
        <header class="top">
            <div>
                <h1>Categorías</h1>
                <p class="muted">Administra las familias de productos.</p>
            </div>
            <div>
                <a href="<c:url value='/producto/gestion'/>" class="btn" style="background:#fff; border:1px solid #ccc; color:#333;">← Volver a Productos</a>
                <a href="<c:url value='/categoria/crear'/>" class="btn pri">+ Nueva categoría</a>
            </div>
        </header>

        <c:if test="${not empty mensaje}"><div class="sv-alert success">${mensaje}</div></c:if>
        <c:if test="${not empty error}"><div class="sv-alert error">${error}</div></c:if>

        <section class="card">
            <div class="cardh">
                <h2>Listado Completo</h2>
                <span class="badge"><c:out value="${fn:length(categorias)}" /></span>
            </div>

            <div class="tblwrap">
                <table class="tbl">
                  <thead>
                    <tr>
                      <th style="width: 50px;">ID</th>
                      <th>Nombre</th>
                      <th>Descripción</th>
                      <th>Estado</th>
                      <th class="c" style="width: 200px;">Acciones</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="cat" items="${categorias}">
                      <tr class="${!cat.activo ? 'inactive' : ''}">
                        <td>${cat.idCategoria}</td>
                        <td><strong>${cat.nombre}</strong></td>
                        <td class="muted"><c:out value="${cat.descripcion}" /></td>
                        
                        <td>
                            <c:choose>
                                <c:when test="${cat.activo}">
                                    <span class="tag ok">Activo</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="tag warn">Inactivo</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="c">
                          <a href="<c:url value='/categoria/editar/${cat.idCategoria}'/>" class="btn tiny">Editar</a>
                          
                          <c:choose>
                              <c:when test="${cat.activo}">
                                  <a href="<c:url value='/categoria/desactivar/${cat.idCategoria}'/>"
                                     class="btn tiny warn"
                                     title="Desactivar"
                                     onclick="return confirm('¿Desactivar categoría?');">
                                     ✕
                                  </a>
                              </c:when>
                              <c:otherwise>
                                  <a href="<c:url value='/categoria/activar/${cat.idCategoria}'/>"
                                     class="btn tiny success"
                                     style="background:#dcfce7; color:#166534; border:1px solid #86efac;"
                                     title="Reactivar">
                                     ✔
                                  </a>
                              </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                    <c:if test="${empty categorias}">
                      <tr><td colspan="5" style="text-align:center; padding:20px;">No hay categorías registradas.</td></tr>
                    </c:if>
                  </tbody>
                </table>
            </div>
        </section>
    </main>
  </body>
</html>