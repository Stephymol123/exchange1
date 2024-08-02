package com.example.Beanpackage;


import java.sql.Timestamp;

public class ExchangeBean {
    private int id;
    private int productId;
    private int interestedUserId;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String productName;
    private String interestedUserName;
    private String ownerUserName;




    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getInterestedUserId() {
        return interestedUserId;
    }

    public void setInterestedUserId(int interestedUserId) {
        this.interestedUserId = interestedUserId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    public String getInterestedUserName() {
        return interestedUserName;
    }

    public void setInterestedUserName(String interestedUserName) {
        this.interestedUserName = interestedUserName;
    }
    public String getOwnerUserName() {
        return ownerUserName;
    }

    public void setOwnerUserName(String ownerUserName) {
        this.ownerUserName = ownerUserName;
    }

    public void setOwnerUserId(String ownerUserId) {

    }
}

