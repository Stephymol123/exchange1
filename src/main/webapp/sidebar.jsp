<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sidebar Example</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #333;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar a {
            display: block;
            color: #f2f2f2;
            padding: 15px;
            text-decoration: none;
            font-size: 18px;
        }
        .sidebar a:hover {
            background-color: #575757;
            color: #ffffff;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            flex: 1;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: #007bff;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2 style="text-align: center;">Mary's Exchange</h2>
    <a href="addProduct">Add Item</a>
    <a href="update-product.jsp">Update Item</a>
    <a href="user-item.jsp">My Items</a>
    <a href="profile.jsp">Profile</a>
</div>


</body>
</html>
