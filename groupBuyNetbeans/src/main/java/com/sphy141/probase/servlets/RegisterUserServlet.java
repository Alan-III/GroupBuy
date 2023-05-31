/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
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
        String fullname = req.getParameter("registerName");
        String username = req.getParameter("registerUsername");
        String email = req.getParameter("registerEmail");
        String password = req.getParameter("registerPassword");
        String confirmPassword = req.getParameter("registerRepeatPassword");
        String terms = req.getParameter("registerCheck");
        boolean termsCheck = "Y".equals(terms);
        String errorString = null;
        boolean hasError = false;
        UserAccount user = null;
        
        if(username == null || password == null || username.length()==0 || password.length()==0){
            hasError=true;
            errorString = "username and password should be provided";
        }
        Connection conn = MyUtils.getStoredConnection(req);
        try {
            user = DBUtils.findUser(conn, username, password);
            if(user==null){
                hasError=true;
                errorString = "username or password is wrong";
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            hasError=true;
            errorString = ex.getMessage();
        }
        //
        if (hasError){
            user = new UserAccount();
            user.setUserName(username);
            user.setPassword(password);
            
            req.setAttribute("errorString", errorString);
            req.setAttribute("logineduser", user);
            RequestDispatcher dispatcher=this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
        dispatcher.forward(req, resp);
        }
        else{
            HttpSession session = req.getSession();
            MyUtils.storeLoginedUser(session, user);
            if(termsCheck){
                MyUtils.storeUserCookie(resp, user);
            }
            else{
                MyUtils.deleteUserCookie(resp);
            }
            resp.sendRedirect(req.getContextPath()+"/userinfo");
        }
    }//doPost
}
