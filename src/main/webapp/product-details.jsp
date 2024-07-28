<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Product</title>
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
        .product-details {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .product-details div {
            margin-bottom: 10px;
        }
        .label {
            font-weight: bold;
            color: #2c3e50;
        }
        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        .image-gallery img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 4px;
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
        .message-box {
            margin-top: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .message-box textarea {
            width: 100%;
            height: 100px;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
            font-family: Arial, sans-serif;
            font-size: 14px;
            resize: none;
        }
        .message-box button {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .message-box button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<h1>Product Details</h1>
<c:if test="${not empty product}">
    <div class="product-details">
        <div><span class="label">Product Name:</span> ${product.pname}</div>
        <div><span class="label">Category:</span> ${product.categoryName}</div>
        <div><span class="label">Price:</span> $${product.price}</div>
        <div><span class="label">Description:</span> ${product.description}</div>
        <div><span class="label">Quantity:</span> ${product.quantity}</div>
        <div>
            <span class="label">Images:</span>
            <div class="image-gallery">
                <img src="${product.firstImageUrl}" alt="${product.pname}" class="product-image"/>
            </div>
        </div>
    </div>

    <!-- Message Box -->
    <div class="message-box">
        <form action="sendMessage" method="post">
            <input type="hidden" name="productId" value="${product.id}">
            <input type="hidden" name="receiverId" value="${product.user_id}">
            <textarea name="message" placeholder="Write your message here..."></textarea>
            <button type="submit">Send Message</button>
        </form>
    </div>
</c:if>
<c:if test="${empty product}">
    <p class="not-found">Product not found.</p>
</c:if>

<a href="allProducts" class="back-link">Back to Products List</a>
</body>
</html>
