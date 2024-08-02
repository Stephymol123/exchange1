<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Exchanges - MangoEx</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #14397d;
            --secondary-color: #4a90e2;
            --background-color: #f4f6f9;
            --text-color: #333;
            --light-gray: #e0e0e0;
        }

        body {
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 30px;
        }

        h2 {
            color: var(--primary-color);
            font-size: 1.8em;
            margin-top: 40px;
            margin-bottom: 20px;
            border-bottom: 2px solid var(--light-gray);
            padding-bottom: 10px;
        }

        .exchange {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .exchange:hover {
            transform: translateY(-5px);
        }

        .exchange-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .exchange-info div {
            margin-bottom: 10px;
        }

        .label {
            font-weight: 500;
            color: var(--primary-color);
            display: block;
            margin-bottom: 5px;
        }

        .value {
            font-weight: 300;
        }

        .btn-group {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }

        .btn, .back-link {
            display: inline-block;
            padding: 10px 15px;
            background-color: var(--secondary-color);
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s, transform 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
        }

        .btn:hover, .back-link:hover {
            background-color: var(--primary-color);
            transform: translateY(-2px);
        }

        .btn-success {
            background-color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .not-found {
            text-align: center;
            color: #e74c3c;
            font-style: italic;
            margin: 20px 0;
        }

        .back-link-container {
            text-align: center;
            margin-top: 40px;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<div class="container">
    <h1>My Exchanges</h1>

    <c:if test="${not empty errorMessage}">
        <p class="error-message">${errorMessage}</p>
    </c:if>

    <h2>Pending Exchanges</h2>
    <c:forEach var="exchange" items="${userExchanges}">
        <c:if test="${exchange.status == 'pending'}">
            <div class="exchange">
                <div class="exchange-info">
                    <div><span class="label">Product Name:</span> <span class="value">${exchange.productName}</span></div>
                    <div><span class="label">Owner User Name:</span> <span class="value">${exchange.ownerUserName}</span></div>
                    <div><span class="label">Interested User Name:</span> <span class="value">${exchange.interestedUserName}</span></div>
                    <div><span class="label">Status:</span> <span class="value">${exchange.status}</span></div>
                    <div><span class="label">Created At:</span> <span class="value">${exchange.createdAt}</span></div>
                    <div><span class="label">Updated At:</span> <span class="value">${exchange.updatedAt}</span></div>
                </div>
                <div class="btn-group">
                    <form action="viewExchanges" method="post" style="display:inline;">
                        <input type="hidden" name="exchangeId" value="${exchange.id}">
                        <button type="submit" name="action" value="accept" class="btn btn-success">Accept</button>
                    </form>
                    <form action="viewExchanges" method="post" style="display:inline;">
                        <input type="hidden" name="exchangeId" value="${exchange.id}">
                        <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
                    </form>
                    <a href="fetchConversations?exchangeId=${exchange.id}" class="btn">View Conversation</a>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <c:if test="${empty userExchanges}">
        <p class="not-found">No pending exchanges found.</p>
    </c:if>

    <h2>Accepted Exchanges</h2>
    <c:forEach var="exchange" items="${userExchanges}">
        <c:if test="${exchange.status == 'accepted'}">
            <div class="exchange">
                <div class="exchange-info">
                    <div><span class="label">Product Name:</span> <span class="value">${exchange.productName}</span></div>
                    <div><span class="label">Owner User Name:</span> <span class="value">${exchange.ownerUserName}</span></div>
                    <div><span class="label">Interested User Name:</span> <span class="value">${exchange.interestedUserName}</span></div>
                    <div><span class="label">Status:</span> <span class="value">${exchange.status}</span></div>
                    <div><span class="label">Created At:</span> <span class="value">${exchange.createdAt}</span></div>
                    <div><span class="label">Updated At:</span> <span class="value">${exchange.updatedAt}</span></div>
                </div>
                <div class="btn-group">
                    <a href="fetchConversations?exchangeId=${exchange.id}" class="btn">View Conversation</a>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <c:if test="${empty userExchanges}">
        <p class="not-found">No accepted exchanges found.</p>
    </c:if>

    <div class="back-link-container">
        <a href="allProducts" class="back-link">Back to Products List</a>
    </div>
</div>
</body>
</html>
