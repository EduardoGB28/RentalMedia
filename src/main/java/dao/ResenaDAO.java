package dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import config.MongoConfig;
import models.Resena;
import java.util.List;

public class ResenaDAO {
    private MongoCollection<Document> collection;

    public ResenaDAO() {
        MongoDatabase database = MongoConfig.getDatabase();
        this.collection = database.getCollection("resenas");
    }
    public boolean SaveRese(Resena r) {
        try {
            Document doc = new Document("username", r.getUsername())
                    .append("idPedido", r.getIdPedido())
                    .append("comentario", r.getComentario())
                    .append("estrellas", r.getEstrellas())
                    .append("fecha", r.getFecha());
            collection.insertOne(doc);
            return true;
        } catch (Exception e) {
            System.out.println("Error al guardar reseña: " + e.getMessage());
            return false;
        }
    }
    public List<Resena> obtenerTodasLasResenas() {
        List<Resena> lista = new java.util.ArrayList<>();
        try {
            for (Document doc : collection.find().sort(new Document("fecha", -1))) {
                Resena r = new Resena();
                r.setId(doc.getObjectId("_id").toHexString());
                r.setUsername(doc.getString("username"));
                r.setIdPedido(doc.getString("idPedido"));
                r.setComentario(doc.getString("comentario"));
                r.setEstrellas(doc.getInteger("estrellas", 0)); 
                r.setFecha(doc.getDate("fecha"));
                
                lista.add(r);
            }
        } catch (Exception e) {
            System.out.println("Error al obtener el muro de reseñas: " + e.getMessage());
        }
        return lista;
    }
}