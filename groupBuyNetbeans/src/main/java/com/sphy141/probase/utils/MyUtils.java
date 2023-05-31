/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.sphy141.probase.beans.UserAccount;
import java.sql.Connection;
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
public class MyUtils {

    private static final String ATT_NAME_CONNECTION = "ATTRIBUTE_FOR_CONNECTION";
    private static final String ATT_NAME_USER_NAME = "ATTRIBUTE_FOR_USER_IN_COOKIE";
    private static final String ATT_NAME_LOGIN_USER = "ATTRIBUTE_FOR_USER_IN_SESSION";

//  //Connection Management
    public static void storeConnection(ServletRequest request, Connection conn) {
        request.setAttribute(ATT_NAME_CONNECTION, conn);
    }//storeConnection

    public static Connection getStoredConnection(ServletRequest request) {
        return (Connection) request.getAttribute(ATT_NAME_CONNECTION);
    }//getStoredConnection

//  //Session Management
    public static void storeLoginedUser(HttpSession session, UserAccount user) {
        session.setAttribute(ATT_NAME_LOGIN_USER, user);
    }//storeLoginedUser

    public static UserAccount getLoginedUser(HttpSession session) {
        return (UserAccount) session.getAttribute(ATT_NAME_LOGIN_USER);
    }//getLoginedUser

//  Store info in cookie    
    public static void storeUserCookie(HttpServletResponse response, UserAccount user) {
        System.out.println("Store user cookie");
        Cookie cookie = new Cookie(ATT_NAME_USER_NAME, user.getUserName());
        // 1 day (Converted to seconds)
        cookie.setMaxAge(24 * 60 * 60);
        response.addCookie(cookie);
    }//storeUserCookie

    public static String getUserNameInCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(ATT_NAME_USER_NAME)) {
                return cookie.getValue();
            }
        }
        return null;
    }

    public static void deleteUserCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie(ATT_NAME_USER_NAME, null);
        // 1 day (Converted to seconds)
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }//storeUserCookie
}
