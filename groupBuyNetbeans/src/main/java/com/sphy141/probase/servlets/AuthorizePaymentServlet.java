/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.paypal.base.rest.PayPalRESTException;
import com.sphy141.probase.beans.OrderDetails;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import com.sphy141.probase.utils.PaymentUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(urlPatterns = {"/authorizepayment"})
public class AuthorizePaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE START
        HttpSession session = req.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        Connection conn = MyUtils.getStoredConnection(req);
        String errorString = null;
        int notificationsCount = 0;

        if (user != null) {
            try {
                notificationsCount = DBUtils.countNotificationsNotReadBy(conn, user);
                req.setAttribute("logineduser", user);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END

        int offerId = Integer.parseInt(req.getParameter("offerId"));
        float subtotal = Float.parseFloat(req.getParameter("subtotal"));
        float shipping = Float.parseFloat(req.getParameter("shipping"));
        float tax = Float.parseFloat(req.getParameter("tax"));
        float total = Float.parseFloat(req.getParameter("total"));
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);

        OrderDetails orderDetails = new OrderDetails();
        orderDetails.setOfferId(offerId);
        orderDetails.setAccountEmail(user.getEmail());
        orderDetails.setTotal(total);
        orderDetails.setDate(formattedDateTime);
        orderDetails.setDetails("details about transaction. eg Fee for offer x.OR full price for offer x etc");
        orderDetails.setShipping(shipping);
        orderDetails.setStatus("pending");
        orderDetails.setSubtotal(subtotal);
        orderDetails.setTax(tax);
        orderDetails.setType("Payout");

        try {
            String approvalLink = PaymentUtils.authorizePayment(orderDetails);
            // After the line `resp.sendRedirect(approvalLink)`
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"redirectUrl\": \"" + approvalLink + "\"}");

        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
        }
    }
}
