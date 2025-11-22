<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Sistema de Ventas</title>

    <link rel="stylesheet" href="../CSS/Login.css" />
  </head>
  <body>
    <!-- Fondo decorativo -->
    <div class="bg-decor"></div>

    <div class="auth" id="authBox">
      <h1 class="brand">Sistema de Ventas</h1>

      <!-- Mensaje de error si vienen credenciales inválidas -->
      <c:if test="${param.error == 'true'}">
        <div class="alert error" style="margin-bottom: 12px">
          Usuario o contraseña inválidos. Intenta de nuevo.
        </div>
      </c:if>

      <!-- ===== FORMULARIO LOGIN (POST a /login) ===== -->
      <form
        class="panel"
        id="form-login"
        method="post"
        action="<c:url value='/login'/>"
        autocomplete="on"
      >
        <div class="input-group">
          <label for="usuario">Usuario</label>
          <input
            type="text"
            id="Correo"
            name="Correo"
            placeholder="Tu usuario"
            required
            value="${param.usuario != null ? param.usuario : ''}"
          />
        </div>

        <div class="input-group">
          <label for="password">Contraseña</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Tu contraseña"
            required
          />
        </div>

        <button type="submit" class="btn primary">Ingresar</button>

      </form>
    </div>
  </body>
</html>
