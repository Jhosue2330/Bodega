package com.example.bodega.Venta.repo;

import com.example.bodega.Venta.web.dto.DetalleVentaDto;
import com.example.bodega.Venta.web.dto.VentaDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

@Repository
public class VentaRepo {

    @Autowired
    private JdbcTemplate jdbc;

    public static class ProductSimple {
        private Integer idProducto;
        private String nombre;
        private String sku;
        private BigDecimal precio;
        private Integer stockActual;

        public Integer getIdProducto() { return idProducto; }
        public void setIdProducto(Integer idProducto) { this.idProducto = idProducto; }

        public String getNombre() { return nombre; }
        public void setNombre(String nombre) { this.nombre = nombre; }

        public String getSku() { return sku; }
        public void setSku(String sku) { this.sku = sku; }

        public BigDecimal getPrecio() { return precio; }
        public void setPrecio(BigDecimal precio) { this.precio = precio; }

        public Integer getStockActual() { return stockActual; }
        public void setStockActual(Integer stockActual) { this.stockActual = stockActual; }
    }

    public ProductSimple obtenerProductoSimple(Integer idProducto) {
        String sql = "SELECT id_producto, nombre, sku, precio, stock_actual FROM PRODUCTO WHERE id_producto = ?";
        List<ProductSimple> list = jdbc.query(sql, (rs, rn) -> {
            ProductSimple p = new ProductSimple();
            p.setIdProducto(rs.getInt("id_producto"));
            p.setNombre(rs.getString("nombre"));
            p.setSku(rs.getString("sku"));
            p.setPrecio(rs.getBigDecimal("precio"));
            p.setStockActual(rs.getInt("stock_actual"));
            return p;
        }, idProducto);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean validarStock(List<DetalleVentaDto> detalles) {
        if (detalles == null || detalles.isEmpty()) return true;
        for (DetalleVentaDto d : detalles) {
            ProductSimple p = obtenerProductoSimple(d.getIdProducto());
            if (p == null) return false;
            if (p.getStockActual() < d.getCantidad()) return false;
        }
        return true;
    }

    public int insertarVentaReturnId(VentaDto venta) {
        String sql = "INSERT INTO VENTA (fecha, tipo_venta, total, descuento, id_vendedor, id_cliente, direccion_entrega, observaciones, id_estado_venta) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        KeyHolder kh = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, Timestamp.valueOf(venta.getFecha()));
            ps.setString(2, venta.getTipoVenta());
            ps.setBigDecimal(3, venta.getTotal());
            ps.setBigDecimal(4, venta.getDescuento() != null ? venta.getDescuento() : BigDecimal.ZERO);
            if (venta.getIdVendedor() != null) ps.setInt(5, venta.getIdVendedor()); else ps.setNull(5, Types.INTEGER);
            if (venta.getIdCliente() != null) ps.setInt(6, venta.getIdCliente()); else ps.setNull(6, Types.INTEGER);
            ps.setString(7, venta.getDireccionEntrega());
            ps.setString(8, venta.getObservaciones());
            if (venta.getIdEstadoVenta() != null) ps.setInt(9, venta.getIdEstadoVenta()); else ps.setNull(9, Types.INTEGER);
            return ps;
        };
        jdbc.update(psc, kh);
        Number key = kh.getKey();
        return key != null ? key.intValue() : -1;
    }

    public void insertarDetalle(int idVenta, DetalleVentaDto d) {
        String sql = "INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)";
        jdbc.update(sql, idVenta, d.getIdProducto(), d.getCantidad(), d.getPrecioUnitario(), d.getSubtotal());
        String upd = "UPDATE PRODUCTO SET stock_actual = stock_actual - ? WHERE id_producto = ?";
        jdbc.update(upd, d.getCantidad(), d.getIdProducto());
    }

    public List<VentaDto> listarVentasResumen() {
        String sql = "SELECT id_venta, fecha, tipo_venta, total FROM VENTA ORDER BY fecha DESC";
        return jdbc.query(sql, (rs, rn) -> {
            VentaDto v = new VentaDto();
            v.setIdVenta(rs.getInt("id_venta"));
            Timestamp ts = rs.getTimestamp("fecha");
            if (ts != null) v.setFecha(ts.toLocalDateTime());
            v.setTipoVenta(rs.getString("tipo_venta"));
            v.setTotal(rs.getBigDecimal("total"));
            return v;
        });
    }

    public List<DetalleVentaDto> listarDetallePorVenta(int idVenta) {
        String sql = "SELECT dv.id_detalle_venta, dv.id_producto, p.nombre AS nombreProducto, dv.cantidad, dv.precio_unitario, dv.subtotal " +
                "FROM DETALLE_VENTA dv JOIN PRODUCTO p ON dv.id_producto = p.id_producto WHERE dv.id_venta = ?";
        return jdbc.query(sql, (rs, rn) -> {
            DetalleVentaDto d = new DetalleVentaDto();
            d.setIdDetalleVenta(rs.getInt("id_detalle_venta"));
            d.setIdProducto(rs.getInt("id_producto"));
            d.setNombreProducto(rs.getString("nombreProducto"));
            d.setCantidad(rs.getInt("cantidad"));
            d.setPrecioUnitario(rs.getBigDecimal("precio_unitario"));
            d.setSubtotal(rs.getBigDecimal("subtotal"));
            return d;
        }, idVenta);
    }

    public List<ProductSimple> buscarProductos(String q) {
        String sql = "SELECT id_producto, nombre, sku, precio, stock_actual FROM PRODUCTO WHERE LOWER(nombre) LIKE ? OR LOWER(sku) LIKE ? LIMIT 50";
        String like = "%" + q.toLowerCase() + "%";
        return jdbc.query(sql, (rs, rn) -> {
            ProductSimple p = new ProductSimple();
            p.setIdProducto(rs.getInt("id_producto"));
            p.setNombre(rs.getString("nombre"));
            p.setSku(rs.getString("sku"));
            p.setPrecio(rs.getBigDecimal("precio"));
            p.setStockActual(rs.getInt("stock_actual"));
            return p;
        }, like, like);
    }
}