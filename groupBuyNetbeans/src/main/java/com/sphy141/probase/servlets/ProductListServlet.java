/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.ProductFilter;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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
@WebServlet(urlPatterns = {"/productlist"})
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        
        String businessIdParam = req.getParameter("businessId");
        String categoryIdParam = req.getParameter("catid");
        String searchParam = req.getParameter("search");
                
        //Get products ALL or Searched
        List<Product> productList = null;
        try {
            if(searchParam==null || searchParam.length()==0)
                productList = DBUtils.queryProduct(conn, userMailstr);
            else
                productList = DBUtils.searchProduct(conn, searchParam, userMailstr);
                
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if(productList==null){
            errorString = "There was a problem with products";
        }
        
        //Check if the keywords exist
        ServletContext context = req.getServletContext();
        List<String> keywordsList = (List<String>) context.getAttribute("keywordsList");
        if (keywordsList == null) {
            // The keywordsList attribute is not set
            // Process categories and products for keywords
            keywordsList = new ArrayList<>();
            for (Product product : productList) {
                keywordsList.add(product.getName());
            }
            List<Category> categoriesList = null;
            try {
                categoriesList = DBUtils.queryCategories(conn);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            if(categoriesList==null){
                errorString = "There was a problem with products";
            }
            for (Category category : categoriesList) {
                keywordsList.add(category.getCategoryName());
            }
            // Set keywordsList attribute
            context.setAttribute("keywordsList", keywordsList);
        }
        
        //Get filters if category was selected
        List<ProductFilter> filtersList = null;
        if(categoryIdParam!=null){
            try {
                Category tempCategory = DBUtils.findCategory(conn, Integer.parseInt(categoryIdParam));
                filtersList = DBUtils.findCategoryFilters(conn, tempCategory.getCategoryName());
            } catch (SQLException ex) {
                ex.printStackTrace();
                errorString = "There was a problem with database";
            }
        }
        
            req.setAttribute("errorString", errorString);
            req.setAttribute("productList", productList);
            req.setAttribute("keywordsList", keywordsList);
            req.setAttribute("filtersList", filtersList);
//            req.setAttribute("logineduser", user);
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/productListView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
