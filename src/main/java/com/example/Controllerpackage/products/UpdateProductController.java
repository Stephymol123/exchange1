package com.example.Controllerpackage.products;

import com.example.Beanpackage.CategoryBeanCls;
import com.example.Daopackage.ProductDAO;
import com.example.Daopackage.CategoryDAO;
import com.example.Beanpackage.ProductBeanCls;
import com.example.utils.CloudinaryConfig;
import com.example.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/updateProduct")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DatabaseConnection.connect()) {
            ProductDAO productDAO = new ProductDAO();
            int productId = Integer.parseInt(request.getParameter("id"));
            ProductBeanCls product = productDAO.getProductById(connection, productId);
            List<CategoryBeanCls> categories = productDAO.getAllCategories(connection); // Fetch all categories

            if (product != null) {
                request.setAttribute("product", product);
                request.setAttribute("categories", categories); // Pass categories to JSP
                request.getRequestDispatcher("update-product.jsp").forward(request, response);
            } else {
                response.sendRedirect("userItems");
            }
        } catch (SQLException e) {
            throw new ServletException("Error accessing the database", e);
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String pname = request.getParameter("pname");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductBeanCls product = new ProductBeanCls();
        product.setId(productId);
        product.setUser_id(userId);
        product.setCategory_id(categoryId);
        product.setPname(pname);
        product.setPrice(price);
        product.setDescription(description);
        product.setQuantity(quantity);

        // Get existing images from the product
        String existingImages = request.getParameter("existingImages");

        // Handle new image uploads
        List<String> imageUrls = new ArrayList<>();
        if (existingImages != null && !existingImages.isEmpty()) {
            imageUrls.add(existingImages);
        }

        for (Part part : request.getParts()) {
            if (part.getName().equals("newImage") && part.getSize() > 0) {
                byte[] imageBytes = convertInputStreamToByteArray(part.getInputStream());
                try {
                    String imageUrl = CloudinaryConfig.uploadImage(imageBytes, part.getSubmittedFileName());
                    imageUrls.add(imageUrl);
                } catch (Exception e) {
                    throw new ServletException("Error uploading image to Cloudinary", e);
                }
            }
        }

        // Combine existing images with new images
        String combinedImages = String.join(",", imageUrls);
        product.setPimages(combinedImages);

        // Obtain connection and update product
        try (Connection connection = DatabaseConnection.connect()) {
            ProductDAO productDAO = new ProductDAO();
            productDAO.updateProduct(connection, product);
            response.sendRedirect("userItems"); // Redirect to the page showing user's items
        } catch (SQLException e) {
            throw new ServletException("Error updating product", e);
        }
    }

    private byte[] convertInputStreamToByteArray(InputStream inputStream) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        int nRead;
        byte[] data = new byte[16384];
        while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }
        buffer.flush();
        return buffer.toByteArray();
    }
}
