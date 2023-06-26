/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.paypal.api.payments.Capture;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import com.sphy141.probase.beans.CouponToken;
import com.sphy141.probase.beans.Offer;
import com.sphy141.probase.beans.OrderDetails;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import com.sphy141.probase.utils.PaymentUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
@WebServlet(urlPatterns = {"/executepayment"})
public class ExecutePaymentServlet extends HttpServlet {
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
        
        String paymentId = req.getParameter("paymentId");
        String payerId = req.getParameter("payerId");
        
        if(payerId==null || paymentId==null)
            resp.sendRedirect(req.getContextPath() + "/paymentfailed");
        
        String orderIdstr = req.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdstr);

        try {
            //Authorize payment and reserve customers funds
            Payment payment = PaymentUtils.executePayment(paymentId, payerId);
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
            
            // Retrieve the authorization ID from the payment response
            String authorizationId = payment.getTransactions().get(0).getRelatedResources().get(0).getAuthorization().getId();
            //Capture funds
            Capture capturePayment = PaymentUtils.capturePayment(authorizationId, transaction.getAmount().getTotal());
            String captureId = capturePayment.getId();
            
            
            //Save the capture ID in your database for future reference
            DBUtils.updatePayPalPayment(conn, orderId, "completed", authorizationId, captureId);
            OrderDetails orderDetails = DBUtils.findPayment(conn, orderId);     //INSERT BEFORE PAYING. ROLLBACK IF CANT PAY
            
            Offer offer = DBUtils.findOffer(conn, orderDetails.getOffer().getId());
            //if user was already in offer then he is paying full price
            CouponToken ct = DBUtils.findCouponToken(conn, offer, user);
            if("participant".equals(ct.getState())){
                DBUtils.updateCouponToken(conn, ct, "buyer");   
            } else{
                DBUtils.insertUserInOffer(conn, offer.getId(), user);
            }
            
            
            
            req.setAttribute("payerInfo", payerInfo);
            req.setAttribute("transaction", transaction);
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/paymentReceiptView.jsp");
            dispatcher.forward(req, resp);
        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
