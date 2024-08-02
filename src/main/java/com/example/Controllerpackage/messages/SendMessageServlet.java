package com.example.Controllerpackage.messages;

import com.example.Beanpackage.ExchangeBean;
import com.example.Beanpackage.OfferMessageBean;
import com.example.Daopackage.ExchangeDAO;
import com.example.Beanpackage.Beancls;
import com.example.Daopackage.OfferMessageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {

    private OfferMessageDAO offerMessageDAO;
    private ExchangeDAO exchangeDAO;

    @Override
    public void init() throws ServletException {
        offerMessageDAO = new OfferMessageDAO();
        exchangeDAO = new ExchangeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Beancls user = (Beancls) session.getAttribute("user");
        int senderId = user.getId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
        String messageText = request.getParameter("message");

        try {
            // Step 1: Create a new exchange
            ExchangeBean exchange = new ExchangeBean();
            exchange.setProductId(productId);
            exchange.setInterestedUserId(senderId);
            exchange.setStatus("pending");
            int exchangeId = exchangeDAO.createExchange(exchange);

            // Step 2: Create a new message with the exchange ID
            OfferMessageBean message = new OfferMessageBean();
            message.setExchangeId(exchangeId);
            message.setSenderId(senderId);
            message.setReceiverId(receiverId);
            message.setMessage(messageText);
            offerMessageDAO.createOfferMessage(message);

            // Redirect to the conversation page
            response.sendRedirect("fetchConversations?exchangeId=" + exchangeId);
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
