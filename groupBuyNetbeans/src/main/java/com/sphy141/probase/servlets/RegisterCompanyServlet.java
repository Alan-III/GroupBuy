/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

/**
 *
 * @author Alan
 */ 

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.CryptoUtils;
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


@WebServlet(urlPatterns = {"/registerCompany"})
public class RegisterCompanyServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
//        dispatcher.forward(req, resp);
        doPost(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String supervisorFirstName = req.getParameter("registerFirstNameC");
        String supervisorLastName = req.getParameter("registerLastNameC");
        String businessName = req.getParameter("registerNameC");
        String email = req.getParameter("registerEmailC");
        String afm = req.getParameter("registerafm");
        String iban = req.getParameter("registeriban");
        String password = req.getParameter("registerPasswordC");
        String confirmPassword = req.getParameter("registerRepeatPasswordC");
        //String terms = req.getParameter("registerCheckC");
        //boolean termsCheck = terms==null ? false : true;
        String errorString = null;
        boolean hasError = false;
        BusinessAccount business = null;
        
        if(iban == null || afm == null || businessName == null || password == null || email == null || confirmPassword == null || supervisorFirstName == null || supervisorLastName == null 
                || supervisorFirstName.length()==0|| supervisorLastName.length()==0  || businessName.length()==0 
                || password.length()==0 || iban.length()==0 || afm.length()==0|| email.length()==0 || email.length()==0 || confirmPassword.length()==0){
            hasError=true;
            errorString = "Fill in all the fields";
        }
        if(!(password.equals(confirmPassword))){
            hasError=true;
            errorString = "passwords don't match";
        }
//        if(!termsCheck){
//            hasError=true;
//            errorString = "please agree to the Terms";
//        }
        Connection conn = MyUtils.getStoredConnection(req);
        try {
            business = DBUtils.findBusiness(conn, email);
            if(business!=null){
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
                business = new BusinessAccount();
                business.setSupervisorFirstName(supervisorFirstName);
                business.setSupervisorLastName(supervisorLastName);
                business.setEmail(email);
                business.setAfm(afm);
                business.setIBAN(iban);
                business.setBusinessName(businessName);
                business.setPassword(CryptoUtils.hashString(password));
                String verificationCode = UUID.randomUUID().toString().substring(0, 20);
                business.setVerificationCode(verificationCode);
                DBUtils.insertBusiness(conn, business);
            } catch (SQLException ex) {
                ex.printStackTrace();
                errorString = ex.getMessage();
                req.setAttribute("errorString", errorString);
                RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
                dispatcher.forward(req, resp);
                return;
            }
            try {
                System.out.println("Mail Sent to: "+business.getEmail());
                MailUtils.sendMail(business);
            } catch (MessagingException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            resp.sendRedirect(req.getContextPath()+"/home");
        }
    }//doPost
}
