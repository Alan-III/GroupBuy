<%-- 
    Document   : userInfoView
    Created on : Jun 9, 2023, 12:04:04 AM
    Author     : Alan
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>GroupBuy - Create Product</title>
        <link rel="stylesheet" href="styles/userInfoStyles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->

    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>
            <div class="main_box">

<!--                <nav class="main-menu">
                    <ul>
                        <li>
                            <a href="https://jbfarrow.com">
                                <i class="fa fa-home fa-2x"></i>
                                <span class="nav-text">
                                    Business Details
                                </span>
                            </a>

                        </li>
                        <li class="has-subnav">
                            <a href="#">
                                <i class="fa fa-shopping-cart fa-2x"></i>
                                <span class="nav-text">
                                    My Offers
                                </span>
                            </a>

                        </li>
                        <li class="has-subnav">
                            <a href="#">
                                <i class="fa fa-book fa-2x"></i>
                                <span class="nav-text">
                                    My Products
                                </span>
                            </a>

                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-info fa-2x"></i>
                                <span class="nav-text">
                                    Notifications
                                </span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-cogs fa-2x"></i>
                                <span class="nav-text">
                                    Account Settings
                                </span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-map-marker fa-2x"></i>
                                <span class="nav-text">
                                    Member Map
                                </span>
                            </a>
                        </li>
                    </ul>

                    <ul class="logout">
                        <li>
                            <a href="/groupbuy/logout">
                                <i class="fa fa-power-off fa-2x"></i>
                                <span class="nav-text">
                                    Logout
                                </span>
                            </a>
                        </li>  
                    </ul>
                </nav>-->
                <div id="userinfo" class="layout">
                <h3 class="text-center text-white pt-5">Create Product</h3>
                <br>
                <div class="loginclamp">
                <form class="form-container" method="post" action="${pageContext.request.contextPath}/createproduct" enctype="multipart/form-data">
                    <div class="input-field">
                    <input type="text" class="form-control" required="required" id="pname" name="pname" />
                    <label class="form-label" for="pname" >Product Name</label> 
                    </div>
                    <div class="input-field">
                    <input type="text" class="form-control" required="required" id="pbarcode" name="pbarcode" />
                    <label class="form-label" for="pbarcode">Product Barcode</label> 
                    </div>
                    <div class="input-field">
                    <input type="text" class="form-control" required="required" id="pprice" name="pprice" />
                    <label class="form-label" for="pprice">Price</label> 
                    </div>
                    <div class="input-field">
                    <input type="number" class="form-control" required="required" id="pcat" name="pcat" value="1" min="1"/>
                    <label class="form-label" for="pprice">Category TEMP</label> 
                    </div>
                    <div class="input-field">
                    <input type="text" class="form-control" required="required" id="pdetails" name="pdetails" rows="4" cols="50" />
                    <label class="form-label" for="pdetails">Details</label> 
                    </div>
                    <div class="input-field">
                    <input type="file" class="form-control" required="required" id="pimage" name="pimage[]" multiple/>
                    <label class="input-label-focused" for="pimage">Images</label> 
                    </div>
                    <button type="submit" name="submit" class="btn btn-primary btn-block mb-4">Submit</button>
                </form>
            </div>
            </div>
            </div>
            <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>