<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>GroupBuy - ProductList</title>
        <!--Sweet Alert-->
        <link rel="stylesheet" href="styles/animate.css" />
        <link rel="stylesheet" href="styles/sweetalert2.css" />
        <!--Site Styles-->
        <link rel="stylesheet" href="styles/productListStyles.css">
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        <!--Fonts-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <!--Jquery-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>
            <div class="main_box">
                <input type="checkbox" id="check" title="cb" placeholder="..">
                <div class="btn_one">
                    <label for="check">
                        <i class="fas fa-filter"></i>
                    </label>
                </div>
                <div class="sidebar_menu">
                    <div class="logo">
                        <a href="#">Filters</a>
                    </div>
                    <div class="btn_two">
                        <label for="check">
                            <i class="fas fa-times"></i>
                        </label>
                    </div>
                    <div class="menu">
                        <div id="side-menu">
                            <ul class="no-liststyle">
                            <c:if test="${filtersList==null}">
                                <li><i class="fas fa-filter"></i>
                                    <a href="#">No filters for this Category</a>
                                </li>
                            </c:if>

                            <c:forEach items="${filtersList}" var="item">
                                <li class="filter-item">
                                    <i class="fas fa-filter"></i>
                                    <span class="filter-name" value="${item.getFilterID()}">${item.getFilterName()}</span>
                                    <ul class="filter-values no-liststyle hidden">
                                        <c:forEach items="${item.getExistingFilterValues()}" var="entry">
                                            <c:set var="itemOption" value="${entry.key}" />
                                            <c:set var="itemRepetition" value="${entry.value}" />
                                            <li>
                                                <input type="checkbox" value="${itemOption}" id="${itemOption}">
                                                <label for="${itemOption}">${itemOption} (${itemRepetition})</label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="layout">
                <div class="search_bar-small" style="width: inherit;">
                    <img src="https://cdn.pixabay.com/photo/2013/07/12/15/55/clues-150586_960_720.png" alt="glass" height="35rem" width="35rem" />
                    <input class="typewriter" id="search-box" type="text" placeholder="Type here to search..."/>
                    <button class="add-product-btn btn btn-primary text-uppercase" onClick="searchProducts()">Search</button>
                </div>
            </div>
            <div class="search-recommends layout">
            </div>

            <br>
            <div class="layout mb-2">
                <h4>Offers</h4>
                <c:if test="${loginedbusiness!=null}">
                    <button class="add-product-btn btn btn-primary  text-uppercase" 
                            onClick="window.location.href = '${pageContext.request.contextPath}/createoffer';">Create Offer</button>
                </c:if>
            </div>
            <div class="layout track-container" id="trackcontainer">
                <!-- Item slider-->
                <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                    <c:forEach items="${offersList}" var="offer">
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
            <br>
            <div class="layout mb-2">
                <h4>Products</h4>
                <c:if test="${loginedbusiness!=null}">
                    <button class="add-product-btn btn btn-primary  text-uppercase" 
                            onClick="window.location.href = '${pageContext.request.contextPath}/createproduct';">Create Product</button>
                    <button class="add-product-btn btn btn-primary  text-uppercase" 
                            onClick="window.location.href = '${pageContext.request.contextPath}/updatebusinessproducts';">Change Business Products</button>
                </c:if>
            </div>
            <div class="layout track-container" id="trackcontainer2">
                <!-- Item slider-->
                <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                    <c:forEach items="${productList}" var="item">
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
                                <c:if test="${logineduser!=null}">
                                    <c:choose>
                                        <c:when test="${item.isWished()}">
                                            <a class="fas fa-star" href="" onclick="confirmWish(${item.getCode()}, this)"></a>
                                        </c:when>
                                        <c:when test="true">
                                            <a class="far fa-star" href="" onclick="confirmWish(${item.getCode()}, this)"></a>
                                        </c:when>
                                    </c:choose>
                                </c:if>
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
        <script>
            //DELETE PRODUCT CONFIRM
            function confirmDeleteProduct(productId) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Are you sure you want to delete this product?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary'
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the product
                        $.ajax({
                            url: '${pageContext.request.contextPath}/deleteproduct',
                            method: 'GET',
                            data: {
                                proid: productId
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'The product has been deleted.',
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
                                    text: 'An error occurred while deleting the product.',
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
                            text: 'The product is safe :)',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            //DELETE OFFER CONFIRM
            function confirmDeleteOffer(offerid) {
                // ALERT WITH FUNCTIONAL CONFIRM & CANCEL BUTTON
                console.log("fire");
                Swal.fire({
                    title: 'Are you sure you want to delete this offer?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-1',
                        cancelButton: 'btn btn-label-secondary'
                    },
                    buttonsStyling: false
                }).then(function (result) {
                    if (result.value) {
                        // Send AJAX request to delete the product
                        $.ajax({
                            url: '${pageContext.request.contextPath}/deleteoffer',
                            method: 'GET',
                            data: {
                                offerid: offerid
                            },
                            success: function (response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'The offer has been deleted.',
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
                                    text: 'An error occurred while deleting the offer.',
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
                            text: 'The offer is safe :)',
                            icon: 'error',
                            customClass: {
                                confirmButton: 'btn btn-success'
                            }
                        });
                    }
                });
            }
            //LOAD NEXT PAGE WITH SEARCH
            function searchProducts() {
                var searchValue = document.getElementById("search-box").value;
                if (searchValue.length)
                    var url = "${pageContext.request.contextPath}/productlist?search=" + encodeURIComponent(searchValue);
                else
                    var url = "${pageContext.request.contextPath}/productlist";

                window.location.href = url;
            }
            //SEARCH RESULTS
            let availableKeywords = [<c:forEach var="keyword" items="${keywordsList}">"${keyword}",</c:forEach>];
                    const recommendsBox = document.querySelector(".search-recommends");
            const searchBox = document.getElementById("search-box");

            searchBox.onkeyup = function () {
                let result = [];
                let input = searchBox.value;
                if (input.length) {
                    result = availableKeywords.filter((keyword) => {
                        return keyword.toLowerCase().includes(input.toLowerCase());
                    });
                }
                display(result);
                if (!result.length) {
                    recommendsBox.innerHTML = '';
                }
            }

            function display(result) {
                const maxItems = 10;
                const limitedResult = result.slice(0, maxItems);
                const content = limitedResult.map((list) => {
                    return "<li onclick=selectInput(this)>" + list + "</li>";
                });

                recommendsBox.innerHTML = "<ul>" + content.join('') + "</li>";
            }

            function selectInput(list) {
                searchBox.value = list.innerHTML;
                recommendsBox.innerHTML = '';
            }

            $(document).ready(function () {
                $(".filter-values li, .filter-values :checkbox").click(function (event) {
                    event.stopPropagation(); // Prevent event from bubbling to parent elements

                    var checkbox = $(this).find(":checkbox");
                    checkbox.prop("checked", !checkbox.prop("checked")); // Toggle the checkbox state

                    var checkedValues = {};

                    $(".filter-values").each(function () {
                        var filterID = $(this).siblings(".filter-name").attr("value");
                        var checkedCheckboxes = $(this).find(":checkbox:checked").map(function () {
                            return $(this).val();
                        }).get();

                        if (checkedCheckboxes.length > 0) {
                            checkedValues[filterID] = checkedCheckboxes;
                        }
                    });

                    console.log(checkedValues); // Print checkedValues in the console
                    //
                    // Perform AJAX POST request with the checked values
                    $.ajax({
                        url: "${pageContext.request.contextPath}/filterproductlist",
                        type: "POST",
                        data: {checkedValues: JSON.stringify(checkedValues)},
                        dataType: "json", // Specify the expected data type as JSON
                        success: function (response) {
                            var productList = response; // The response is already parsed as JSON
                            // Clear the existing productList HTML
                            console.log(productList);
                            $("#image-track2").empty();

                            // Iterate over the productList and populate the HTML
                            productList.forEach(function (item) {
                                var productHtml = `<div class='product'>
    <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=` + item.code + `'>
      <img src='` + item.firstImagePath + `' draggable='false' />
    </a>
            <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                <p class="image-left">
                                    <a class="fas fa-pencil-alt" href='editproduct?proid=` + item.id + `'></a>
                                </p>
            </c:if>
                            <p class="image-right">
                               (` + item.wishesCount + `)`;
                                if (item.wished)
                                    productHtml += `<a class="fas fa-star" href="" onclick="confirmWish(` + item.code + `)"></a>`;
                                else
                                    productHtml += `<a class="far fa-star" href="" onclick="confirmWish(` + item.code + `)"></a>`;

                                productHtml += `<c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                    <a class="fas fa-trash" href="#" onclick="confirmRedirect(` + item.id + `)" style="color:red"></a>
            </c:if>
                            </p>
    <p class="image-left image-bottom">` + item.name + `</p>
    <p class="image-right image-bottom">` + item.price + `$</p>
  </div>`;

                                // Append the productHtml to the productList container
                                $("#image-track2").append(productHtml);
                            });

                        },
                        error: function (xhr, status, error) {
                            // Handle the error
                            console.log(error);
                        }
                    });

                });
                $(".filter-values label").click(function (event) {
                    event.stopPropagation(); // Prevent event from bubbling to parent elements
                });
                $(".filter-item").click(function () {
                    $(this).find(".filter-values").toggleClass("hidden");
                });
            });
            //Toggle wishes in DB and in div class
            function confirmWish(productCode, element) {
                if (${logineduser!=null}) {
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
                } else
                    alert("You need to be logged in to wishlist products");
            }
        </script>
        <script type='text/javascript' src='js/listTrack.js'></script>
        <script type='text/javascript' src='js/filterScroll.js'></script>
        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Sweet Alert JS-->
        <script src="js/sweetalert2.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>