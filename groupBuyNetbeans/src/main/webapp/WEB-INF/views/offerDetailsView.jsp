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
                            <c:choose>
                                <c:when test="${offer.getParticipants()>=offer.getGroupSize()}">
                                    <span class="price text-uppercase" style="color: red;" >offer full!</span>
                                    <c:choose>
                                        <c:when test="${loginedbusiness!=null}">
                                            <c:choose>
                                                <c:when test="${offer.getStatus()=='active'}">
                                                    <button type="button" onclick="confirmAcceptOffer(${offer.getId()})" class="p-2 m-2">
                                                        <span>Accept Offer</span>
                                                    </button>
                                                    <button type="button" onclick="confirmCancelOffer(${offer.getId()})" class="leave-offer-btn p-2 m-2">
                                                        <span>Cancel Offer</span>
                                                    </button>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='canceled'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: red;" >offer canceled!</span>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${logineduser!=null}">
                                            <c:choose>
                                                <c:when test="${offer.getStatus()=='active'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: #ffc800;" >Waiting for <br>Business response</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='participant'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                        <button type="button" onclick="payFullOffer(${offer.getId()})" class="p-2 m-2">
                                                        <span>Pay Full Price</span>
                                                        </button>
                                                        <button type="button" onclick="abandonOffer(${offer.getId()})" class="leave-offer-btn p-2 m-2">
                                                            <span>abandon Offer</span>
                                                        </button>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='buyer'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >you have <br>purchased this!</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='abandoned'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                    <span class="price text-uppercase p-2 m-2" style="color: red;" >you have <br>abandoned this!</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='canceled'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: red;" >offer canceled!</span>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:when test="${offer.getOfferExpire()<=currentDatetime}">
                                    <span class="price text-uppercase" style="color: red;" >offer expired!</span>
                                    <c:choose>
                                        <c:when test="${loginedbusiness!=null}">
                                            <c:choose>
                                                <c:when test="${offer.getStatus()=='active'}">
                                                    <button type="button" onclick="confirmAcceptOffer(${offer.getId()})" class="p-2 m-2">
                                                        <span>Accept Offer</span>
                                                    </button>
                                                    <button type="button" onclick="confirmCancelOffer(${offer.getId()})" class="leave-offer-btn p-2 m-2">
                                                        <span>Cancel Offer</span>
                                                    </button>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='canceled'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: red;" >offer canceled!</span>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${logineduser!=null}">
                                            <c:choose>
                                                <c:when test="${offer.getStatus()=='active'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: #ffc800;" >Waiting for <br>Business response</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='participant'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                        <button type="button" onclick="payFullOffer(${offer.getId()})" class="p-2 m-2">
                                                        <span>Pay Full Price</span>
                                                        </button>
                                                        <button type="button" onclick="abandonOffer(${offer.getId()})" class="leave-offer-btn p-2 m-2">
                                                            <span>abandon Offer</span>
                                                        </button>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='buyer'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >you have <br>purchased this!</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='abandoned'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                                    <span class="price text-uppercase p-2 m-2" style="color: red;" >you have <br>abandoned this!</span>
                                                </c:when>
                                                <c:when test="${offer.getStatus()=='canceled'}">
                                                    <span class="price text-uppercase p-2 m-2" style="color: red;" >offer canceled!</span>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:when test="${isParticipant}">
                                    <c:choose>
                                        <c:when test="${offer.getStatus()=='active'}">
                                            <button type="button" onclick="confirmLeaveOffer(${offer.getId()}, ${offer.getCouponPrice()})" class="leave-offer-btn">
                                                <img src="http://co0kie.github.io/codepen/nike-product-page/cart.png" alt="">
                                                <span>Leave offer</span>
                                            </button>
                                        </c:when>
                                        <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='participant'}">
                                            <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                            <button type="button" onclick="payFullOffer(${offer.getId()})" class="p-2 m-2">
                                                <span>Pay Full Price</span>
                                            </button>
                                            <button type="button" onclick="abandonOffer(${offer.getId()})" class="leave-offer-btn p-2 m-2">
                                                <span>abandon Offer</span>
                                            </button>
                                        </c:when>
                                        <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='buyer'}">
                                            <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                            <span class="price text-uppercase p-2 m-2" style="color: green;" >you have <br>purchased this!</span>
                                        </c:when>
                                        <c:when test="${offer.getStatus()=='accepted' && couponToken.getState()=='abandoned'}">
                                            <span class="price text-uppercase p-2 m-2" style="color: green;" >offer accepted!</span>
                                            <span class="price text-uppercase p-2 m-2" style="color: red;" >you have <br>abandoned this!</span>
                                        </c:when>
                                        <c:when test="${offer.getStatus()=='canceled'}">
                                            <span class="price text-uppercase p-2 m-2" style="color: red;" >offer canceled!</span>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:when test="${logineduser==null}">
                                    <span class="price text-uppercase">Login as user<br>to join</span>
                                </c:when>
                                <c:when test="true">
                                    <button type="button" onclick="confirmJoinOffer(${offer.getId()}, ${offer.getCouponPrice()})">
                                        <img src="http://co0kie.github.io/codepen/nike-product-page/cart.png" alt="">
                                        <span>join offer</span>
                                    </button>
                                </c:when>
                            </c:choose>

                            <div>
                                <div class="price" style="color: #fe6168">Expires on:</div>
                                <span style="color: #b3900e"> ${offer.getOfferExpire()}</span>
                            </div>
                            <a href="#" onClick="showCurrentPageURL()"><img src="http://co0kie.github.io/codepen/nike-product-page/share.png" alt=""></a>
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
            // ON PAGE LOAD
            window.onload = function () {
                // CHECK IF OFFER FULL
                if (${offer.getParticipants() >= offer.getGroupSize()}) {
                    showNotification();
                }
            };
            //OFFER FULL POPUP
            function showNotification() {
                Swal.fire({
                    title: 'This offer is full',
                    text: 'Check out other offers on your wishlisted product!',
                    icon: 'info',
                    showConfirmButton: true,
                    timer: 5000,
                    timerProgressBar: true,
                    toast: true,
                    position: 'top',
                    showClass: {
                        popup: 'animated fadeInDown'
                    },
                    hideClass: {
                        popup: 'animated fadeOutUp'
                    }
                });
            }
            // USER ABANDON OFFER
            function abandonOffer(offerID) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Abandon Offer?',
                    text: "Are you sure? Your paid fees will be lost!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Abandon Offer!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary'
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the joined user and pay back
                        $.ajax({
                            url: '${pageContext.request.contextPath}/abandonoffer',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Offer Abandoned',
                                    text: 'You are no longer a member of this offer',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                }).then(function () {
//                                    if (response.redirectUrl) {
//                                        var url = "${pageContext.request.contextPath}/" + response.redirectUrl;
//                                        window.location.href = url;
//                                    }
                                })
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
                            title: 'Not Abandoned',
                            text: 'You have 5 days from the acceptance date to decide!',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            // USER PAY FULL OFFER
            function payFullOffer(offerID) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Pay Full Offer?',
                    text: "You will be redirected to pay the full price (minus fee)",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Pay with PayPal!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary'
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the joined user and pay back
                        $.ajax({
                            url: '${pageContext.request.contextPath}/authorizepayment',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                                total: "${offer.getFinalprice()}",
                                subtotal: "${offer.getFinalprice()}",
                                shipping: "0",
                                tax: "0"
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'info',
                                    title: 'Pay with PayPal',
                                    text: 'You will be redirected to PayPal',
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
                            title: 'Canceled',
                            text: 'You have 5 days from the acceptance date to decide!',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            // BUSINESS ACCEPT OFFER
            function confirmAcceptOffer(offerID) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Accept Offer?',
                    text: "The fees will be sent to your account and your customers will be notified to pay the full price.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Accept Offer!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary',
                        cancelButtonText: 'No, i\'ll think about it.',
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the joined user and pay back
                        $.ajax({
                            url: '${pageContext.request.contextPath}/acceptoffer',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Offer Accepted',
                                    text: response.fees+'$ fees sent to you. Customers have 5 days to pay full price.',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                }).then(function () {
//                                    if (response.redirectUrl) {
//                                        var url = "${pageContext.request.contextPath}/" + response.redirectUrl;
//                                        window.location.href = url;
//                                    }
                                })
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
                            title: 'Not Accepted',
                            text: 'Don\'t left your customers wait. Accept or Cancel your offer.',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            // BUSINESS CANCEL OFFER
            function confirmCancelOffer(offerID) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Cancel Offer?',
                    text: "Your customers will be refunded their fees.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Cancel Offer!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary',
                        cancelButtonText: 'No, i\'ll think about it.',
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the joined user and pay back
                        $.ajax({
                            url: '${pageContext.request.contextPath}/canceloffer',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Offer Canceled',
                                    text: 'Your offer is no longer active.',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                }).then(function () {
//                                    if (response.redirectUrl) {
//                                        var url = "${pageContext.request.contextPath}/" + response.redirectUrl;
//                                        window.location.href = url;
//                                    }
                                })
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
                            title: 'Safe',
                            text: 'Don\'t left your customers wait. Accept or Cancel your offer.',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            //LEAVE OFFER CONFIRM
            function confirmLeaveOffer(offerID, fee) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Leave Offer?',
                    text: "Your will be refunded " + fee + "$ fee you payed to join. You can join again later.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Leave!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary'
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the joined user and pay back
                        $.ajax({
                            url: '${pageContext.request.contextPath}/executerefund',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Fee refunded',
                                    text: 'You have left the offer',
                                    customClass: {
                                        confirmButton: 'btn btn-success'
                                    }
                                }).then(function () {
                                    if (response.redirectUrl) {
                                        var url = "${pageContext.request.contextPath}/" + response.redirectUrl;
                                        window.location.href = url;
                                    }
                                })
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
                            text: 'You will be notified when the offer is completed to pay the Full Price',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
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
                        // Send AJAX request to join offer and pay
                        $.ajax({
                            url: '${pageContext.request.contextPath}/authorizepayment',
                            method: 'POST',
                            data: {
                                offerId: offerID,
                                total: fee,
                                subtotal: fee,
                                shipping: "0",
                                tax: "0"
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'info',
                                    title: 'Pay with PayPal',
                                    text: 'You will be redirected to PayPal',
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

            //SHARE OFFER URL
            function showCurrentPageURL() {
                // Get the current page's URL
                var currentPageURL = window.location.href;

                // Create a SweetAlert2 modal with the URL
                Swal.fire({
                    title: 'OFFER URL',
                    html: 'Copy the URL below:',
                    input: 'text',
                    inputValue: currentPageURL,
                    showCancelButton: true,
                    confirmButtonText: 'Copy URL',
                    cancelButtonText: 'Close',
                    preConfirm: function (url) {
                        // Copy the URL to the clipboard
                        var tempInput = document.createElement('input');
                        document.body.appendChild(tempInput);
                        tempInput.value = url;
                        tempInput.select();
                        document.execCommand('copy');
                        document.body.removeChild(tempInput);

                        // Show a success message
                        Swal.fire({
                            title: 'URL Copied!',
                            text: 'The URL has been copied to the clipboard.',
                            icon: 'success',
                            timer: 1500,
                            timerProgressBar: true,
                            showConfirmButton: false
                        });
                    }
                });
            }

        </script>
        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Sweet Alert JS-->
        <script src="js/sweetalert2.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="js/listTrack.js"></script>

    </body>

</html>
