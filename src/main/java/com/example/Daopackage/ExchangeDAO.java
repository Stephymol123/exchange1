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

            statement.setInt(1, exchange.getProductId());
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

    public List<ExchangeBean> getExchangesByUserId(int userId) throws SQLException {
        List<ExchangeBean> exchanges = new ArrayList<>();
        String sql = "SELECT e.*, p.pname as product_name, i.username as interested_user_name, o.username as owner_user_name, o.id as owner_user_id " +
                "FROM exchanges e " +
                "JOIN products p ON e.product_id = p.id " +
                "JOIN users i ON e.interested_user_id = i.id " +
                "JOIN users o ON p.user_id = o.id " + // This retrieves the owner's username and ID
                "WHERE e.interested_user_id = ? OR p.user_id = ?";
        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ExchangeBean exchange = new ExchangeBean();
                exchange.setId(rs.getInt("id"));
                exchange.setProductId(rs.getInt("product_id"));
                exchange.setProductName(rs.getString("product_name"));
                exchange.setInterestedUserId(rs.getInt("interested_user_id"));
                exchange.setInterestedUserName(rs.getString("interested_user_name"));
                exchange.setOwnerUserId(String.valueOf(rs.getInt("owner_user_id")));
                exchange.setOwnerUserName(rs.getString("owner_user_name"));
                exchange.setStatus(rs.getString("status"));
                exchange.setCreatedAt(rs.getTimestamp("created_at"));
                exchanges.add(exchange);
            }
        }
        return exchanges;
    }




    public List<ExchangeBean> getExchangesByInterestedUserIdAndStatus(int interestedUserId, String status) throws SQLException {
        List<ExchangeBean> exchanges = new ArrayList<>();
        String sql = "SELECT e.id, e.product_id, e.interested_user_id, e.status, e.created_at, e.updated_at, " +
                "p.pname AS product_name, " +
                "iu.username AS interested_user_name, " +
                "ou.username AS owner_user_name " +
                "FROM exchanges e " +
                "JOIN products p ON e.product_id = p.id " +
                "JOIN users iu ON e.interested_user_id = iu.id " +
                "JOIN users ou ON p.user_id = ou.id " +
                "WHERE e.interested_user_id = ? AND e.status = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, interestedUserId);
            preparedStatement.setString(2, status);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ExchangeBean exchange = new ExchangeBean();
                exchange.setId(resultSet.getInt("id"));
                exchange.setProductId(resultSet.getInt("product_id"));
                exchange.setInterestedUserId(resultSet.getInt("interested_user_id"));
                exchange.setStatus(resultSet.getString("status"));
                exchange.setProductName(resultSet.getString("product_name"));
                exchange.setCreatedAt(resultSet.getTimestamp("created_at"));
                exchange.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                exchange.setInterestedUserName(resultSet.getString("interested_user_name"));
                exchange.setOwnerUserName(resultSet.getString("owner_user_name"));
                exchanges.add(exchange);
            }
        }

        return exchanges;
    }

    public int getProductOwnerId(int exchangeId) throws SQLException {
        String sql = "SELECT p.user_id FROM exchanges e " +
                "JOIN products p ON e.product_id = p.id " +
                "WHERE e.id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, exchangeId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("user_id");
            }
        }
        return 0;
    }

    public void updateExchangeStatus(int exchangeId, String status) throws SQLException {
        String sql = "UPDATE exchanges SET status = ? WHERE id = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, exchangeId);
            preparedStatement.executeUpdate();
        }
    }
}

