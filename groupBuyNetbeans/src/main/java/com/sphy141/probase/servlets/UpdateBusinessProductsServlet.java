/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
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
import javax.servlet.http.Part;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/updatebusinessproducts"})
public class UpdateBusinessProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        String errorString = null;
//        if (business == null) {
//            resp.sendRedirect(req.getContextPath() + "/home");  // REDIRECT TO ACCESS DENIED PAGE
//            return;
//        } else {
        req.setAttribute("loginedbusiness", business);
//        }

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
            errorString = ex.getMessage();
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

        List<Product> productList = null;
        List<Product> businessProductList = null;
        try {
            productList = DBUtils.queryProductsNotInBusiness(conn, business.getBusinessID());
            businessProductList = DBUtils.queryProductsInBusiness(conn, business.getBusinessID());

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (productList == null || businessProductList == null) {
            errorString = "There was a problem with products";
        }

        req.setAttribute("genCategory", genlist);
        req.setAttribute("category", midlist);
        req.setAttribute("subCategory", sublist);
        req.setAttribute("productList", productList);
        req.setAttribute("businessProductList", businessProductList);

        RequestDispatcher dispatcher = this.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/updateBusinessProductsView.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        if (business == null) {
            resp.getWriter().write("false");
            return;
        } else {
            req.setAttribute("loginedbusiness", business);
        }
        Connection conn = MyUtils.getStoredConnection(req);

        //Get the filters cheched
        String productCode = req.getParameter("productCode");

        try {
            //Toggle Handler. if it exists delete it, if it doesn't Insert it
            DBUtils.toggleBusinessProduct(conn, productCode, business.getBusinessID());
        } catch (SQLException ex) {
            ex.printStackTrace();
            resp.getWriter().write("false");
            return;
        }
        resp.getWriter().write("true");
    }
}
