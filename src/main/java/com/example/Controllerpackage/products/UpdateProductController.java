package com.example.Controllerpackage.products;

import com.example.Daopackage.ProductDAO;
import com.example.Beanpackage.ProductBeanCls;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/updateProduct")
public class UpdateProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String pname = request.getParameter("pname");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String pimages = request.getParameter("pimages");

        ProductBeanCls product = new ProductBeanCls();
        product.setId(productId);
        product.setUser_id(userId);
        product.setCategory_id(categoryId);
        product.setPname(pname);
        product.setPrice(price);
        product.setDescription(description);
        product.setQuantity(quantity);
        product.setPimages(pimages);

        // Obtain connection
        Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
        ProductDAO productDAO = new ProductDAO();

        try {
            productDAO.updateProduct(connection, product);
            response.sendRedirect("userItems"); // Redirect to the page showing user's items
        } catch (SQLException e) {
            throw new ServletException("Error updating product", e);
        }
    }
}
