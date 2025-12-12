package com.example.bodega.login.Service; // <--- Paquete nuevo

import com.example.bodega.login.Repo.UsuarioRepository; // Importamos tu repo
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;

@Service 
public class LoginService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Map<String, Object> autenticar(String correo, String passwordInput) {
        // 1. Llamamos al repositorio
        Map<String, Object> usuarioRaw = usuarioRepository.buscarPorCorreo(correo);

        // 2. Validamos lógica
        if (usuarioRaw != null) {
            // NOTA: H2 suele devolver las columnas en MAYÚSCULAS por defecto
            String passDb = (String) usuarioRaw.get("HASH_PASSWORD"); 
            
            if (passDb != null && passDb.equals(passwordInput)) {
                return usuarioRaw; // ¡Login correcto!
            }
        }
        return null; // Login fallido
    }
}