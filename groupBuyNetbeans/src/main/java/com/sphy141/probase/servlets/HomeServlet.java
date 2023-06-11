/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MailUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
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
 * @author USER
 */
@WebServlet(urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        if(user!=null)
            req.setAttribute("logineduser", user);
        else{
            req.setAttribute("logineduser", null);
        
            BusinessAccount business = MyUtils.getLoginedBusiness(session);
            if(business!=null)
                req.setAttribute("loginedbusiness", business);
            else
                req.setAttribute("loginedbusiness", null);
        }
        Connection conn = MyUtils.getStoredConnection(req);
        List<Category> list = null;
        String errorString = null;
        try {
            list = DBUtils.queryCategories(conn);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if(list==null){
            errorString = "There was a problem with products";
        }
        req.setAttribute("errorString", errorString);
        req.setAttribute("list", list);
            
        RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String msg = req.getParameter("msg");
        String errorString = null;
        boolean hasError = false;
        UserAccount user = null;
        
        if(name == null || email == null || msg == null || name.length()==0 
                || email.length()==0 || email.length()==0 || msg.length()==0){
            hasError=true;
            errorString = "Please fill in the form";
        }
        Connection conn = MyUtils.getStoredConnection(req);
//        try {
//            user = DBUtils.findUser(conn, email);
//            if(user!=null){
//                hasError=true;
//                errorString = "email already exists";
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//            hasError=true;
//            errorString = ex.getMessage();
//        }
        //
        if (hasError){
            req.setAttribute("errorString", errorString);
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
        dispatcher.forward(req, resp);
        }
        else{

                System.out.println("Mail Sent from: "+email);
            try {
                MailUtils.sendMail(name,email,phone,msg);
                req.setAttribute("errorString", "Thank you for contacting us!");
            } catch (MessagingException ex) {
                req.setAttribute("errorString", "Something went wrong");
            }

            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
        dispatcher.forward(req, resp);
        }
    }//doPost

}
