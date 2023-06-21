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
public class OrderDetails {
    private int id;
    private String accountEmail;
    //private double amount;  //change to subtotal, tax etc
    private String details;
    private String date;
    private String type;
    private String status;
    private Offer offer;
    
    //paypal
    private float shipping;
    private float tax;
    private float subtotal;
    private float total;
    private String paypalPaymentId;
    private String paypalSaleId;
    
    
    public OrderDetails(){
    }

    public String getTax() {
        return String.format("%.2f",tax);
    }

    public void setTax(float tax) {
        this.tax = tax;
    }

    public String getSubtotal() {
        return String.format("%.2f",subtotal);
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    public String getTotal() {
        return String.format("%.2f",total);
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getShipping() {
        return String.format("%.2f",shipping);
    }

    public void setShipping(float shipping) {
        this.shipping = shipping;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccountEmail() {
        return accountEmail;
    }

    public void setAccountEmail(String accountEmail) {
        this.accountEmail = accountEmail;
    }

//    public double getAmount() {
//        return amount;
//    }
//
//    public void setAmount(double amount) {
//        this.amount = amount;
//    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Offer getOffer() {
        return offer;
    }

    public void setOffer(Offer offer) {
        this.offer = offer;
    }

    public String getPaypalPaymentId() {
        return paypalPaymentId;
    }

    public void setPaypalPaymentId(String paypalPaymentId) {
        this.paypalPaymentId = paypalPaymentId;
    }

    public String getPaypalSaleId() {
        return paypalSaleId;
    }

    public void setPaypalSaleId(String paypalSaleId) {
        this.paypalSaleId = paypalSaleId;
    }

}
