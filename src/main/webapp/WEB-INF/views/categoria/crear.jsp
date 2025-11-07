<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Crear / Editar Categoría</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="../CSS/Gestion.css" />
    <link rel="stylesheet" href="../CSS/Navbar.css" />
  </head>
  <body>
    <!-- NAVBAR -->
    <jsp:include page="/WEB-INF/views/componentes/navbar_bodega.jsp" />

    <h1>
      <form:if test="${categoria.idCategoria == null}">Nueva</form:if>
      <form:if test="${categoria.idCategoria != null}">Editar</form:if>
      Categoría
    </h1>

    <form:form action="/gestion/categoria/guardar" method="POST" modelAttribute="categoria">
      <form:hidden path="idCategoria" />

      <label>Nombre</label>
      <form:input path="nombre" required="true" />

      <label>Descripción</label>
      <form:textarea path="descripcion" rows="3" />

      <div class="actions">
        <button type="submit">Guardar</button>
        <a class="btn" href="/gestion/categoria/listar">Cancelar</a>
      </div>
    </form:form>

    <!-- FOOTER (opcional) -->
    <jsp:include page="/WEB-INF/views/componentes/footer.jsp" />
  </body>
</html>
