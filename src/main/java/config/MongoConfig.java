package config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class MongoConfig {
    
    private static final String URI = "mongodb+srv://User:1234@cluster0.ybcvjqj.mongodb.net/?retryWrites=true&w=majority";
    private static MongoClient mongoClient = null;
    
    public static MongoDatabase getDatabase() {
        if (mongoClient == null) {
            mongoClient = MongoClients.create(URI);
        }
        return mongoClient.getDatabase("Herencia"); 
    }
}