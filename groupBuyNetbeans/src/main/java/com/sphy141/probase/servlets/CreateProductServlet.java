/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Product;
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

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/createproduct"})
public class CreateProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        String errorString = null;
        if (business == null) {
            errorString = "You don't have access to that page";
            req.setAttribute("errorString", errorString);
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        RequestDispatcher dispatcher = this.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/createProductView.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String strPrice = req.getParameter("price");
        float price = 0;
        String errorString = null;
        try {
            price = Float.parseFloat(strPrice);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The price is not a number";
        }//try-catch
        String regex = "\\w+";
        if (code == null || !code.matches(regex)) {
            errorString = "Product code is invalid";
        }//if
        if (name == null || name.length()==0) {
           errorString = "Product name cannot be empty";
        }//
        Product product = new Product();
        product.setCode(code);
        product.setName(name);
        product.setPrice(price);
        if (errorString==null) {
            Connection conn = MyUtils.getStoredConnection(req);
            try {
                DBUtils.insertProduct(conn, product);
                resp.sendRedirect(req.getContextPath()+"/productlist");
            } catch (SQLException ex) {
                ex.printStackTrace();
                errorString = "There is a problem with the database";
            }
        }//if
        if (errorString != null) {
            req.setAttribute("errorString", errorString);
            req.setAttribute("product", product);
            RequestDispatcher dispatcher = this.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/createProductView.jsp");
            dispatcher.forward(req, resp);
        }  //if       
    }

}
