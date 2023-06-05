/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

/**
 *
 * @author Alan
 */
import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.UserAccount;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtils {
    
    public static void sendMail(UserAccount user) throws AddressException, MessagingException {
        String fromEmail = "mygroupbuy8@gmail.com";
        String password = "ohbmbkantkphspho";
        
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.starttls.enable", "true");
        //paaqixermthcsqsc
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(fromEmail,password);
            }
        }); // gives the authentication to send email
        
        Message msg = new MimeMessage(session);
        
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
        
        msg.setSubject("User Verification");
        msg.setText("Registration success. Please verify your account using this code: CODE");
        //user.verificationCode
        Transport.send(msg);
    }
    
    public static void sendMail(BusinessAccount business) throws AddressException, MessagingException {
        String fromEmail = "mygroupbuy8@gmail.com";
        String password = "ohbmbkantkphspho";
        
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.starttls.enable", "true");
        //paaqixermthcsqsc
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(fromEmail,password);
            }
        }); // gives the authentication to send email
        
        Message msg = new MimeMessage(session);
        
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(business.getEmail()));
        
        msg.setSubject("Business Verification");
        msg.setText("Registration success. Please verify your account using this code: CODE");
        //user.verificationCode
        Transport.send(msg);
    }
}