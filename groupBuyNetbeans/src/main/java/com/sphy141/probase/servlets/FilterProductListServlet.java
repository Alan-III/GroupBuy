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
import com.sphy141.probase.beans.UserAccount;
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
            resp.sendRedirect(req.getContextPath()+"/home");
            return;
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE START
        HttpSession session = req.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        Connection conn = MyUtils.getStoredConnection(req);
        String userMailstr = " ";
        String errorString = null;
        int notificationsCount = 0;

        if (user != null) {
            req.setAttribute("logineduser", user);
            userMailstr = user.getEmail();
            try {
                notificationsCount = DBUtils.countNotificationsNotReadBy(conn, user);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else {
            req.setAttribute("logineduser", null);
            
            if (business != null) {
                req.setAttribute("loginedbusiness", business);
                try {
                notificationsCount = DBUtils.countNotificationsNotReadBy(conn, business);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            } else {
                req.setAttribute("loginedbusiness", null);
            }
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END
        
        String searchQuerry = "";
        
        //Get the filters cheched
        String checkedValuesJson = req.getParameter("checkedValues");
        
        System.out.println(checkedValuesJson);
        // The checkedValues parameter is not empty
        if (!checkedValuesJson.equals("{}")) {
            //Get the filters checked in a map from JSON
            ObjectMapper objectMapper = new ObjectMapper();
            Map<Integer, List<String>> checkedValues = objectMapper.readValue(checkedValuesJson, new TypeReference<Map<Integer, List<String>>>() {
            });

            // Build the WHERE querry from the checkedValues map
            for (Map.Entry<Integer, List<String>> entry : checkedValues.entrySet()) {
                Integer filterID = entry.getKey();
                List<String> checkedOptions = entry.getValue();

                searchQuerry +="(filtersId = "+filterID+" AND filtervalue IN ("+checkedOptions+")) OR ";
            }
            // checkedOptions is in [Apple, Samsung] format
            // we need it to be in  'Apple','Samsung'
            searchQuerry = searchQuerry.replace("[", "'").replace("]", "'").replace(", ", "','");   
            searchQuerry = searchQuerry.substring(0, searchQuerry.length() - 3);
        }
        
        //Filter Products
        //Get products ALL or Searched
        List<Product> productList = null;
        try {
            if (!checkedValuesJson.equals("{}"))   //Filters applied
                productList = DBUtils.filterSearchProduct(conn, searchQuerry, userMailstr);
            else   //No Filters applied get all products
                productList = DBUtils.queryProduct(conn, userMailstr);
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        if(productList==null){
            errorString = "There was a problem with products";
        }
        
       // Convert productList to JSON
        ObjectMapper om = new ObjectMapper();
        String productListJson = om.writeValueAsString(productList);

        // Set the response content type
        resp.setContentType("application/json");

        // Write the JSON response
        resp.getWriter().write(productListJson);
    }
}
