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

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/deleteproduct"})
public class DeleteProductServlet extends HttpServlet {
  
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        if(business!=null)
            req.setAttribute("loginedbusiness", business);
        else{
            req.setAttribute("errorString", "Access Denied");
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
            dispatcher.forward(req, resp);
            return;
        }
        
        Connection conn = MyUtils.getStoredConnection(req);
        try {
            DBUtils.deleteProduct(conn, Integer.parseInt(req.getParameter("proid")));
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
        req.setAttribute("errorString", "Product Deleted!");
        resp.sendRedirect(req.getContextPath() + "/productlist");
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
