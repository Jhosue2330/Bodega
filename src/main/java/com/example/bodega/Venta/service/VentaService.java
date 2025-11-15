package com.example.bodega.Venta.service;

import com.example.bodega.Venta.web.dto.DetalleVentaDto;
import com.example.bodega.Venta.web.dto.VentaDto;
import com.example.bodega.Venta.repo.VentaRepo;
import com.example.bodega.Venta.repo.VentaRepo.ProductSimple;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
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

        for (DetalleVentaDto d : venta.getDetalles()) {
            if (d.getCantidad() == null || d.getCantidad() <= 0)
                throw new IllegalArgumentException("Cantidad inválida");

            if (d.getPrecioUnitario() == null) {
                ProductSimple p = repo.obtenerProductoSimple(d.getIdProducto());
                if (p == null) throw new IllegalArgumentException("Producto no existe: " + d.getIdProducto());
                // usar el getter en la clase ProductSimple
                d.setPrecioUnitario(p.getPrecio());
                if (d.getPrecioUnitario() == null) throw new IllegalArgumentException("Precio del producto no disponible: " + d.getIdProducto());
            }

            if (d.getSubtotal() == null) d.recomputeSubtotalIfPossible();
        }

        BigDecimal suma = venta.getDetalles().stream().filter(Objects::nonNull)
                .map(d -> d.getSubtotal() != null ? d.getSubtotal() : d.getPrecioUnitario().multiply(new BigDecimal(d.getCantidad())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal descuento = venta.getDescuento() != null ? venta.getDescuento() : BigDecimal.ZERO;
        venta.setTotal(suma.subtract(descuento).setScale(2, BigDecimal.ROUND_HALF_UP));

        if (!repo.validarStock(venta.getDetalles())) throw new IllegalStateException("Stock insuficiente para uno o varios productos");

        int idVenta = repo.insertarVentaReturnId(venta);
        if (idVenta <= 0) throw new IllegalStateException("No se pudo insertar venta");

        for (DetalleVentaDto d : venta.getDetalles()) {
            repo.insertarDetalle(idVenta, d);
        }
        return idVenta;
    }

    public java.util.List<VentaDto> listarVentas() { return repo.listarVentasResumen(); }
    public java.util.List<DetalleVentaDto> obtenerDetallesPorVenta(int idVenta) { return repo.listarDetallePorVenta(idVenta); }
}
