/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.beans;

/**
 *
 * @author Alan
 */
public class Notification {
    private int id;
    private String notificationTitle;
    private String details;
    private String productOrOfferName;
    private String date;
    
    // Constructor
    public Notification() {

    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNotificationTitle() {
        return notificationTitle;
    }
    
    public void setNotificationTitle(String notificationTitle) {
        this.notificationTitle = notificationTitle;
    }
    
    public String getDetails() {
        return details;
    }
    
    public void setDetails(String details) {
        this.details = details;
    }
    
    public String getProductOrOfferName() {
        return productOrOfferName;
    }
    
    public void setProductOrOfferName(String productOrOfferName) {
        this.productOrOfferName = productOrOfferName;
    }
    
    public String getDate() {
        return date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
}

