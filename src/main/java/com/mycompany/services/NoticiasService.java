package com.mycompany.services;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import models.Noticia;

public class NoticiasService {
    
   
    private static final String API_KEY = "9677a6c460c147969a5adb1a498f76a8"; 
    
    public List<Noticia> obtenerNoticias() {
        List<Noticia> listaNoticias = new ArrayList<>();
        
        try {
         
            String tema = "IGN"; 
            String urlString = "https://newsapi.org/v2/everything?q=" + tema + "&language=es&sortBy=publishedAt&apiKey=" + API_KEY;
            
          
            URL url = new URL(urlString);
            HttpURLConnection request = (HttpURLConnection) url.openConnection();
            request.setRequestProperty("User-Agent", "Mozilla/5.0"); 
            request.connect();
            JsonObject jsonResponse = JsonParser.parseReader(new InputStreamReader(request.getInputStream())).getAsJsonObject();
            JsonArray articulos = jsonResponse.getAsJsonArray("articles");
            int limite = Math.min(5, articulos.size());
            for (int i = 0; i < limite; i++) {
                JsonObject obj = articulos.get(i).getAsJsonObject();
                String titulo = obj.has("title") && !obj.get("title").isJsonNull() ? obj.get("title").getAsString() : "Sin título";
                String descripcion = obj.has("description") && !obj.get("description").isJsonNull() ? obj.get("description").getAsString() : "Sin resumen";
                String urlNota = obj.has("url") && !obj.get("url").isJsonNull() ? obj.get("url").getAsString() : "#";
                String urlImagen = obj.has("urlToImage") && !obj.get("urlToImage").isJsonNull() ? obj.get("urlToImage").getAsString() : "";
                
                listaNoticias.add(new Noticia(titulo, descripcion, urlNota, urlImagen));
            }
            
        } catch (Exception e) {
            System.out.println("Error al conectar con la API: " + e.getMessage());
        }
        
        return listaNoticias;
    }
}