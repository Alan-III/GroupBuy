/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.conn;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author USER
 */
public class ConnectionUtils {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        return MySQLConnUtils.getMySQLConnection();
    }  //getConnection

    public static void closeQuietly(Connection conn) {
        try {
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static void rollbackQuietly(Connection conn) {
        try {
            conn.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
