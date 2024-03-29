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
        <title>GroupBuy - Business Info</title>
        <link rel="stylesheet" href="styles/userInfoStyles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->

    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>
            <div class="main_box">

                <div class="sidebar">
                    <nav class="main-menu">
                        <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/businessInfo">
                                <i class="fa fa-home fa-2x"></i>
                                <span class="nav-text">
                                    Business Details
                                </span>
                            </a>

                        </li>
                        <li class="has-subnav">
                            <a href="${pageContext.request.contextPath}/myoffers">
                                <i class="fa fa-shopping-cart fa-2x"></i>
                                <span class="nav-text">
                                    My Offers
                                </span>
                            </a>
                        </li>
                        <li class="has-subnav">
                            <a href="${pageContext.request.contextPath}/updatebusinessproducts">
                                <i class="fa fa-barcode fa-2x"></i>
                                <span class="nav-text">
                                    My Products
                                </span>
                            </a>
                        </li>
                        <li class="has-subnav">
                            <a href="${pageContext.request.contextPath}/mypayments">
                                <i class="fa fa-book fa-2x"></i>
                                <span class="nav-text">
                                    My Payments
                                </span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/businessnotifications">
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
                        <li>
                            <a href="${pageContext.request.contextPath}/logout">
                                <i class="fa fa-power-off fa-2x"></i>
                                <span class="nav-text">
                                    Logout
                                </span>
                            </a>
                        </li>
                </ul>
                </nav>
            </div>
                <div id="userinfo" class="layout">
                <h3 class="text-center text-white pt-5">Business Details</h3>
                <div class="container">
                <p>Business Name: ${loginedbusiness.getBusinessName()}</p>
                <p>Supervisor: ${loginedbusiness.getSupervisorLastName()} ${loginedbusiness.getSupervisorFirstName()}</p>
                <p>Email: ${loginedbusiness.getEmail()}</p>
                <p>AFM: ${loginedbusiness.getAfm()}</p>
                <p>Balance: ${loginedbusiness.getBalance()}</p>
                <p>IBAN: ${loginedbusiness.getIBAN()}</p>
                <p>Password: ${loginedbusiness.getPassword()}</p>
                </div>
            </div>
            </div>
            <script>
            window.addEventListener('load', function() {
              var mainNavHeight = document.getElementById('mainNav').offsetHeight;
              var mainBox = document.getElementById('mainBox');
              mainBox.style.marginTop = mainNavHeight + 'px';
            });
          </script>
            <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>