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
        String nuevoUser = request.getParameter("nuevoUsername");
        String nuevaPass = request.getParameter("nuevaPassword");
        if (nuevoUser != null && nuevaPass != null && !nuevoUser.trim().isEmpty() && !nuevaPass.trim().isEmpty()) {
            UsuarioDAO dao = new UsuarioDAO();
            boolean exito = dao.UsuCreate(nuevoUser.trim(), nuevaPass.trim());         
            if (exito) {
                request.setAttribute("mensajeExito", "¡Cuenta creada con éxito! Ahora puedes iniciar sesión.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Ese nombre de usuario ya está ocupado. Elige otro.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }           
        } else {
            request.setAttribute("error", "Por favor, llena todos los campos para registrarte.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}