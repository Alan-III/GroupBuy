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
                        <div class="product-image">
                            <div class="product-image-slider">
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
                        <div class="product-footer mt-5">
                            <button type="button">
                                <img src="http://co0kie.github.io/codepen/nike-product-page/cart.png" alt="">
                                <span>add to cart</span>
                            </button>
                            <a href="#!"><img src="http://co0kie.github.io/codepen/nike-product-page/share.png" alt=""></a>
                        </div>
                    </div>
                </div> 
                <!-- product -->
                <div class="layout mb-2 mt-4">
                    <h4 class="text-center">Offers</h4>
                </div>
                <div class="layout track-container border-yellow mb-4 mt-2" id="trackcontainer">
                    <!-- Item slider-->
                    <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <c:forEach items="${productOffersList}" var="offer">
                            <div class='product' data-product-code="${offer.getCode()}">
                                <a class="product-image" href='${pageContext.request.contextPath}/offerdetails?offerid=${offer.getId()}'>
                                    <img src='${offer.getFirstImagePath()}' draggable='false' />
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
                                <p class="image-left image-bottom">${offer.getName()}</p>
                                <p class="image-right image-bottom">${offer.getPrice()}$</p>
                            </div>                            
                        </c:forEach>

                    </div>
                    <!-- Item slider end-->
                </div>
            </div>
        </div>
        <div class="layout track-container border-yellow mb-4 mt-2" id="trackcontainer2" hidden="hidden">
            <!-- Item slider-->
            <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0' hidden="hidden"></div>    
        </div>
        <script>
            //PRODUCT IMAGE SLIDER
            $(document).ready(function () {
                $('.dots a').click(function () {
                    var index = $(this).index();
                    $('.dots a').removeClass('active');
                    $(this).addClass('active');
                    var slideWidth = $('.product-image').outerWidth() - parseFloat($('.product-image').css('padding-left'));
                    $('.product-image-slider').css('transform', 'translateX(-' + (index * slideWidth) + 'px)');
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

        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="js/listTrack.js"></script>
    </body>

</html>
