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

        <p class="swap">
          ¿No tienes cuenta?
          <!-- En esta maqueta solo mostramos el link; si luego quieres registrar, lo conectamos -->
          <a
            class="link"
            href="#"
            onclick="document.getElementById('form-register').style.display='grid'; document.getElementById('form-login').style.display='none'; return false;"
          >
            Regístrate
          </a>
        </p>
      </form>

      <!-- ===== FORMULARIO REGISTRO (maqueta, sin backend aún) ===== -->
      <form
        class="panel"
        id="form-register"
        style="display: none"
        autocomplete="off"
        onsubmit="alert('Registro de demo. Vuelve a iniciar sesión.'); this.style.display='none'; document.getElementById('form-login').style.display='grid'; return false;"
      >
        <div class="input-group">
          <label for="correo">Correo</label>
          <input type="email" id="correo" placeholder="tucorreo@dominio.com" required />
        </div>

        <div class="input-group">
          <label for="usuario-reg">Usuario</label>
          <input type="text" id="usuario-reg" placeholder="Elige un usuario" required />
        </div>

        <div class="input-group">
          <label for="password-reg">Contraseña</label>
          <input type="password" id="password-reg" placeholder="Crea una contraseña" required />
        </div>

        <button type="submit" class="btn primary">Crear cuenta</button>
        <p class="swap">
          ¿Ya tienes cuenta?
          <a
            class="link"
            href="#"
            onclick="document.getElementById('form-register').style.display='none'; document.getElementById('form-login').style.display='grid'; return false;"
          >
            Inicia sesión
          </a>
        </p>
      </form>
    </div>
  </body>
</html>
