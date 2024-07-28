package com.example.Daopackage;


import com.example.Beanpackage.ExchangeBean;
import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExchangeDAO {

    public int createExchange(ExchangeBean exchange) throws SQLException {
        String sql = "INSERT INTO exchanges (product_id, interested_user_id, status, created_at, updated_at) VALUES (?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, exchange.getItemId());
            statement.setInt(2, exchange.getInterestedUserId());
            statement.setString(3, exchange.getStatus());
            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating exchange failed, no rows affected.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating exchange failed, no ID obtained.");
                }
            }
        }
    }

    public String getExchangeStatus(int exchangeId) throws SQLException {
        String sql = "SELECT status FROM exchanges WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, exchangeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("status");
                }
            }
        }
        return null;
    }

    public void updateExchangeStatus(int exchangeId, String status) throws SQLException {
        String sql = "UPDATE exchanges SET status = ?, updated_at = ? WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            statement.setInt(3, exchangeId);

            statement.executeUpdate();
        }
    }

    public List<ExchangeBean> getExchangesByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM exchanges WHERE interested_user_id = ? OR EXISTS (SELECT 1 FROM products WHERE id = exchanges.product_id AND user_id = ?)";
        List<ExchangeBean> exchanges = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, userId);
            statement.setInt(2, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ExchangeBean exchange = new ExchangeBean();
                    exchange.setId(resultSet.getInt("id"));
                    exchange.setItemId(resultSet.getInt("product_id"));
                    exchange.setInterestedUserId(resultSet.getInt("interested_user_id"));
                    exchange.setStatus(resultSet.getString("status"));
                    exchange.setCreatedAt(Timestamp.valueOf(resultSet.getString("created_at")));
                    exchange.setUpdatedAt(Timestamp.valueOf(resultSet.getString("updated_at")));
                    exchanges.add(exchange);
                }
            }
        }
        return exchanges;
    }
}

