/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Offer;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.UserAccount;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class DBUtils {

    public static UserAccount findUser(Connection conn, String loginEmail, String password) throws SQLException {
        String sql = "SELECT firstName, lastName, userID, phoneNum, balance, userName, bankAccount, u.email as email FROM users u INNER JOIN login l "
                + "ON u.email=l.email WHERE u.email = ?  AND password = ? AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, loginEmail);
        pst.setString(2, password);
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

    public static UserAccount findUser(Connection conn, String loginEmail) throws SQLException {
        String sql = "SELECT firstName, lastName, userID, phoneNum, balance, userName, bankAccount, u.email as email FROM users u INNER JOIN login l "
                + "ON u.email=l.email WHERE u.email = ?  AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, loginEmail);
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
    
    public static int insertUser(Connection conn, UserAccount user) throws SQLException {
        //insertDetails
        String sql = "INSERT INTO users (firstName, lastName, email, userName, verificationCode) VALUES(?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, user.getFirstName());
        pst.setString(2, user.getLastName());
        pst.setString(3, user.getEmail());
        pst.setString(4, user.getUserName());
        pst.setString(5, user.getVerificationCode());
        pst.executeUpdate();
        //insertPassword
        String sql1 = "INSERT INTO login (email, password) VALUES(?, ?)";
        PreparedStatement pst1 = conn.prepareCall(sql1);
        pst1 = conn.prepareCall(sql1);
        pst1.setString(1, user.getEmail());
        pst1.setString(2, user.getPassword());
        pst1.executeUpdate();
        
        sql = "SELECT userID FROM users WHERE email = ?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, user.getEmail());
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            return Integer.parseInt(rs.getString("userID"));
        }
        return -1;   
    }//insertUser
    
    public static void updateUser(Connection conn, UserAccount user) throws SQLException {
        String sql = "UPDATE Product SET firstName=?, lastName=?, phoneNum=?, balance=?, userName=?, bankAccount=? WHERE email=?";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, user.getFirstName());
        pst.setString(2, user.getLastName());
        pst.setString(3, user.getPhoneNum());
        pst.setDouble(4, user.getBalance());
        pst.setString(5, user.getUserName());
        pst.setString(6, user.getBankAccount());
        pst.setString(7, user.getEmail());
        pst.executeUpdate();
    }//updateUser
    
    public static boolean verifyUser(Connection conn, UserAccount user) throws SQLException {
        //insertDetails
        String sql = "SELECT * FROM users WHERE userID = ? AND verificationCode=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, user.getUserID());
        pst.setString(2, user.getVerificationCode());
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            String sql1 = "UPDATE users SET enabled=? WHERE userID=?";
            PreparedStatement pst1 = conn.prepareCall(sql1);
            pst1 = conn.prepareCall(sql1);
            pst1.setInt(1, 1);
            pst1.setInt(2, user.getUserID());
            pst1.executeUpdate();
            return true;
        }
        return false;
    }//verifyBusiness

    public static List<Product> queryProduct(Connection conn) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID GROUP BY p.productID";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }//while
        return list;
    }//queryProduct

    public static Product findProduct(Connection conn, String code) throws SQLException {
        String sql = "SELECT *  FROM products WHERE  productCode = ? ";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, code);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setPrice(rs.getFloat("price"));
            prod.setId(rs.getInt("productID"));
            return prod;
        }//while
        return null;
    }//findProduct
    
   
public static List<String> queryBusinnesProducts(Connection conn, int businessID) throws SQLException {
    List<String> codelist = new ArrayList<>();
    String sql = "SELECT productCode FROM businessproducts WHERE businessID = ?";
    PreparedStatement pst = conn.prepareStatement(sql);
    pst.setInt(1, businessID);
    ResultSet rs = pst.executeQuery();
    while (rs.next()) {
        String productCode = rs.getString("productCode");
        codelist.add(productCode);
    }
    return codelist;
}


