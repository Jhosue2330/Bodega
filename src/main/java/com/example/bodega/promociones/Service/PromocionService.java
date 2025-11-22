package com.example.bodega.promociones.Service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.bodega.promociones.Model.Promocion;
import com.example.bodega.promociones.repository.PromocionRepository;

@Service
@Transactional
public class PromocionService {

    private final PromocionRepository repo;

    public PromocionService(PromocionRepository repo) {
        this.repo = repo;
    }

    @Transactional(readOnly = true)
    public List<Promocion> listarTodas() {
        return repo.findAll();
    }

    @Transactional(readOnly = true)
    public List<Promocion> listarActivas() {
        return repo.findActivas();
    }

    @Transactional(readOnly = true)
    public Promocion obtenerPorId(Integer id) {
        return repo.findById(id);
    }

    public Promocion guardar(Promocion p) {
        if (p.getIdPromocion() == null) {
            repo.insert(p);
        } else {
            repo.update(p);
        }
        return p;
    }

    public void desactivar(Integer id) {
        repo.desactivar(id);
    }

    public void activar(Integer id) {
        repo.activar(id);
    }
}
