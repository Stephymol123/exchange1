package com.example.Controllerpackage.messages;

import com.example.Beanpackage.OfferMessageBean;
import com.example.Daopackage.OfferMessageDAO;
import com.example.Beanpackage.Beancls;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/sendNewMessage")
public class SendNewMessageServlet extends HttpServlet {

    private OfferMessageDAO offerMessageDAO;

    @Override
    public void init() throws ServletException {
        offerMessageDAO = new OfferMessageDAO();
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
        int exchangeId = Integer.parseInt(request.getParameter("exchangeId"));
        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
        String messageText = request.getParameter("message");

        OfferMessageBean message = new OfferMessageBean();
        message.setExchangeId(exchangeId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessage(messageText);

        try {
            offerMessageDAO.createOfferMessage(message);
            response.sendRedirect("fetchConversations?exchangeId=" + exchangeId);
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}

