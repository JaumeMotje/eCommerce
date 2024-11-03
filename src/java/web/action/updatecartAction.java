package web.action;

import javax.servlet.http.*;
import cart.ShoppingCart;
import cart.ShoppingCartItem;
import model.ProductModel;
import entity.Product;

public class updatecartAction implements Action {

    ProductModel productModel;

    public updatecartAction(ProductModel productModel) {
        this.productModel = productModel;
    }

    @Override
    public void perform(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // Retrieve the cart from the session or create a new one if it doesn't exist
        HttpSession session = req.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }

        // Get the product ID and quantity change from the request
        int productId = Integer.parseInt(req.getParameter("productid"));
        int change = Integer.parseInt(req.getParameter("change")); // Can be -1 or +1
        int quantity = change + cart.getQuantityForProduct(productId);
        
        // Retrieve the product from the model
        Product product = productModel.retrieveById(productId);
        if (product != null) {
            if (quantity <= 0) {
                cart.removeItem(productId);
            } else{
                if(quantity == 1 && !cart.itemExists(productId)){
                    cart.addItem(new ShoppingCartItem(product));
                }
                    cart.updateItemQuantity(productId, quantity);
            }

        }

        // Update the cart in the session
        session.setAttribute("cart", cart);
        
        // Respond with the current quantity
        resp.getWriter().write(Integer.toString(cart.getQuantityForProduct(productId)));
    }
}
