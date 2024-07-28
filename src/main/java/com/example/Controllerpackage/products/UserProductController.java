package com.example.Controllerpackage.products;

import com.example.Daopackage.ProductDAO;
import com.example.Beanpackage.ProductBeanCls;
import com.example.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/userItems")
public class UserProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            com.example.Beanpackage.Beancls user = (com.example.Beanpackage.Beancls) session.getAttribute("user");

            if (user != null) {
                int userId = user.getId(); // Retrieve user ID from Beancls object

                // Retrieve the database connection using the utility class
                try (Connection connection = DatabaseConnection.connect()) {
                    ProductDAO productDAO = new ProductDAO();
                    List<ProductBeanCls> products = productDAO.getProductsByUserId(connection, userId);
                    request.setAttribute("products", products);
                    request.getRequestDispatcher("/user-item.jsp").forward(request, response);
                } catch (SQLException e) {
                    throw new ServletException("Cannot obtain products from DB", e);
                }
            } else {
                // User object is null, redirect to login
                response.sendRedirect("login.jsp");
            }
        } else {
            // Session is null, redirect to login
            response.sendRedirect("login.jsp");
        }
    }
}
