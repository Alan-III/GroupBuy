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
                            <img src="${offer.getPath()}" draggable='false' />
                        </div>
                    </div>
                    <div class="product-details">
                        <header>
                            <h1 class="title">${offer.getTitle()}</h1>
                            <span class="colorCat">subtitle</span>
                            <div class="flex-fill" style="display: flex; justify-content: space-between;">
                                <div class="price">
                                    <span class="before">Price: $${Math.round(offer.getFinalprice()*100/(100-offer.getDiscount()) * 10) / 10}</span>
                                    <span class="discount">Offer: $${offer.getFinalprice()}</span>
                                    <span class="fee"> Fee: $${offer.getCouponPrice()}</span>
                                </div>
                                <div class="rate">
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
                            <button type="button">
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
                <div class="layout track-container border-yellow mb-4 mt-2" id="trackcontainer">
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

        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="js/listTrack.js"></script>
    </body>

</html>
