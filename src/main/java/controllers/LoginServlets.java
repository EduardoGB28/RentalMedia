package controllers;

import dao.UsuarioDAO;
import models.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlets extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuarioValidado = dao.auth(username, password);

        if (usuarioValidado != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuarioLogueado", usuarioValidado);
            if ("admin".equals(usuarioValidado.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin.jsp"); 
            } else {
                response.sendRedirect(request.getContextPath() + "/inicio");
            }
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}