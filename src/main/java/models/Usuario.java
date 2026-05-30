package models;

public class Usuario{
    private String username;
    private String password;
    private String role;
    
    public Usuario() {}
   public Usuario(String username, String password, String role){
       this.username=username;
       this.password=password;
       this.role=role;
   }
//getters
   public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
//setters
    public void setPassword(String password) { this.password = password; }
    public void setUsername(String username) { this.username = username; }
    public void setRole(String role) { this.role = role; }
}
        
