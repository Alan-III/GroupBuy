/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.beans;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MITSOS GLA
 */
public class Offer {
    
    private float finalprice;
    private float couponPrice;
    private String title;
    private float discount;
    private int groupSize;
    private int id;
    private String details;
    private String offerExpire;
    private String couponExpire;
    private String path;
    private int participants;
    private String businessMail;
    private String status;
    private List<Product> productsList;

    public Offer() {
        this.productsList=new ArrayList<Product>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParticipants() {
        return participants;
    }

    public void setParticipants(int participants) {
        this.participants = participants;
    }
    public void addParticipants(int participants) {
        this.participants += participants;
    }

    public List<Product> getProductsList() {
        return productsList;
    }

    public void setProductsList(List<Product> productsList) {
        this.productsList = productsList;
    }
    public void addProductInList(Product product) {
        this.productsList.add(product);
    }

    public String getBusinessMail() {
        return businessMail;
    }

    public void setBusinessMail(String businessMail) {
        this.businessMail = businessMail;
    }
    

    public float getFinalprice() {
        return finalprice;
    }

    public void setFinalprice(float finalprice) {
        this.finalprice = finalprice;
    }

    public float getCouponPrice() {
        return couponPrice;
    }

    public void setCouponPrice(float couponPrice) {
        this.couponPrice = couponPrice;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public int getGroupSize() {
        return groupSize;
    }

    public void setGroupSize(int groupSize) {
        this.groupSize = groupSize;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getOfferExpire() {
        return offerExpire;
    }

    public void setOfferExpire(String offerExpire) {
        this.offerExpire = offerExpire;
    }

    public String getCouponExpire() {
        return couponExpire;
    }

    public void setCouponExpire(String couponExpire) {
        this.couponExpire = couponExpire;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
