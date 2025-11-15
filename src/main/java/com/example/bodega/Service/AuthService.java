package com.example.bodega.Service;

import org.springframework.stereotype.Service;

import com.example.bodega.model.Usuario;
import com.example.bodega.repository.UsuarioRepository;

@Service
public class AuthService {

    private final UsuarioRepository usuarioRepo;

    public AuthService(UsuarioRepository usuarioRepo) {
        this.usuarioRepo = usuarioRepo;
    }

    public Usuario autenticar(String correo, String clave) {

        // Buscar usuario activo por correo (JDBC)
        Usuario usuario = usuarioRepo.buscarPorCorreoActivo(correo);

        if (usuario == null) {
            return null; // No existe o no está activo
        }

        // Comparar contraseña (texto plano por ahora)
        if (usuario.getHashPassword() != null 
                && usuario.getHashPassword().equals(clave)) {
            return usuario; // Autenticado
        }

        return null; // Contraseña incorrecta
    }
}
