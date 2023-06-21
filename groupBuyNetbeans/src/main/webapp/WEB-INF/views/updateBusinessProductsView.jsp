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
        <title>GroupBuy - Update Business Products</title>
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
            <div id="userinfo" class="business-products layout">
                <h3 class="text-center text-white pt-5">Update Business Products</h3>
                <br>
                <h6 class="text-center">Filter Products</h6>
                <div class="categories-flex mb-4">
                    <div class="input-field">
                        <select id="generalCategory" name="generalCategory" class="form-control" required="required">
                            <option value="" disabled selected></option>
                            <!-- Populate options for general categories -->
                            <c:forEach var="genCat" items="${genCategory}">
                                <option value="${genCat.getCategoryName()}">${genCat.getCategoryName()}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label" for="generalCategory">General Category</label>
                    </div>
                    <div class="input-field">
                        <select id="category" name="category" class="form-control" disabled>
                            <option value="" disabled selected></option>
                            <!-- Options for categories will be loaded dynamically -->
                        </select>
                        <label class="form-label" for="category">Category</label>
                    </div>
                    <div class="input-field">
                        <select id="subcategory" name="subcategory" class="form-control" disabled>
                            <option value="" disabled selected></option>
                            <!-- Options for subcategories will be loaded dynamically -->
                        </select>
                        <label class="form-label" for="subcategory">Sub Category</label>
                    </div>
                    </form>
                </div>

                <div class="layout mb-2">
                    <h4 class="text-center">Your Business Products</h4>
                </div>
                <div class="layout track-container" id="trackcontainer">
                    <!-- Item slider-->
                    <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <c:forEach items="${businessProductList}" var="item">
                            <div class='product' data-product-code="${item.getCode()}">
                                <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=${item.getCode()}'>
                                    <img src='${item.getFirstImagePath()}' draggable='false' />
                                </a>
                                <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                    <p class="image-left">
                                        <a href="#image-track" class="small-icon icon-minus" onclick="moveProduct('${item.getCode()}')">
                                        </a>
                                    </p>
                                    <p class="image-right">
                                        <a href="#image-track" onclick="confirmRedirect(${item.getId()})">
                                            <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                        </a>
                                    </p>
                                </c:if>
                                <p class="image-left image-bottom">${item.getName()}</p>
                                <p class="image-right image-bottom">${item.getPrice()}$</p>
                            </div>                            
                        </c:forEach>

                    </div>

                    <!-- Item slider end-->
                </div>

                <div class="layout mb-2">
                    <h4 class="text-center">Products not offered by your business</h4>
                </div>
                <div class="layout track-container mb-2" id="trackcontainer2">
                    <!-- Item slider-->
                    <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <c:forEach items="${productList}" var="item">
                            <div class='product' data-product-code="${item.getCode()}">
                                <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=${item.getCode()}'>
                                    <img src='${item.getFirstImagePath()}' draggable='false' />
                                </a>
                                <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                    <p class="image-left">
                                        <a href="#image-track" class="small-icon icon-plus" onclick="moveProduct('${item.getCode()}')">
                                        </a>
                                    </p>
                                    <p class="image-right">
                                        <a href="#image-track" onclick="confirmRedirect(${item.getId()})">
                                            <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                        </a>
                                    </p>
                                </c:if>
                                <p class="image-left image-bottom">${item.getName()}</p>
                                <p class="image-right image-bottom">${item.getPrice()}$</p>
                            </div>                            
                        </c:forEach>
                    </div>
                    <!-- Item slider end-->
                </div> 
            </div>
        </div>

        <script>
            var categories = {
            // Mapping of general category ID to category list
            <c:forEach var="genCat" items="${genCategory}">
                ${genCat.getCategoryName()}: [
                <c:forEach var="cat" items="${category}">
                    <c:if test="${cat.getGenCategory() == genCat.getCategoryName()}">
            { id: '${cat.getCategoryName()}', name: '${cat.getCategoryName()}' },
                    </c:if>
                </c:forEach>
            ],
            </c:forEach>
            };
            var subcategories = {
            // Mapping of category ID to subcategory list
            <c:forEach var="cat" items="${category}">
                ${cat.getCategoryName()}: [
                <c:forEach var="subCat" items="${subCategory}">
                    <c:if test="${subCat.getMidCategory() == cat.getCategoryName()}">
            { id: '${subCat.getCategoryName()}', name: '${subCat.getCategoryName()}' },
                    </c:if>
                </c:forEach>
            ],
            </c:forEach>
            };
            //--------------------//
            // Handle general category selection change
            var generalCategorySelect = document.getElementById("generalCategory");
            generalCategorySelect.addEventListener("change", function () {
            var categoryName = this.value;
            var categorySelect = document.getElementById("category");
            var subcategorySelect = document.getElementById("subcategory");
            // Clear existing options
            categorySelect.innerHTML = '<option value="" disabled selected></option>';
            subcategorySelect.innerHTML = '<option value="" disabled selected></option>';
            // Make AJAX request to servlet with selected value and field name
            categoryFilterProductsAjax(categoryName, "genCategory");
            // Populate options for categories based on selected general category
            if (categoryName in categories) {
            categories[categoryName].forEach(function (category) {
            var option = document.createElement("option");
            option.value = category.id;
            option.text = category.name;
            categorySelect.appendChild(option);
            });
            categorySelect.disabled = false;
            } else {
            categorySelect.disabled = true;
            subcategorySelect.disabled = true;
            }
            //--------------------//
            // Handle category selection change
            var categorySelect = document.getElementById("category");
            categorySelect.addEventListener("change", function () {
            var subcategoryName = this.value;
            var subcategorySelect = document.getElementById("subcategory");
            // Clear existing options
            subcategorySelect.innerHTML = '<option value="" disabled selected></option>';
            // Make AJAX request to servlet with selected value and field name
            categoryFilterProductsAjax(subcategoryName, "category");
            // Populate options for subcategories based on selected category
            if (subcategoryName in subcategories) {
            subcategories[subcategoryName].forEach(function (subcategory) {
            var option = document.createElement("option");
            option.value = subcategory.id;
            option.text = subcategory.name;
            subcategorySelect.appendChild(option);
            });
            subcategorySelect.disabled = false;
            } else {
            subcategorySelect.disabled = true;
            }
            });
            });
            //--------------------//
            // Handle subcategory selection change
            var subcategorySelect = document.getElementById("subcategory");
            subcategorySelect.addEventListener("change", function () {
            var subcategoryName = this.value;
            // Make AJAX request to servlet with selected value and field name
            categoryFilterProductsAjax(subcategoryName, "subCategory");
            // Rest of your code...
            });
            //--------------------//

            function moveProduct(productCode) {
            // AJAX post to servlet with productId
            $.ajax({
            type: 'POST',
                    url: '${pageContext.request.contextPath}/updatebusinessproducts',
                    data: { productCode: productCode },
                    success: function(response) {
                    // Handle success
                    if (response === 'true') {
                    // Handle success case
                    console.log('Operation successful');
                    // Check if the productDiv exists in #image-track2
                    var productDiv = $("#image-track2").find(`.product[data-product-code='` + productCode + `']`);
                    if (productDiv.length === 0) {
                    // Search for the productDiv in #image-track
                    productDiv = $("#image-track").find(`.product[data-product-code='` + productCode + `']`);
                    if (productDiv.length > 0) {
                    // Move the productDiv to #image-track2
                    productDiv.appendTo("#image-track2");
                    // Change the button icon to fa-plus
                    productDiv.find(".icon-minus").removeClass("icon-minus").addClass("icon-plus");
                    }
                    } else {
                    // Move the productDiv to #image-track
                    productDiv.appendTo("#image-track");
                    // Change the button icon to fa-minus
                    productDiv.find(".icon-plus").removeClass("icon-plus").addClass("icon-minus");
                    }
                    } else {
                    // Handle error case
                    alert('Operation failed. Please make sure you are logged in your Business Account. ');
                    }
                    },
                    error: function() {
                    // Handle error
                    alert('Error occurred during the operation. Please try again later.');
                    }
            });
            }
