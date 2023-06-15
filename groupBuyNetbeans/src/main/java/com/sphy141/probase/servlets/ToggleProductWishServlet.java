/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.UserAccount;
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
@WebServlet(urlPatterns = {"/toggleproductwish"})
public class ToggleProductWishServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        String userMailstr="";
        if(user!=null){
            req.setAttribute("logineduser", user);
            userMailstr=user.getEmail();
        }
        else{
            req.setAttribute("logineduser", null);
        
            BusinessAccount business = MyUtils.getLoginedBusiness(session);
            if(business!=null)
                req.setAttribute("loginedbusiness", business);
            else
                req.setAttribute("loginedbusiness", null);
        }
        Connection conn = MyUtils.getStoredConnection(req);

        //Get the filters cheched
        String productCode = req.getParameter("productCode");

        try {
            //Toggle Handler. if it exists delete it, if it doesn't Insert it
            DBUtils.toggleProductWishForUser(conn, productCode, userMailstr);
        } catch (SQLException ex) {
            ex.printStackTrace();
            resp.getWriter().write("false");
            return;
        }
        resp.getWriter().write("true");
    }
}
