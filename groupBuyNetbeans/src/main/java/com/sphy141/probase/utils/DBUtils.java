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
import com.sphy141.probase.beans.ProductFilter;
import com.sphy141.probase.beans.UserAccount;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    //GET LIST OF PRODUCTS AND CHECK WITH EMAIL IF SOME OF THEM ARE WISHED. (email should be '' for null users or business)
    public static List<Product> queryProduct(Connection conn, String userEmail) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID "
                + "LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) GROUP BY p.productID";
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
            if(rs.getString("email")!=null)
                prod.setIsWished(true);
            list.add(prod);
        }//while
        return list;
    }//queryProduct

    //GET DATA OF CERTAIN PRODUCT AND CHECK WITH EMAIL IF IT IS WISHED. (email should be '' for null users or business)
    public static Product findProduct(Connection conn, String code, String userEmail) throws SQLException {
        String sql = "SELECT *  FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID "
                + "LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) WHERE  p.productCode = ? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, userEmail);
        pst.setString(2, code);
        ResultSet rs = pst.executeQuery();
        Product prod = null; 
        while (rs.next()) {
            if(prod==null){
                prod=new Product();
                prod.setCode(rs.getString("productCode"));
                prod.setName(rs.getString("productName"));
                prod.setDetails(rs.getString("details"));
                prod.setPrice(rs.getFloat("price"));
                prod.setId(rs.getInt("productID"));
                prod.setCategoryID(rs.getInt("belong"));
                if(rs.getString("email")!=null)
                    prod.setIsWished(true);
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
    public static List<Product> searchProduct(Connection conn, String keyword ,String useremail) throws SQLException {
        String sql = "SELECT * FROM group_buy.products p INNER JOIN productphoto pp ON p.productID=pp.productID"
                + " LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) WHERE productName like ? or details like ? GROUP BY p.productID;";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, useremail);
        pst.setString(2, "%"+keyword+"%");
        pst.setString(3, "%"+keyword+"%");
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product prod = new Product();
            prod.setId(rs.getInt("productID"));
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setDetails(rs.getString("details"));
            prod.setPrice(rs.getFloat("price"));
            prod.addImagePath(rs.getString("path"));
            if(rs.getString("email")!=null)
                    prod.setIsWished(true);
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
            if (subCategory != null)
                categoryName=subCategory;
            else if(midCategory != null)
                categoryName=midCategory;
            else
                categoryName=genCategory;
                
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
        String sql = "SELECT f.filterName, f.filtersID, pf.filtervalue, countp AS repetitionCount\n" +
"FROM catergoryfilters cf\n" +
"INNER JOIN filtersdetails f ON cf.filtersID = f.filtersID\n" +
"INNER JOIN categories c ON c.categoryID = cf.categoryID\n" +
"LEFT JOIN (\n" +
"    SELECT filtersID, filtervalue, COUNT(productID) AS countp\n" +
"    FROM productfilters\n" +
"    GROUP BY filtersID, filtervalue\n" +
") pf ON pf.filtersID = f.filtersID\n" +
"WHERE c.subCategory = ? OR c.category = ? OR c.genCategory = ?\n" +
"GROUP BY f.filterName, f.filtersID, pf.filtervalue\n" +
"ORDER BY f.filtersID;";
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
            filter.addExistingFilterValues(rs.getString("filtervalue"),rs.getInt("repetitionCount"));
            // Filter unique because of distinct, add it to the list
        }//while
        filtersList.add(filter);
        return filtersList;
    }

    //GET LIST OF PRODUCTS THAT HAVE FILTERS CHECKED
    public static List<Product> filterSearchProduct(Connection conn, String searchQuerry, String useremail) throws SQLException{
        String sql = "SELECT * FROM products p INNER JOIN productfilters pf ON p.productID=pf.productID INNER JOIN productphoto pp ON p.productID=pp.productID"
                + " LEFT JOIN mywish mw ON mw.productCode=p.productCode AND (email = ? OR email IS NULL) WHERE "+searchQuerry+"GROUP BY pp.productID";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, useremail);
        ResultSet rs = pst.executeQuery();
        List<Product> list = new ArrayList<Product>();
        while (rs.next()) {
            Product prod = new Product();
            prod.setCode(rs.getString("productCode"));
            prod.setName(rs.getString("productName"));
            prod.setPrice(rs.getFloat("price"));
            prod.setId(rs.getInt("productID"));
            prod.addImagePath(rs.getString("path"));
            if(rs.getString("email")!=null)
                    prod.setIsWished(true);
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
    public static List<Product> queryProductsNotInBusiness(Connection conn, int businessID) throws SQLException{
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
    public static List<Product> queryProductsInCategory(Connection conn, String categoryName, String categoryType) throws SQLException{
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID INNER JOIN categories c ON p.belong=c.categoryID WHERE "+categoryType+" = ?;";
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
    public static List<Product> queryProductsNotInBusinessInCategory(Connection conn, int businessID, String categoryType, String categoryName) throws SQLException{
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID INNER JOIN categories c ON p.belong=c.categoryID LEFT JOIN businessproducts bp ON p.productCode=bp.productCode WHERE "+categoryType+" = ?  AND (businessID != ? OR businessID IS NULL) GROUP BY p.productID ;";
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
    public static List<Product> queryProductsInBusinessInCategory(Connection conn, int businessID, String categoryType, String categoryName) throws SQLException{
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID INNER JOIN categories c ON p.belong=c.categoryID LEFT JOIN businessproducts bp ON p.productCode=bp.productCode WHERE "+categoryType+" = ?  AND businessID = ? GROUP BY p.productID ;";
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

    public static List<Offer> queryProductOffers(Connection conn, String productCodeParam) throws SQLException {
        String sql = "SELECT * FROM offerdetails od INNER JOIN offers o ON od.offerID=o.offerID WHERE productCode = ?";
        List<Offer> list = new ArrayList<Offer>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, productCodeParam);
        ResultSet rs = pst.executeQuery();
        Offer of = null;
        while (rs.next()) {
            if(of==null || of.getId()!=rs.getInt("offerID")){
                of = new Offer();
                of.setId(rs.getInt("offerID"));
                of.setCouponExpire(rs.getString("couponExpire"));
                of.setCouponPrice(rs.getFloat("couponPrice"));
                of.setDetails(rs.getString("details"));
                of.setDiscount(rs.getFloat("discount"));
                of.setFinalprice(rs.getFloat("finalPrice"));
                of.setGroupSize(rs.getInt("groupSize"));
                of.setTitle(rs.getString("title"));
            }
            of.addImagePath(rs.getString("path"));
            list.add(of);
        }//while
        return list;
    }

    public static void toggleProductWishForUser(Connection conn, String productCode, String userMailstr)throws SQLException {
        String sql = "CALL ToggleProductWishForUser(?, ?)";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, productCode);
        pst.setString(2, userMailstr);
        pst.executeUpdate();
    }
}