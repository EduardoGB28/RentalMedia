package dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import models.Usuario;
import config.MongoConfig;
import org.mindrot.jbcrypt.BCrypt; 

public class UsuarioDAO {
    private MongoCollection<Document> collection;

    public UsuarioDAO() {
        MongoDatabase database = MongoConfig.getDatabase();
        this.collection = database.getCollection("Users");
    }
    public Usuario auth(String username, String password) {
        try {
            Document doc = collection.find(Filters.eq("username", username)).first();
            if (doc != null) {
                String hashGuardado = doc.getString("password");
                if (BCrypt.checkpw(password, hashGuardado)) {
                    Usuario user = new Usuario();
                    user.setUsername(doc.getString("username"));
                    user.setRole(doc.getString("role"));
                    user.setCorreo(doc.getString("correo"));
                    user.setNombreCompleto(doc.getString("nombreCompleto"));
                    user.setFechaNacimiento(doc.getString("fechaNacimiento"));
                    Number tokensNum = doc.get("tokens", Number.class);
                    user.setTokens(tokensNum != null ? tokensNum.intValue() : 0);
                    return user;
                }
            }
        } catch (Exception e) {
            System.out.println("Error al autenticar: " + e.getMessage());
        }
        return null;
    }
    public boolean UsuCreate(String username, String password, String correo, String nombreCompleto, String fechaNacimiento) {
        try {

            Document usuarioExistente = collection.find(Filters.eq("username", username)).first();
            if (usuarioExistente != null) {
                return false;
            }
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
            Document nuevoUsuario = new Document("username", username)
                    .append("password", hashedPassword)
                    .append("correo", correo)
                    .append("nombreCompleto", nombreCompleto)
                    .append("fechaNacimiento", fechaNacimiento)
                    .append("role", "user")
                    .append("tokens", 0);
            collection.insertOne(nuevoUsuario);
            return true;
        } catch (Exception e) {
            System.out.println("Error al crear la cuenta: " + e.getMessage());
            return false;
        }
    }
    public boolean sumarTokens(String username, int cantidadGanada) {
        try {
            collection.updateOne(
                Filters.eq("username", username),
                Updates.inc("tokens", cantidadGanada)
            );
            return true;
        } catch (Exception e) {
            System.out.println("Error al actualizar la billetera: " + e.getMessage());
            return false;
        }
    }
    public boolean restarTokens(String username, int cantidadRestar) {
        try {
            collection.updateOne(
                Filters.eq("username", username),
                Updates.inc("tokens", -cantidadRestar)
            );
            return true;
        } catch (Exception e) {
            System.out.println("Error al restar tokens: " + e.getMessage());
            return false;
        }
    }
}