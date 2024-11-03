package web.action;

import javax.servlet.http.*;
import web.ViewManager;

public class clearcartAction implements Action {

    @Override
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        // Retrieve the session and remove the cart attribute
        HttpSession session = req.getSession();
        session.removeAttribute("cart");

        // Redirect or forward to a page to confirm the cart has been cleared
        ViewManager.nextView(req, resp, "/view/cart.jsp");
    }
}