/*public static Product queryBusinnesOffers(Connection conn) throws SQLException {/////// ΝΑ ΡΩΤΗΣΩ ΑΛΛΕΞΑ
        String sql = "SELECT offerID,title,  FROM offers  WHERE email=? ";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, get;)
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setId(rs.getInt("productID"));
            return prod;
        }//while
        return null;
    }//findProduct
    
  */ 
    
    public static void updateProduct(Connection conn, Product product) throws SQLException {
        String sql = "UPDATE products SET name=?,Price=? WHERE code = ?";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, product.getName());
        pst.setFloat(2, product.getPrice());
        pst.setString(3, product.getCode());
        pst.executeUpdate();
    }//updateProduct

    public static void insertProduct(Connection conn, Product product) throws SQLException {
        String sql = "INSERT INTO products (productCode,productName,details,belong,price) VALUES(?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, product.getCode());
        pst.setString(2, product.getName());
        pst.setString(3, product.getDetails());
        pst.setInt(4, product.getCategoryID());
        pst.setDouble(5, product.getPrice());
        pst.executeUpdate();
        
        List<String> paths = product.getImagePaths();
        Product productNew = findProduct(conn, product.getCode());
        for (String path : paths) {
            String sql2 = "INSERT INTO productphoto (productID,path) VALUES(?,?)";
            PreparedStatement pst2 = conn.prepareCall(sql2);
            pst2.setInt(1, productNew.getId());
            pst2.setString(2, path);
            pst2.executeUpdate();
        }
    }//insertProduct
    
    public static void insertOffer(Connection conn, Offer offer) throws SQLException {
        String sql = "INSERT INTO offers (title,finalPrice,discount,couponPrice,offerExpire,couponExpire,details,groupsize,email) values (?,?,?,?,?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, offer.getTitle());
        pst.setDouble(2, offer.getFinalprice());
        pst.setDouble(3, offer.getDiscount());
        pst.setDouble(4, offer.getCouponPrice());
        pst.setDate(5, Date.valueOf(offer.getOfferExpire()));
        pst.setDate(6, Date.valueOf(offer.getCouponExpire()));
        pst.setString(7, offer.getDetails());
        pst.setDouble(8, offer.getGroupSize());
        /*email*/
        pst.executeUpdate();
        
        
        /*List<String> paths = offer.getImagePaths();
        Product offerNew = findOffer(conn, offer.getOfferID());
        for (String path : paths) {
            String sql2 = "INSERT INTO offerphoto (offerID,path) VALUES(?,?)";
            PreparedStatement pst2 = conn.prepareCall(sql2);
            pst2.setInt(1, offerNew.getId());
            pst2.setString(2, path);
            pst2.executeUpdate();
        }*/
    }//insertProduct
    
    
    /*public static void deleteOffer(Connection conn, String code) throws SQLException {
        String sql = "DELETE FROM products WHERE offerID=? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1,offerID);
        pst.executeUpdate();
    }//deleteProduct
    */
    public static BusinessAccount findBusiness(Connection conn, String loginEmail, String password) throws SQLException {
        String sql = "SELECT businessID, supervisorFirstName, supervisorLastName, balance, businessName,"
                + " IBAN,AFM, b.email as email, password FROM business b INNER JOIN login l ON b.email=l.email WHERE b.email = ? AND password = ?  AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, loginEmail);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            BusinessAccount business = new BusinessAccount();
            business.setBusinessID(Integer.parseInt(rs.getString("businessID")));
            business.setSupervisorFirstName(rs.getString("supervisorFirstName"));
            business.setSupervisorLastName(rs.getString("supervisorLastName"));
            business.setEmail(rs.getString("email"));
            business.setBalance(Double.parseDouble(rs.getString("balance")));
            business.setBusinessName(rs.getString("businessName"));
            business.setIBAN(rs.getString("IBAN"));
            business.setAfm(rs.getString("AFM"));
            business.setPassword(rs.getString("password"));
            return business;
        }
        return null;
    }//findBusiness
    public static BusinessAccount findBusiness(Connection conn, String loginEmail) throws SQLException {
        String sql = "SELECT businessID, supervisorFirstName, supervisorLastName, balance, businessName,"
                + " IBAN,AFM, b.email as email, password FROM business b INNER JOIN login l ON b.email=l.email WHERE b.email = ?  AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, loginEmail);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            BusinessAccount business = new BusinessAccount();
            business.setBusinessID(Integer.parseInt(rs.getString("businessID")));
            business.setSupervisorFirstName(rs.getString("supervisorFirstName"));
            business.setSupervisorLastName(rs.getString("supervisorLastName"));
            business.setEmail(rs.getString("email"));
            business.setBalance(Double.parseDouble(rs.getString("balance")));
            business.setBusinessName(rs.getString("businessName"));
            business.setIBAN(rs.getString("IBAN"));
            business.setAfm(rs.getString("AFM"));
            business.setPassword(rs.getString("password"));
            return business;
        }
        return null;
    }//findBusiness
    
    public static void insertBusiness(Connection conn, BusinessAccount business) throws SQLException {
        //insertDetails
        String sql = "INSERT INTO business (supervisorFirstName, supervisorLastName, email, businessName, verificationCode, AFM, IBAN) VALUES(?,?,?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, business.getSupervisorFirstName());
        pst.setString(2, business.getSupervisorLastName());
        pst.setString(3, business.getEmail());
        pst.setString(4, business.getBusinessName());
        pst.setString(5, business.getVerificationCode());
        pst.setString(6, business.getAfm());
        pst.setString(7, business.getIBAN());
        pst.executeUpdate();
        //insertPassword
        String sql1 = "INSERT INTO login (email, password) VALUES(?, ?)";
        PreparedStatement pst1 = conn.prepareCall(sql1);
        pst1 = conn.prepareCall(sql1);
        pst1.setString(1, business.getEmail());
        pst1.setString(2, business.getPassword());
        pst1.executeUpdate();
    }//insertBusiness
    
    public static boolean verifyBusiness(Connection conn, BusinessAccount business) throws SQLException {
        //insertDetails
        String sql = "SELECT * FROM business WHERE businessID = ? AND verificationCode=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, business.getBusinessID());
        pst.setString(2, business.getVerificationCode());
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            String sql1 = "UPDATE business SET enabled=?";
            PreparedStatement pst1 = conn.prepareCall(sql1);
            pst1 = conn.prepareCall(sql1);
            pst1.setInt(1, 1);
            pst1.executeUpdate();
            return true;
        }
        return false;
    }//verifyBusiness
    
    public static List<Category> queryCategories(Connection conn) throws SQLException {
        String sql = "SELECT * FROM categories";
        List<Category> list = new ArrayList<Category>();
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Category cat = new Category();
            cat.setCategoryID(rs.getInt("CategoryID"));
            if(rs.getString("subCategory")!=null){
                cat.setCategoryName(rs.getString("subCategory"));
                cat.setSubCategory(rs.getString("subCategory"));
                cat.setMidCategory(rs.getString("category"));
                cat.setGenCategory(rs.getString("genCategory"));
            }else if(rs.getString("category")!=null){
                cat.setCategoryName(rs.getString("category"));
                cat.setMidCategory(rs.getString("category"));
                cat.setGenCategory(rs.getString("genCategory"));
            }else{
                cat.setCategoryName(rs.getString("genCategory"));
                cat.setGenCategory(rs.getString("genCategory"));
            }
            cat.setCategoryImagePath(rs.getString("path"));
            list.add(cat);
        }//while
        return list;
    }//queryCategories

    public static Category findCategory(Connection conn, Category category) throws SQLException {
        String sql;
        if(category.getMidCategory()==null){
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category IS NULL AND subCategory IS NULL";
        } else if(category.getSubCategory()==null){
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory IS NULL";
        }else{
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory = ?";
        }
        PreparedStatement pst = conn.prepareStatement(sql);
        if(category.getMidCategory()==null){
            pst.setString(1, category.getGenCategory());
        } else if(category.getSubCategory()==null){
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory IS NULL";
            pst.setString(1, category.getGenCategory());
            pst.setString(2, category.getMidCategory());
        }else{
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory = ?";
            pst.setString(1, category.getGenCategory());
            pst.setString(2, category.getMidCategory());
            pst.setString(3, category.getSubCategory());
        }
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            if(category.getSubCategory()!=null)
                category.setCategoryName(category.getSubCategory());
            else if(category.getMidCategory()!=null)
                category.setCategoryName(category.getMidCategory());
            else
                category.setCategoryName(category.getGenCategory());
            category.setCategoryID(rs.getInt("categoryID"));
            category.setCategoryImagePath(rs.getString("path"));
            return category;
        }//while
        return null;
    }
    
    //GET A LIST OF FILTERS AND VALUES FOR A SPECIFIC CATEGORY NAME
    public static List<ProductFilter> findCategoryFilters(Connection conn, String categoryName) throws SQLException {
        String sql = "SELECT distinct(filterName), f.filtersID, filtervalue FROM catergoryfilters cf INNER JOIN filtersdetails f on cf.filtersID=f.filtersID " +
"INNER JOIN categories c on c.categoryID=cf.categoryID " +
"INNER JOIN productfilters pf on pf.filtersID=f.filtersID WHERE subCategory = ? OR category = ? OR genCategory = ? ORDER BY f.filtersID;";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, categoryName);
        pst.setString(2, categoryName);
        pst.setString(3, categoryName);
        ResultSet rs = pst.executeQuery();
        List<ProductFilter> filtersList = new ArrayList<>();
        ProductFilter filter = null;
        int tmpID=0;
        while (rs.next()) {
            int filterID = rs.getInt("filtersID");
            if(tmpID!=filterID){
                tmpID=filterID;
                if(filter!=null)
                    filtersList.add(filter);
                filter = new ProductFilter();
                filter.setFilterID(rs.getInt("filtersID"));
                filter.setFilterName(rs.getString("filterName"));
            }
            filter.addExistingFilterValues(rs.getString("filtervalue"));
            // Filter unique because of distinct, add it to the list
        }//while
        filtersList.add(filter);
        return filtersList;
    }
    
    //GET SPECIFIC FILTER
    public static ProductFilter findFilter(Connection conn, String name) throws SQLException {
        String sql = "SELECT * FROM filtersdetails WHERE filterName=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, name);
        ResultSet rs = pst.executeQuery();
        ProductFilter filter = null;
        while (rs.next()) {
            filter = new ProductFilter();
            filter.setFilterID(rs.getInt("filtersID"));
            filter.setFilterName(rs.getString("filterName"));
        }//while
        return filter;
    }

    //SAVE FILTERS FOR CREATED PRODUCT
    public static void storeProductFilter(Connection conn, int productID, String filtername, String filtervalue) throws SQLException {
        String sql = "INSERT INTO productfilters (filtersID, productID, filtervalue) VALUES (?,?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, findFilter(conn, filtername).getFilterID());
        pst.setInt(2, productID);
        pst.setString(3, filtervalue);
        pst.executeUpdate();
    }
}
