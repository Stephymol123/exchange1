<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Navbar</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .navbar {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000; /* Ensure the navbar stays on top */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Add a subtle shadow for better separation */
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            transition: background-color 0.3s;
            font-size: 16px; /* Adjust font size for better readability */
        }
        .navbar a:hover {
            background-color: #0056b3;
            border-radius: 4px; /* Add a slight rounding for hover effect */
        }
        .navbar-left,
        .navbar-right {
            display: flex;
            align-items: center;
        }
        .navbar-right a {
            margin-left: 15px; /* Add spacing between right-aligned links */
        }
        /* Ensure content below the navbar is not hidden behind it */
        .content {
            padding-top: 60px; /* Adjust according to the navbar's height */
        }
    </style>
</head>
<body>
<div class="navbar">
    <div class="navbar-left">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About</a>
        <a href="allProducts">All Products</a>
        <a href="viewExchanges">My Exchanges</a>
        <a href="predictCategory">Predict Category</a>
        <a href="userItems">My Items</a>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="addProduct">Add New Item</a>
            </c:when>
        </c:choose>
    </div>
    <div class="navbar-right">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="logout">Logout</a>
                
            </c:when>
            <c:otherwise>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
