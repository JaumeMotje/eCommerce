package web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import cart.ShoppingCartItem;
import web.ViewManager;
import java.util.ArrayList;

public class viewcartAction implements Action {

    @Override
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        // Get the session from the request
        HttpSession session = req.getSession();
        
        // Retrieve the shopping cart from the session
        List<ShoppingCartItem> cartItems = (List<ShoppingCartItem>) session.getAttribute("cartItems");
        
        // If the cart is null, it means it's empty
        if (cartItems == null) {
            cartItems = new ArrayList<ShoppingCartItem>(); // Create an empty list if no cart exists
        }

        // Set the cart items in the request attribute for the JSP to use
        req.setAttribute("cartItems", cartItems);

        // Forward the request to cart.jsp to display the cart
        ViewManager.nextView(req, resp, "/view/cart.jsp");
    }
}
