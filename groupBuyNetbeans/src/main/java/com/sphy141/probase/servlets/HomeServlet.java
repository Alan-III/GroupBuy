/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.CryptoUtils;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MailUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE START
        HttpSession session = req.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        Connection conn = MyUtils.getStoredConnection(req);
        String userMailstr = " ";
        String errorString = null;
        int notificationsCount = 0;

        if (user != null) {
            req.setAttribute("logineduser", user);
            userMailstr = user.getEmail();
            try {
                notificationsCount = DBUtils.countNotificationsNotReadBy(conn, user);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else {
            req.setAttribute("logineduser", null);
            
            if (business != null) {
                req.setAttribute("loginedbusiness", business);
                try {
                notificationsCount = DBUtils.countNotificationsNotReadBy(conn, business);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            } else {
                req.setAttribute("loginedbusiness", null);
            }
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END
        List<Category> categoriesList = null;
        try {
            categoriesList = DBUtils.queryCategories(conn);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (categoriesList == null) {
            errorString = "There was a problem with products";
        }

        //Load products to find keywords
        List<Product> productList = null;
        try {
            productList = DBUtils.queryProduct(conn, userMailstr);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (categoriesList == null) {
            errorString = "There was a problem with products";
        }
        //Check if the keywords exist
        ServletContext context = req.getServletContext();
        List<String> keywordsList = (List<String>) context.getAttribute("keywordsList");
        if (keywordsList == null) {
            // The keywordsList attribute is not set
            // Process categories and products for keywords
            keywordsList = new ArrayList<>();
            for (Product product : productList) {
                keywordsList.add(product.getName());
            }
            for (Category category : categoriesList) {
                keywordsList.add(category.getCategoryName());
            }
            // Set keywordsList attribute
            context.setAttribute("keywordsList", keywordsList);
        }

        req.setAttribute("errorString", errorString);
        req.setAttribute("categorylist", categoriesList);
        req.setAttribute("keywordsList", keywordsList);

        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
        dispatcher.forward(req, resp);
    }//doGet

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //For Contact
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String msg = req.getParameter("msg");
        String errorString = null;
        boolean hasError = false;
        UserAccount user = null;

        if (name == null || email == null || msg == null || name.length() == 0
                || email.length() == 0 || email.length() == 0 || msg.length() == 0) {
            hasError = true;
            errorString = "Please fill in the form";
        }
        Connection conn = MyUtils.getStoredConnection(req);

        if (hasError) {
            req.setAttribute("errorString", errorString);
            RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
            dispatcher.forward(req, resp);
        } else {

            System.out.println("Mail Sent from: " + email);
            try {
                MailUtils.sendMail(name, email, phone, msg);
                req.setAttribute("errorString", "Thank you for contacting us!");
            } catch (MessagingException ex) {
                req.setAttribute("errorString", "Something went wrong");
            }

            RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
            dispatcher.forward(req, resp);
        }
    }//doPost

}
