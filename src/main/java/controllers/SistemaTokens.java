package controllers;

import dao.UsuarioDAO;
import dao.VentaDAO;
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

@WebServlet(name = "SistemaTokens", urlPatterns = {"/SistemaTokens"})
public class SistemaTokens extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String nombreProducto = request.getParameter("nombreProducto");
        int costoTokens = Integer.parseInt(request.getParameter("costoTokens"));
        if (user.getTokens() < costoTokens) {
            response.sendRedirect(request.getContextPath() + "/catalogoTokens.jsp?error=insuficiente");
            return;
        }
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean descuentoOk = usuarioDAO.restarTokens(user.getUsername(), costoTokens);
        if (descuentoOk) {
            VentaDAO ventaDAO = new VentaDAO();
            Venta nuevaRenta = new Venta();
            nuevaRenta.setUsername(user.getUsername());
            List<String> productos = new ArrayList<>();
            productos.add(nombreProducto);
            nuevaRenta.setNombresProductos(productos);
            nuevaRenta.setTotal(0.0);
            nuevaRenta.setFechaVenta(new Date());
            ventaDAO.registrarVenta(nuevaRenta);
            user.setTokens(user.getTokens() - costoTokens);
            session.setAttribute("usuarioLogueado", user);
            response.sendRedirect(request.getContextPath() + "/catalogoTokens.jsp?exito=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/catalogoTokens.jsp?error=transaccion");
        }
    }
}