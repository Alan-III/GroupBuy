<%-- 
    Document   : myPaymentsListView
    Created on : Jun 21, 2023, 9:40:27 AM
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
        <title>GroupBuy - My Payments</title>
        <link rel="stylesheet" href="styles/userInfoStyles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>

            <div class="main_box">
                <div class="sidebar">
                    <nav class="main-menu">
                        <ul>
                        <c:choose>
                            <c:when test="${loginedbusiness!=null}">
                                <li>
                                    <a href="https://jbfarrow.com">
                                        <i class="fa fa-home fa-2x"></i>
                                        <span class="nav-text">
                                            Business Details
                                        </span>
                                    </a>

                                </li>
                                <li class="has-subnav">
                                    <a href="${pageContext.request.contextPath}/productlist">
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
                                    <a href="#">
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
                            </c:when>
                            <c:when test="${logineduser!=null}">
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
                            </c:when>
                        </c:choose>    

                    </ul>
                </nav>
            </div>
            <div id="userinfo" class="px-4 layout">
                <h3 class="text-center text-white pt-5 mb-4">My payments</h3>
                <div class="container">
                    <div class="layout">

                        <table class="m-auto w-100 text-center border-yellow notification-table">
                            <thead class="border-red mb-2">
                                <tr>
                                    <th>A/A</th>
                                    <th>Details</th>
                                    <th>Total</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${paymentsList}" var="payment" varStatus="status">
                                        <!--chose when pending, completed, cancel etc-->
                                        <tr data-notification-id="${payment.getId()}" class="notification-row mb-2">
                                            
                                        <td>${status.index + 1}</td>
                                        <td>${payment.getDetails()}</td>
                                        <td>${payment.getTotal()}</td>
                                        <td>${payment.getDate()}</td>
                                        <td>${payment.getType()}</td>
                                        <td>${payment.getStatus()}</td>
                                        <td>${payment.getOfferId()}</td>   <!--  get offer whole and show name and link with id-->
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // i don't know
            window.addEventListener('load', function () {
                var mainNavHeight = document.getElementById('mainNav').offsetHeight;
                var mainBox = document.getElementById('mainBox');
                mainBox.style.marginTop = mainNavHeight + 'px';
            });
            //Click Notification
            $(document).ready(function () {
                $(".notification-row").click(function () {
                    // Open modal code here
                    if ($(this).attr('style')) {
                        $(this).removeAttr('style');
                        // Retrieve notification ID and send Ajax request
                        var notificationId = $(this).data("notification-id");
                        // Send AJAX request with the notificationID
                        $.post('${pageContext.request.contextPath}/readnotification', {notificationID: notificationId}, function (data) {
                            // Handle the AJAX response
                            // ...
                        });
                    }
                });
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