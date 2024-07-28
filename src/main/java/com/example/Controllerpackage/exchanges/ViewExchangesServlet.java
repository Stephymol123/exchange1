package com.example.Controllerpackage.exchanges;

import com.example.Beanpackage.Beancls;
import com.example.Beanpackage.ExchangeBean;
import com.example.Daopackage.ExchangeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/viewExchanges")
public class ViewExchangesServlet extends HttpServlet {

    private ExchangeDAO exchangeDAO;

    @Override
    public void init() throws ServletException {
        exchangeDAO = new ExchangeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Beancls user = (Beancls) session.getAttribute("user");
        int userId = user.getId();

        try {
            List<ExchangeBean> exchanges = exchangeDAO.getExchangesByUserId(userId);
            request.setAttribute("exchanges", exchanges);
            request.getRequestDispatcher("/view-exchanges.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}

