/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/ajaxproductsofcategory"})
public class AjaxProductsOfCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        if (business == null) {
            return;
        } else {
            req.setAttribute("loginedbusiness", business);
        }
        Connection conn = MyUtils.getStoredConnection(req);

        //Get the filters cheched
        String categoryType = req.getParameter("categoryType");
        String categoryName = req.getParameter("categoryName");

        List<Product> productList = null;
        List<Product> businessProductList = null;
        try {
            businessProductList = DBUtils.queryProductsInBusinessInCategory(conn, business.getBusinessID(), categoryType, categoryName);
            productList = DBUtils.queryProductsNotInBusinessInCategory(conn, business.getBusinessID(), categoryType, categoryName);
        } catch (SQLException ex) {
            ex.printStackTrace();
            resp.getWriter().write("false");
            return;
        }
        if (productList == null || businessProductList == null) {
            resp.getWriter().write("false");
            return;
        }

        // Create a map to hold the indexes and their corresponding lists
        Map<String, List<Product>> responseMap = new HashMap<>();
        responseMap.put("businessProducts", businessProductList);
        responseMap.put("notBusinessProducts", productList);

        // Convert the map to JSON
        ObjectMapper om = new ObjectMapper();
        String responseJson = om.writeValueAsString(responseMap);

        // Set the response content type
        resp.setContentType("application/json");

        // Write the JSON response
        resp.getWriter().write(responseJson);
    }
}