// Function to make AJAX post request to servlet
            function categoryFilterProductsAjax(categoryName, categoryType) {
            $.ajax({
            type: 'POST',
                    url: '${pageContext.request.contextPath}/ajaxproductsofcategory',
                    data: {
                    categoryName: categoryName,
                            categoryType: categoryType
                    },
                    success: function (response) {
                    // Handle success and populate the divs with the received response
                    console.log(response);
                    if(response!="false"){
                        // Extract the lists from the response JSON
                        var businessProducts = response.businessProducts;
                        var notBusinessProducts = response.notBusinessProducts;
                        // Populate the divs with the lists
                        populateDivWithProducts("#image-track", businessProducts);
                        populateDivWithProducts("#image-track2", notBusinessProducts);
                    }
                    },
                    error: function () {
                    // Handle error
                    alert('Error occurred during the operation. Please try again later.');
                    }
            });
            }

            function populateDivWithProducts(divId, productList) {
            var addicon;
            if(divId=="#image-track"){
                addicon = "icon-minus";
            }
            else
                addicon = "icon-plus";
            $(divId).empty();
            productList.forEach(function (product) {
            // Create and append the necessary elements based on your HTML structure
            var productHtml = `<div class='product' data-product-code="` + product.code + `">
                                <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=` + product.code + `'>
                                    <img src='` + product.firstImagePath + `' draggable='false' />
                                </a>
            <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                    <p class="image-left">
                                        <a href="#image-track" class="small-icon `+addicon+`" onclick="moveProduct(` + product.code + `)">
                                        </a>
                                    </p>
                                    <p class="image-right">
                                        <a href="#image-track" onclick="confirmRedirect(` + product.id + `)">
                                            <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                        </a>
                                    </p>
            </c:if>
                                <p class="image-left image-bottom">` + product.name + `</p>
                                <p class="image-right image-bottom">` + product.price + `$</p>
                            </div>`;
            // Append the productHtml to the productList container
            $(divId).append(productHtml);
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