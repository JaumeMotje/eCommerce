package cart;

import entity.Product;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ShoppingCart {
    // List to hold items in the shopping cart
    private List<ShoppingCartItem> items;

    // Constructor to initialize the items list
    public ShoppingCart() {
        // Explicit type declaration for compatibility with older Java versions
        this.items = new ArrayList<ShoppingCartItem>();
    }

    // Method to get the list of items in the cart
    public List<ShoppingCartItem> getItems() {
        return items;
    }

    // Method to add an item to the cart
    public void addItem(ShoppingCartItem item) {
        // Check if the item is already in the cart
        for (ShoppingCartItem cartItem : items) {
            if (cartItem.getProduct().getId() == item.getProduct().getId()) {
                // If found, increment the quantity and return
                cartItem.incrementQuantity();
                return;
            }
        }
        // If not found, add the new item to the cart
        items.add(item);
    }

    // Method to get an item from the cart by product ID
    public ShoppingCartItem getItemById(int productId) {
        // Iterate through the items to find the matching product ID
        for (ShoppingCartItem item : items) {
            if (item.getProduct().getId() == productId) {
                return item; // Return the item if found
            }
        }
        return null; // Return null if not found
    }

    // Method to remove an item from the cart by product ID
    public void removeItem(int productId) {
        // Use an iterator to safely remove an item while iterating
        Iterator<ShoppingCartItem> iterator = items.iterator();
        while (iterator.hasNext()) {
            ShoppingCartItem item = iterator.next();
            // Check if the current item's product ID matches the given product ID
            if (item.getProduct().getId() == productId) {
                iterator.remove(); // Remove the item from the list
            }
        }
    }

    // Method to calculate the total price of items in the cart
    public double getTotalPrice() {
        double total = 0;
        // Loop through each item and add its total price to the total sum
        for (ShoppingCartItem item : items) {
            total += item.getTotalPrice();
        }
        return total; // Return the calculated total price
    }

    // Method to clear all items from the cart
    public void clear() {
        items.clear(); // Remove all items from the list
    }

    // Method to check if the cart is empty
    public boolean isEmpty() {
        return items.isEmpty(); // Return true if the cart has no items
    }
    
    public void updateItemQuantity(Integer productId, Integer quantity) {
        for (ShoppingCartItem item : items) {
            if (item.getProduct().getId().equals(productId)) {
                if (quantity > 0) {
                    item.setQuantity(quantity);  // Update the quantity if it's greater than zero
                } else {
                    items.remove(item);  // Remove the item if the quantity is zero
                }
                break;  // Exit the loop once the item is found and updated
            }
        }
    }
    
    public void incrementItemQuantity(Integer productId, int amount) {
        for (ShoppingCartItem item : items) {
            if (item.getProduct().getId().equals(productId)) {
                item.setQuantity(item.getQuantity() + amount);
                return; // Exit after updating the quantity
            }
        }
    }

    public int getQuantityForProduct(int productId) {
        for (ShoppingCartItem item : items) {
            if (item.getProduct().getId().equals(productId)) {
                return item.getQuantity();
            }
        }
        // Return 0 if the product is not found in the cart
        return 0;
    }
    
        // Check if an item exists in the cart
    public boolean itemExists(int productId) {
        for (ShoppingCartItem item : items) {
            if (item.getProduct().getId() == productId) {
                return true; // Item exists
            }
        }
        return false; // Item does not exist
    }
}
