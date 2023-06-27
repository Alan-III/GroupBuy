/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.CouponToken;
import com.sphy141.probase.beans.Offer;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(urlPatterns = {"/offerdetails"})
public class OfferDetailsServlet extends HttpServlet {
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
        
        //----------Find offer in DB
        String offerIdParam = req.getParameter("offerid");
        int offerId = Integer.parseInt(offerIdParam);
        Offer offer = null;
        try {
            offer = DBUtils.findOffer(conn, offerId);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if(offer==null){
            errorString = "There was a problem with product";
        }
        
        //----------See if user has already joined this offer
        boolean isParticipant=false;
        CouponToken ct=null;
        if(user!=null){
            try {
                ct = DBUtils.findCouponToken(conn, offer, user);
                isParticipant = (ct!=null);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        // Get the current datetime
        Date currentDate = new Date();

        // Convert the Date object to a Timestamp object
        Timestamp currentTimestamp = new Timestamp(currentDate.getTime());

        // Print the current datetime
        System.out.println("Current Datetime: " + currentTimestamp);
        
        // You can also pass the current datetime to your JSP page or set it as a request attribute
        req.setAttribute("currentDatetime", currentTimestamp);
        req.setAttribute("errorString", errorString);
        req.setAttribute("offer", offer);
        req.setAttribute("isParticipant", isParticipant);
        req.setAttribute("couponToken", ct);
        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/offerDetailsView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
