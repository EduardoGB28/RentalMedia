
package models;

import java.util.Date;
import java.util.List;

public class Venta
{
    private String username;
    private List<String> nombresProductos;
    private double total;
    private Date fechaVenta;
    
    public Venta(){}
    
    
   public Venta(String username, List <String> nombresProductos,double total ,Date fechaVenta){
       this.username=username;
       this.nombresProductos=nombresProductos;
       this.total=total;
       this.fechaVenta=fechaVenta;
   }
//getters
   public String getUsername(){return username;}
   public List <String> getNombresProductos() {return nombresProductos;}
   public double getTotal() { return total;}
   public Date getFechaVenta() {return fechaVenta;}
//setters
   public void setUsername(String username) { this.username = username; }
   public void setNombresProductos(List<String> nombresProductos) { this.nombresProductos = nombresProductos; }
   public void setTotal(double total) { this.total = total; }
   public void setFechaVenta(Date fechaVenta) { this.fechaVenta = fechaVenta; }
}