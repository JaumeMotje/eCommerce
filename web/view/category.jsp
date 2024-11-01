<%@ page import="entity.Product" %>
<%@ page import="java.util.List" %>

<head>
    <title>Category - Products</title>
</head>

<body>
    <h2>Products in <%= request.getAttribute("categoryName") %></h2>

    <table width="80%" border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Product</th>
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
            <td><%=product.getDescription()%></td>
            <td>$<%=product.getPrice()%></td>
            <td><a href="addtocart.do?productid=<%=product.getId()%>">Add to Cart</a></td>
        </tr>
        <% } %>
    </table>

    <p><a href="start.jsp">Back to Home</a></p>
</body>
