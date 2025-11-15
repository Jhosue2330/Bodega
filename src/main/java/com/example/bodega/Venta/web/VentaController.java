package com.example.bodega.Venta.web;

import com.example.bodega.Venta.web.dto.DetalleVentaDto;
import com.example.bodega.Venta.web.dto.VentaDto;
import com.example.bodega.Venta.service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

@Controller
@RequestMapping("/ventas")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    @GetMapping
    public String viewVentas(Model model) {
        model.addAttribute("ventas", ventaService.listarVentas());
        return "transaccion/Venta";
    }

    @PostMapping("/registrar")
    public String registrarVenta(
            @RequestParam(name = "tipoVenta", required = false) String tipoVenta,
            @RequestParam(name = "descuento", required = false) BigDecimal descuento,
            @RequestParam(name = "idVendedor", required = false) Integer idVendedor,
            @RequestParam(name = "idCliente", required = false) Integer idCliente,
            @RequestParam(name = "direccionEntrega", required = false) String direccionEntrega,
            @RequestParam(name = "observaciones", required = false) String observaciones,
            @RequestParam(name = "productoIds[]", required = false) Integer[] productoIds,
            @RequestParam(name = "cantidades[]", required = false) Integer[] cantidades,
            @RequestParam(name = "precios[]", required = false) BigDecimal[] precios,
            Model model
    ) {
        VentaDto venta = new VentaDto();
        venta.setFecha(LocalDateTime.now());
        venta.setTipoVenta(tipoVenta != null ? tipoVenta : "POS");
        venta.setDescuento(descuento != null ? descuento : BigDecimal.ZERO);
        venta.setIdVendedor(idVendedor != null ? idVendedor : 1);
        venta.setIdCliente(idCliente);
        venta.setDireccionEntrega(direccionEntrega);
        venta.setObservaciones(observaciones);
        venta.setIdEstadoVenta(1);

        List<DetalleVentaDto> detalles = new ArrayList<>();
        if (productoIds != null) {
            int n = productoIds.length;
            for (int i = 0; i < n; i++) {
                DetalleVentaDto d = new DetalleVentaDto();
                d.setIdProducto(productoIds[i]);
                d.setCantidad((cantidades != null && i < cantidades.length) ? cantidades[i] : 1);
                d.setPrecioUnitario((precios != null && i < precios.length) ? precios[i] : null);
                d.recomputeSubtotalIfPossible();
                detalles.add(d);
            }
        }
        venta.setDetalles(detalles);

        try {
            ventaService.registrarVentaCompleta(venta);
            return "redirect:/transaccion/venta";
        } catch (Exception ex) {
            model.addAttribute("mensaje", ex.getMessage());
            model.addAttribute("ventas", ventaService.listarVentas());
            return "transaccion/Venta";
        }
    }
}
