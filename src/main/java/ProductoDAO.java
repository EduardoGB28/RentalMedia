package dao;

import com.mongodb.client.MongoCollection;
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
}