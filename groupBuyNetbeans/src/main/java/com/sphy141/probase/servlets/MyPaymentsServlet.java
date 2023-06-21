/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.OrderDetails;
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
@WebServlet(urlPatterns = {"/mypayments"})
public class MyPaymentsServlet extends HttpServlet {

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
                resp.sendRedirect(req.getContextPath()+"/login");
                return;
            }
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END
        
        List<OrderDetails> paymentsList = new ArrayList<OrderDetails>();
        try {
            if(business!=null)
                paymentsList = DBUtils.queryPayments(conn, business.getEmail());
            else if(user!=null)
                paymentsList = DBUtils.queryPayments(conn, user.getEmail());
                
                
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if(paymentsList==null){
            errorString = "There was a problem with products";
        }
        req.setAttribute("loginedbusiness", business);
        req.setAttribute("paymentsList", paymentsList);
        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/myPaymentsListView.jsp");
        dispatcher.forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
