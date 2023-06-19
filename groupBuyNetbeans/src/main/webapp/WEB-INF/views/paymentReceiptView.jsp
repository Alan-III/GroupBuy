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
        <title>GroupBuy - Payment Receipt</title>
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
                            <a href="https://jbfarrow.com">
                                <i class="fa fa-home fa-2x"></i>
                                <span class="nav-text">
                                    User Details
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
                                <i class="fa fa-gift fa-2x"></i>
                                <span class="nav-text">
                                    My Coupons
                                </span>
                            </a>

                        </li>
                        <li class="has-subnav">
                            <a href="#">
                                <i class="fa fa-star fa-2x"></i>
                                <span class="nav-text">
                                    My Wishlist
                                </span>
                            </a>

                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/usernotifications">
                                <i class="fa fa-info fa-2x"></i>
                                <span class="nav-text">
                                    Notifications
                                </span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-book fa-2x"></i>
                                <span class="nav-text">
                                    My Payments
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
                <h3 class="text-center text-white pt-5">Payment Receipt</h3>
                <form class="container" action="executepayment" method="post">
                <h5 class="text-center text-white pt-5">Transaction Details:</h5>
                <p>Description: ${transaction.description}</p>
                <p>Subtotal: ${transaction.amount.details.subtotal}</p>
                <p>Shipping: ${transaction.amount.details.shipping}</p>
                <p>Tax: ${transaction.amount.details.tax}</p>
                <p>Total: ${transaction.amount.total}</p>
                
                <h5 class="text-center text-white pt-5">Payer Information:</h5>
                <p>Billing First Name: ${payerInfo.firstName}</p>
                <p>Billing Last Name: ${payerInfo.lastName}</p>
                <p>Billing Email: ${payerInfo.email}</p>
                <p>User Full Name: ${logineduser.getLastName()} ${logineduser.getFirstName()}</p>
                <p>User Email: ${logineduser.getEmail()}</p>
                </form>
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