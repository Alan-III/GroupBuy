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
 * @author USER
 */
public class Product {

    private int id;
    private String code;
    private String name;
    private String details;
    private int categoryID;
    private float price;
    private List<String> imagePaths;
    private boolean isWished;
    private int wishesCount;

    public Product() {
        this.imagePaths = new ArrayList<String>();
        isWished = false;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getWishesCount() {
        return wishesCount;
    }

    public void setWishesCount(int wishesCount) {
        this.wishesCount = wishesCount;
    }

    public boolean isWished() {
        return isWished;
    }

    public void setIsWished(boolean isWished) {
        this.isWished = isWished;
    }
    public void toggleIsWished() {
        this.isWished = (! this.isWished);
    }
    
    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public List<String> getImagePaths() {
        return imagePaths;
    }
    public String getFirstImagePath() {
        if (imagePaths != null && !imagePaths.isEmpty()) {
        return imagePaths.get(0);
    }
    return null; // Return null if the imagePath is empty or null
    }

    public void setImagePaths(List<String> imagePath) {
        this.imagePaths = imagePath;
    }
    public void addImagePath(String imagePath) {
        this.imagePaths.add(imagePath);
    }
    


    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }    
}
