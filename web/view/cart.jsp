<%@ page import="cart.ShoppingCartItem" %>
<%@ page import="cart.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<head>
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Shopping Cart</title>
    <style>
        table {
            table-layout: fixed;
            width: 80%;
            margin: auto;
            text-align: center;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
        }
        h2, h3, p {
            text-align: center;
        }
        button {
            margin: 0 5px;
        }
    </style>

    <script>
        function updateCart(productId, change) {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "updatecart.do?productid=" + productId + "&change=" + change, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    const response = xhr.responseText.trim();
                    if (response === "0") {
                        // Remove row if quantity reaches 0
                        const row = document.getElementById("row-" + productId);
                        if (row) row.parentNode.removeChild(row);

                        // Check if the cart is now empty
                        const table = document.getElementById("cart-table");
                        if (table.rows.length === 1) { // Only the header row remains
                            document.getElementById("cart-container").innerHTML = `
                                <table width="100%" border="1" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td colspan="5" align="center">Your cart is empty!</td>
                                    </tr>
                                </table>
                                <p><a href="start.jsp">Back to Home</a></p>
                            `;
                        }
                    } else {
                        // Update quantity and total price for the item
                        document.getElementById("cart-info-" + productId).innerText = "Quantity: " + response;
                        const itemPrice = parseFloat(document.getElementById("item-price-" + productId).innerText.substring(1));
                        document.getElementById("total-item-price-" + productId).innerText =
                            "$" + (itemPrice * parseInt(response)).toFixed(2);
                    }

                    // Update total cart price dynamically
                    let newTotalPrice = 0;
                    const totalPriceElements = document.querySelectorAll('[id^="total-item-price-"]');
                    totalPriceElements.forEach(el => {
                        newTotalPrice += parseFloat(el.innerText.substring(1));
                    });
                    document.getElementById("total-price").innerText = "Total Price: $" + newTotalPrice.toFixed(2);
                }
            };
            xhr.send();
        }
    </script>
</head>

<body>
    <h2>Your Shopping Cart</h2>

    <div id="cart-container">
        <%
            ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
            List<ShoppingCartItem> cartItems = cart != null ? (List<ShoppingCartItem>) cart.getItems() : null;

            if (cart == null || cart.isEmpty()) {
        %>
        <table width="100%" border="1" cellpadding="3" cellspacing="0">
            <tr>
                <td colspan="5" align="center">Your cart is empty!</td>
            </tr>
        </table>
        <p><a href="start.jsp">Back to Home</a></p>
        <%
            } else {
        %>
        <table id="cart-table" width="100%" border="1" cellpadding="3" cellspacing="0">
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            <%
                for (ShoppingCartItem item : cartItems) {
                    double totalPrice = item.getTotalPrice();
            %>
            <tr id="row-<%= item.getProduct().getId() %>">
                <td><%= item.getProduct().getName() %></td>
                <td>
                    <div id="cart-controls-<%= item.getProduct().getId() %>">
                        <button onclick="updateCart('<%= item.getProduct().getId() %>', -1)">-</button>
                        <span id="cart-info-<%= item.getProduct().getId() %>">Quantity: <%= item.getQuantity() %></span>
                        <button onclick="updateCart('<%= item.getProduct().getId() %>', 1)">+</button>
                    </div>
                </td>
                <td id="item-price-<%= item.getProduct().getId() %>">$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                <td id="total-item-price-<%= item.getProduct().getId() %>">$<%= String.format("%.2f", totalPrice) %></td>
                <td>
                    <button onclick="updateCart('<%= item.getProduct().getId() %>', -999)">Remove</button>
                </td>
            </tr>
            <% } %>
        </table>

        <%
                double totalCartPrice = 0;
                for (ShoppingCartItem item : cartItems) {
                    totalCartPrice += item.getTotalPrice();
                }
        %>

        <h3 id="total-price">Total Price: $<%= String.format("%.2f", totalCartPrice) %></h3>

        <h3>
            <a href="checkout.do">Proceed to Checkout</a>
            <br>
            <a href="init.do">Continue Shopping</a>
        </h3>
        <%
            }
        %>
    </div>
</body>
