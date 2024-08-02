<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category Prediction</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.4;
            color: #333;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 4px;
            font-weight: bold;
            text-align: left;
        }
        select {
            width: 100%;
            padding: 6px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            font-size: 14px;
        }
        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            padding: 8px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            width: 100%;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        h3 {
            margin-top: 10px;
            text-align: center;
            color: #2c3e50;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<h2>Predict Category</h2>

<form action="predictCategory" method="post">
    <label for="brand">Brand:</label>
    <select id="brand" name="brand">
        <option value="None" <%= request.getParameter("brand") == null || "None".equals(request.getParameter("brand")) ? "selected" : "" %>>None</option>
        <option value="Lenovo" <%= "Lenovo".equals(request.getParameter("brand")) ? "selected" : "" %>>Lenovo</option>
        <option value="Samsung" <%= "Samsung".equals(request.getParameter("brand")) ? "selected" : "" %>>Samsung</option>
        <option value="Apple" <%= "Apple".equals(request.getParameter("brand")) ? "selected" : "" %>>Apple</option>
        <option value="Microsoft" <%= "Microsoft".equals(request.getParameter("brand")) ? "selected" : "" %>>Microsoft</option>
        <option value="Zara" <%= "Zara".equals(request.getParameter("brand")) ? "selected" : "" %>>Zara</option>
        <option value="IKEA" <%= "IKEA".equals(request.getParameter("brand")) ? "selected" : "" %>>IKEA</option>
        <option value="Toshiba" <%= "Toshiba".equals(request.getParameter("brand")) ? "selected" : "" %>>Toshiba</option>
        <option value="Bose" <%= "Bose".equals(request.getParameter("brand")) ? "selected" : "" %>>Bose</option>
        <option value="Google" <%= "Google".equals(request.getParameter("brand")) ? "selected" : "" %>>Google</option>
        <option value="Acer" <%= "Acer".equals(request.getParameter("brand")) ? "selected" : "" %>>Acer</option>
        <option value="Panasonic" <%= "Panasonic".equals(request.getParameter("brand")) ? "selected" : "" %>>Panasonic</option>
        <option value="Crayola" <%= "Crayola".equals(request.getParameter("brand")) ? "selected" : "" %>>Crayola</option>
        <option value="Puma" <%= "Puma".equals(request.getParameter("brand")) ? "selected" : "" %>>Puma</option>
        <option value="Bosch" <%= "Bosch".equals(request.getParameter("brand")) ? "selected" : "" %>>Bosch</option>
        <option value="Reebok" <%= "Reebok".equals(request.getParameter("brand")) ? "selected" : "" %>>Reebok</option>
    </select>

    <label for="model">Model:</label>
    <select id="model" name="model">
        <option value="None" <%= request.getParameter("model") == null || "None".equals(request.getParameter("model")) ? "selected" : "" %>>None</option>
        <option value="Pixel_6_Pro" <%= "Pixel_6_Pro".equals(request.getParameter("model")) ? "selected" : "" %>>Pixel 6 Pro</option>
        <option value="XPS_13" <%= "XPS_13".equals(request.getParameter("model")) ? "selected" : "" %>>XPS 13</option>
        <option value="15_Pro" <%= "15_Pro".equals(request.getParameter("model")) ? "selected" : "" %>>15 Pro</option>
        <option value="Surface_Pro_8" <%= "Surface_Pro_8".equals(request.getParameter("model")) ? "selected" : "" %>>Surface Pro 8</option>
        <option value="QuietComfort_45" <%= "QuietComfort_45".equals(request.getParameter("model")) ? "selected" : "" %>>QuietComfort 45</option>
        <option value="Chromebook_Flip" <%= "Chromebook_Flip".equals(request.getParameter("model")) ? "selected" : "" %>>Chromebook Flip</option>
        <option value="ThinkPad_X1" <%= "ThinkPad_X1".equals(request.getParameter("model")) ? "selected" : "" %>>ThinkPad X1</option>
        <option value="Nitro_5" <%= "Nitro_5".equals(request.getParameter("model")) ? "selected" : "" %>>Nitro 5</option>
        <option value="InstaView" <%= "InstaView".equals(request.getParameter("model")) ? "selected" : "" %>>InstaView</option>
    </select>

    <label for="type">Type:</label>
    <select id="type" name="type">
        <option value="None" <%= request.getParameter("type") == null || "None".equals(request.getParameter("type")) ? "selected" : "" %>>None</option>
        <option value="Sofa" <%= "Sofa".equals(request.getParameter("type")) ? "selected" : "" %>>Sofa</option>
        <option value="Desktop" <%= "Desktop".equals(request.getParameter("type")) ? "selected" : "" %>>Desktop</option>
        <option value="Tablet" <%= "Tablet".equals(request.getParameter("type")) ? "selected" : "" %>>Tablet</option>
        <option value="Chair" <%= "Chair".equals(request.getParameter("type")) ? "selected" : "" %>>Chair</option>
        <option value="Skirt" <%= "Skirt".equals(request.getParameter("type")) ? "selected" : "" %>>Skirt</option>
        <option value="Desk" <%= "Desk".equals(request.getParameter("type")) ? "selected" : "" %>>Desk</option>
        <option value="Jacket" <%= "Jacket".equals(request.getParameter("type")) ? "selected" : "" %>>Jacket</option>
        <option value="Phone" <%= "Phone".equals(request.getParameter("type")) ? "selected" : "" %>>Phone</option>
        <option value="Dishwasher" <%= "Dishwasher".equals(request.getParameter("type")) ? "selected" : "" %>>Dishwasher</option>
        <option value="Refrigerator" <%= "Refrigerator".equals(request.getParameter("type")) ? "selected" : "" %>>Refrigerator</option>
        <option value="Smartwatch" <%= "Smartwatch".equals(request.getParameter("type")) ? "selected" : "" %>>Smartwatch</option>
        <option value="Speaker" <%= "Speaker".equals(request.getParameter("type")) ? "selected" : "" %>>Speaker</option>
        <option value="Microwave" <%= "Microwave".equals(request.getParameter("type")) ? "selected" : "" %>>Microwave</option>
    </select>

    <label for="colour">Colour:</label>
    <select id="colour" name="colour">
        <option value="None" <%= request.getParameter("colour") == null || "None".equals(request.getParameter("colour")) ? "selected" : "" %>>None</option>
        <option value="Green" <%= "Green".equals(request.getParameter("colour")) ? "selected" : "" %>>Green</option>
        <option value="Purple" <%= "Purple".equals(request.getParameter("colour")) ? "selected" : "" %>>Purple</option>
        <option value="White" <%= "White".equals(request.getParameter("colour")) ? "selected" : "" %>>White</option>
        <option value="Orange" <%= "Orange".equals(request.getParameter("colour")) ? "selected" : "" %>>Orange</option>
        <option value="Black" <%= "Black".equals(request.getParameter("colour")) ? "selected" : "" %>>Black</option>
        <option value="Magenta" <%= "Magenta".equals(request.getParameter("colour")) ? "selected" : "" %>>Magenta</option>
        <option value="Teal" <%= "Teal".equals(request.getParameter("colour")) ? "selected" : "" %>>Teal</option>
        <option value="Coral" <%= "Coral".equals(request.getParameter("colour")) ? "selected" : "" %>>Coral</option>
        <option value="Bronze" <%= "Bronze".equals(request.getParameter("colour")) ? "selected" : "" %>>Bronze</option>
    </select>

    <label for="ram">RAM:</label>
    <select id="ram" name="ram">
        <option value="None" <%= request.getParameter("ram") == null || "None".equals(request.getParameter("ram")) ? "selected" : "" %>>None</option>
        <option value="4GB" <%= "4GB".equals(request.getParameter("ram")) ? "selected" : "" %>>4GB</option>
        <option value="12GB" <%= "12GB".equals(request.getParameter("ram")) ? "selected" : "" %>>12GB</option>
        <option value="128GB" <%= "128GB".equals(request.getParameter("ram")) ? "selected" : "" %>>128GB</option>
        <option value="24GB" <%= "24GB".equals(request.getParameter("ram")) ? "selected" : "" %>>24GB</option>
    </select>

    <label for="size">Size:</label>
    <select id="size" name="size">
        <option value="None" <%= request.getParameter("size") == null || "None".equals(request.getParameter("size")) ? "selected" : "" %>>None</option>
        <option value="XS" <%= "XS".equals(request.getParameter("size")) ? "selected" : "" %>>XS</option>
        <option value="S" <%= "S".equals(request.getParameter("size")) ? "selected" : "" %>>S</option>
        <option value="M" <%= "M".equals(request.getParameter("size")) ? "selected" : "" %>>M</option>
        <option value="XXL" <%= "XXL".equals(request.getParameter("size")) ? "selected" : "" %>>XXL</option>
    </select>

    <input type="submit" value="Predict">
</form>

<%
    String predictedCategory = (String) request.getAttribute("predictedCategory");
    if (predictedCategory != null) {
        out.println("<h3>Predicted Category: " + predictedCategory + "</h3>");
    }
%>

</body>
</html>
