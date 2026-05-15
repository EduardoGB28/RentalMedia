package models;

public class Producto {
    private String name;
    private String category;
    private double price;
    private String imageUrl;
    private int stock;

    public Producto() {}


    public String getName() { return name; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    public String getImageUrl() { return imageUrl; }
    public int getStock() { return stock; }
    
    
    public void setName(String name) { this.name = name; }
    public void setCategory(String category) { this.category = category; }
    public void setPrice(double price) { this.price = price; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setStock(int stock) { this.stock = stock; }
}