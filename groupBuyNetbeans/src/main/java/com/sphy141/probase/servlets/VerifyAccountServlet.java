/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.google.protobuf.Int32Value;
import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
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

/**
 *
 * @author Alan
 */

@WebServlet(urlPatterns = {"/verify"})
public class VerifyAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountType = req.getParameter("type");
        Connection conn = MyUtils.getStoredConnection(req);
        if(accountType.equals("u")){
            UserAccount user = new UserAccount();
            user.setUserID(Integer.parseInt(req.getParameter("id")));
            user.setVerificationCode(req.getParameter("code"));
            try {
                req.setAttribute("user", "user");
                if(DBUtils.verifyUser(conn, user)){
                    req.setAttribute("verify", true);
                }else{
                    req.setAttribute("verify", false);
                }
            } catch (SQLException ex) {
                Logger.getLogger(VerifyAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else{
            BusinessAccount business = new BusinessAccount();
            business.setBusinessID(Integer.parseInt(req.getParameter("id")));
            business.setVerificationCode(req.getParameter("code"));
            try {
                if(DBUtils.verifyBusiness(conn, business)){
                    req.setAttribute("verify", true);
                }else{
                    req.setAttribute("verify", false);
                }
            } catch (SQLException ex) {
                Logger.getLogger(VerifyAccountServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/verifyView.jsp");
//        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
