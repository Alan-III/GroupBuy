/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Offer;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
@WebServlet(urlPatterns = {"/canceloffer"})
public class CancelOfferServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE START
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
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END
        String offerIdstr = req.getParameter("offerId");
        int offerId = Integer.parseInt(offerIdstr);
        
        try {
            Offer offer = DBUtils.findOffer(conn, offerId);
            DBUtils.updateOffer(conn, offer, "canceled");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
//        String paymentId = req.getParameter("paymentId");
//        String payerId = req.getParameter("payerId");
//        
//        if(payerId==null || paymentId==null)
//            resp.sendRedirect(req.getContextPath() + "/paymentfailed");
//        
//        String orderIdstr = req.getParameter("orderId");
//        int orderId = Integer.parseInt(orderIdstr);
//
//        try {
//            //Authorize payment and reserve customers funds
//            Payment payment = PaymentUtils.executePayment(paymentId, payerId);
//            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
//            Transaction transaction = payment.getTransactions().get(0);
//            
//            // Retrieve the authorization ID from the payment response
//            String authorizationId = payment.getTransactions().get(0).getRelatedResources().get(0).getAuthorization().getId();
//            //Capture funds
//            Capture capturePayment = PaymentUtils.capturePayment(authorizationId, transaction.getAmount().getTotal());
//            String captureId = capturePayment.getId();
//            
//            
//            //Save the sale ID in your database for future reference
//            DBUtils.updatePayPalPayment(conn, orderId, "completed", authorizationId, captureId);
//            OrderDetails orderDetails = DBUtils.findPayment(conn, orderId);     //INSERT BEFORE PAYING. ROLLBACK IF CANT PAY
//            DBUtils.insertUserInOffer(conn, orderDetails.getOffer().getId(), user);
//            
//            
//            req.setAttribute("payerInfo", payerInfo);
//            req.setAttribute("transaction", transaction);
//            String redirectUrl = "/offerdetails?offerid=" + orderDetails.getOffer().getId();
//            resp.setContentType("application/json");
//            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("true");
//        } catch (PayPalRESTException ex) {
//            ex.printStackTrace();           //########### TODO ########## SEND TO ERROR PAGE
//            resp.sendRedirect(req.getContextPath() + "/paymentfailed");
//                return;
//        } catch (SQLException ex) {
//            ex.printStackTrace();           //########### TODO ########## SEND TO ERROR PAGE
//            resp.sendRedirect(req.getContextPath() + "/paymentfailed");
//                return;
//        }
    }
}
