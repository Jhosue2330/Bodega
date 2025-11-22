package com.example.bodega.promociones.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.bodega.promociones.Model.Promocion;

@Service
public class PublicidadService {

    private final PromocionService promocionService;

    public PublicidadService(PromocionService promocionService) {
        this.promocionService = promocionService;
    }

    /**
     * Promociones que se mostrarán en la página pública (/publicidad).
     * Por ahora: solo las activas.
     */
    public List<Promocion> obtenerPromocionesPublicas() {
        return promocionService.listarActivas();
    }
}
