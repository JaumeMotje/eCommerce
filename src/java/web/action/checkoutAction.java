package web.action;

import javax.servlet.http.*;
import cart.ShoppingCart;
import web.ViewManager;

public class checkoutAction implements Action {

    @Override
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            // Redirect to an empty cart view if there's nothing to checkout
            ViewManager.nextView(req, resp, "/view/emptycart.jsp");
        } else {
            // Calculate the total amount for the cart
            double totalAmount = cart.getTotalPrice();
            req.setAttribute("totalAmount", totalAmount);

            // Forward to the checkout page to display the order summary
            ViewManager.nextView(req, resp, "/view/checkout.jsp");
        }
    }
}
