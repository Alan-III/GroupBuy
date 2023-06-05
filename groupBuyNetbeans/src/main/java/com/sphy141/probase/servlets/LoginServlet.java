/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.UserAccount;
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
        
        if(email == null || password == null || email.length()==0 || password.length()==0){
            hasError=true;
            errorString = "email and password should be provided";
        }
        Connection conn = MyUtils.getStoredConnection(req);
        try {
            user = DBUtils.findUser(conn, email, password);
            if(user==null){
                hasError=true;
                errorString = "email or password is wrong or does not exist";
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            hasError=true;
            errorString = ex.getMessage();
        }
        //
        if (hasError){
            user = new UserAccount();
            user.setEmail(email);
            user.setPassword(password);
            
            req.setAttribute("errorString", errorString);
            req.setAttribute("logineduser", user);
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
        dispatcher.forward(req, resp);
        }
        else{
            HttpSession session = req.getSession();
            MyUtils.storeLoginedUser(session, user);
            if(rememberMe){
                MyUtils.storeUserCookie(resp, user);
            }
            else{
                MyUtils.deleteUserCookie(resp);
            }
            resp.sendRedirect(req.getContextPath()+"/home");
        }
    }//doPost
}
