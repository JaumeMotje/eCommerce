<%@ page import="cart.ShoppingCartItem" %>
<%@ page import="cart.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<head>
    <title>Checkout</title>
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <style>
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        h2, h3, p {
            text-align: center;
        }
    </style>
</head>

<body>
    <h2>Checkout</h2>

    <div id="checkout-container">
        <%
            ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
            if (cart != null && !cart.isEmpty()) {
                List<ShoppingCartItem> cartItems = cart.getItems();
                double totalAmount = (double) request.getAttribute("totalAmount");
        %>
        <table>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            <%
                for (ShoppingCartItem item : cartItems) {
                    double itemTotalPrice = item.getTotalPrice();
            %>
            <tr>
                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                <td>$<%= String.format("%.2f", itemTotalPrice) %></td>
            </tr>
            <% } %>
        </table>

        <h3>Total Amount: $<%= String.format("%.2f", totalAmount) %></h3>

        <form action="finalizepurchase.do" method="post">
            <fieldset>
                <legend>Customer Information</legend>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required><br><br>
                <label for="address">Address:</label>
                <textarea id="address" name="address" required></textarea><br><br>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required><br><br>
            </fieldset>
            <input type="submit" value="Complete Purchase">
        </form>

        <p><a href="cart.do">Back to Cart</a></p>
        <%
            } else {
        %>
        <h3>Your cart is empty!</h3>
        <p><a href="start.jsp">Continue Shopping</a></p>
        <%
            }
        %>
    </div>
</body>
