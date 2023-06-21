/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sphy141.probase.servlets;

/**
 *
 * @author MITSOS GLA
 */
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

@WebServlet(urlPatterns = {"/deleteoffeer"})
public class DeleteOfferServlet extends HttpServlet {
     
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
            resp.sendRedirect(req.getContextPath()+"/home");
            return;
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
        try {
            DBUtils.deleteOffer(conn, Integer.parseInt(req.getParameter("offerID")));
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
        req.setAttribute("errorString", "Offer Deleted!");
        resp.sendRedirect(req.getContextPath() + "/offerlist");
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }//dopost
    
}//deleteOfferServlet
