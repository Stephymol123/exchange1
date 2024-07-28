<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Exchanges</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .exchange {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 10px;
        }
        .exchange div {
            margin-bottom: 10px;
        }
        .label {
            font-weight: bold;
            color: #2c3e50;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .back-link:hover {
            background-color: #2980b9;
        }
        .not-found {
            text-align: center;
            color: #e74c3c;
        }
    </style>
</head>
<body>
<h1>My Exchanges</h1>

<c:if test="${not empty exchanges}">
    <c:forEach var="exchange" items="${exchanges}">
        <div class="exchange">
            <div><span class="label">Exchange ID:</span> ${exchange.id}</div>
            <div><span class="label">Item ID:</span> ${exchange.itemId}</div>
            <div><span class="label">Interested User ID:</span> ${exchange.interestedUserId}</div>
            <div><span class="label">Status:</span> ${exchange.status}</div>
            <div><span class="label">Created At:</span> ${exchange.createdAt}</div>
            <div><span class="label">Updated At:</span> ${exchange.updatedAt}</div>
            <a href="fetchConversations?exchangeId=${exchange.id}" class="back-link">View Conversation</a>
        </div>
    </c:forEach>
</c:if>
<c:if test="${empty exchanges}">
    <p class="not-found">No exchanges found.</p>
</c:if>

<a href="allProducts" class="back-link">Back to Products List</a>
</body>
</html>
