<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <title>${categoria.idCategoria == null ? 'Nueva' : 'Editar'} Categoría</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="<c:url value='/CSS/Gestion.css'/>" />
    <link rel="stylesheet" href="<c:url value='/CSS/Navbar.css'/>" />
  </head>
  <body data-page="gestion">
    
    <header id="navbar">
      <%@ include file="../componentes/navbar_bodega.jsp" %>
    </header>

    <main class="wrap">
        <header class="page-head">
            <h2>
               <c:choose>
                   <c:when test="${categoria.idCategoria == null}">✨ Nueva Categoría</c:when>
                   <c:otherwise>✏️ Editar Categoría</c:otherwise>
               </c:choose>
            </h2>
        </header>

        <section class="card form-pane" style="max-width: 500px; margin: 0 auto;">
            <form:form action="${pageContext.request.contextPath}/categoria/guardar" method="POST" modelAttribute="categoria" class="form">
              
              <form:hidden path="idCategoria" />
              <form:hidden path="activo" />

              <div class="field">
                  <label>Nombre *</label>
                  <form:input path="nombre" cssClass="input" required="true" placeholder="Ej: Lácteos"/>
              </div>

              <div class="field" style="margin-top: 15px;">
                  <label>Descripción</label>
                  <form:textarea path="descripcion" cssClass="input" rows="3" placeholder="Detalles opcionales..."/>
              </div>

              <div class="actions" style="margin-top: 20px; text-align: right;">
                <a class="btn ghost" href="<c:url value='/categoria/listar'/>">Cancelar</a>
                <button type="submit" class="btn pri">Guardar Datos</button>
              </div>
            </form:form>
        </section>
    </main>
  </body>
</html>