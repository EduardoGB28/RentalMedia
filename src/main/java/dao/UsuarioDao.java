package dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import com.mongodb.client.model.Filters;
import models.Usuario;
import config.MongoConfig;

public class UsuarioDAO
{
    private MongoCollection<Document> collection;
    public UsuarioDAO(){
    MongoDatabase database=MongoConfig.getDatabase();
    this.collection=database.getCollection("Users");
    }
    public Usuario auth(String username, String password){
        Document doc=collection.find(Filters.and(Filters.eq("username",username),Filters.eq("password",password))).first();
   if(doc != null){
       Usuario user=new Usuario();
       user.setUsername(doc.getString("username"));
       user.setRole(doc.getString("role"));
   }
   return null;
    }
}