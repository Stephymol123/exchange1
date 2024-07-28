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
import java.util.List;

@WebServlet("/fetchConversations")
public class FetchConversationsServlet extends HttpServlet {

    private OfferMessageDAO offerMessageDAO;

    @Override
    public void init() throws ServletException {
        offerMessageDAO = new OfferMessageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int exchangeId = Integer.parseInt(request.getParameter("exchangeId"));

        try {
            List<OfferMessageBean> messages = offerMessageDAO.getOfferMessagesByExchangeId(exchangeId);
            request.setAttribute("messages", messages);
            request.setAttribute("exchangeId", exchangeId);
            request.setAttribute("receiverId", getReceiverId(messages, session));
            request.getRequestDispatcher("/conversation.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }

    private int getReceiverId(List<OfferMessageBean> messages, HttpSession session) {
        Beancls user = (Beancls) session.getAttribute("user");
        int userId = user.getId();

        for (OfferMessageBean message : messages) {
            if (message.getSenderId() != userId) {
                return message.getSenderId();
            }
        }
        return 0;
    }
}
