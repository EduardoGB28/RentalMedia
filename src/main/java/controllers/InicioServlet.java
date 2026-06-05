package controllers;

import dao.ProductoDAO;
import models.Producto;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "InicioServlet", urlPatterns = {"/inicio"})
public class InicioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductoDAO dao = new ProductoDAO();
        List<Producto> destacados = dao.obtenerTodos();
        request.setAttribute("productosDestacados", destacados);
        request.getRequestDispatcher("inicio.jsp").forward(request, response);
    }
}