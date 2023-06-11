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
        <title>GroupBuy - Create Offer</title>
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
                    <h3 class="text-center text-white pt-5">Create Offer</h3>
                    <br>
                    <div class="loginclamp">
                        <form class="form-container" method="post" action="${pageContext.request.contextPath}/createoffer" enctype="multipart/form-data">
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="oname" name="oname" />
                            <label class="form-label" for="oname" >Offer Name</label> 
                        </div>
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="odetails" name="odetails" rows="4" cols="50" />
                            <label class="form-label" for="odetails">Details</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="ofinalprice" name="ofinalprice" min="0" step="0.01" />
                            <label class="form-label" for="ofinalprice">Final Price</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="ocouponprice" name="ocouponprice" min="0" step="0.01" />
                            <label class="form-label" for="ocouponprice">Coupon Price</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="odiscount" name="odiscount" min="1" />
                            <label class="form-label" for="odiscount">Offer Discount%</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="osize" name="osize"  min="1"/>
                            <label class="form-label" for="osize">Group Size</label> 
                        </div>
                        <div class="input-field">
                            <input type="date" class="form-control" required="required" id="oexpdate" name="oexpdate" min="" onfocus="(this.type='date')" onblur="(this.type='text')"/>
                            <label class="form-label" for="oexpdate">Offer Expire</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="oexpcoupon" name="oexpcoupon" min="1"/>
                            <label class="form-label" for="oexpcoupon">Coupon Expire in days after purchase</label> 
                        </div>
                        <div class="input-field">
                            <input type="file" class="form-control" required="required" id="oimage" name="oimage[]" multiple/>
                            <label class="input-label-focused" for="oimage">Images</label> 
                        </div>
                        <button type="submit" name="submit" class="btn btn-primary btn-block mb-4">Submit</button>
                    </form>
                </div>
            </div>
        </div>
        <script>
            // Get today's date
            var today = new Date();

            // Format the date as YYYY-MM-DD
            var formattedDate = today.toISOString().split('T')[0];

            // Set the value and minimum attributes of the date input field
            document.getElementById('oexpdate').min = formattedDate;
            document.getElementById('oexpdate').type = 'text';
        </script>
        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>