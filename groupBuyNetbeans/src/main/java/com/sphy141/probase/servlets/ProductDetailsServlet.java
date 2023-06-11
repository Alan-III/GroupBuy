/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

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
import java.util.List;
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
@WebServlet(urlPatterns = {"/productdetails"})
public class ProductDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        if(user!=null)
            req.setAttribute("logineduser", user);
        else{
            req.setAttribute("logineduser", null);
        
            BusinessAccount business = MyUtils.getLoginedBusiness(session);
            if(business!=null)
                req.setAttribute("loginedbusiness", business);
            else
                req.setAttribute("loginedbusiness", null);
        }
        
        String productCodeParam = req.getParameter("productCode");
        
        Connection conn = MyUtils.getStoredConnection(req);
        Product product = null;
        String errorString = null;
        try {
            product = DBUtils.findProduct(conn, productCodeParam);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if(product==null){
            errorString = "There was a problem with product";
        }
        
        List<Category> listall = null;
        List<Category> genlist = new ArrayList<>();
        List<Category> midlist = new ArrayList<>();
        List<Category> sublist = new ArrayList<>();
        try {
            listall = DBUtils.queryCategories(conn);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        for (Category category : listall) {
            if(category.getSubCategory()!=null){
                sublist.add(category);
            }else if(category.getMidCategory()!=null){
                midlist.add(category);
            }else{
                genlist.add(category);
            }
        }
            req.setAttribute("genCategory", genlist);
            req.setAttribute("category", midlist);
            req.setAttribute("subCategory", sublist);
            
            req.setAttribute("errorString", errorString);
            req.setAttribute("product", product);
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/productDetailsView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
