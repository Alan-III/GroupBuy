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
import java.util.UUID;
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
 * @author Alan
 */
@WebServlet(urlPatterns = {"/registerUser"})
public class RegisterUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
//        dispatcher.forward(req, resp);
        doPost(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("registerFirstNameU");
        String lastName = req.getParameter("registerLastNameU");
        String username = req.getParameter("registerUsernameU");
        String email = req.getParameter("registerEmailU");
        String password = req.getParameter("registerPasswordU");
        String confirmPassword = req.getParameter("registerRepeatPasswordU");
        String terms = req.getParameter("registerCheckU");
        boolean termsCheck = terms==null ? false : true;
        String errorString = null;
        boolean hasError = false;
        UserAccount user = null;
        
        if(username == null || password == null || email == null || confirmPassword == null || username.length()==0 
                || password.length()==0 || email.length()==0 || email.length()==0 || confirmPassword.length()==0){
            hasError=true;
            errorString = "email, username and password should be provided";
        }
        if(!(password.equals(confirmPassword))){
            hasError=true;
            errorString = "passwords don't match";
        }
        if(!termsCheck){
            hasError=true;
            errorString = "please agree to the Terms";
        }
        Connection conn = MyUtils.getStoredConnection(req);
        try {
            user = DBUtils.findUser(conn, email);
            if(user!=null){
                hasError=true;
                errorString = "email already exists";
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
            try {
                user = new UserAccount();
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setUserName(username);
                user.setPassword(password);
                String verificationCode = UUID.randomUUID().toString().substring(0, 8);
                user.setVerificationCode(verificationCode);
                user.setUserID(DBUtils.insertUser(conn, user));
            } catch (SQLException ex) {
                ex.printStackTrace();
                errorString = ex.getMessage();
                req.setAttribute("errorString", errorString);
                RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
                dispatcher.forward(req, resp);
                return;
            }
            try {
                System.out.println("Mail Sent to: "+user.getEmail());
                MailUtils.sendMail(user);
                
            } catch (MessagingException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            resp.sendRedirect(req.getContextPath()+"/home");
        }
    }//doPost
}
