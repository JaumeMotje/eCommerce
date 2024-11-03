<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>

<head>
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>eCommerce Sample</title>
    <style>
        body {
            font-family: Arial, sans-serif; /* Use a clean font */
            background-color: #f4f4f4; /* Light gray background */
            color: #333; /* Darker text for readability */
            margin: 0;
            padding: 0;
        }
        h2, h3 {
            text-align: center; /* Center align headings */
            color: #2c3e50; /* Darker shade for headings */
        }
        h2 {
            margin-top: 20px; /* Add some spacing above the main heading */
        }
        h3 {
            margin-bottom: 20px; /* Add spacing below the subheading */
            font-weight: 300; /* Lighter font weight for subheading */
        }
        table {
            width: 80%; /* Wider table */
            margin: 0 auto; /* Center the table */
            border-collapse: collapse; /* Collapse borders for a cleaner look */
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Add subtle shadow for depth */
            background-color: white; /* White background for the table */
        }
        td {
            text-align: center; /* Center content in table cells */
            padding: 10px; /* Add padding inside cells */
            border: 1px solid #ddd; /* Light border for cells */
        }
        td img {
            width: 100px; /* Set a standard image width */
            height: auto; /* Maintain aspect ratio */
            border-radius: 5px; /* Rounded corners for images */
        }
        a {
            text-decoration: none; /* Remove underline from links */
            color: #2980b9; /* Set link color */
            transition: color 0.3s; /* Smooth transition for hover */
        }
        a:hover {
            color: #3498db; /* Change color on hover */
        }
        h4 {
            text-align: center; /* Center align the View Cart link */
            margin-top: 20px; /* Add spacing above */
        }
    </style>
</head>

<body>
    <h2>Welcome to the Online Home of Our Virtual Grocery</h2>
    <h3>Our unique home delivery service brings you fresh organic produce, dairy, meats, breads, and other delicious and healthy items direct to your doorstep.</h3>

    <table>
        <tr>
            <%
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                for (Category category : categories) {
            %>
            <td valign="center" align="middle">
                <a href="category.do?categoryid=<%= category.getId() %>">
                    <img src="img/categories/<%= category.getName() %>.jpg" alt="<%= category.getName() %>">
                    <div><%= category.getName() %></div>
                </a>
            </td>
            <% } %>
        </tr>
    </table>

    <!-- Link to View Cart -->
    <h4>
       <a href="viewcart.do">View Cart</a>
    </h4>  
</body>
