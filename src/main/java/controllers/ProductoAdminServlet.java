/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.ProductoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Usuario;

@WebServlet(name = "ProductoAdminServlet", urlPatterns = {"/adminProducto"})
public class ProductoAdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String categoria = request.getParameter("categoria");
        String precioStr = request.getParameter("precio");
        String imagen = request.getParameter("imagen");
        String stockStr = request.getParameter("stock");

        try {
            double precio = Double.parseDouble(precioStr);
            int stock = Integer.parseInt(stockStr);
            ProductoDAO dao = new ProductoDAO();
            boolean exito = dao.addProd(nombre, categoria, precio, imagen, stock);
            if (exito) {
                System.out.println("¡Producto '" + nombre + "' agregado exitosamente!");
                response.sendRedirect(request.getContextPath() + "/admin.jsp");
            } else {
                System.out.println("Fallo al guardar en MongoDB.");
                response.sendRedirect(request.getContextPath() + "/admin.jsp");
            }
        } catch (Exception e) {
            System.out.println("Error de formato en los números: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
        }
    }
}