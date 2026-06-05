package dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import config.MongoConfig;
import models.Producto;
import org.bson.Document;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    private MongoCollection<Document> collection;

    public ProductoDAO() {
       
        this.collection = MongoConfig.getDatabase().getCollection("Persona");
    }

    public List<Producto> obtenerTodos() {
        List<Producto> lista = new ArrayList<>();
        for (Document doc : collection.find()) {
            Producto p = new Producto();
            p.setName(doc.getString("name"));
            p.setCategory(doc.getString("category")); 
           Number priceNum = doc.get("price", Number.class);
            if (priceNum != null) { p.setPrice(priceNum.doubleValue()); }
            p.setImageUrl(doc.getString("imageUrl"));
            Number stockNum = doc.get("stock", Number.class);
            if (stockNum != null) { p.setStock(stockNum.intValue()); }
            lista.add(p);
        }
        return lista;
    }
      public List<Producto> obtenerporcate(String categoria)
      {
         List<Producto> lista= new ArrayList<>();
         MongoCursor<Document> cursor=collection.find(Filters.eq("category", categoria)).iterator();
         try
         {
             while (cursor.hasNext())
             {
                 Document doc = cursor.next();
                 Producto p = new Producto();
                 p.setName(doc.getString("name"));
                 p.setCategory(doc.getString("category"));
                 p.setPrice(doc.getDouble("price"));
                 p.setStock(doc.getInteger("stock"));
                 p.setImageUrl(doc.getString("imageUrl"));
                 lista.add(p);
             }
         } 
         finally {cursor.close();}
         return lista;
      }
    public List<Producto> srchname(String textoBusqueda) {
        List<Producto> lista = new ArrayList<>();
       try
       {
            for (Document doc : collection.find(Filters.regex("name", ".*" + textoBusqueda + ".*", "i"))) {
                Producto p = new Producto();
                p.setName(doc.getString("name"));
                p.setCategory(doc.getString("category"));
                Object precioObj = doc.get("price");
                if (precioObj instanceof Integer) {
                    p.setPrice(((Integer) precioObj).doubleValue());
                } else if (precioObj instanceof Double) {
                    p.setPrice((Double) precioObj);
                }
                p.setStock(doc.getInteger("stock"));
                p.setImageUrl(doc.getString("imageUrl"));
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println("error: " + e.getMessage());
        }
        return lista;
    }
}