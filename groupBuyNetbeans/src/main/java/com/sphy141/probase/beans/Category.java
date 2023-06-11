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
public class Category {
    private int categoryID;
    private String categoryName;
    private String genCategory;
    private String midCategory;
    private String subCategory;
    private String categoryImagePath;

    public String getGenCategory() {
        return genCategory;
    }

    public void setGenCategory(String genCategory) {
        this.genCategory = genCategory;
    }

    public String getMidCategory() {
        return midCategory;
    }

    public void setMidCategory(String midCategory) {
        this.midCategory = midCategory;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryImagePath() {
        return categoryImagePath;
    }

    public void setCategoryImagePath(String categoryImagePath) {
        this.categoryImagePath = categoryImagePath;
    }
}
