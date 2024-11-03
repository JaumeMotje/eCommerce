<%@ page import="cart.ShoppingCartItem" %>
<%@ page import="cart.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<head>
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Checkout</title>
</head>

<body>
    <h2>Checkout</h2>

    <%
        // Retrieve the shopping cart from the session
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        double totalCartPrice = 0;

        if (cart != null && !cart.isEmpty()) {
            // Calculate the total price of the cart
            totalCartPrice = cart.getTotalPrice();
        } else {
    %>
        <p>Your cart is empty! Please add items before proceeding to checkout.</p>
        <p><a href="start.jsp">Continue Shopping</a></p>
    <%
        return; // Stop processing if the cart is empty
        }
    %>

    <div class="total-price">Total Amount: $<%= String.format("%.2f", totalCartPrice) %></div>
    
    <!-- PayPal Checkout Form -->
    <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
        <input type="hidden" name="cmd" value="_xclick">
        <input type="hidden" name="business" value="jaumemotje00@gmail.com"> <!-- Replace with your PayPal email -->
        <input type="hidden" name="item_name" value="Shopping Cart Total">
        <input type="hidden" name="currency_code" value="USD">
        <input type="hidden" name="amount" value="<%= String.format("%.2f", totalCartPrice) %>"> <!-- Total Price -->
        <input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-but01.gif" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
    </form>
    
    <p><a href="start.jsp">Continue Shopping</a></p>
</body>
</html>
