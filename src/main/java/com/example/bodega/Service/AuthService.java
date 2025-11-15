// src/main/java/com/example/bodega/service/AuthService.java
package com.example.bodega.Service;

import java.util.Optional;
import org.springframework.stereotype.Service;

import com.example.bodega.model.Usuario;
import com.example.bodega.repository.UsuarioRepository;

@Service
public class AuthService {

  private final UsuarioRepository usuarioRepo;

  public AuthService(UsuarioRepository usuarioRepo) {
    this.usuarioRepo = usuarioRepo;
  }

  public Optional<Usuario> autenticar(String correo, String clave) {
    return usuarioRepo.findByCorreoAndActivoTrue(correo)
        .filter(u -> u.getHashPassword() != null && u.getHashPassword().equals(clave));
    // ⇡ Hoy comparamos texto plano (demo). Luego cambiamos a BCrypt.
  }
}
