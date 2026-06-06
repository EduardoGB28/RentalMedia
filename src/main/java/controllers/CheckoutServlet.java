package controllers;

import dao.VentaDAO;
import models.Producto;
import models.Usuario; 
import models.Venta;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioLogueado");
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<Producto> carrito = (List<Producto>) sesion.getAttribute("carritoRentas"); 
        if (carrito != null && !carrito.isEmpty()) {
            List<String> nombresProductos = new ArrayList<>();
            double totalAPagar = 0.0;    
            for (Producto p : carrito) {
                nombresProductos.add(p.getName());
                totalAPagar += p.getPrice();
            }
            Venta nuevaVenta = new Venta(usuario.getUsername(), nombresProductos, totalAPagar, new Date());
            VentaDAO dao = new VentaDAO();
            String idVenta = dao.registrarVenta(nuevaVenta);
            if (idVenta != null) {
                sesion.removeAttribute("carritoRentas");
                System.out.println("¡Venta registrada con ID: " + idVenta + "!");
                response.sendRedirect(request.getContextPath() + "/resumen.jsp?id=" + idVenta);
            } else {
                System.out.println("Error al guardar la venta.");
                response.sendRedirect(request.getContextPath() + "/carrito.jsp");
            }         
        } else {
            response.sendRedirect(request.getContextPath() + "/catalogo");
        }
    }
}