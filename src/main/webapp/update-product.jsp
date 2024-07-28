<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
            color: var(--text-color);
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group label {
            font-weight: 600;
            color: var(--primary-color);
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 8px;
            font-size: 1rem;
        }
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(20, 57, 125, 0.25);
        }
        .btn-custom {
            padding: 12px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #0f2c99;
            border-color: #0f2c99;
        }
        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            color: var(--primary-color);
        }
        .btn-secondary:hover {
            background-color: #b9d7e0;
            border-color: #b9d7e0;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Update Product Details</h1>
    <form action="updateProduct" method="post">
        <input type="hidden" name="id" value="${product.id}">
        <input type="hidden" name="user_id" value="${product.user_id}">
        <div class="form-group">
            <label for="category_id">Category ID:</label>
            <input type="text" id="category_id" name="category_id" class="form-control" value="${product.category_id}" required>
        </div>
        <div class="form-group">
            <label for="pname">Product Name:</label>
            <input type="text" id="pname" name="pname" class="form-control" value="${product.pname}" required>
        </div>
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="text" id="price" name="price" class="form-control" value="${product.price}" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" class="form-control" rows="4" required>${product.description}</textarea>
        </div>
        <div class="form-group">
            <label for="quantity">Quantity:</label>
            <input type="text" id="quantity" name="quantity" class="form-control" value="${product.quantity}" required>
        </div>
        <div class="form-group">
            <label for="pimages">Image URL:</label>
            <input type="text" id="pimages" name="pimages" class="form-control" value="${product.pimages}" required>
        </div>
        <div class="form-group text-center">
            <button style="color: #3498db" type="submit" class="btn btn-custom btn-primary">Update</button>
        </div>
        <div class="back-link">
            <a href="product-details.jsp" style="color: #3498db" class="btn btn-secondary">Back</a>
        </div>
    </form>
</div>
</body>
</html>
