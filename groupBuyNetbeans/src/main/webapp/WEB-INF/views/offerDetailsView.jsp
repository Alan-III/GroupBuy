<%-- 
    Document   : productDetailsView
    Created on : Jun 15, 2023, 2:04:39 PM
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
        <title>GroupBuy - Offer Details</title>
        <!--Sweet Alert-->
        <link rel="stylesheet" href="styles/animate.css" />
        <link rel="stylesheet" href="styles/sweetalert2.css" />
        <!--Site Styles-->
        <link rel="stylesheet" href="styles/productViewStyles.css"/>
        <link rel="stylesheet" href="styles/userInfoStyles.css"/>
        <link rel="stylesheet" href="styles/filterSidebarStyles.css"/>
        <link rel="stylesheet" href="styles/BootstrapStyles.css" />
        <!--Fonts-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <!--Jquery-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://www.paypal.com/sdk/js?client-id=AXs6H0x4pAvgK7AETNsfSbYd1MOMyfmNZZzcPPppfxGk1NKBOVukD-fXSXaRBGSTWK_BsvyfWcVOQGTA&currency=USD"></script>
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>
            <div class="main_box">

                <div class="layout mt-4">
                    <div id="productinfo" class="product-container">
                        <div class="product-image-card">
                            <div class="product-image-card-slider">
                                <img src="${offer.getPath()}" draggable='false' />
                        </div>
                    </div>
                    <div class="product-details">
                        <header>
                            <h1 class="title">${offer.getTitle()}</h1>
                            <span class="colorCat">subtitle</span>
                            <div class="flex-fill" style="display: flex; justify-content: space-between;">
                                <table class="price">
                                    <tr>
                                        <td class="before">Full Price:</td>
                                        <td class="discount">Offer:</td>
                                        <td class="fee"> Fee:</td>
                                    <tr>
                                    <tr>
                                        <td class="before">$${Math.round(offer.getFinalprice()*100/(100-offer.getDiscount()) * 10) / 10}</td>
                                        <td class="discount">$${offer.getFinalprice()}</td>
                                        <td class="fee">$${offer.getCouponPrice()}</td>
                                    <tr>
                                </table>
                                <div class="rate mt-1 offset-1">
                                    Joined: ${offer.getParticipants()}/${offer.getGroupSize()}
                                </div>
                            </div>
                            <hr>
                        </header>
                        <article>
                            <h5>Description</h5>
                            <p>${offer.getDetails()}</p>
                        </article>
                        <div class="product-footer mt-5">
                            <button type="button" onclick="confirmJoinOffer(${offer.getId()}, ${offer.getCouponPrice()})">
                                <img src="http://co0kie.github.io/codepen/nike-product-page/cart.png" alt="">
                                <span>join offer</span>
                            </button>
                            <div>
                                <div class="price" style="color: #fe6168">Expires on:</div>
                                <span style="color: #b3900e"> ${offer.getOfferExpire()}</span>
                            </div>
                            <a href="#!"><img src="http://co0kie.github.io/codepen/nike-product-page/share.png" alt=""></a>
                        </div>
                    </div>
                </div> 
                <!-- product -->
                <div class="layout mb-2 mt-4">
                    <h4 class="text-center">Products in Offer</h4>
                </div>
                <div class="layout track-container mb-4 mt-2" id="trackcontainer">
                    <!-- Item slider-->
                    <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <c:forEach items="${offer.getProductsList()}" var="item">
                            <div class='product'>
                                <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=${item.getCode()}'>
                                    <img src='${item.getFirstImagePath()}' draggable='false' />
                                </a>
                                <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                    <p class="image-left">
                                        <a class="fas fa-pencil-alt" href='editproduct?proid=${item.getId()}'></a>
                                    </p>
                                </c:if>
                                <p class="image-right">
                                    (${item.getWishesCount()})
                                    <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                        <a class="fas fa-trash" href="#" onclick="confirmDeleteProduct(${item.getId()})" style="color:red"></a>
                                    </c:if>
                                </p>
                                <p class="image-left image-bottom">${item.getName()}</p>
                                <p class="image-right image-bottom">${item.getPrice()}$</p>
                            </div>                                    
                        </c:forEach>

                    </div>
                    <!-- Item slider end-->
                </div>
            </div>
        </div>
        <div class="layout track-container mb-4 mt-2" id="trackcontainer2" hidden="hidden">
            <!-- Item slider-->
            <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0' hidden="hidden"></div>    
        </div>
        <script>
            //JOIN OFFER CONFIRM
            function confirmJoinOffer(offerID, fee) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Join Offer?',
                    text: "You will be charged a small fee of " + fee + "$ to join. It will be returned if you decide to exit the offer before it closes.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Join!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary'
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the product
                        $.ajax({
                            url: '${pageContext.request.contextPath}/authorizepayment',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                                total: fee,
                                subtotal: "40",
                                shipping: "5",
                                tax: "10"
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Payment in progress!',
                                    text: 'Joining offer.',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                }).then(function () {
                                    window.location.href = response.redirectUrl; // Redirect to PayPal approval link
                                });
                            },
                            error: function (xhr, status, error) {
                                Swal.fire({
                                    title: 'Error',
                                    text: 'An error occurred.',
                                    icon: 'error',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                });
                            }
                        });
                    } else if (result.dismiss === Swal.DismissReason.cancel) {
                        Swal.fire({
                            title: 'Cancelled',
                            text: 'Wishlist the products to be notifified for new offers',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            //PRODUCT IMAGE SLIDER
            $(document).ready(function () {
                $('.dots a').click(function () {
                    var index = $(this).index();
                    $('.dots a').removeClass('active');
                    $(this).addClass('active');
                    var slideWidth = $('.product-image-card').outerWidth() - parseFloat($('.product-image-card').css('padding-left'));
                    $('.product-image-card-slider').css('transform', 'translateX(-' + (index * slideWidth) + 'px)');
                });
            });
            //DELETE CONFIRM
            function confirmRedirect(offerId) {
                var confirmed = confirm("Are you sure you want to delete this Offer?");
                if (confirmed) {
                    window.location.href = "deleteoffer?offerid=" + offerId;
                }
            }

            //Toggle wishes in DB and in div class
            function confirmWish(productCode, element) {
                if ($(element).hasClass("far")) {
                    $(element).removeClass("far").addClass("fas");
                } else {
                    $(element).removeClass("fas").addClass("far");
                }
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/toggleproductwish",
                    data: {productCode: productCode},
                    success: function (response) {
                        // Check the response and update the element's class accordingly
                        if (response == "true") {

                        } else {
                            var alert = alert("something went wrong");
                        }
                    }
                });
            }
        </script>
        <div id="paypal-button-container"></div>
        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Sweet Alert JS-->
        <script src="js/sweetalert2.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="js/listTrack.js"></script>
        <!-- PayPal JS-->

        <script src="js/paypal.js"></script>
    </body>

</html>
