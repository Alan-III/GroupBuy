/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sphy141.probase.utils;

import com.sphy141.probase.beans.BusinessAccount;
import com.sphy141.probase.beans.Category;
import com.sphy141.probase.beans.Product;
import com.sphy141.probase.beans.ProductFilter;
import com.sphy141.probase.beans.UserAccount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author USER
 */
public class DBUtils {

    //FIND USER WITH EMAIL & PASSWORD
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

    //FIND USER WITH EMAIL
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
    
    //CREATE NEW USER
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

    //CHANGE USER DETAILS
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

    //FIND USER WITH GIVE CODE AND ENABLE HIM
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

    //LIST OF ALL PRODUCTS
    public static List<Product> queryProduct(Connection conn) throws SQLException {
        String sql = "SELECT * FROM products p INNER JOIN productphoto pp ON p.productID=pp.productID GROUP BY p.productID";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
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
    }//queryProduct
    
    //SEARCH KEYWORD AND BRING LIST OF PRODUCTS
    public static List<Product> searchProduct(Connection conn, String keyword) throws SQLException {
        String sql = "SELECT * FROM group_buy.products p INNER JOIN productphoto pp ON p.productID=pp.productID where productName like ? or details like ? GROUP BY p.productID;";
        List<Product> list = new ArrayList<Product>();
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, "%"+keyword+"%");
        pst.setString(2, "%"+keyword+"%");
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
    }//queryProduct

    //FIND SPESCIFIC PRODUCT BY BARCODE
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

    //NOT DONE YET
    public static void updateProduct(Connection conn, Product product) throws SQLException {
        String sql = "UPDATE products SET name=?,Price=? WHERE code = ?";
        PreparedStatement pst = conn.prepareCall(sql);
        pst.setString(1, product.getName());
        pst.setFloat(2, product.getPrice());
        pst.setString(3, product.getCode());
        pst.executeUpdate();
    }//updateProduct

    
    //CREATE NEW PRODUCT AND UPLOAD ITS PHOTOS
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

    //DELETE PRODUCT BY PRODUCTID
    public static void deleteProduct(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM products WHERE productID=? ";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        pst.executeUpdate();
    }//deleteProduct

    //FIND BUSINESS BY EMAIL & PASSWORD
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

    //FIND BUSINESS BY EMAIL
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

    //CREATE NEW BUSINESS ACCOUNT
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

    //FIND BUSINESS WITH GIVE CODE AND ENABLE IT
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

    //GET LIST OF ALL CATEGORIES
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

    //FIND SPECIFIC CATEGORY
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
