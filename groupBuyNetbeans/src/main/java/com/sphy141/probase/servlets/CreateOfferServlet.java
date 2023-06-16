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
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/createoffer"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxRequestSize = 1024 * 1024 * 100
)
public class CreateOfferServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        BusinessAccount business = MyUtils.getLoginedBusiness(session);
        String errorString = null;
        if (business == null) {
            resp.sendRedirect(req.getContextPath() + "/home");  // REDIRECT TO ACCESS DENIED PAGE
            return;
        } else {
            req.setAttribute("loginedbusiness", business);
        }

        Connection conn = MyUtils.getStoredConnection(req);

        List<Product> businessProductList = null;
        try {
            businessProductList = DBUtils.queryProductsInBusiness(conn, business.getBusinessID());

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (businessProductList == null) {
            errorString = "There was a problem with products";
        }
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
        } else {
            req.setAttribute("loginedbusiness", business);
        }

        

        String name = req.getParameter("oname");
        String ofinalprice = req.getParameter("ofinalprice");//
        String odiscount = req.getParameter("odiscount");
        String oexdate = req.getParameter("oexpdate");
        String couponprice = req.getParameter("ocouponprice");
        String osize = req.getParameter("osize");
        String image = req.getParameter("oimage");
        String details = req.getParameter("odetails");
        String codes = req.getParameter("codes");
        int randomfolder1= (int) (10000000*Math.random());
        ServletContext context = getServletContext();
        String realPath = context.getRealPath("/assets/databaseImages/offers/");
        String uploadDirectory = realPath + "\\..\\..\\..\\..\\..\\src\\main\\webapp\\assets\\databaseImages\\offers\\" + business.getBusinessName() + "\\" + randomfolder1 +  "\\";  // Specify the directory where you want to save the files
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
        String imagePath= null;
        // Process the uploaded image files
        for (Part imageFile : imageFiles) {
            // Perform your desired operations with the image file

            String fileName = imageFile.getSubmittedFileName();
            if (fileName == null) {
                continue;
            }
            Path filePath = Paths.get(uploadDirectory, fileName);
            try {
                // Save the file to the specified directory
                Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
//                imageFile.write(filePath.toString());
                imagePaths.add("assets/databaseImages/offers/" +business.getBusinessName() + "/" + randomfolder1 + "/" + fileName);
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
        float finalprice = 0;
        float offerdiscount = 0;
        int size = 1;
        float coupprise = 0;
        LocalDate exdate = LocalDate.now();
        LocalDate excoupon = LocalDate.now();
        LocalDate currentDate = LocalDate.now();
        try {
            size = Integer.parseInt(osize);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "Group size is not a regular number";
        }//try-catch

        try {
            finalprice = Float.parseFloat(ofinalprice);
            if (finalprice < 0.0) {
                errorString = "Product price cannot be negative";
            }//
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The final price is not a number" + finalprice;
            
        }//try-catch

        try {
            offerdiscount = Float.parseFloat(odiscount);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The offer discount is not a number"+ offerdiscount;
        }//try-catch

        try {
            coupprise = Float.parseFloat(couponprice);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The cprice is not a number"+couponprice;
        }//try-catch

        String regex = "\\w+";

        if (name == null || name.length() == 0) {
            errorString = "Product name cannot be empty";
        }//iff

        if (details == null || details.length() == 0) {
            errorString = "Product details cannot be empty";
        }//iff
        if (imagePath == null) {
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

         // Retrieve the productCodes
        String productCodesJson = req.getParameter("productCodes");
            List<String>  productCodes = new ArrayList<String>();

        if (productCodesJson != null) {
            JSONArray productCodesArray = new JSONArray(productCodesJson);


            for (int i = 0; i < productCodesArray.length(); i++) {
                String productCode = productCodesArray.getString(i);

                if (productCode != null && !productCode.isEmpty()) {
                    productCodes.add(productCode);
                }
            }

            // Now you have the product codes in the 'productCodes' array
        }
        //------------------------------------------------------// 

        Offer offer = new Offer();

        if (errorString == null) {

            Connection conn = MyUtils.getStoredConnection(req);

            try {
                offer.setDiscount(offerdiscount);
                offer.setGroupSize(size);
                offer.setOfferExpire(oexdate);
                offer.setTitle(name);
                offer.setFinalprice(finalprice);
                offer.setCouponPrice(coupprise);
                offer.setDetails(details);
                offer.setPath(path);
                DBUtils.CreateOffer(conn, offer, business.getEmail(), productCodes);
                resp.sendRedirect(req.getContextPath() + "/offerlist");

            } catch (SQLException ex) {
                ex.printStackTrace();
                errorString = "There is a problem with the database";
            }
        }//if
        if (errorString != null) {
            req.setAttribute("errorString", errorString);
            RequestDispatcher dispatcher = this.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/createOfferView.jsp");
            dispatcher.forward(req, resp);
        }  //if       

    }
}
