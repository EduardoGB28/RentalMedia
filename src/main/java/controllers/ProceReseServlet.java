package controllers;

import dao.ResenaDAO;
import dao.UsuarioDAO;
import dao.VentaDAO;
import models.Resena;
import models.Usuario;
import models.Venta;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

@WebServlet(name = "ProcesarResenaServlet", urlPatterns = {"/ProcesarResena"})
public class ProceReseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String idPedido = request.getParameter("idPedido");
        String comentario = request.getParameter("comentario");
        int estrellas = Integer.parseInt(request.getParameter("estrellas"));
        VentaDAO ventaDAO = new VentaDAO();
        Venta venta = ventaDAO.obtenerVentaPorId(idPedido);
        int tokensGanados = 0;
        if (venta != null) {
            tokensGanados = (int) (venta.getTotal() * 0.25);
        }
        Resena nuevaResena = new Resena();
        nuevaResena.setUsername(user.getUsername());
        nuevaResena.setIdPedido(idPedido);
        nuevaResena.setComentario(comentario);
        nuevaResena.setEstrellas(estrellas);
        nuevaResena.setFecha(new Date());
        ResenaDAO resenaDAO = new ResenaDAO();
        boolean guardadoExitoso = resenaDAO.SaveRese(nuevaResena);
        if (guardadoExitoso && tokensGanados > 0) {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.sumarTokens(user.getUsername(), tokensGanados);
            user.setTokens(user.getTokens() + tokensGanados);
            session.setAttribute("usuarioLogueado", user);
            response.sendRedirect(request.getContextPath() + "/muro.jsp?exito=true&tokens=" + tokensGanados);
        } else {
            response.sendRedirect(request.getContextPath() + "/muro.jsp?error=true");
        }
    }
}