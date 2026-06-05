
package controllers;

import dao.ProductoDAO;
import models.Producto;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name= "CarritoServlet", urlPatterns ={"/carrito"})
 public class CarritoServlet extends HttpServlet {
    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        HttpSession sesion=request.getSession();//Sesion actyual
        if(sesion.getAttribute("usuarioLogueado")==null){//verificacion ,login
            response.sendRedirect(request.getContextPath()+ "/login");
        }
       String PdctoNombre= request.getParameter("idProducto");
       if (PdctoNombre != null && !PdctoNombre.trim().isEmpty()){
           ProductoDAO dao=new ProductoDAO();
           List<Producto> resultados= dao.srchname(PdctoNombre);
           if (!resultados.isEmpty()){
               Producto productoAgregado=resultados.get(0);
               List<Producto> carrito =(List<Producto>) sesion.getAttribute("carritoRentas");
               if (carrito == null){
                   carrito=new ArrayList<>();
                  
               }
             carrito.add(productoAgregado);
             sesion.setAttribute("carritoRentas", carrito);
             System.out.println("Producto en carrito "+ productoAgregado);
             
           }
       }
        
        response.sendRedirect(request.getContextPath()+ "/catalogo");
        
    }
}