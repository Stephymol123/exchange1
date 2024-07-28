package com.example.Daopackage;

import com.example.Beanpackage.OfferMessageBean;
import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OfferMessageDAO {

    public void createOfferMessage(OfferMessageBean message) throws SQLException {
        String sql = "INSERT INTO offer_messages (exchange_id, sender_id, receiver_id, message, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, message.getExchangeId());
            statement.setInt(2, message.getSenderId());
            statement.setInt(3, message.getReceiverId());
            statement.setString(4, message.getMessage());
            statement.executeUpdate();
        }
    }

    public List<OfferMessageBean> getOfferMessagesByExchangeId(int exchangeId) throws SQLException {
        List<OfferMessageBean> messages = new ArrayList<>();
        String sql = "SELECT * FROM offer_messages WHERE exchange_id = ? ORDER BY created_at ASC";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, exchangeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    OfferMessageBean message = new OfferMessageBean();
                    message.setId(resultSet.getInt("id"));
                    message.setExchangeId(resultSet.getInt("exchange_id"));
                    message.setSenderId(resultSet.getInt("sender_id"));
                    message.setReceiverId(resultSet.getInt("receiver_id"));
                    message.setMessage(resultSet.getString("message"));
                    message.setCreatedAt(resultSet.getTimestamp("created_at"));
                    messages.add(message);
                }
            }
        }
        return messages;
    }
}

