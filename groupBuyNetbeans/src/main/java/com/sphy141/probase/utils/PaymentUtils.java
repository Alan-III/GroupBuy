/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.sphy141.probase.beans.Transaction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Alan
 */
public class PaymentUtils {
    
    public static void processPayPalPayment(Connection conn, Transaction transaction) {
        try {
            // Disable auto-commit to start a transaction
            conn.setAutoCommit(false);
            
            // Insert the payment record
            String sql = "INSERT INTO payments (accountEmail, amount, details, date, type, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, transaction.getAccountEmail());
            statement.setDouble(2, transaction.getAmount());
            statement.setString(3, transaction.getDetails());
            statement.setString(4, transaction.getDate());
            statement.setString(5, transaction.getType());
            statement.setString(6, transaction.getStatus());
            statement.executeUpdate();

            // Here, you would integrate with the PayPal API
            // and handle the payment confirmation process
            // If the payment is successful, update the status to "completed"
            // If the payment fails or is canceled, update the status to "failed"

            // Update the payment status based on the PayPal API response
            String updateSql = "UPDATE payments SET status = ? WHERE accountEmail = ?";
            PreparedStatement updateStatement = conn.prepareStatement(updateSql);
            updateStatement.setString(1, "completed"); // or "failed" based on the PayPal response
            updateStatement.setString(2, transaction.getAccountEmail());
            updateStatement.executeUpdate();

            // Commit the transaction
            conn.commit();

            System.out.println("Payment record inserted and status updated successfully!");

        } catch (SQLException e) {
            // Rollback the transaction if an error occurs
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }

            e.printStackTrace();
        }
    }
}
