package com.example.Controllerpackage.products;

import com.example.Daopackage.ProductDAO;
import com.example.Beanpackage.ProductBeanCls;
import com.example.Beanpackage.CategoryBeanCls;
import com.example.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/allProducts")
public class AllProductsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryIdParam = request.getParameter("category");

        try (Connection connection = DatabaseConnection.connect()) {
            ProductDAO productDAO = new ProductDAO();
            List<ProductBeanCls> products;
            List<CategoryBeanCls> categories = productDAO.getAllCategories(connection);

            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                int categoryId = Integer.parseInt(categoryIdParam);
                products = productDAO.getProductsByCategory(connection, categoryId);
            } else {
                products = productDAO.getAllProducts(connection);
            }

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("selectedCategory", categoryIdParam);
            request.getRequestDispatcher("all-products.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error retrieving products", e);
        }
    }
}
