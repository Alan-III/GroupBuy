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
        <title>GroupBuy - Product Details</title>
        <link rel="stylesheet" href="styles/productViewStyles.css"/>
        <link rel="stylesheet" href="styles/userInfoStyles.css"/>
        <link rel="stylesheet" href="styles/filterSidebarStyles.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <link rel="stylesheet" href="styles/BootstrapStyles.css" />
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>
            <div class="main_box">

                <div class="layout mt-4">
                    <div id="productinfo" class="product-container">
                        <div class="product-image-card">
                            <div class="product-image-card-slider">
                            <c:forEach items="${product.getImagePaths()}" var="imagepath">
                                <img src="${imagepath}" draggable='false' />
                            </c:forEach>
                        </div>
                        <div class="dots">
                            <c:forEach items="${product.getImagePaths()}" var="imagepath" varStatus="loop">
                                <a href="#!" class="${loop.index == 0 ? 'active' : ''}"><i></i></a>
                                    </c:forEach>
                        </div>
                    </div>
                    <div class="product-details">
                        <header>
                            <h1 class="title">${product.getName()}</h1>
                            <span class="colorCat">subtitle</span>
                            <div class="flex-fill" style="display: flex; justify-content: space-between;">
                                <div class="price">
                                    <span class="before">$${product.getPrice()}</span>
                                    <span class="current">$${product.getPrice()}</span>
                                </div>
                                <div class="rate">
                                    Wishlist:
                                    <c:choose>
                                    <c:when test="${product.isWished()}">
                                        <a href="#!" class="fas fa-star" onclick="confirmWish(${product.getCode()},this)"></a>
                                    </c:when>
                                    <c:when test="true">
                                        <a href="#!" class="far fa-star" onclick="confirmWish(${product.getCode()},this)"></a>
                                    </c:when>
                                    </c:choose>
                                    (${product.getWishesCount()})
                                </div>
                            </div>
                            <hr>
                        </header>
                        <article>
                            <h5>Description</h5>
                            <p>${product.getDetails()}</p>
                        </article>
                        <div class="controls">
                            <div class="color">
                                <h5>color</h5>
                                <ul>
                                    <li><a href="#!" class="colors color-bdot1 active"></a></li>
                                    <li><a href="#!" class="colors color-bdot2"></a></li>
                                    <li><a href="#!" class="colors color-bdot3"></a></li>
                                    <li><a href="#!" class="colors color-bdot4"></a></li>
                                    <li><a href="#!" class="colors color-bdot5"></a></li>
                                </ul>
                            </div>
                            <div class="size">
                                <h5>size</h5>
                                <a href="#!" class="option">(UK 8)</a>
                            </div>
                            <div class="qty">
                                <h5>qty</h5>
                                <a href="#!" class="option">(1)</a>
                            </div>
                        </div>
                    </div>
                </div> 
                <!-- product -->
                <div class="layout mb-2 mt-4">
                    <h4 class="text-center">Offers</h4>
                </div>
                <div class="layout track-container mb-4 mt-2" id="trackcontainer">
                    <!-- Item slider-->
                    <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <c:forEach items="${productOffersList}" var="offer">
                            <div class='product' data-product-code="${offer.getId()}">
                                <a class="product-image" href='${pageContext.request.contextPath}/offerdetails?offerid=${offer.getId()}'>
                                    <img src='${offer.getPath()}' draggable='false' />
                                </a>
                                <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                    <p class="image-left">
                                        <a class="fas fa-pencil-alt" href='editoffer?offerid=${offer.getId()}'></a>
                                        </a>
                                    </p>
                                    <p class="image-right">
                                        <a class="fas fa-trash" href="#" onclick="confirmRedirect(${offer.getId()})" style="color:red"></a>
                                    </p>
                                </c:if>
                                <p class="image-left image-bottom">${offer.getTitle()}</p>
                                <p class="image-right image-bottom">${offer.getFinalprice()}$</p>
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
            function confirmJoinOffer(offerId, fee) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Join Offer?',
                    text: "You will be charged a fee of "+fee+"$.\nYour fee will be returned if you leave the offer before it is accepted by the business.",
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
                            url: '${pageContext.request.contextPath}/joinoffer',
                            method: 'POST',
                            data: {
                                proid: productId
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Joined!',
                                    text: 'You have joined the offer!\nYou will be notified when it is completed to pay the remainder for the products.',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                });
                                // Perform any necessary UI updates after successful deletion
                                // For example, removing the deleted row from the table
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
                            text: 'You can wishlist the products to be notified when offers are made.',
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
                if(${logineduser!=null}){
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
                            alert("something went wrong");
                        }
                    }
                });
                }
                else
                    alert("You need to be logged in to wishlist products");
            }
        </script>

        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="js/listTrack.js"></script>
    </body>

</html>
