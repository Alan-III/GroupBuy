/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.filter;

import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
@WebFilter(filterName = "cookieFilter", urlPatterns = {"/*"})
public class CookieFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
//        Filter.super.init(filterConfig); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException {
        System.out.println("Cookie Filter is running");
        HttpServletRequest request = (HttpServletRequest) sr;
        HttpSession session = request.getSession();
        UserAccount user = MyUtils.getLoginedUser(session);
        if (user != null) {
            session.setAttribute("CHECKED_COOKIE", "CHECKED");
            fc.doFilter(sr, sr1);
            return;
        }
        Connection conn = MyUtils.getStoredConnection(sr);
        String checked = (String) session.getAttribute("CHECKED_COOKIE");
        if (checked == null && conn != null) {
            String userName = (String) MyUtils.getUserNameInCookie(request);
            try {
                user = DBUtils.findUser(conn, userName);
                MyUtils.storeLoginedUser(session, user);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            session.setAttribute("CHECKED_COOKIE", "CHECKED");
        }
        fc.doFilter(sr, sr1);
    }

    @Override
    public void destroy() {
//        Filter.super.destroy(); //To change body of generated methods, choose Tools | Templates.
    }

}
