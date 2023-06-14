/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sphy141.probase.beans.Product;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/filterproductlist"})
public class FilterProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Connection conn = MyUtils.getStoredConnection(req);
        
        //Get the filters cheched in a map from JSON
        String checkedValuesJson = req.getParameter("checkedValues");
        ObjectMapper objectMapper = new ObjectMapper();
        Map<Integer, List<String>> checkedValues = objectMapper.readValue(checkedValuesJson, new TypeReference<Map<Integer, List<String>>>() {
        });

        // Build the WHERE querry from the checkedValues map
        String searchQuerry = "";
        for (Map.Entry<Integer, List<String>> entry : checkedValues.entrySet()) {
            Integer filterID = entry.getKey();
            List<String> checkedOptions = entry.getValue();

            searchQuerry +="(filtersId = "+filterID+" AND filtervalue IN ("+checkedOptions+")) OR ";
        }
        searchQuerry = searchQuerry.replace("[", "'").replace("]", "'").replace(", ", "','");
        searchQuerry = searchQuerry.substring(0, searchQuerry.length() - 3);
        System.out.println(searchQuerry);
        
        //Filter Products
        //Get products ALL or Searched
        List<Product> productList = null;
        String errorString = null;
        try {
            //            if(searchParam==null || searchParam.length()==0)
//                productList = DBUtils.queryProduct(conn);
//            else
            productList = DBUtils.filterSearchProduct(conn, searchQuerry);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        if(productList==null){
            errorString = "There was a problem with products";
        }
        for (Product product : productList) {
            System.out.println(product.getName());
        }
        
       // Convert productList to JSON
        ObjectMapper om = new ObjectMapper();
        String productListJson = om.writeValueAsString(productList);
System.out.println(productListJson);

        // Set the response content type
        resp.setContentType("application/json");

        // Write the JSON response
        resp.getWriter().write(productListJson);
    }
}
