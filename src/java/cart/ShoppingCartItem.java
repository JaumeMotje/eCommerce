package cart;

import entity.Product;

public class ShoppingCartItem {
    private Product product;
    private int quantity;

    public ShoppingCartItem(Product product) {
        this.product = product;
        this.quantity = 1; // Default quantity when first added
    }

    // Getters and setters
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void incrementQuantity() {
        this.quantity++;
    }

    public void decrementQuantity() {
        if (this.quantity > 1) {
            this.quantity--;
        }
    }

    public double getTotalPrice() {
        return product.getPrice() * quantity; // Assuming Product has a getPrice() method
    }
}
