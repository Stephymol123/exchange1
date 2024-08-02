<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conversations - MangoEx</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #14397d;
            --secondary-color: #4a90e2;
            --background-color: #f4f6f9;
            --text-color: #333;
            --light-gray: #e0e0e0;
            --white: #ffffff;
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
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 30px;
        }

        .product-info {
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 30px;
        }

        .product-name {
            font-size: 1.4em;
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .user-info {
            display: flex;
            justify-content: space-between;
            font-size: 0.9em;
            color: var(--text-color);
        }

        .message-container {
            margin-bottom: 30px;
        }

        .message-box {
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        .message-box:hover {
            transform: translateY(-3px);
        }

        .sender {
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .message {
            margin-bottom: 10px;
        }

        .created-at {
            color: #7f8c8d;
            font-size: 0.8em;
            text-align: right;
        }

        .message-form {
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 20px;
        }

        .message-form textarea {
            width: 100%;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 4px;
            border: 1px solid var(--light-gray);
            font-family: 'Roboto', sans-serif;
            font-size: 1em;
            resize: vertical;
        }

        .message-form button {
            padding: 12px 20px;
            background-color: var(--secondary-color);
            color: var(--white);
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            font-size: 1em;
            font-weight: 500;
        }

        .message-form button:hover {
            background-color: var(--primary-color);
            transform: translateY(-2px);
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 20px;
            background-color: var(--secondary-color);
            color: var(--white);
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s, transform 0.3s;
            font-weight: 500;
        }

        .back-link:hover {
            background-color: var(--primary-color);
            transform: translateY(-2px);
        }

        .no-messages {
            text-align: center;
            color: #7f8c8d;
            font-style: italic;
            margin: 30px 0;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<div class="container">
    <h1>Conversations</h1>

    <div class="product-info">
        <div class="product-name">
            Product: ${productName}
        </div>
        <div class="user-info">
            <span><strong>Owner:</strong> ${ownerUserName}</span>
            <span><strong>Interested User:</strong> ${interestedUserName}</span>
        </div>
    </div>

    <div class="message-container">
        <c:if test="${not empty messages}">
            <c:forEach var="message" items="${messages}">
                <div class="message-box">
                    <div class="sender">Sender: ${message.senderUsername}</div>
                    <div class="message">${message.message}</div>
                    <div class="created-at">${message.createdAt}</div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty messages}">
            <p class="no-messages">No messages found.</p>
        </c:if>
    </div>

    <div class="message-form">
        <form action="sendNewMessage" method="post">
            <input type="hidden" name="exchangeId" value="${exchangeId}">
            <input type="hidden" name="receiverId" value="${receiverId}">
            <textarea name="message" rows="4" placeholder="Enter your message here..." required></textarea>
            <button type="submit">Send Message</button>
        </form>
    </div>

    <a href="allProducts" class="back-link">Back to Products List</a>
</div>
</body>
</html>