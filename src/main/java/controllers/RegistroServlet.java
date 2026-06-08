package controllers;

import dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String correo = request.getParameter("correo");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        dao.UsuarioDAO dao = new dao.UsuarioDAO();
        boolean exito = dao.UsuCreate(username, password, correo, nombreCompleto, fechaNacimiento);
        if (exito) {
            System.out.println("¡Usuario " + username + " registrado con seguridad BCrypt y datos completos!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            System.out.println("El nombre de usuario ya existe o hubo un error.");
            request.setAttribute("error", "El usuario ya existe. Intenta con otro.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}