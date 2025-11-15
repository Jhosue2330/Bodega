package com.example.bodega.Venta.service;

import com.example.bodega.Venta.repo.VentaRepo;
import com.example.bodega.Venta.web.dto.DetalleVentaDto;
import com.example.bodega.Venta.web.dto.VentaDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

@Service
public class VentaService {

    @Autowired
    private VentaRepo repo;

    @Transactional
    public int registrarVentaCompleta(VentaDto venta) {
        if (venta == null) throw new IllegalArgumentException("Venta null");
        if (venta.getDetalles() == null || venta.getDetalles().isEmpty()) throw new IllegalArgumentException("Debe haber detalles");
        if (venta.getIdVendedor() == null) throw new IllegalArgumentException("Falta idVendedor");

        if (venta.getFecha() == null) venta.setFecha(LocalDateTime.now());

        // rellenar precios si no vienen y calcular subtotales
        for (DetalleVentaDto d : venta.getDetalles()) {
            if (d.getCantidad() == null || d.getCantidad() <= 0) throw new IllegalArgumentException("Cantidad inválida");
            if (d.getPrecioUnitario() == null) {
                VentaRepo.ProductSimple p = repo.obtenerProductoSimple(d.getIdProducto());
                if (p == null) throw new IllegalArgumentException("Producto no existe: " + d.getIdProducto());
                d.setPrecioUnitario(p.precio != null ? p.precio : 0.0);
            }
            if (d.getSubtotal() == null) d.recomputeSubtotalIfPossible();
        }

        // total
        double suma = venta.getDetalles().stream()
                .filter(Objects::nonNull)
                .mapToDouble(d -> d.getSubtotal() != null ? d.getSubtotal() : d.getCantidad() * d.getPrecioUnitario())
                .sum();
        double descuento = venta.getDescuento() != null ? venta.getDescuento() : 0.0;
        venta.setTotal(suma - descuento);

        // validar stock antes de persistir
        if (!repo.validarStock(venta.getDetalles())) throw new IllegalStateException("Stock insuficiente");

        int idVenta = repo.insertarVentaReturnId(venta);
        if (idVenta <= 0) throw new IllegalStateException("No se pudo insertar venta");

        for (DetalleVentaDto d : venta.getDetalles()) {
            repo.insertarDetalle(idVenta, d);
        }

        return idVenta;
    }

    public List<VentaDto> listarVentas() {
        return repo.listarVentasResumen();
    }

    public List<DetalleVentaDto> obtenerDetallesPorVenta(int idVenta) {
        return repo.listarDetallePorVenta(idVenta);
    }
}