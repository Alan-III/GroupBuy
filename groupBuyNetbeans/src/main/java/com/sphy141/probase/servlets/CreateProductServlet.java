/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.servlets;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.utils.DBUtils;
import com.sphy141.probase.utils.MyUtils;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.SQLException;
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
 * 3.3.8 3.3.1
 *
 * @author Alan
 */
@WebServlet(urlPatterns = {"/createproduct"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxRequestSize = 1024 * 1024 * 100
)
public class CreateProductServlet extends HttpServlet {

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
        List<Category> listall = null;
        List<Category> genlist = new ArrayList<>();
        List<Category> midlist = new ArrayList<>();
        List<Category> sublist = new ArrayList<>();
        try {
            listall = DBUtils.queryCategories(conn);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        for (Category category : listall) {
            if (category.getSubCategory() != null) {
                sublist.add(category);
            } else if (category.getMidCategory() != null) {
                midlist.add(category);
            } else {
                genlist.add(category);
            }
        }
        req.setAttribute("genCategory", genlist);
        req.setAttribute("category", midlist);
        req.setAttribute("subCategory", sublist);
        RequestDispatcher dispatcher = this.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/createProductView.jsp");
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

        String name = req.getParameter("pname");
        String barcode = req.getParameter("pbarcode");
        String strPrice = req.getParameter("pprice");
        String details = req.getParameter("pdetails");
        String generalCategory = req.getParameter("generalCategory");
        String midCategory = req.getParameter("category");
        String subcategory = req.getParameter("subcategory");
        ServletContext context = getServletContext();
        String realPath = context.getRealPath("/assets/databaseImages/products/");
        //TARGET DIRECTORY (DELETED WITH EACH BUILD)
//        String uploadDirectory = realPath+barcode+"\\";  // Specify the directory where you want to save the files
        //SRC DIRECTORY (UPDATES TARGET)
        String srcDirectory = "C:\\Users\\Alan\\Documents\\Repos\\GroupBuy\\groupBuyNetbeans\\src\\main\\webapp\\assets\\databaseImages\\products\\" + barcode + "\\";  // Specify the directory where you want to save the files
//        Path directoryPath = Paths.get(uploadDirectory);
        Path directorysrcPath = Paths.get(srcDirectory);
        try {
            // Create the directory if it doesn't exist
//            Files.createDirectories(directoryPath);
            Files.createDirectories(directorysrcPath);
            System.out.println("Directory created: " + directorysrcPath);
        } catch (IOException e) {
            // Handle the exception if directory creation fails
            System.out.println("Error creating directory: " + directorysrcPath);
            e.printStackTrace();
        }
        Collection<Part> imageParts = req.getParts();
        List<Part> imageFiles = new ArrayList<>(imageParts);
        List<String> imagePaths = new ArrayList<String>();
        // Process the uploaded image files
        for (Part imageFile : imageFiles) {
            // Perform your desired operations with the image file

            String fileName = imageFile.getSubmittedFileName();
            if (fileName == null) {
                continue;
            }
//            Path filePath = Paths.get(uploadDirectory, fileName);
            Path filesrcPath = Paths.get(srcDirectory, fileName);
            try {
                // Save the file to the specified directory
//                Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                Files.copy(imageFile.getInputStream(), filesrcPath, StandardCopyOption.REPLACE_EXISTING);
//                imageFile.write(filePath.toString());
                imagePaths.add("assets/databaseImages/products/" + barcode + "/" + fileName);
                System.out.println("File saved: " + filesrcPath);
            } catch (IOException e) {
                // Handle the exception if file saving fails
                System.out.println("Error saving file: " + filesrcPath);
                e.printStackTrace();
            }
        }

        float price = 0;
        String errorString = null;
        try {
            price = Float.parseFloat(strPrice);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = "The price is not a number";
        }//try-catch
        String regex = "\\w+";
        if (barcode == null || !barcode.matches(regex)) {
            errorString = "Product code is invalid";
        }//if
        if (name == null || name.length() == 0) {
            errorString = "Product name cannot be empty";
        }//
        if (price < 0) {
            errorString = "Product price cannot be negative";
        }//
        if (details == null || details.length() == 0) {
            errorString = "Product details cannot be empty";
        }//
        if (imagePaths == null) {
            errorString = "Product must have at least 1 image";
        }//
        if (generalCategory == null) {
            errorString = "Product must belong to a category";
        }//

        Product product = new Product();
        if (errorString == null) {

            Connection conn = MyUtils.getStoredConnection(req);
            try {
                product = DBUtils.findProduct(conn, barcode);
                if (product != null) {
                    errorString = "Product BarCode exists";
                } else {
                    Category category = new Category();
                    category.setGenCategory(generalCategory);
                    category.setMidCategory(midCategory);
                    category.setSubCategory(subcategory);

                    category = DBUtils.findCategory(conn, category);
                    if (category == null) {
                        errorString = "Category doesn't exist";
                    } else {

                        product = new Product();
                        product.setCode(barcode);
                        product.setName(name);
                        product.setPrice(price);
                        product.setDetails(details);
                        product.setImagePaths(imagePaths);
                        product.setCategoryID(category.getCategoryID());

                        DBUtils.insertProduct(conn, product);
                        resp.sendRedirect(req.getContextPath() + "/productlist");
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                errorString = "There is a problem with the database";
            }
        }//if
        if (errorString != null) {

            req.setAttribute("errorString", errorString);
            RequestDispatcher dispatcher = this.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/createProductView.jsp");
            dispatcher.forward(req, resp);
        }  //if       
    }
}
