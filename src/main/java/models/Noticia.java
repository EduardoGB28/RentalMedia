
package models;

public class Noticia {
    private String titulo;
    private String descripcion;
    private String url;
    private String urlImagen;


    public Noticia() {}


    public Noticia(String titulo, String descripcion, String url, String urlImagen) {
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.url = url;
        this.urlImagen = urlImagen;
    }
//getters
    public String getTitulo() { return titulo; }
    public String getDescripcion() { return descripcion; }
    public String getUrl() { return url; }
    public String getUrlImagen() { return urlImagen; }
//setters
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public void setUrl(String url) { this.url = url; }
    public void setUrlImagen(String urlImagen) { this.urlImagen = urlImagen; }
}