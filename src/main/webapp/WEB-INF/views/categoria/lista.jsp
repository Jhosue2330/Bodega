<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Gestión de Categorías</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="/css/Gestion.css" />
  </head>
  <body>
    <!-- NAVBAR -->
    <jsp:include page="/WEB-INF/views/componentes/navbar_bodega.jsp" />

    <h1>Gestión de Categorías</h1>

    <c:if test="${not empty mensaje}">
      <div class="msg">${mensaje}</div>
    </c:if>

    <div class="bar">
      <div>
        Total activas: <strong><c:out value="${fn:length(categorias)}" /></strong>
      </div>
      <div>
        <a href="/gestion/categoria/crear" class="btn primary">+ Nueva categoría</a>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Nombre</th>
          <th>Descripción</th>
          <th style="width: 220px">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="cat" items="${categorias}">
          <tr>
            <td>${cat.idCategoria}</td>
            <td>${cat.nombre}</td>
            <td><c:out value="${cat.descripcion}" /></td>
            <td>
              <a href="/gestion/categoria/editar/${cat.idCategoria}" class="btn">Editar</a>
              <a
                href="/gestion/categoria/desactivar/${cat.idCategoria}"
                class="btn warn"
                onclick="return confirm('¿Desactivar esta categoría?');"
                >Desactivar</a
              >
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty categorias}">
          <tr>
            <td colspan="4">No hay categorías activas.</td>
          </tr>
        </c:if>
      </tbody>
    </table>

    <!-- FOOTER (opcional) -->
    <jsp:include page="/WEB-INF/views/componentes/footer.jsp" />
  </body>
</html>
