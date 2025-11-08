package com.example.bodega.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.bodega.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Optional<Usuario> findByCorreoAndActivoTrue(String correo);
}
