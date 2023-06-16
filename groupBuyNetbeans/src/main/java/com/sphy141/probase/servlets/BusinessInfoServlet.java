/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.UserAccount;
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
@WebServlet(urlPatterns = {"/businessInfo"})
public class BusinessInfoServlet  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        Connection conn = MyUtils.getStoredConnection(req);
        String errorString = null;
        int notificationsCount = 0;

        if (business != null) {
            try {
                notificationsCount = DBUtils.countNotificationsNotReadBy(conn, business);
                req.setAttribute("loginedbusiness", business);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else {
            resp.sendRedirect(req.getContextPath()+"/login");
            return;
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END
        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/businessInfoView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}