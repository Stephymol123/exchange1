package com.example.Controllerpackage.products;


import com.example.Daopackage.ProductDAO;
import com.example.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/deleteProduct")
public class DeleteProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the product ID from the request
        int productId = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DatabaseConnection.connect()) {
            ProductDAO productDAO = new ProductDAO();

            // Delete the product using the ProductDAO
            boolean success = productDAO.deleteProductById(connection, productId);

            if (success) {
                // Redirect to a success page or back to the product list
                response.sendRedirect("userItems?success=true");
            } else {
                // Handle the error, maybe the product was not found
                response.sendRedirect("userItems?error=notfound");
            }

        } catch (SQLException e) {
            throw new ServletException("Error deleting product", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirecting POST request to doPost method for handling
        doPost(request, response);
    }
}
