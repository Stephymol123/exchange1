<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .sidebar {
            width: 250px;
            background-color: #007bff;
            color: #fff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 20px;
        }
        .sidebar a {
            display: block;
            color: #f2f2f2;
            padding: 15px;
            text-decoration: none;
            font-size: 1.1rem;
        }
        .sidebar a:hover {
            background-color: #ddd;
            color: black;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
            width: calc(100% - 260px);
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .welcome-message {
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<div class="sidebar">
    <a href="<c:url value='/allProducts' />">All Items</a>
    <a href="<c:url value='/addProduct' />">Add Item</a>
    <!--<a href="<c:url value='/updateProduct' />">Update Item</a>-->
    <a href="<c:url value='/userItems' />">My Items</a>
    <a href="<c:url value='/profile.jsp' />">Profile</a>
</div>
<div class="content">

    <br><br>
    <h2 class="welcome-message">Welcome, <c:out value="${user.username}" /></h2>

    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</div>

</body>
</html>
