package com.example.Controllerpackage.auth;

import com.example.Daopackage.Daocls;
import com.example.Beanpackage.Beancls;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/user-login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Daocls userDao;
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new Daocls();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Beancls beancls = userDao.validateUser(username, password);

            if (beancls != null) {
                // If user is validated, set user attribute and forward to index.jsp or any other page
                request.getSession().setAttribute("user", beancls); // Store user in session

                // Log the username and user_id
                logger.log(Level.INFO, "User logged in: {0}, user_id: {1}", new Object[]{beancls.getUsername(), beancls.getId()});

                response.sendRedirect("user-home.jsp"); // Redirect to index.jsp after successful login
            } else {
                // If validation fails, set error message attribute and forward to login.jsp
                request.setAttribute("message", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error validating user", e);
            throw new ServletException("Error validating user", e);
        }
    }
}
