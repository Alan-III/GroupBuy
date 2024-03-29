/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Notification;
import com.sphy141.probase.beans.Offer;
import com.sphy141.probase.beans.OrderDetails;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.ProductFilter;
import com.sphy141.probase.beans.UserAccount;
import com.sphy141.probase.utils.CryptoUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author USER
 */
public class DBUtils {

    public static UserAccount findUser(Connection conn, String loginEmail, String password) throws SQLException {
        String sql = "SELECT firstName, lastName, userID, phoneNum, balance, userName, bankAccount, u.email as email FROM users u INNER JOIN login l "
                + "ON u.email=l.email WHERE u.email = ?  AND password = ? AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(loginEmail));
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            UserAccount user = new UserAccount();
            user.setUserID(Integer.parseInt(rs.getString("userID")));
            user.setFirstName(CryptoUtils.decrypt(rs.getString("firstName"))); //decrtypt
            user.setLastName(CryptoUtils.decrypt(rs.getString("lastName")));
            user.setEmail(CryptoUtils.decrypt(rs.getString("email")));
            user.setPhoneNum(rs.getString("phoneNum"));
            user.setBalance(Double.parseDouble(rs.getString("balance")));
            user.setUserName(CryptoUtils.decrypt(rs.getString("userName")));
            user.setBankAccount(CryptoUtils.encrypt(rs.getString("bankAccount")));
            user.setPassword(password);
            return user;
        }
        return null;
    }//findUser

    public static UserAccount findUser(Connection conn, String loginEmail) throws SQLException {
        String sql = "SELECT firstName, lastName, userID, phoneNum, balance, userName, bankAccount, u.email as email FROM users u INNER JOIN login l "
                + "ON u.email=l.email WHERE u.email = ?  AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(loginEmail));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            UserAccount user = new UserAccount();
            user.setUserID(Integer.parseInt(rs.getString("userID")));
            user.setFirstName(CryptoUtils.decrypt(rs.getString("firstName"))); //decrtypt
            user.setLastName(CryptoUtils.decrypt(rs.getString("lastName")));
            user.setEmail(CryptoUtils.decrypt(rs.getString("email")));
            user.setPhoneNum(rs.getString("phoneNum"));
            user.setBalance(Double.parseDouble(rs.getString("balance")));
            user.setUserName(CryptoUtils.decrypt(rs.getString("userName")));
            user.setBankAccount(CryptoUtils.encrypt(rs.getString("bankAccount")));
            user.setPassword(rs.getString("password"));
            return user;
        }
        return null;
    }//findUser

    public static int insertUser(Connection conn, UserAccount user) throws SQLException {
        //insertDetails
        String sql = "INSERT INTO users (firstName, lastName, email, userName, verificationCode) VALUES(?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, CryptoUtils.encrypt(user.getFirstName()));
        pst.setString(2, CryptoUtils.encrypt(user.getLastName()));
        pst.setString(3, CryptoUtils.encrypt(user.getEmail()));
        pst.setString(4, CryptoUtils.encrypt(user.getUserName()));
        pst.setString(5, user.getVerificationCode());
        pst.executeUpdate();
        //insertPassword
        String sql1 = "INSERT INTO login (email, password) VALUES(?, ?)";
        PreparedStatement pst1 = conn.prepareCall(sql1);
        pst1 = conn.prepareCall(sql1);
        pst1.setString(1, CryptoUtils.encrypt(user.getEmail()));
        pst1.setString(2, user.getPassword());
        pst1.executeUpdate();

        sql = "SELECT userID FROM users WHERE email = ?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(user.getEmail()));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            return Integer.parseInt(rs.getString("userID"));
        }
        return -1;
    }//insertUser

    public static void updateUser(Connection conn, UserAccount user) throws SQLException {
        String sql = "UPDATE Product SET firstName=?, lastName=?, phoneNum=?, balance=?, userName=?, bankAccount=? WHERE email=?";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, CryptoUtils.encrypt(user.getFirstName()));
        pst.setString(2, CryptoUtils.encrypt(user.getLastName()));
        pst.setString(3, user.getPhoneNum());
        pst.setDouble(4, user.getBalance());
        pst.setString(5, CryptoUtils.encrypt(user.getUserName()));
        pst.setString(6, CryptoUtils.encrypt(user.getBankAccount()));
        pst.setString(7, CryptoUtils.encrypt(user.getEmail()));
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

    //GET LIST OF PRODUCTS AND CHECK WITH EMAIL IF SOME OF THEM ARE WISHED. (email should be '' for null users or business)
    public static List<Product> queryProduct(Connection conn, String userEmail) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID "
                + "LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) "
                + "LEFT JOIN (select productCode,count(email) as wishcount from mywish GROUP BY productCode) c ON c.productCode=p.productCode GROUP BY p.productID";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, userEmail);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            prod.setWishesCount(rs.getInt("wishcount"));
            if (rs.getString("email") != null) {
                prod.setIsWished(true);
            }
            list.add(prod);
        }//while
        return list;
    }//queryProduct

    //GET DATA OF CERTAIN PRODUCT AND CHECK WITH EMAIL IF IT IS WISHED. (email should be '' for null users or business)
    public static Product findProduct(Connection conn, String code, String userEmail) throws SQLException {
        String sql = "SELECT *  FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID "
                + "LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) "
                + "INNER JOIN (select count(email) as wishcount from mywish a where productCode=?) c WHERE  p.productCode = ? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(userEmail));
        pst.setString(2, code);
        pst.setString(3, code);
        ResultSet rs = pst.executeQuery();
        Product prod = null;
        while (rs.next()) {
            if (prod == null) {
                prod = new Product();
                prod.setCode(rs.getString("productCode"));
                prod.setName(rs.getString("productName"));
                prod.setDetails(rs.getString("details"));
                prod.setPrice(rs.getFloat("price"));
                prod.setId(rs.getInt("productID"));
                prod.setCategoryID(rs.getInt("belong"));
                prod.setWishesCount(rs.getInt("wishcount"));
                if (rs.getString("email") != null) {
                    prod.setIsWished(true);
                }
            }
            prod.addImagePath(rs.getString("path"));
        }//while
        return prod;
    }//findProduct

