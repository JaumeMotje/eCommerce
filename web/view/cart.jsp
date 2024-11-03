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
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        #cart-container {
            width: 90%;
            margin: auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e2e6ea;
        }
        img {
            max-width: 100px; /* Ensure images fit nicely */
            height: auto; /* Maintain aspect ratio */
            border-radius: 8px; /* Rounded corners for images */
        }
        button {
            background-color: #28a745; /* Green background for buttons */
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .total-price {
            text-align: center;
            font-size: 1.5em;
            color: #333;
            margin: 20px 0;
        }
        .action-links {
            text-align: center;
        }
        .action-links a {
            margin: 0 15px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .action-links a:hover {
            text-decoration: underline;
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
                        const row = document.getElementById("row-" + productId);
                        if (row) row.parentNode.removeChild(row);
                        const table = document.getElementById("cart-table");
                        if (table.rows.length === 1) { // Only the header row remains
                            document.getElementById("cart-container").innerHTML = `
                                <h3>Your cart is empty!</h3>
                                <p><a href="start.jsp">Back to Home</a></p>
                            `;
                        }
                    } else {
                        document.getElementById("cart-info-" + productId).innerText = "Quantity: " + response;
                        const itemPrice = parseFloat(document.getElementById("item-price-" + productId).innerText.substring(1));
                        document.getElementById("total-item-price-" + productId).innerText =
                            "$" + (itemPrice * parseInt(response)).toFixed(2);
                    }

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
        <h3>Your cart is empty!</h3>
        <p><a href="start.jsp">Back to Home</a></p>
        <%
            } else {
        %>
        <table id="cart-table">
            <tr>
                <th>Product</th>
                <th>Name</th>
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
                <td><img src="img/products/<%=item.getProduct().getName()%>.png" alt="<%=item.getProduct().getName()%>"></td>
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

        <h3 class="total-price" id="total-price">Total Price: $<%= String.format("%.2f", totalCartPrice) %></h3>

        <div class="action-links">
            <a href="init.do">Continue Shopping</a>
            <a href="clearcart.do">Clear Cart</a>
            <a href="checkout.do">Proceed to Checkout</a>
        </div>
        <%
            }
        %>
    </div>
</body>
