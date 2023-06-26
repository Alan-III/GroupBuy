/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sphy141.probase.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
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
 * @author MITSOS GLA
 */

@WebServlet(urlPatterns = {"/chartdetails"})

public class ChartDetailsServlet extends HttpServlet {
  
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            resp.sendRedirect(req.getContextPath()+"/home");
            return;
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
// get lists of categories
        List<Category> listall = null;
        List<Category> genlist = new ArrayList<>();
        List<Category> midlist = new ArrayList<>(); 
        List<Category> sublist = new ArrayList<>();
        try {
            listall = DBUtils.queryCategories(conn);
        } catch (SQLException ex) {
            ex.printStackTrace();
            String errorString = ex.getMessage();
        }
        for (Category category : listall) {
            if (category.getSubCategory() != null) {
                sublist.add(category);
            } else if (category.getMidCategory() != null) {
                midlist.add(category);
            } else {
                genlist.add(category);
            }
        }


        req.setAttribute("genCategory", genlist);
        req.setAttribute("category", midlist);
        req.setAttribute("subCategory", sublist);
        
        
        //Get the filters cheched
        String genCategory = req.getParameter("generalCategory");
                String category = req.getParameter("category");
        String subCategory = req.getParameter("subcategory");
        String startDate = req.getParameter("startDate");
        String endDate = req.getParameter("endDate");


        List<Product> productList2 = null;
        
        try {
            productList2 = DBUtils.queryHotSearchesOnPeriod (conn, genCategory, category,subCategory, startDate, endDate);
        } catch (SQLException ex) {
            ex.printStackTrace();
            resp.getWriter().write("false");
            return;
        }
        if (productList2 == null) {
            resp.getWriter().write("false");
            return;
        }
        // Create Gson object
Gson gson = new Gson();

// Convert the object to JSON
String json = gson.toJson(productList2);

// Set the JSON as an attribute in the request
req.setAttribute("productList2", json);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hotproducts.jsp");
        dispatcher.forward(req, resp);
    }
}