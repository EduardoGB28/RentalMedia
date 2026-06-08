package models;

import java.util.Date;

public class Resena {
    private String id;
    private String username;
    private String idPedido;
    private String comentario;
    private int estrellas;
    private Date fecha;

    public Resena() {}
//getters
    public String getId() { return id; }
    public String getUsername() { return username; }
    public String getIdPedido() { return idPedido; }
    public String getComentario() { return comentario; }
    public int getEstrellas() { return estrellas; }
    public Date getFecha() { return fecha; }
//setters
    public void setId(String id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setIdPedido(String idPedido) { this.idPedido = idPedido; }
    public void setComentario(String comentario) { this.comentario = comentario; }
    public void setEstrellas(int estrellas) { this.estrellas = estrellas; }
    public void setFecha(Date fecha) { this.fecha = fecha; }
}