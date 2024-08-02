<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Listed Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #333;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header a {
            color: white;
            text-decoration: none;
        }
        .header a:hover {
            text-decoration: underline;
        }
        h1 {
            text-align: center;
            color: #333;
            padding: 20px 0;
        }
        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }
        .product-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .product-info {
            padding: 15px;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .product-name a {
            color: #333;
            text-decoration: none;
        }
        .product-name a:hover {
            text-decoration: underline;
        }
        .product-category {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 10px;
        }
        .product-description {
            font-size: 14px;
            color: #333;
            margin-bottom: 10px;
        }
        .product-quantity {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
        .product-actions {
            display: flex;
            justify-content: space-between;
        }
        .product-actions a {
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
            color: white;
        }
        .product-actions .update-link {
            background-color: #007bff;
        }
        .product-actions .delete-link {
            background-color: #dc3545;
        }
        .product-actions a:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<div class="header">
    <a href="user-home.jsp">Back to Home</a>
    <h1>Your Listed Products</h1>
    <div></div>
</div>
<div class="product-grid">
    <c:forEach var="product" items="${products}">
        <div class="product-card">
            <img src="${product.firstImageUrl}" alt="${product.pname}" class="product-image">
            <div class="product-info">
                <div class="product-name">
                    <a href="productDetails?id=${product.id}">${product.pname}</a>
                </div>
                <div class="product-category">${product.categoryName}</div>
                <div class="product-price">$${product.price}</div>
                <div class="product-description">${product.description}</div>
                <div class="product-quantity">In stock: ${product.quantity}</div>
                <div class="product-actions">
                    <a href="updateProduct?id=${product.id}" class="update-link">Update</a>
                    <a href="deleteProduct?id=${product.id}" class="delete-link"
                       onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>
