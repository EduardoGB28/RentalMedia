
package dao;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import models.Venta;
import org.bson.Document;
import config.MongoConfig;



public class VentaDAO {
    private MongoCollection<Document> collection;

    public VentaDAO(){
    this.collection = MongoConfig.getDatabase().getCollection("ventas");
}

public boolean registrarVenta(Venta nuevaVenta){
 try{
Document doc=new Document("username", nuevaVenta.getUsername())
        .append("productos", nuevaVenta.getNombresProductos())
        .append("total", nuevaVenta.getTotal())
        .append("fecha", nuevaVenta.getFechaVenta());

 collection.insertOne(doc);
return true;
}catch (Exception e) {
        System.out.println("Error al registrar la venta en Mongo: " + e.getMessage());
        return false;
}
}
}