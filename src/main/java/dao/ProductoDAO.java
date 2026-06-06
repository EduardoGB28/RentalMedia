package dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import config.MongoConfig;
import models.Producto;
import org.bson.Document;
import java.util.ArrayList;
import java.util.List;
import org.bson.types.ObjectId;
import com.mongodb.client.model.Updates;

public class ProductoDAO {
    private MongoCollection<Document> collection;

    public ProductoDAO() {
       
        this.collection = MongoConfig.getDatabase().getCollection("Persona");
    }
    public List<Producto> obtenerTodos() {
        List<Producto> lista = new ArrayList<>();
        
        for (Document doc : collection.find()) {
            try {
                Producto p = new Producto();
                
                // 1. Sacamos el ID
                if (doc.getObjectId("_id") != null) {
                    p.setId(doc.getObjectId("_id").toHexString());
                }
                
                p.setName(doc.getString("name"));
                
                // ==========================================
                // 2. CATEGORÍA: Buscamos la nueva o la vieja
                // ==========================================
                String cat = doc.getString("categoria");
                if (cat == null) {
                    cat = doc.getString("category"); // Fallback
                }
                p.setCategory(cat); 
                
                // ==========================================
                // 3. IMAGEN: Buscamos la nueva o la vieja
                // ==========================================
                String img = doc.getString("image");
                if (img == null) {
                    img = doc.getString("imageUrl"); // Fallback
                }
                p.setImageUrl(img);
                
                // 4. PRECIO (A prueba de balas)
                if (doc.get("price") != null) { 
                    p.setPrice(Double.parseDouble(doc.get("price").toString())); 
                }
                
                // 5. STOCK (A prueba de balas)
                if (doc.get("stock") != null) { 
                    p.setStock(Integer.parseInt(doc.get("stock").toString())); 
                }
                
                lista.add(p);
                
            } catch (Exception e) {
                System.out.println("Error leyendo un producto de Mongo: " + e.getMessage());
            }
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
    public boolean addProd(String nombre, String categoria, double precio, String imagen, int stock) {
        try {
            Document nuevoProducto = new Document("name", nombre)
                    .append("categoria", categoria) 
                    .append("price", precio)
                    .append("image", imagen)
                    .append("stock", stock);
            collection.insertOne(nuevoProducto);
            return true;
        } catch (Exception e) {
            System.out.println("Error al agregar producto: " + e.getMessage());
            return false;
        }
    }
    public boolean delProd(String idHexadecimal) {
        try {
            ObjectId idMongo = new ObjectId(idHexadecimal);
            collection.deleteOne(com.mongodb.client.model.Filters.eq("_id", idMongo));
            return true;
        } catch (Exception e) {
            System.out.println("Error al eliminar producto: " + e.getMessage());
            return false;
        }
    }
    public boolean updtProd(String idHexadecimal, String nombre, String categoria, double precio, String imagen, int stock) {
        try {
            ObjectId idMongo = new ObjectId(idHexadecimal);
            org.bson.conversions.Bson actualizaciones = Updates.combine(
                    Updates.set("name", nombre),
                    Updates.set("categoria", categoria),
                    Updates.set("price", precio),
                    Updates.set("image", imagen),
                    Updates.set("stock", stock)
            );
            collection.updateOne(com.mongodb.client.model.Filters.eq("_id", idMongo), actualizaciones);
            return true;
        } catch (Exception e) {
            System.out.println("Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }
}