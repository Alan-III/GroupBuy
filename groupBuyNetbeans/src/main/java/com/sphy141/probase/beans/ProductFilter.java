/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.beans;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Alan
 */
public class ProductFilter {
    private int filterID;
    private String filterName;
    private String filterValue;
    private Map<String, Integer> existingFilterValues;
    private int repetitionOfSameValueCount;

    public ProductFilter() {
        this.existingFilterValues = new HashMap<>();
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

    public Map<String, Integer> getExistingFilterValues() {
        return existingFilterValues;
    }

    public void setExistingFilterValues(Map<String, Integer> existingFilterValues) {
        this.existingFilterValues = existingFilterValues;
    }
    public void addExistingFilterValues(String valueName, int valueRepetitionCount) {
        this.existingFilterValues.put(valueName, valueRepetitionCount);
    }

    public int getRepetitionOfSameValueCount() {
        return repetitionOfSameValueCount;
    }

    public void setRepetitionOfSameValueCount(int repetitionOfSameValueCount) {
        this.repetitionOfSameValueCount = repetitionOfSameValueCount;
    }
    
}
