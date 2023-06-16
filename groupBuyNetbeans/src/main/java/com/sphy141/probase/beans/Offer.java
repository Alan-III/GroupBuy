/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.beans;

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
    private String imagePath;

    public Offer() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
}
