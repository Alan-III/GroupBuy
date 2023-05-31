/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.UserAccount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class DBUtils {

    public static UserAccount findUser(Connection conn, String loginName, String password) throws SQLException {
        String sql = "SELECT firstName, lastName, userID, phoneNum, balance, userName, bankAccount, u.email as email FROM users u INNER JOIN login l ON u.email=l.email WHERE (u.email = ? OR u.userName=?) AND password = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, loginName);
        pst.setString(2, loginName);
        pst.setString(3, password);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            UserAccount user = new UserAccount();
            user.setUserID(Integer.parseInt(rs.getString("userID")));
            user.setFirstName(rs.getString("firstName"));
            user.setLastName(rs.getString("lastName"));
            user.setEmail(rs.getString("email"));
            user.setPhoneNum(rs.getString("phoneNum"));
            user.setBalance(Double.parseDouble(rs.getString("balance")));
            user.setUserName(rs.getString("userName"));
            user.setBankAccount(rs.getString("bankAccount"));
            user.setPassword(password);
            return user;
        }
        return null;
    }//findUser

    public static UserAccount findUser(Connection conn, String loginName) throws SQLException {
        String sql = "SELECT firstName, lastName, userID, phoneNum, balance, userName, bankAccount, u.email as email FROM users u INNER JOIN login l ON u.email=l.email WHERE u.email = ? OR u.userName=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, loginName);
        pst.setString(2, loginName);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            UserAccount user = new UserAccount();
            user.setUserID(Integer.parseInt(rs.getString("userID")));
            user.setFirstName(rs.getString("firstName"));
            user.setLastName(rs.getString("lastName"));
            user.setEmail(rs.getString("email"));
            user.setPhoneNum(rs.getString("phoneNum"));
            user.setBalance(Double.parseDouble(rs.getString("balance")));
            user.setUserName(rs.getString("userName"));
            user.setBankAccount(rs.getString("bankAccount"));
            user.setPassword(rs.getString("password"));
            return user;
        }
        return null;
    }//findUser

    public static List<Product> queryProduct(Connection conn) throws SQLException {
        String sql = "SELECT * FROM Product";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("Code"));
            prod.setName(rs.getString("Name"));
            prod.setPrice(rs.getFloat("Price"));
            list.add(prod);
        }//while
        return list;
    }//queryProduct

    public static Product findProduct(Connection conn, String code) throws SQLException {
        String sql = "SELECT *  FROM Product WHERE  code = ? ";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, code);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("Code"));
            prod.setName(rs.getString("Name"));
            prod.setPrice(rs.getFloat("Price"));
            return prod;
        }//while
        return null;
    }//findProduct

    public static void updateProduct(Connection conn, Product product) throws SQLException {
        String sql = "UPDATE Product SET name=?,Price=? WHERE code = ?";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, product.getName());
        pst.setFloat(2, product.getPrice());
        pst.setString(3, product.getCode());
        pst.executeUpdate();
    }//updateProduct

    public static void insertProduct(Connection conn, Product product) throws SQLException {
        String sql = "INSERT INTO Product (code,name,Price) VALUES(?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, product.getCode());
        pst.setString(2, product.getName());
        pst.setFloat(3, product.getPrice());
        pst.executeUpdate();
    }//insertProduct
    
    public static void deleteProduct(Connection conn, String code) throws SQLException {
        String sql = "DELETE FROM Product WHERE code=? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, code);
        pst.executeUpdate();
    }//deleteProduct
}
