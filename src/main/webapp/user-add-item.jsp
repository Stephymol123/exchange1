<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
            color: #333;
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
            color: #007bff;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group label {
            font-weight: 600;
            color: #007bff;
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 8px;
            font-size: 1rem;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
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
            background-color: #007bff;
            border-color: #007bff;
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            color: #fff;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
        .alert-message {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Add Product Details</h1>
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-message" role="alert">
                ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-message" role="alert">
                ${error}
        </div>
    </c:if>
    <form action="addProduct" enctype="multipart/form-data" method="post">
        <div class="form-group">
            <label for="pname">Name:</label>
            <input type="text" id="pname" name="pname" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="price">Price (Rs):</label>
            <input type="number" id="price" name="price" step="0.01" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" class="form-control" required></textarea>
        </div>
        <div class="form-group">
            <label for="category_id">Category:</label>
            <select id="category_id" name="category_id" class="form-control" required>
                <option value="" disabled selected>Select Category</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.id}">${category.category}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="pimages">Browse files:</label>
            <input type="file" id="pimages" name="pimages" accept="image/*" multiple class="form-control-file" required />
        </div>
        <div class="form-group text-center">
            <input type="submit" style="color: #3498db" value="Add" class="btn btn-custom btn-primary" />
        </div>
        <div class="back-link">
            <a href="user-home.jsp" class="btn btn-secondary">Back</a>
        </div>
    </form>
</div>
</body>
</html>
