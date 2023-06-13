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
 * @author Alan
 */
public class ProductFilter {
    private int filterID;
    private String filterName;
    private String filterValue;
    private List<String> existingFilterValues;

    public ProductFilter() {
        this.existingFilterValues = new ArrayList<>();
    }

    public int getFilterID() {
        return filterID;
    }

    public void setFilterID(int filterID) {
        this.filterID = filterID;
    }

    public String getFilterName() {
        return filterName;
    }

    public void setFilterName(String filterName) {
        this.filterName = filterName;
    }

    public String getFilterValue() {
        return filterValue;
    }

    public void setFilterValue(String filterValue) {
        this.filterValue = filterValue;
    }

    public List<String> getExistingFilterValues() {
        return existingFilterValues;
    }

    public void setExistingFilterValues(List<String> existingFilterValues) {
        this.existingFilterValues = existingFilterValues;
    }
    public void addExistingFilterValues(String value) {
        this.existingFilterValues.add(value);
    }
    
}
