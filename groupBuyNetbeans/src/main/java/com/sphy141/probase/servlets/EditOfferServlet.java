
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Offer;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.ProductFilter;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/editoffer"})
@MultipartConfig(
    fileSizeThreshold= 1024 *1024 * 1,
    maxRequestSize= 1024 *1024 * 100
)
public class EditOfferServlet extends HttpServlet {
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
            resp.sendRedirect(req.getContextPath()+"/home");
            return;
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
                resp.sendRedirect(req.getContextPath()+"/login");
                return;
            }
        }
        req.setAttribute("notificationsCount", notificationsCount);
        //------------------CHECK LOGINED USER - BUSINESS - GET NOTIFICATIONS------------------TEMPLATE END
        
        List<String> productList = null;
        List<Product> businessProductList = null;
        try {
            productList = null;
            businessProductList = DBUtils.queryProductsInBusiness(conn, business.getBusinessID());

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (businessProductList == null) {
            errorString = "There was a problem with products";
        }
        req.setAttribute("productList", productList);
        req.setAttribute("businessProductList", businessProductList);

        
        RequestDispatcher dispatcher = this.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/createOfferView.jsp");
        dispatcher.forward(req, resp);
        
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);

        if (business == null) {
            resp.sendRedirect(req.getContextPath() + "/home");  // REDIRECT TO ACCESS DENIED PAGE
            return;
        }
        else
            req.setAttribute("loginedbusiness", business);
        
        req.setAttribute("errorString", "Servlet not implemented yet");
        if(true){
            RequestDispatcher dispatcher = this.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/createOfferView.jsp");
            dispatcher.forward(req, resp);
            return;
        }
            
        String name = req.getParameter("oname");
        String ofinalprice = req.getParameter("ofinalprice");//
        String odiscount = req.getParameter("odiscount");
        String oexdate = req.getParameter("oexpdate");
        String oexcoupon = req.getParameter("oecoupon");
        String couponprice = req.getParameter("couponprice");
        String osize = req.getParameter("osize");
        String image = req.getParameter("oimage");
        String details = req.getParameter("odetails");
        String codes = req.getParameter("codes");
        
        ServletContext context = getServletContext();
        String realPath = context.getRealPath("/assets/databaseImages/offers/");
        String uploadDirectory = realPath+"\\";  // Specify the directory where you want to save the files
        Path directoryPath = Paths.get(uploadDirectory);
        try {
            // Create the directory if it doesn't exist
            Files.createDirectories(directoryPath);
            System.out.println("Directory created: " + directoryPath);
        } catch (IOException e) {
            // Handle the exception if directory creation fails
            System.out.println("Error creating directory: " + directoryPath);
            e.printStackTrace();
        }
        
    
        Collection<Part> imageParts = req.getParts();
        List<Part> imageFiles = new ArrayList<>(imageParts);
        List<String> imagePaths = new ArrayList<String>();
        // Process the uploaded image files
        for (Part imageFile : imageFiles) {
            // Perform your desired operations with the image file
            
            String fileName = imageFile.getSubmittedFileName();
            if(fileName==null)
                continue;
            Path filePath = Paths.get(uploadDirectory, fileName);
            try {
                // Save the file to the specified directory
                Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
//                imageFile.write(filePath.toString());
                imagePaths.add("assets/databaseImages/offers/"+"/"+fileName);
                System.out.println("File saved: " + filePath);
            } catch (IOException e) {
                // Handle the exception if file saving fails
                System.out.println("Error saving file: " + filePath);
                e.printStackTrace();
            }     
            
        }//for
            String path = imagePaths.get(0);
            
                    /* Collection<Part> businesPro = req.getBussinessProducts();       
        List<Part> productCodes = new ArrayList<>(businesPro);
        //proses to upload productcodes
        for (Part productCodes : productCodes ) {
            // Perform your desired operations with the image file
            
            String  = imageFile.getSubmittedFileName();
            if(fileName==null)
                continue;
            Path filePath = Paths.get(uploadDirectory, fileName);
            try {
                // Save the file to the specified directory
                Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
//                imageFile.write(filePath.toString());
                imagePaths.add("assets/databaseImages/offers/"+"/"+fileName);
                System.out.println("File saved: " + filePath);
            } catch (IOException e) {
                // Handle the exception if file saving fails
                System.out.println("Error saving file: " + filePath);
                e.printStackTrace();
            }
            
        }//for
        
        */
        String errorString = null;
        float finalprice =0;
        float offerdiscount =0;
        int size = 1;
        float coupprise=0;
        LocalDate exdate =LocalDate.now();
        LocalDate excoupon=LocalDate.now();
        LocalDate currentDate = LocalDate.now();
        try {
            size = Integer.parseInt(osize);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "Group size is not a regular number";
        }//try-catch
        
        try {
            finalprice = Float.parseFloat(ofinalprice);
            if (finalprice <0.0) {
            errorString = "Product price cannot be negative";
        }//
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The final price is not a number";
        }//try-catch
        
        try {
            offerdiscount = Float.parseFloat(odiscount);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The price is not a number";
        }//try-catch
        
        try {
            coupprise = Float.parseFloat(couponprice);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The price is not a number";
        }//try-catch
        
        String regex = "\\w+";
        
        if (name==null || name.length() == 0) {
            errorString = "Product name cannot be empty";
        }//iff
        
        if (details == null || details.length() == 0) {
            errorString = "Product details cannot be empty";
        }//iff
        if (imagePaths == null) {
            errorString = "Product must have at least 1 image";
        }//iff
        
       try {
            exdate = LocalDate.parse(oexdate);
            if (exdate == null || exdate.isBefore(currentDate)) {
            errorString = "Offer Expire day must not be today or before today";
            }//iff
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "Offer expire day is not valid";
        }//try-catch
       
       
        try {
            excoupon = LocalDate.parse(oexcoupon);
         
            if (excoupon == null || excoupon.isBefore(currentDate)) {
            errorString = "Coupon Expire day must not be today or before today";
        }//iff
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "Coupon expire day is not valid";
        }//try-catch
        
        Offer offer = new Offer();
        
        if (errorString == null) {
           
            Connection conn = MyUtils.getStoredConnection(req);
            
            //try {   
                    offer.setDiscount(offerdiscount);
                    offer.setGroupSize(size);
                    offer.setOfferExpire(oexdate);
                    offer.setCouponExpire(oexcoupon);
                    offer.setTitle(name);
                    offer.setFinalprice(finalprice);
                    offer.setCouponPrice(coupprise);
                    offer.setDetails(details);
                    offer.setPath(path);
                    //DBUtils.insertOffer(conn, offer); 
                    resp.sendRedirect(req.getContextPath() + "/offerlist");
                    
                
            //} catch (SQLException ex) {
                //ex.printStackTrace();
                errorString = "There is a problem with the database";
            //}
        }//if
        if (errorString != null) {
            req.setAttribute("errorString", errorString);
            RequestDispatcher dispatcher = this.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/createProductView.jsp");
            dispatcher.forward(req, resp);
        }  //if       
    }
}