// GET PRODUCTS OF A CERTAIN BUSINESS
    public static List<Product> queryProductsInBusiness(Connection conn, int businessID) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM businessproducts bp INNER JOIN products p ON p.productCode=bp.productCode INNER JOIN productphoto pp ON p.productID=pp.productID WHERE businessID = ? GROUP BY pp.productID";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, businessID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }
        return list;
    }

// INSERT PRODUCTS IN A CERTAIN OFFER
    public static List<Product> insertProductInOffer(Connection conn, int businessID, String productCode) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM businessproducts bp INNER JOIN products p ON p.productCode=bp.productCode INNER JOIN productphoto pp ON p.productID=pp.productID WHERE businessID = ? GROUP BY pp.productID";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, businessID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }
        return list;
    }

    public static Offer findOffer(Connection conn, int offerID) throws SQLException {
        String sql = "SELECT *,(SELECT count(*) FROM coupontokens WHERE offerID=?) as participants FROM offers o INNER JOIN offerdetails od ON o.offerID=od.offerID "
                + "INNER JOIN products p ON od.productCode=p.productCode WHERE o.offerID = ? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, offerID);
        pst.setInt(2, offerID);
        ResultSet rs = pst.executeQuery();
        Offer offer = null;
        List<Product> productlist = new ArrayList<Product>();
        while (rs.next()) {
            if (offer == null) {
                offer = new Offer();
                offer.setTitle(rs.getString("title"));
                offer.setFinalprice(rs.getFloat("finalPrice"));
                offer.setDiscount(rs.getFloat("discount"));
                offer.setDetails(rs.getString("details"));
                offer.setCouponPrice(rs.getFloat("couponPrice"));
                offer.setGroupSize(rs.getInt("groupSize"));
                offer.setId(rs.getInt("offerID"));
                offer.setOfferExpire(rs.getString("offerExpire"));
                offer.setPath(rs.getString("path"));
                offer.setParticipants(rs.getInt("participants"));
                offer.setStatus(rs.getString("status"));
            }
            Product pro = findProduct(conn, rs.getString("productCode"), "");
            offer.addProductInList(pro);
        }//while
        return offer;
    }//findOffer

    //GET LIST OF PRODUCTS IN AN OFFER
    public static List<Product> queryProductsInOffer(Connection conn, int offerID, int businessID) throws SQLException {
        String sql = "SELECT bp.productID,bp.productCode,p.productName,p.details,p.price\n"
                + "from offers o \n"
                + "inner join business b  on o.email=b.email\n"
                + "inner jOIN offerdetails od on o.offerID=od.offerID\n"
                + "inner JOIN businessproducts bp ON od.productCode=bp.productCode \n"
                + "inner join products p on bp.productCode=p.productCode \n"
                + "where o.offerID=? AND \n"
                + "businessID=?;";

        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, offerID);
        pst.setInt(2, businessID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }//while
        return list;
    }

    //INSERT NEW OFFER TO DB
    public static void insertOffer(Connection conn, Offer offer, String email, List<String> productCodes) throws SQLException {
        String sql = "insert into offers (title,finalPrice,discount,couponPrice,offerExpire,details,email,path,groupSize,status) values (?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, offer.getTitle());
        pst.setFloat(2, offer.getFinalprice());
        pst.setFloat(3, offer.getDiscount());
        pst.setFloat(4, offer.getCouponPrice());
        pst.setString(5, offer.getOfferExpire());
        pst.setString(6, offer.getDetails());
        pst.setString(7, email);
        pst.setString(8, offer.getPath());
        pst.setInt(9, offer.getGroupSize());
        pst.setString(10, offer.getStatus());
        pst.executeUpdate();

        ResultSet generatedKeys = pst.getGeneratedKeys();
        if (generatedKeys.next()) {
            int offerID = generatedKeys.getInt(1);
            offer.setId(offerID);

            for (String productCode : productCodes) {
                //INSERT LIST OF PRODUCTS IN OFFERDETAILS
                sql = "insert into offerdetails (offerID,productCode) values (?,?)";
                pst = conn.prepareCall(sql);
                pst.setInt(1, offerID);
                pst.setString(2, productCode);
                pst.executeUpdate();

                //INSERT NOTIFICATIONS FOR EACH PRODUCT
                insertNotification(conn, offer, productCode, "New offer");
            }//for
        }

    }//findOffer

    //INSERT NOTIFICATION
    public static void insertNotification(Connection conn, Offer offer, String productCode, String title) throws SQLException {
                String sql = "insert into notifications (title,details,offerID,productCode,notificationDate) values (?,?,?,?,NOW())";
                PreparedStatement pst = conn.prepareCall(sql);
                pst.setString(1, title);
                pst.setString(2, offer.getDetails());
                pst.setInt(3, offer.getId());
                pst.setString(4, productCode);
                pst.executeUpdate();
    }
    
    /*
public static void UpdateOffer(Connection conn,Offer offer) throws SQLException {
        String sql = "INSERT INTO   FROM offers WHERE  offerID = ? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, offerID);
        ResultSet rs = pst.executeQuery();
        Offer offer = new Offer();
        while (rs.next()) {
            offer.setTitle(rs.getString("title"));
            offer.setFinalprice(rs.getFloat("finalPrice"));
            offer.setDiscount(rs.getFloat("discount"));
            offer.setDetails(rs.getString("details"));
            offer.setCouponPrice(rs.getFloat("couponPrice"));
            offer.setGroupSize(rs.getInt("groupSize"));
            java.sql.Date offerExpireDate = rs.getDate("offerExpire");
            java.time.LocalDate offerExpire = offerExpireDate.toLocalDate();
            offer.setOfferExpire(offerExpire);
            java.sql.Date couponExpireDate = rs.getDate("couponExpire");
            java.time.LocalDate couponExpire = couponExpireDate.toLocalDate();
            
            sql ="SELECT *  FROM offersdetails WHERE  offerID = ? ";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, offerID);
            List<String> productlist = new ArrayList<>();
            rs = pst.executeQuery();
            while (rs.next()){
                String productCode = rs.getString("productCode");
                productlist.add("productCode");
            }            
            sql ="SELECT *  FROM offerphoto WHERE  offerID = ? ";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, offerID);
            List<String> pathlist = new ArrayList<>();
            rs = pst.executeQuery();
            while (rs.next()){
                String productCode = rs.getString("productCode");
                pathlist.add("path");
            }
            offer.setImagePaths(pathlist);
            offer.setProductCode(productlist);
            return offer;            
        }//while
        return null;
    }//findOffer

     */
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
        Product productNew = findProduct(conn, product.getCode(), "");
        for (String path : paths) {
            String sql2 = "INSERT INTO productphoto (productID,path) VALUES(?,?)";
            PreparedStatement pst2 = conn.prepareCall(sql2);
            pst2.setInt(1, productNew.getId());
            pst2.setString(2, path);
            pst2.executeUpdate();
        }
    }//insertProduct  

    public static BusinessAccount findBusiness(Connection conn, String loginEmail, String password) throws SQLException {
        String sql = "SELECT businessID, supervisorFirstName, supervisorLastName, balance, businessName,"
                + " IBAN,AFM, b.email as email, password FROM business b INNER JOIN login l ON b.email=l.email WHERE b.email = ? AND password = ?  AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(loginEmail));
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            BusinessAccount business = new BusinessAccount();
            business.setBusinessID(Integer.parseInt(rs.getString("businessID")));
            business.setSupervisorFirstName(CryptoUtils.decrypt(rs.getString("supervisorFirstName")));
            business.setSupervisorLastName(CryptoUtils.decrypt(rs.getString("supervisorLastName")));
            business.setEmail( CryptoUtils.decrypt(rs.getString("email")));
            business.setBalance(Double.parseDouble(rs.getString("balance")));
            business.setBusinessName(CryptoUtils.decrypt(rs.getString("businessName")));
            business.setIBAN(CryptoUtils.decrypt(rs.getString("IBAN")));
            business.setAfm(CryptoUtils.decrypt(rs.getString("AFM")));
            business.setPassword(rs.getString("password"));
            return business;
        }
        return null;
    }//findBusiness

    public static BusinessAccount findBusiness(Connection conn, String loginEmail) throws SQLException {
        String sql = "SELECT businessID, supervisorFirstName, supervisorLastName, balance, businessName,"
                + " IBAN,AFM, b.email as email, password FROM business b INNER JOIN login l ON b.email=l.email WHERE b.email = ?  AND enabled = 1";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(loginEmail));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            BusinessAccount business = new BusinessAccount();
            business.setBusinessID(Integer.parseInt(rs.getString("businessID")));
            business.setSupervisorFirstName(CryptoUtils.decrypt(rs.getString("supervisorFirstName")));
            business.setSupervisorLastName(CryptoUtils.decrypt(rs.getString("supervisorLastName")));
            business.setEmail( CryptoUtils.decrypt(rs.getString("email")));
            business.setBalance(Double.parseDouble(rs.getString("balance")));
            business.setBusinessName(CryptoUtils.decrypt(rs.getString("businessName")));
            business.setIBAN(CryptoUtils.decrypt(rs.getString("IBAN")));
            business.setAfm(CryptoUtils.decrypt(rs.getString("AFM")));
            business.setPassword(rs.getString("password"));
            return business;
        }
        return null;
    }//findBusiness

    public static int insertBusiness(Connection conn, BusinessAccount business) throws SQLException {
        //insertDetails
        String sql = "INSERT INTO business (supervisorFirstName, supervisorLastName, email, businessName, verificationCode, AFM, IBAN) VALUES(?,?,?,?,?,?,?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, CryptoUtils.encrypt(business.getSupervisorFirstName()));
        pst.setString(2, CryptoUtils.encrypt(business.getSupervisorLastName()));
        pst.setString(3, CryptoUtils.encrypt(business.getEmail()));
        pst.setString(4, CryptoUtils.encrypt(business.getBusinessName()));
        pst.setString(5, business.getVerificationCode());
        pst.setString(6, CryptoUtils.encrypt(business.getAfm()));
        pst.setString(7, CryptoUtils.encrypt(business.getIBAN()));
        pst.executeUpdate();

        //insertPassword
        String sql1 = "INSERT INTO login (email, password) VALUES(?, ?)";
        PreparedStatement pst1 = conn.prepareCall(sql1);
        pst1 = conn.prepareCall(sql1);
        pst1.setString(1, CryptoUtils.encrypt(business.getEmail()));
        pst1.setString(2, business.getPassword());
        pst1.executeUpdate();
        
        sql = "SELECT businessID FROM business WHERE email = ?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(business.getEmail()));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            return Integer.parseInt(rs.getString("businessID"));
        }
        return -1;
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
            if (rs.getString("subCategory") != null) {
                cat.setCategoryName(rs.getString("subCategory"));
                cat.setSubCategory(rs.getString("subCategory"));
                cat.setMidCategory(rs.getString("category"));
                cat.setGenCategory(rs.getString("genCategory"));
            } else if (rs.getString("category") != null) {
                cat.setCategoryName(rs.getString("category"));
                cat.setMidCategory(rs.getString("category"));
                cat.setGenCategory(rs.getString("genCategory"));
            } else {
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
        if (category.getMidCategory() == null) {
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category IS NULL AND subCategory IS NULL";
        } else if (category.getSubCategory() == null) {
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory IS NULL";
        } else {
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory = ?";
        }
        PreparedStatement pst = conn.prepareStatement(sql);
        if (category.getMidCategory() == null) {
            pst.setString(1, category.getGenCategory());
        } else if (category.getSubCategory() == null) {
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory IS NULL";
            pst.setString(1, category.getGenCategory());
            pst.setString(2, category.getMidCategory());
        } else {
            sql = "SELECT * FROM categories WHERE genCategory = ? AND category = ? AND subCategory = ?";
            pst.setString(1, category.getGenCategory());
            pst.setString(2, category.getMidCategory());
            pst.setString(3, category.getSubCategory());
        }
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            if (category.getSubCategory() != null) {
                category.setCategoryName(category.getSubCategory());
            } else if (category.getMidCategory() != null) {
                category.setCategoryName(category.getMidCategory());
            } else {
                category.setCategoryName(category.getGenCategory());
            }
            category.setCategoryID(rs.getInt("categoryID"));
            category.setCategoryImagePath(rs.getString("path"));
            return category;
        }//while
        return null;
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

    //SEARCH KEYWORD AND BRING LIST OF PRODUCTS
    public static List<Product> searchProduct(Connection conn, String keyword, String useremail) throws SQLException {
        String sql = "SELECT * FROM group_buy.products p INNER JOIN productphoto pp ON p.productID=pp.productID"
                + " LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) "
                + "LEFT JOIN (select productCode,count(email) as wishcount from mywish GROUP BY productCode) c ON c.productCode=p.productCode"
                + " WHERE productName like ? or details like ? GROUP BY p.productID;";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(useremail));
        pst.setString(2, "%" + keyword + "%");
        pst.setString(3, "%" + keyword + "%");
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            prod.setWishesCount(rs.getInt("wishcount"));
            if (rs.getString("email") != null) {
                prod.setIsWished(true);
            }
            list.add(prod);
        }//while
        return list;
    }//queryProduct

    //DELETE PRODUCT BY PRODUCTID
    public static void deleteProduct(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM products WHERE productID=? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        pst.executeUpdate();
    }//deleteProduct

    //FIND SPECIFIC CATEGORY
    public static Category findCategory(Connection conn, int categoryID) throws SQLException {
        String sql = "SELECT * FROM categories WHERE categoryID = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, categoryID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getInt("categoryID"));
            if (rs.getString("subCategory") != null) {
                category.setCategoryName(rs.getString("subCategory"));
                category.setSubCategory(rs.getString("subCategory"));
                category.setMidCategory(rs.getString("category"));
                category.setGenCategory(rs.getString("genCategory"));
            } else if (rs.getString("category") != null) {
                category.setCategoryName(rs.getString("category"));
                category.setMidCategory(rs.getString("category"));
                category.setGenCategory(rs.getString("genCategory"));
            } else {
                category.setCategoryName(rs.getString("genCategory"));
                category.setGenCategory(rs.getString("genCategory"));
            }
            category.setCategoryImagePath(rs.getString("path"));
            return category;
        }//while
        return null;
    }

    //GET A LIST OF FILTERS NAMES FOR EACH CATEGORY NAME
    public static Map<String, List<String>> queryCategoryFilters(Connection conn) throws SQLException {
        String sql = "SELECT subCategory,category,genCategory,filterName FROM catergoryfilters cf inner join filtersdetails f on cf.filtersID=f.filtersID \n"
                + "inner join categories c on c.categoryID=cf.categoryID order by subCategory, category, genCategory";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        Map<String, List<String>> categoryFilterMap = new HashMap<>();
        while (rs.next()) {
            String subCategory = rs.getString("subCategory");
            String midCategory = rs.getString("category");
            String genCategory = rs.getString("genCategory");
            String filterName = rs.getString("filterName");
            String categoryName;
            if (subCategory != null) {
                categoryName = subCategory;
            } else if (midCategory != null) {
                categoryName = midCategory;
            } else {
                categoryName = genCategory;
            }

            // Check if the key exists in the map
            if (categoryFilterMap.containsKey(categoryName)) {
                // Key exists, get the list and check if the filter exists
                List<String> filters = categoryFilterMap.get(categoryName);
                if (!filters.contains(filterName)) {
                    // Filter doesn't exist, add it to the list
                    filters.add(filterName);
                }
            } else {
                // Key doesn't exist, create a new list and add the filter
                List<String> filters = new ArrayList<>();
                filters.add(filterName);
                categoryFilterMap.put(categoryName, filters);
            }
        }//while
        return categoryFilterMap;
    }

    //GET A LIST OF FILTERS AND VALUES FOR A SPECIFIC CATEGORY NAME
    public static List<ProductFilter> findCategoryFilters(Connection conn, String categoryName) throws SQLException {
        String sql = "SELECT f.filterName, f.filtersID, pf.filtervalue, countp AS repetitionCount\n"
                + "FROM catergoryfilters cf\n"
                + "INNER JOIN filtersdetails f ON cf.filtersID = f.filtersID\n"
                + "INNER JOIN categories c ON c.categoryID = cf.categoryID\n"
                + "LEFT JOIN (\n"
                + "    SELECT filtersID, filtervalue, COUNT(productID) AS countp\n"
                + "    FROM productfilters\n"
                + "    GROUP BY filtersID, filtervalue\n"
                + ") pf ON pf.filtersID = f.filtersID\n"
                + "WHERE c.subCategory = ? OR c.category = ? OR c.genCategory = ?\n"
                + "GROUP BY f.filterName, f.filtersID, pf.filtervalue\n"
                + "ORDER BY f.filtersID;";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, categoryName);
        pst.setString(2, categoryName);
        pst.setString(3, categoryName);
        ResultSet rs = pst.executeQuery();
        List<ProductFilter> filtersList = new ArrayList<>();
        ProductFilter filter = null;
        int tmpID = 0;
        while (rs.next()) {
            int filterID = rs.getInt("filtersID");
            if (tmpID != filterID) {
                tmpID = filterID;
                if (filter != null) {
                    filtersList.add(filter);
                }
                filter = new ProductFilter();
                filter.setFilterID(rs.getInt("filtersID"));
                filter.setFilterName(rs.getString("filterName"));

            }
            filter.addExistingFilterValues(rs.getString("filtervalue"), rs.getInt("repetitionCount"));
            // Filter unique because of distinct, add it to the list
        }//while
        filtersList.add(filter);
        return filtersList;
    }

    //GET LIST OF PRODUCTS THAT HAVE FILTERS CHECKED
    public static List<Product> filterSearchProduct(Connection conn, String searchQuerry, String useremail) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productfilters pf ON p.productID=pf.productID INNER JOIN productphoto pp ON p.productID=pp.productID"
                + " LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) "
                + "LEFT JOIN (select productCode,count(email) as wishcount from mywish GROUP BY productCode) c ON c.productCode=p.productCode"
                + " WHERE " + searchQuerry + "GROUP BY pp.productID";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(useremail));
        ResultSet rs = pst.executeQuery();
        List<Product> list = new ArrayList<Product>();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setPrice(rs.getFloat("price"));
            prod.setId(rs.getInt("productID"));
            prod.addImagePath(rs.getString("path"));
            prod.setWishesCount(rs.getInt("wishcount"));
            if (rs.getString("email") != null) {
                prod.setIsWished(true);
            }
            list.add(prod);
        }//while
        return list;
    }

    // TOGGLE A PRODUCT IN BUSINESS PRODUCTS. HANDLE DELETE OR INSERT
    public static void toggleBusinessProduct(Connection conn, String productBarcode, int businessID) throws SQLException {
        String sql = "CALL ToggleBusinessProduct(?, ?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, productBarcode);
        pst.setInt(2, businessID);
        pst.executeUpdate();
    }

    //GET LIST OF PRODUCTS NOT PROVIDED BY THE BUSINESS
    public static List<Product> queryProductsNotInBusiness(Connection conn, int businessID) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID LEFT JOIN businessproducts bp ON p.productCode=bp.productCode WHERE businessID != ? OR businessID IS NULL GROUP BY p.productID";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, businessID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }//while
        return list;
    }

    //GET LIST OF PRODUCTS OF A CERTAIN CATEGORY
    public static List<Product> queryProductsInCategory(Connection conn, String categoryName, String categoryType) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID INNER JOIN categories c ON p.belong=c.categoryID WHERE " + categoryType + " = ?;";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, categoryName);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }//while
        return list;
    }

    //GET LIST OF PRODUCTS NOT PROVIDED BY THE BUSINESS IN A CERTAIN CATEGORY
    public static List<Product> queryProductsNotInBusinessInCategory(Connection conn, int businessID, String categoryType, String categoryName) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID INNER JOIN categories c ON p.belong=c.categoryID LEFT JOIN businessproducts bp ON p.productCode=bp.productCode WHERE " + categoryType + " = ?  AND (businessID != ? OR businessID IS NULL) GROUP BY p.productID ;";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, categoryName);
        pst.setInt(2, businessID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }//while
        return list;
    }

    //GET LIST OF PRODUCTS PROVIDED BY THE BUSINESS IN A CERTAIN CATEGORY
    public static List<Product> queryProductsInBusinessInCategory(Connection conn, int businessID, String categoryType, String categoryName) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID INNER JOIN categories c ON p.belong=c.categoryID LEFT JOIN businessproducts bp ON p.productCode=bp.productCode WHERE " + categoryType + " = ?  AND businessID = ? GROUP BY p.productID ;";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, categoryName);
        pst.setInt(2, businessID);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            list.add(prod);
        }//while
        return list;
    }

    //GET A LIST OF OFFERS FOR A CERTAIN PRODUCT
    public static List<Offer> queryOffersForProduct(Connection conn, String productCodeParam) throws SQLException {
        String sql = "SELECT * FROM offerdetails od INNER JOIN offers o ON od.offerID=o.offerID WHERE productCode = ?";
        List<Offer> list = new ArrayList<Offer>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, productCodeParam);
        ResultSet rs = pst.executeQuery();
        Offer of = null;
        while (rs.next()) {
            if (of == null || of.getId() != rs.getInt("offerID")) {
                of = new Offer();
                of.setId(rs.getInt("offerID"));
                of.setCouponPrice(rs.getFloat("couponPrice"));
                of.setDetails(rs.getString("details"));
                of.setDiscount(rs.getFloat("discount"));
                of.setFinalprice(rs.getFloat("finalPrice"));
                of.setGroupSize(rs.getInt("groupSize"));
                of.setTitle(rs.getString("title"));
                of.setPath(rs.getString("path"));
                of.setBusinessMail(CryptoUtils.decrypt(rs.getString("email")));
                list.add(of);
            }
        }//while
        return list;
    }

    //GET A LIST OF ALL OFFERS
    public static List<Offer> queryOffers(Connection conn) throws SQLException {
        String sql = "SELECT * FROM offers";
        List<Offer> list = new ArrayList<Offer>();
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        Offer of = null;
        while (rs.next()) {
            if (of == null || of.getId() != rs.getInt("offerID")) {
                of = new Offer();
                of.setId(rs.getInt("offerID"));
                of.setCouponPrice(rs.getFloat("couponPrice"));
                of.setDetails(rs.getString("details"));
                of.setDiscount(rs.getFloat("discount"));
                of.setFinalprice(rs.getFloat("finalPrice"));
                of.setGroupSize(rs.getInt("groupSize"));
                of.setTitle(rs.getString("title"));
                of.setPath(rs.getString("path"));
                of.setStatus(rs.getString("status"));
                of.setBusinessMail(CryptoUtils.decrypt(rs.getString("email")));
                list.add(of);
            }
        }//while
        return list;
    }

    //INSERT OR DELETE WISH OF A PRODUCT FOR A USER
    public static void toggleProductWishForUser(Connection conn, String productCode, String userMailstr) throws SQLException {
        String sql = "CALL ToggleProductWishForUser(?, ?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, productCode);
        pst.setString(2, CryptoUtils.encrypt(userMailstr));
        pst.executeUpdate();
    }

    public static List<Notification> queryNotifications(Connection conn, UserAccount user) throws SQLException {
        String sql = "SELECT *,rn.email as seen FROM notifications n INNER JOIN mywish mw ON n.productCode=mw.productCode \n"
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID \n"
                + "LEFT JOIN (SELECT productName,productCode FROM products) p ON n.productCode=p.productCode\n"
                + "LEFT JOIN (SELECT title as offerTitle,offerID FROM offers) o ON n.offerID=o.offerID\n"
                + "WHERE mw.email=? AND (rn.email=? OR rn.email IS NULL) \n"
                + "ORDER BY notificationDate DESC;";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(user.getEmail()));
        pst.setString(2, CryptoUtils.encrypt(user.getEmail()));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product pro = new Product();
            Offer of = new Offer();
            Notification notif = new Notification();
            notif.setId(rs.getInt("notificationID"));
            notif.setNotificationTitle(rs.getString("title"));
            notif.setDetails(rs.getString("details"));
            notif.setDate(rs.getString("notificationDate"));
            of.setTitle(rs.getString("offerTitle"));
            of.setId(rs.getInt("offerID"));
            pro.setName(rs.getString("productName"));
            pro.setCode(rs.getString("productCode"));
            notif.setOffer(of);
            notif.setProduct(pro);
            if (rs.getString("seen") != null) {
                notif.setSeen(true);
            }
            list.add(notif);
        }//while
        return list;
    }

    public static List<Notification> queryNotifications(Connection conn, BusinessAccount business) throws SQLException {
        String sql = "SELECT o.title as offerTitle, n.notificationID, notificationDate,n.title, n.details,o.offerID,rn.email as seen FROM offers o "
                + "LEFT JOIN notifications n ON o.offerID=n.offerID\n" +
                "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID AND rn.email=?\n" +
                " WHERE o.email=?\n" +
                " ORDER BY notificationDate DESC;";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(business.getEmail()));
        pst.setString(2, CryptoUtils.encrypt(business.getEmail()));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product pro = new Product();
            Offer of = new Offer();
            Notification notif = new Notification();
            notif.setId(rs.getInt("notificationID"));
            notif.setNotificationTitle(rs.getString("title"));
            notif.setDetails(rs.getString("details"));
            notif.setDate(rs.getString("notificationDate"));
            of.setTitle(rs.getString("offerTitle"));
            of.setId(rs.getInt("offerID"));
            notif.setOffer(of);
            notif.setProduct(pro);
            if (rs.getString("seen") != null) {
                notif.setSeen(true);
            }
            list.add(notif);
        }//while
        return list;
    }

    //GET NOTIFICATIONS READ BY THE USER
    public static List<Notification> queryNotificationsReadBy(Connection conn, UserAccount user) throws SQLException {
        String sql = "SELECT * FROM notifications n INNER JOIN mywish mw ON n.productCode=mw.productCode "
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID "
                + "LEFT JOIN (SELECT productName,productCode FROM products) p ON n.productCode=p.productCode "
                + "LEFT JOIN (SELECT title,offerID FROM offers) o ON n.offerID=o.offerID "
                + "WHERE mw.email=? AND rn.email=?";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(user.getEmail()));
        pst.setString(2, CryptoUtils.encrypt(user.getEmail()));
        ResultSet rs = pst.executeQuery();
        Product pro = new Product();
        Offer of = new Offer();
        while (rs.next()) {
            Notification notif = new Notification();
            notif.setId(rs.getInt("notificationID"));
            notif.setNotificationTitle(rs.getString("title"));
            notif.setDetails(rs.getString("details"));
            notif.setDate(rs.getString("notificationDate"));
            of.setTitle(rs.getString("title"));
            of.setId(rs.getInt("offerID"));
            pro.setName(rs.getString("productName"));
            pro.setCode(rs.getString("productCode"));
            notif.setOffer(of);
            notif.setProduct(pro);
            list.add(notif);
        }//while
        return list;
    }

    //GET NOTIFICATIONS READ BY THE BUSINESS
    public static List<Notification> queryNotificationsReadBy(Connection conn, BusinessAccount business) throws SQLException {
        String sql = "SELECT * FROM notifications n INNER JOIN mywish mw ON n.productCode=mw.productCode "
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID "
                + "LEFT JOIN (SELECT productName,productCode FROM products) p ON n.productCode=p.productCode "
                + "LEFT JOIN (SELECT title,offerID FROM offers) o ON n.offerID=o.offerID "
                + "WHERE mw.email=? AND rn.email=?";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(business.getEmail()));
        pst.setString(2, CryptoUtils.encrypt(business.getEmail()));
        ResultSet rs = pst.executeQuery();
        Product pro = new Product();
        Offer of = new Offer();
        while (rs.next()) {
            Notification notif = new Notification();
            notif.setId(rs.getInt("notificationID"));
            notif.setNotificationTitle(rs.getString("title"));
            notif.setDetails(rs.getString("details"));
            notif.setDate(rs.getString("notificationDate"));
            of.setTitle(rs.getString("title"));
            of.setId(rs.getInt("offerID"));
            pro.setName(rs.getString("productName"));
            pro.setCode(rs.getString("productCode"));
            notif.setOffer(of);
            notif.setProduct(pro);
            list.add(notif);
        }//while
        return list;
    }

    //GET NOTIFICATIONS NOT READ BY THE USER
    public static List<Notification> queryNotificationsNotReadBy(Connection conn, UserAccount user) throws SQLException {
        String sql = "SELECT * FROM notifications n INNER JOIN mywish mw ON n.productCode=mw.productCode "
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID "
                + "LEFT JOIN (SELECT productName,productCode FROM products) p ON n.productCode=p.productCode "
                + "LEFT JOIN (SELECT title,offerID FROM offers) o ON n.offerID=o.offerID "
                + "WHERE mw.email=? AND (rn.email!=? OR rn.email IS NULL);";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, user.getEmail());
        pst.setString(2, user.getEmail());
        ResultSet rs = pst.executeQuery();
        Product pro = new Product();
        Offer of = new Offer();
        while (rs.next()) {
            Notification notif = new Notification();
            notif.setId(rs.getInt("notificationID"));
            notif.setNotificationTitle(rs.getString("title"));
            notif.setDetails(rs.getString("details"));
            notif.setDate(rs.getString("notificationDate"));
            of.setTitle(rs.getString("title"));
            of.setId(rs.getInt("offerID"));
            pro.setName(rs.getString("productName"));
            pro.setCode(rs.getString("productCode"));
            notif.setOffer(of);
            notif.setProduct(pro);
            list.add(notif);
        }//while
        return list;
    }

    //GET NOTIFICATIONS NOT READ BY THE BUSINESS
    public static List<Notification> queryNotificationsNotReadBy(Connection conn, BusinessAccount business) throws SQLException {
        String sql = "SELECT * FROM notifications n INNER JOIN mywish mw ON n.productCode=mw.productCode "
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID "
                + "LEFT JOIN (SELECT productName,productCode FROM products) p ON n.productCode=p.productCode "
                + "LEFT JOIN (SELECT title,offerID FROM offers) o ON n.offerID=o.offerID "
                + "WHERE mw.email=? AND (rn.email!=? OR rn.email IS NULL);";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, business.getEmail());
        pst.setString(2, business.getEmail());
        ResultSet rs = pst.executeQuery();
        Product pro = new Product();
        Offer of = new Offer();
        while (rs.next()) {
            Notification notif = new Notification();
            notif.setId(rs.getInt("notificationID"));
            notif.setNotificationTitle(rs.getString("title"));
            notif.setDetails(rs.getString("details"));
            notif.setDate(rs.getString("notificationDate"));
            of.setTitle(rs.getString("title"));
            of.setId(rs.getInt("offerID"));
            pro.setName(rs.getString("productName"));
            pro.setCode(rs.getString("productCode"));
            notif.setOffer(of);
            notif.setProduct(pro);
            list.add(notif);
        }//while
        return list;
    }

    //GET NUMBER OF UNREAD NOTIFICATIONS
    public static int countNotificationsNotReadBy(Connection conn, UserAccount user) throws SQLException {
        String sql = "SELECT count(*) as notcount FROM notifications n INNER JOIN mywish mw ON n.productCode=mw.productCode "
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID AND rn.email=? WHERE mw.email=? AND rn.email IS NULL;";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(user.getEmail()));
        pst.setString(2, CryptoUtils.encrypt(user.getEmail()));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            return rs.getInt("notcount");
        }//while
        return 0;
    }

    //GET NUMBER OF UNREAD NOTIFICATIONS
    public static int countNotificationsNotReadBy(Connection conn, BusinessAccount business) throws SQLException {
        String sql = "SELECT count(*) as notcount FROM notifications n INNER JOIN offers o ON n.offerID=o.offerID "
                + "LEFT JOIN readnotifications rn ON n.notificationID=rn.notificationID AND rn.email=? WHERE o.email=? AND rn.email IS NULL;";
        List<Notification> list = new ArrayList<Notification>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, CryptoUtils.encrypt(business.getEmail()));
        pst.setString(2, CryptoUtils.encrypt(business.getEmail()));
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            return rs.getInt("notcount");
        }//while
        return 0;
    }

    //INSERT TO READ NOTIFICATIONS THE USER THAT READ THAT NOTIFICATION
    public static void insertNotificationReadBy(Connection conn, int notificationID, UserAccount user) throws SQLException {
        String sql = "INSERT INTO readnotifications (notificationID,email) VALUES (?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, notificationID);
        pst.setString(2, CryptoUtils.encrypt(user.getEmail()));
        pst.executeUpdate();
    }

    //INSERT TO READ NOTIFICATIONS THE BUSINESS THAT READ THAT NOTIFICATION
    public static void insertNotificationReadBy(Connection conn, int notificationID, BusinessAccount business) throws SQLException {
        String sql = "INSERT INTO readnotifications (notificationID,email) VALUES (?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, notificationID);
        pst.setString(2, CryptoUtils.encrypt(business.getEmail()));
        pst.executeUpdate();
    }

    //SEARCH KEYWORD AND BRING LIST OF OFFERS
    public static List<Offer> searchOffer(Connection conn, String keyword) throws SQLException {
        String sql = "SELECT * FROM offers o LEFT JOIN (SELECT count(*) AS participants,offerID FROM coupontokens "
                + "GROUP BY offerID) ct ON o.offerID=ct.offerID "
                + "WHERE title like ? or details like ? ;";
        List<Offer> list = new ArrayList<Offer>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, "%" + keyword + "%");
        pst.setString(2, "%" + keyword + "%");
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
                Offer offer = new Offer();
                offer.setId(rs.getInt("offerID"));
                offer.setTitle(rs.getString("title"));
                offer.setFinalprice(rs.getFloat("finalPrice"));
                offer.setDiscount(rs.getFloat("discount"));
                offer.setDetails(rs.getString("details"));
                offer.setCouponPrice(rs.getFloat("couponPrice"));
                offer.setGroupSize(rs.getInt("groupSize"));
                offer.setOfferExpire(rs.getString("offerExpire"));
                offer.setPath(rs.getString("path"));
                offer.setStatus(rs.getString("status"));
                offer.setParticipants(rs.getInt("participants"));
                list.add(offer);
        }//while
        return list;
    }//queryProduct
    
    //INSERT A NEW PAYMENT AS PENDING UNTIL THE USER PAYS
    public static void insertPayPalPayment(Connection conn, OrderDetails orderDetails)throws SQLException {
            // Insert the payment record
            String sql = "INSERT INTO payments (accountEmail, amount, details, date, type, status, offerId) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql ,Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, CryptoUtils.encrypt(orderDetails.getAccountEmail()));//encrypt
            pst.setString(2, orderDetails.getTotal());
            pst.setString(3, orderDetails.getDetails());
            pst.setString(4, orderDetails.getDate());
            pst.setString(5, orderDetails.getType());
            pst.setString(6, orderDetails.getStatus());
            pst.setInt(7, orderDetails.getOffer().getId());
            pst.executeUpdate();
            
            ResultSet generatedKeys = pst.getGeneratedKeys();
        if (generatedKeys.next()) {
            int paymentID = generatedKeys.getInt(1);
            orderDetails.setId(paymentID);
        }
        
            System.out.println("Payment record inserted! id="+orderDetails.getId());
    }
    
    //UPDATE PAYMENT WITH NEW STATUS AND SALEID
    public static void updatePayPalPayment(Connection conn, int orderId, String status, String saleId) throws SQLException {
            // Update the payment status based on the PayPal API response
            String sql = "UPDATE payments SET status = ?,saleId=?  WHERE paymentID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, status);
            pst.setString(2, saleId);   //ADD THIS COLUMN TO THE DATABASE AND THE TO THE ORDERDETAILS
            pst.setInt(3, orderId);
            pst.executeUpdate();
            
            System.out.println("Payment record updated!");
    }
    //UPDATE PAYMENT WITH NEW STATUS
    public static void updatePayPalPayment(Connection conn, int orderId, String status) throws SQLException {
            // Update the payment status based on the PayPal API response
            String sql = "UPDATE payments SET status = ?,saleId=?  WHERE paymentID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, status);
            pst.setInt(2, orderId);
            pst.executeUpdate();
            
            System.out.println("Payment record updated!");
    }
    
    //FIND PAYMENT AND GET DETAILS
    public static OrderDetails findPayment(Connection conn, int orderId)throws SQLException {
            // Find the payment record
            String sql = "SELECT * FROM payments p INNER JOIN offers o ON p.offerID=o.offerID WHERE paymentID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, orderId);
            ResultSet rs = pst.executeQuery();
            OrderDetails order=null;
            Offer offer = null;
            while (rs.next()) {
                order = new OrderDetails();
                order.setId(rs.getInt("paymentID"));
                order.setAccountEmail(CryptoUtils.decrypt(rs.getString("accountEmail")));//decrypt
                order.setDate(rs.getString("date"));
                order.setDetails(rs.getString("details"));
                order.setTotal(rs.getFloat("amount"));
                order.setType(rs.getString("type"));
                order.setStatus(rs.getString("status"));
                
                offer = findOffer(conn, rs.getInt("offerId"));
                order.setOffer(offer);
            }//while
            return order;
    }
    
    //INSERT USER AS PARTICIPANT IN AN OFFER
    public static void insertUserInOffer(Connection conn, int offerId, UserAccount user)throws SQLException {
            // Insert the payment record
            String sql = "INSERT INTO coupontokens (email, offerID, date) VALUES (?, ?, NOW())";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, CryptoUtils.encrypt(user.getEmail()));//encrypt
            pst.setInt(2, offerId);
            pst.executeUpdate();

            Offer offer = new Offer();
            offer.setId(offerId);
            insertNotification(conn, offer, null, "New User joined Offer");
            
            if(offer.getParticipants()==offer.getGroupSize()){
                insertNotification(conn, offer, null, "Offer group Filled!");
                offer = findOffer(conn, offerId);
                offer.setStatus("filled");
                //updateOffer(conn, offer);
                //SEND EMAIL TO BUSINESS
            }
    }

    public static boolean isParticipantInOffer(Connection conn, UserAccount user, Offer offer) throws SQLException {
        String sql = "SELECT * FROM coupontokens WHERE offerID=? AND email=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, offer.getId());
        pst.setString(2, CryptoUtils.encrypt(user.getEmail()));//encrypt
        ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                return true;
            }//while
            return false;
    }

    public static List<OrderDetails> queryPayments(Connection conn, String accountEmail) throws SQLException {
        
            String sql = "SELECT * FROM payments WHERE accountEmail=? ORDER BY date DESC";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, CryptoUtils.encrypt(accountEmail));//encrypt
            ResultSet rs = pst.executeQuery();
            List<OrderDetails> list= new ArrayList<OrderDetails>();
            Offer offer = null;
            while (rs.next()) {
                OrderDetails order = new OrderDetails();
                order.setId(rs.getInt("paymentID"));
                order.setAccountEmail(CryptoUtils.decrypt(rs.getString("accountEmail")));//decrypt
                order.setDate(rs.getString("date"));
                order.setDetails(rs.getString("details"));
                order.setTotal(rs.getFloat("amount"));
                order.setType(rs.getString("type"));
                order.setStatus(rs.getString("status"));
                offer = findOffer(conn, rs.getInt("offerId"));
                order.setOffer(offer);
                list.add(order);
            }//while
            return list;
    }

    //GET OFFERS MADE BY BUSINESS
    public static List<Offer> queryBusinessOffers(Connection conn, BusinessAccount business) throws SQLException {
            String sql = "SELECT *,CASE "
                    + "WHEN res IS NULL THEN 0 "
                    + "ELSE res "
                    + "END AS participants FROM offers o "
                    + "LEFT JOIN (SELECT offerId, count(*) as res FROM coupontokens GROUP BY offerID) t "
                    + "ON o.offerID=t.offerID WHERE email=? ORDER BY offerExpire";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, business.getEmail());
            ResultSet rs = pst.executeQuery();
            List<Offer> list= new ArrayList<Offer>();
            while (rs.next()) {
                Offer offer = new Offer();
                offer.setTitle(rs.getString("title"));
                offer.setFinalprice(rs.getFloat("finalPrice"));
                offer.setDiscount(rs.getFloat("discount"));
                offer.setDetails(rs.getString("details"));
                offer.setCouponPrice(rs.getFloat("couponPrice"));
                offer.setGroupSize(rs.getInt("groupSize"));
                offer.setId(rs.getInt("offerID"));
                offer.setOfferExpire(rs.getString("offerExpire"));
                offer.setPath(rs.getString("path"));
                offer.setStatus(rs.getString("status"));
                offer.setParticipants(rs.getInt("participants"));
                
                list.add(offer);
            }//while
            return list;
    }

    //GET OFFERS JOINED BY USER
    public static List<Offer> queryJoinedOffers(Connection conn, UserAccount user) throws SQLException {
        String sql = "SELECT *,(SELECT count(*) FROM coupontokens) as participants FROM coupontokens ct "
                + "INNER JOIN offers o ON o.offerID=ct.offerID WHERE ct.email=? ORDER BY ct.date DESC";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, user.getEmail());
            ResultSet rs = pst.executeQuery();
            List<Offer> list= new ArrayList<Offer>();
            while (rs.next()) {
                Offer offer = new Offer();
                offer.setTitle(rs.getString("title"));
                offer.setFinalprice(rs.getFloat("finalPrice"));
                offer.setDiscount(rs.getFloat("discount"));
                offer.setDetails(rs.getString("details"));
                offer.setCouponPrice(rs.getFloat("couponPrice"));
                offer.setGroupSize(rs.getInt("groupSize"));
                offer.setId(rs.getInt("offerID"));
                offer.setOfferExpire(rs.getString("offerExpire"));
                offer.setPath(rs.getString("path"));
                offer.setStatus(rs.getString("status"));
                offer.setParticipants(rs.getInt("participants"));
                
                list.add(offer);
            }//while
            return list;
    }

    public static void deleteUserFromOffer(Connection conn, int offerId, UserAccount user) throws SQLException {
        // Insert the payment record
            String sql = "DELETE FROM coupontokens WHERE email=? AND offerID=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, CryptoUtils.encrypt(user.getEmail()));//encrypt
            pst.setInt(2, offerId);
            pst.executeUpdate();

            Offer offer = new Offer();
            offer.setId(offerId);
            insertNotification(conn, offer, null, "User left Offer");
    }
}
