/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import com.sphy141.probase.beans.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Alan
 */
public class PaymentUtils {
    private static final String CLIENT_ID = "AXs6H0x4pAvgK7AETNsfSbYd1MOMyfmNZZzcPPppfxGk1NKBOVukD-fXSXaRBGSTWK_BsvyfWcVOQGTA";
    private static final String CLIENT_SECRET = "ED4JnKtscwQAn7YKTgKjuSC68kTdTHFXpssOC_juokF4gypB0T8NTPoNrtKDG1FNI8jLXKwfQM1GAYth";
    private static final String MODE = "sandbox";           //CHANGE TO LIVE
    
    public static String authorizePayment(OrderDetails orderDetails) throws PayPalRESTException{
        Payer payer = getPayerInformation();
        RedirectUrls redirectUrls = getRedirectUrls();
        List<Transaction> listTransaction = getTransactionInformation(orderDetails);
        
        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction)
                .setRedirectUrls(redirectUrls)
                .setPayer(payer)
                .setIntent("authorize");
        
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        Payment approvedPayment = requestPayment.create(apiContext);
        
        System.out.println(approvedPayment);
        
        return getApprovalLink(approvedPayment);
    }
    
    private static String getApprovalLink(Payment approvedPayment){
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;
        
        for (Links link : links){
            if(link.getRel().equalsIgnoreCase("approval_url")){
                approvalLink = link.getHref();
            }
        }
        return approvalLink;
    }
    
    private static List<Transaction> getTransactionInformation(OrderDetails orderDetails){
        Details details = new Details();
        details.setShipping(orderDetails.getShipping());
        details.setSubtotal(orderDetails.getSubtotal());
        details.setTax(orderDetails.getTax());
        
        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(orderDetails.getTotal());
        amount.setDetails(details);
        
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription(orderDetails.getDetails()); //getProductName??
        
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<Item>();
        
        Item item = new Item();
        item.setCurrency("USD")
                .setName(orderDetails.getDetails()) //getProductName??
                .setPrice(orderDetails.getSubtotal())
                .setTax(orderDetails.getTax())
                .setQuantity("1");
        
        items.add(item);
        itemList.setItems(items);
        transaction.setItemList(itemList);
        
        List<Transaction> listTransaction = new ArrayList<Transaction>();
        listTransaction.add(transaction);
                
        return listTransaction;
    }
    
    private static RedirectUrls getRedirectUrls() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/groupbuy/cancelurl");           //CHANGE
        redirectUrls.setReturnUrl("http://localhost:8080/groupbuy/reviewpayment");           //CHANGE
        return redirectUrls;
    }
    
    public static Payment getPaymentDetails(String paymentId) throws PayPalRESTException{
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }
    
    public static Payment executePayment(String paymentId, String payerId) throws PayPalRESTException{
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);
        
        Payment payment = new Payment().setId(paymentId);
        
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        
        return payment.execute(apiContext, paymentExecution);
    }

    private static Payer getPayerInformation() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
        
        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName("William")           //CHANGE
                .setLastName("Peterson")           //CHANGE
                .setEmail("sb-pvz6f26155168@personal.example.com");           //CHANGE
        payer.setPayerInfo(payerInfo);
        
        return payer;
    }
    
    
    public static void processPayPalPayment(Connection conn, OrderDetails orderDetails) {
        try {
            // Disable auto-commit to start a orderDetails
            conn.setAutoCommit(false);
            
            // Insert the payment record
            String sql = "INSERT INTO payments (accountEmail, amount, details, date, type, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, orderDetails.getAccountEmail());
            statement.setString(2, orderDetails.getTotal());
            statement.setString(3, orderDetails.getDetails());
            statement.setString(4, orderDetails.getDate());
            statement.setString(5, orderDetails.getType());
            statement.setString(6, orderDetails.getStatus());
            statement.executeUpdate();

            // Here, you would integrate with the PayPal API
            // and handle the payment confirmation process
            // If the payment is successful, update the status to "completed"
            // If the payment fails or is canceled, update the status to "failed"

            // Update the payment status based on the PayPal API response
            String updateSql = "UPDATE payments SET status = ? WHERE accountEmail = ?";
            PreparedStatement updateStatement = conn.prepareStatement(updateSql);
            updateStatement.setString(1, "completed"); // or "failed" based on the PayPal response
            updateStatement.setString(2, orderDetails.getAccountEmail());
            updateStatement.executeUpdate();

            // Commit the orderDetails
            conn.commit();

            System.out.println("Payment record inserted and status updated successfully!");

        } catch (SQLException e) {
            // Rollback the orderDetails if an error occurs
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
