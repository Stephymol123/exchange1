<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conversations</title>
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
        .message-box {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 10px;
        }
        .sender {
            font-weight: bold;
            color: #2c3e50;
        }
        .created-at {
            color: #7f8c8d;
            font-size: 0.9em;
        }
        .message-form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-top: 20px;
        }
        .message-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .message-form button {
            padding: 10px 15px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .message-form button:hover {
            background-color: #2980b9;
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
    </style>
</head>
<body>
<h1>Conversations</h1>

<c:if test="${not empty messages}">
    <c:forEach var="message" items="${messages}">
        <div class="message-box">
            <div class="sender">Sender ID: ${message.senderId}</div>
            <div class="message">${message.message}</div>
            <div class="created-at">${message.createdAt}</div>
        </div>
    </c:forEach>
</c:if>
<c:if test="${empty messages}">
    <p>No messages found.</p>
</c:if>

<div class="message-form">
    <form action="sendNewMessage" method="post">
        <input type="hidden" name="exchangeId" value="${exchangeId}">
        <input type="hidden" name="receiverId" value="${receiverId}">
        <textarea name="message" rows="4" placeholder="Enter your message here..." required></textarea>
        <button type="submit">Send Message</button>
    </form>
</div>

<a href="allProducts" class="back-link">Back to Products List</a>
</body>
</html>
