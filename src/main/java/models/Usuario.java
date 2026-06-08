package models;

public class Usuario{
    private String username;
    private String password;
    private String role;
    private String correo;
    private String nombreCompleto;
    private String fechaNacimiento;
    private int tokens;
    
    public Usuario() {
    this.tokens = 0;
    }
   public Usuario(String username, String password, String role){
       this.username=username;
       this.password=password;
       this.role=role;
   }
//getters
   public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getCorreo() { return correo; }
    public String getNombreCompleto() { return nombreCompleto; }
    public String getFechaNacimiento() { return fechaNacimiento; }
    public int getTokens() { return tokens; }
//setters
    public void setPassword(String password) { this.password = password; }
    public void setUsername(String username) { this.username = username; }
    public void setRole(String role) { this.role = role; }
    public void setCorreo(String correo) { this.correo = correo; }
    public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }
    public void setFechaNacimiento(String fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }
    public void setTokens(int tokens) { this.tokens = tokens; }
}
        
