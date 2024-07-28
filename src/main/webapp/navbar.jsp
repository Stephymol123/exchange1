<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        .navbar {
            background-color: #007bff;
            color: white;
            padding: 10px;
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000; /* Ensure the navbar stays on top */
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #0056b3;
        }
        .navbar-right {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="navbar">
    <div class="navbar-left">
        <a href="user-home.jsp">Home</a>
        <a href="about.jsp">About</a>
        <a href="allProducts">All Product</a>
        <a href="viewExchanges">My Exchanges</a>
        <a href="userItems">My Items</a>
        <!--<c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="addProduct">Add New Item</a>
            </c:when>
        </c:choose>-->
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
