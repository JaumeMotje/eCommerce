<%@ page import="entity.Product" %>
<%@ page import="java.util.List" %>

<head>
    <title>Category - Products</title>
    <style>
        table {
            table-layout: fixed;
            width: 80%;
            margin: auto; /* Centers the entire table on the page */
        }
        th, td {
            text-align: center; /* Centers the text within the cells */
            vertical-align: middle; /* Centers content vertically */
        }
        img {
            display: block;
            margin: auto; /* Centers the image within the cell */
        }
        p, h2, h3 {
        text-align: center; /* Centers the heading text */
        }
    </style>

    <script>
        function updateCart(productId, change) {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "updatecart.do?productid=" + productId + "&change=" + change, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Update quantity display
                    const response = xhr.responseText.trim();
                    if (response === "0") {
                        // If quantity is 0, hide the cart controls and show the Add to Cart button
                        document.getElementById("cart-controls-" + productId).style.display = 'none';
                        document.getElementById("add-to-cart-" + productId).style.display = 'inline';
                    } else {
                        document.getElementById("cart-info-" + productId).innerText = "Quantity: " + response;
                        document.getElementById("add-to-cart-" + productId).style.display = 'none';
                        document.getElementById("cart-controls-" + productId).style.display = 'inline';
                    }
                }
            };
            xhr.send();
        }

    </script>
</head>

<body>
    <h2>Products in <%= request.getAttribute("categoryName") %></h2>
    
    <table width="80%" border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Product</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        for (Product product : products) {
        %>
        <tr>
            <td><img src="img/products/<%=product.getName()%>.png" alt="<%=product.getName()%>" width="100"></td>
            <td><%=product.getName()%></td>
            <td><%=product.getDescription()%></td>
            <td>$<%=product.getPrice()%></td>
            <td>
                <!-- Add to Cart Button -->
                <button id="add-to-cart-<%=product.getId()%>" onclick="updateCart('<%=product.getId()%>', 1);">
                    Add to Cart
                </button>
                
                <!-- Cart Controls (Initially Hidden) -->
                <div id="cart-controls-<%=product.getId()%>" style="display: none;">
                    <button onclick="updateCart('<%=product.getId()%>', -1)">-</button>
                    <span id="cart-info-<%=product.getId()%>">Quantity: 1</span>
                    <button onclick="updateCart('<%=product.getId()%>', 1)">+</button>
                    <button onclick="updateCart('<%=product.getId()%>', -999)">Remove</button>
                </div>
            </td>
        </tr>
        <script>
            updateCart('<%=product.getId()%>', 0); // Check initial quantity for this product
        </script>
        <% } %>
    </table>

    <!-- Link to View Cart -->
    <h3>
        <a href="viewcart.do">View Cart</a>
    </h3>
    
    <p><a href="start.jsp">Back to Home</a></p>
</body>
