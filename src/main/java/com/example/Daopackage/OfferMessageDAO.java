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
        String sql = "SELECT om.id, om.exchange_id, om.sender_id, om.message, om.created_at, " +
                "u.username AS sender_username " +
                "FROM offer_messages om " +
                "JOIN users u ON om.sender_id = u.id " +
                "WHERE om.exchange_id = ? " +
                "ORDER BY om.created_at";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, exchangeId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OfferMessageBean message = new OfferMessageBean();
                message.setId(resultSet.getInt("id"));
                message.setExchangeId(resultSet.getInt("exchange_id"));
                message.setSenderId(resultSet.getInt("sender_id"));
                message.setMessage(resultSet.getString("message"));
                message.setCreatedAt(resultSet.getTimestamp("created_at"));
                message.setSenderUsername(resultSet.getString("sender_username"));
                messages.add(message);
            }
        }

        return messages;
    }
    public String getOwnerUserNameByExchangeId(int exchangeId) throws SQLException {
        String sql = "SELECT u.username FROM exchanges e " +
                "JOIN products p ON e.product_id = p.id " +
                "JOIN users u ON p.user_id = u.id " +
                "WHERE e.id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, exchangeId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("username");
            }
        }
        return "";
    }
    public String getProductNameByExchangeId(int exchangeId) throws SQLException {
        String sql = "SELECT p.pname FROM exchanges e " +
                "JOIN products p ON e.product_id = p.id " +
                "WHERE e.id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, exchangeId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("pname");
            }
        }
        return "";
    }
}

