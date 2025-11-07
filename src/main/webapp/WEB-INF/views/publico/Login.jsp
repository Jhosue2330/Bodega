<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Configuración básica del documento -->
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Login - Sistema de Ventas</title>

    <link rel="stylesheet" href="../CSS/Login.css" />
  </head>

  <body>
    <!-- Fondo decorativo con efectos de color y luz -->
    <div class="bg-decor"></div>

    <!-- Contenedor principal del login -->
    <div class="auth" id="authBox">
      <!-- Título o marca del sistema -->
      <h1 class="brand">Sistema de Ventas</h1>

      <!-- ===============================
           FORMULARIO DE LOGIN
           - Permite que el usuario escriba su usuario y contraseña
           - Incluye un enlace para ir al formulario de registro
      ================================ -->
      <form class="panel" id="form-login" autocomplete="on">
        <!-- Campo de nombre de usuario -->
        <div class="input-group">
          <label for="usuario">Usuario</label>
          <input type="text" id="usuario" name="usuario" placeholder="Tu usuario" required />
        </div>

        <!-- Campo de contraseña -->
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

        <!-- Botón para iniciar sesión -->
        <button type="submit" class="btn primary">Ingresar</button>

        <!-- Enlace para cambiar al formulario de registro -->
        <p class="swap">
          ¿No tienes cuenta?
          <a href="#" class="link" id="go-register">Regístrate</a>
        </p>
      </form>

      <!-- ===============================
           FORMULARIO DE REGISTRO
           - Se muestra cuando el usuario no tiene cuenta
           - Crea una cuenta de forma simulada (modo demo)
      ================================ -->
      <form class="panel" id="form-register" style="display: none" autocomplete="off">
        <!-- Campo para correo electrónico -->
        <div class="input-group">
          <label for="correo">Correo</label>
          <input type="email" id="correo" placeholder="tucorreo@dominio.com" required />
        </div>

        <!-- Campo para nombre de usuario -->
        <div class="input-group">
          <label for="usuario-reg">Usuario</label>
          <input type="text" id="usuario-reg" placeholder="Elige un usuario" required />
        </div>

        <!-- Campo para crear contraseña -->
        <div class="input-group">
          <label for="password-reg">Contraseña</label>
          <input type="password" id="password-reg" placeholder="Crea una contraseña" required />
        </div>

        <!-- Botón para crear cuenta -->
        <button type="submit" class="btn primary">Crear cuenta</button>

        <!-- Enlace para volver al formulario de login -->
        <p class="swap">
          ¿Ya tienes cuenta?
          <a href="#" class="link" id="go-login">Inicia sesión</a>
        </p>
      </form>
    </div>

    <!-- ===============================
         SCRIPT JAVASCRIPT
         Controla toda la funcionalidad de los formularios
    ================================ -->
    <script>
      // Guarda los formularios en variables para poder manipularlos
      const fLogin = document.getElementById('form-login')
      const fReg = document.getElementById('form-register')

      // ---- 1️ Cambiar del login al registro ----
      document.getElementById('go-register').onclick = (e) => {
        e.preventDefault() 
        fLogin.style.display = 'none' // oculta login
        fReg.style.display = 'grid' // muestra el registro
      }

      // ---- 2️ Volver del registro al login ----
      document.getElementById('go-login').onclick = (e) => {
        e.preventDefault()
        fReg.style.display = 'none' // oculta el registro
        fLogin.style.display = 'grid' // muestra el login
      }

      // ---- 3️⃣ Iniciar sesión ----
      fLogin.addEventListener('submit', (e) => {
        e.preventDefault()
        // Guarda una variable de sesión en el navegador (modo demo)
        sessionStorage.setItem('logueado', 'true')
        // Redirige al usuario a la página principal o panel
        window.location.href = './Bodeguero.html'
      })

      // ---- 4️⃣ Crear cuenta (modo demostración) ----
      fReg.addEventListener('submit', (e) => {
        e.preventDefault()
        // Muestra un mensaje de éxito
        alert('Cuenta creada (demo). Ahora inicia sesión.')
        // Oculta el registro y vuelve al login
        fReg.style.display = 'none'
        fLogin.style.display = 'grid'
      })
    </script>
  </body>
</html>
