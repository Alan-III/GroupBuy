/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.CryptoUtils;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MailUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("loginEmail");
        String password = req.getParameter("loginPassword");
        String remember = req.getParameter("loginCheck");
        boolean rememberMe = "Y".equals(remember);
        String errorString = null;
        boolean hasError = false;
        UserAccount user = null;
        BusinessAccount business = null;
        
        if(email == null || password == null || email.length()==0 || password.length()==0){
            hasError=true;
            errorString = "email and password should be provided";
        }
        Connection conn = MyUtils.getStoredConnection(req);
        try {
            user = DBUtils.findUser(conn, email, CryptoUtils.hashString(password));
            if(user==null){
                business = DBUtils.findBusiness(conn, email, CryptoUtils.hashString(password));
                if(business==null){
                    hasError=true;
                    errorString = "email or password is wrong, does not exist or email not verified";
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            hasError=true;
            errorString = ex.getMessage();
        }
        //
        if (hasError){
            req.setAttribute("errorString", errorString);
            
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
            dispatcher.forward(req, resp);
        }
        else{
            HttpSession session = req.getSession();
            req.setAttribute("logineduser", user);
            req.setAttribute("loginedbusiness", business);
            if(user!=null)
                MyUtils.storeLoginedUser(session, user);
            else
                MyUtils.storeLoginedBusiness(session, business);
            if(rememberMe){
                if(user!=null)
                    MyUtils.storeUserCookie(resp, user);
                else
                    MyUtils.storeBusinessCookie(resp, business);
            }
            else{
                if(user!=null)
                    MyUtils.deleteUserCookie(resp);
                else
                    MyUtils.deleteBusinessCookie(resp);
            }
            resp.sendRedirect(req.getContextPath()+"/home");
        }
    }//doPost
}
