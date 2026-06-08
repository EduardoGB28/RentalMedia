
package dao;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import models.Venta;
import org.bson.Document;
import config.MongoConfig;
import java.util.List;



public class VentaDAO {
    private MongoCollection<Document> collection;

    public VentaDAO(){
    this.collection = MongoConfig.getDatabase().getCollection("ventas");
}
    public String registrarVenta(Venta nuevaVenta) {
        try {
            Document doc = new Document("username", nuevaVenta.getUsername())
                    .append("productos", nuevaVenta.getNombresProductos())
                    .append("total", nuevaVenta.getTotal())
                    .append("fecha", nuevaVenta.getFechaVenta());
            collection.insertOne(doc);
            return doc.getObjectId("_id").toHexString();
        } catch (Exception e) {
            System.out.println("Error al registrar la venta en Mongo: " + e.getMessage());
            return null;
        }
    }
    public Venta obtenerVentaPorId(String idHexadecimal) {
        try {
            org.bson.types.ObjectId idMongo = new org.bson.types.ObjectId(idHexadecimal);
            Document doc = collection.find(com.mongodb.client.model.Filters.eq("_id", idMongo)).first();
            if (doc != null) {
                Venta ventaEncontrada = new Venta();
                ventaEncontrada.setUsername(doc.getString("username"));
                ventaEncontrada.setNombresProductos((List<String>) doc.get("productos"));
                ventaEncontrada.setTotal(doc.getDouble("total"));
                ventaEncontrada.setFechaVenta(doc.getDate("fecha"));
                return ventaEncontrada;
            }
        } catch (Exception e) {
            System.out.println("Error al buscar la venta: " + e.getMessage());
        }
        return null;
    }
    public List<Venta> obtenerVentasPorUsuario(String username) {
        List<Venta> listaHistorial = new java.util.ArrayList<>();
        try {
            for (Document doc : collection.find(com.mongodb.client.model.Filters.eq("username", username))) {
                Venta v = new Venta();
                v.setId(doc.getObjectId("_id").toHexString());
                v.setUsername(doc.getString("username"));
                v.setNombresProductos((List<String>) doc.get("productos"));
                v.setTotal(doc.getDouble("total"));
                v.setFechaVenta(doc.getDate("fecha"));
                listaHistorial.add(v);
            }
        } catch (Exception e) {
            System.out.println("Error al obtener historial: " + e.getMessage());
        }
        return listaHistorial;
    }
}
