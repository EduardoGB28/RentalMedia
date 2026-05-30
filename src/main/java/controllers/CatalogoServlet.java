package controllers;

import dao.ProductoDAO;
import models.Producto;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.List;
import models.Noticia;
import com.mycompany.services.NoticiasService;



@WebServlet(name = "CatalogoServlet", urlPatterns = {"/catalogo"})
public class CatalogoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductoDAO dao = new ProductoDAO();
        List<Producto> productos;
        String categoriaFiltro= request.getParameter("categoria");
        if (categoriaFiltro !=null && !categoriaFiltro.isEmpty()){
            productos=dao.obtenerporcate(categoriaFiltro);
        } else{
            productos=dao.obtenerTodos();
        }
        request.setAttribute("listaProductos", productos);
        NoticiasService noticiasService = new NoticiasService();
        List<Noticia> listaNoticias = noticiasService.obtenerNoticias();
        request.setAttribute("noticias", listaNoticias);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}