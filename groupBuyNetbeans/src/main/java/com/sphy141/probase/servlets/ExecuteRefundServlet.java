/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.paypal.api.payments.Capture;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Refund;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import com.sphy141.probase.beans.OrderDetails;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import com.sphy141.probase.utils.PaymentUtils;
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
@WebServlet(urlPatterns = {"/executerefund"})
public class ExecuteRefundServlet extends HttpServlet {

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

        String offerIdstr = req.getParameter("offerId");
        int offerId = Integer.parseInt(offerIdstr);

        try {
            OrderDetails orderDetails = DBUtils.findPayment(conn, offerId, user);

            Refund refund = PaymentUtils.refundPayment(orderDetails.getCaptureId(), Double.parseDouble(orderDetails.getTotal()));

            if (refund == null) {
                resp.sendRedirect(req.getContextPath() + "/paymentfailed");
                return;
            }
            //########### TODO ##########  get transaction info to show in JSP

            // Save the sale ID in your database for future reference
            DBUtils.updatePayPalPayment(conn, orderDetails.getId(), "refunded");
            DBUtils.deleteUserFromOffer(conn, orderDetails.getOffer().getId(), user);

            //req.setAttribute("payerInfo", payerInfo);
            //req.setAttribute("transaction", transaction);
            String redirectUrl = "/offerdetails?offerid=" + orderDetails.getOffer().getId();
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"redirectUrl\": \"" + redirectUrl + "\"}");

        } catch (PayPalRESTException ex) {
            ex.printStackTrace();           //########### TODO ########## SEND TO ERROR PAGE
            resp.sendRedirect(req.getContextPath() + "/paymentfailed");
                return;
        } catch (SQLException ex) {
            ex.printStackTrace();           //########### TODO ########## SEND TO ERROR PAGE
            resp.sendRedirect(req.getContextPath() + "/paymentfailed");
                return;
        }
    }
}
