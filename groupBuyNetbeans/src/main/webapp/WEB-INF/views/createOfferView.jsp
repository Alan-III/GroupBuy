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
        <title>GroupBuy - Create Offer</title>
        <link rel="stylesheet" href="styles/productList.css">

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

                <!--                <nav class="main-menu">
                                    <ul>
                                        <li>
                                            <a href="https://jbfarrow.com">
                                                <i class="fa fa-home fa-2x"></i>
                                                <span class="nav-text">
                                                    Business Details
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
                                                <i class="fa fa-book fa-2x"></i>
                                                <span class="nav-text">
                                                    My Products
                                                </span>
                                            </a>
                
                                        </li>
                                        <li>
                                            <a href="#">
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
                                    </ul>
                
                                    <ul class="logout">
                                        <li>
                                            <a href="/groupbuy/logout">
                                                <i class="fa fa-power-off fa-2x"></i>
                                                <span class="nav-text">
                                                    Logout
                                                </span>
                                            </a>
                                        </li>  
                                    </ul>
                                </nav>-->
                <div id="userinfo" class="layout">
                    <h3 class="text-center text-white pt-5">Create Offer</h3>
                    <br>
                    <div class="loginclamp">
                        <form class="form-container" method="post" action="${pageContext.request.contextPath}/createoffer" enctype="multipart/form-data">
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="oname" name="oname" />
                            <label class="form-label" for="oname" >Offer Name</label> 
                        </div>
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="odetails" name="odetails" rows="4" cols="50" />
                            <label class="form-label" for="odetails">Details</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="ofinalprice" name="ofinalprice" min="0" step="0.01" />
                            <label class="form-label" for="ofinalprice">Final Price</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="ocouponprice" name="ocouponprice" min="0" step="0.01" />
                            <label class="form-label" for="ocouponprice">Coupon Price</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="odiscount" name="odiscount" min="1" />
                            <label class="form-label" for="odiscount">Offer Discount%</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="osize" name="osize"  min="1"/>
                            <label class="form-label" for="osize">Group Size</label> 
                        </div>
                        <div class="input-field">
                            <input type="date" class="form-control" required="required" id="oexpdate" name="oexpdate" min="" onfocus="(this.type='date')" onblur="(this.type='text')"/>
                            <label class="form-label" for="oexpdate">Offer Expire</label> 
                        </div>
                        <div class="input-field">
                            <input type="number" class="form-control" required="required" id="oexpcoupon" name="oexpcoupon" min="1"/>
                            <label class="form-label" for="oexpcoupon">Coupon Expire in days after purchase</label> 
                        </div>
                        <div class="input-field">
                            <input type="file" class="form-control" required="required" id="oimage" name="oimage[]" min= "1" multiple/>
                            <label class="input-label-focused" for="oimage">Images</label> 
                        </div>
                       
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="selectedCodesText" readonly>
                            <select id="codes" multiple onchange="updateLabel()">
</select>
                            <label class="input-label-focused" for="codes">Product Code</label>
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

                        <div class="layout track-container border-yellow" id="trackcontainer2">
                <!-- Item slider-->
                        <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                            <c:forEach items="${productList}" var="item">
                        <div class='product'>
                            <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=${item.getCode()}'>
                                <img src='${item.getFirstImagePath()}' draggable='false' />
                            </a>
                                <p class="image-left">
                                    <a class="fas fa-bars" href='editproduct?proid=${item.getId()}'></a>
                                </p>
                                <p class="image-right">
                                    <a href="#" onclick="confirmRedirect(${item.getId()})">
                                        <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                    </a>
                                </p>
                            <p class="image-left image-bottom">${item.getName()}</p>
                            <p class="image-right image-bottom">${item.getPrice()}$</p>
                        </div>                            
                                </c:forEach>

                        </div>

                <!-- Item slider end-->
                        </div>


                        <button type="submit" name="submit" class="btn btn-primary btn-block mb-4">Submit</button>
                    </form>
                </div>
            </div>
        </div>
                        <div class="layout track-container border-yellow" id="trackcontainer" hidden="hidden">
                <!-- Item slider-->
                <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0' hidden="hidden">
                        </div>
                        </div>
                        
                        <script>
            //DELETE CONFIRM
            function confirmRedirect(productId) {
                var confirmed = confirm("Are you sure you want to delete this product?");
                if (confirmed) {
                    window.location.href = "deleteproduct?proid=" + productId;
                }
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
                $(".filter-item").click(function () {
                    $(this).find(".filter-values").toggleClass("hidden");
                });
            });
          
            // Get today's date
            var today = new Date();

            // Format the date as YYYY-MM-DD
            var formattedDate = today.toISOString().split('T')[0];

            // Set the value and minimum attributes of the date input field
            document.getElementById('oexpdate').min = formattedDate;
            document.getElementById('oexpdate').type = 'text';
        </script>
        <script>
    function updateLabel() {
        var selectElement = document.getElementById("codes");
        var selectedCodes = [];
        for (var i = 0; i < selectElement.options.length; i++) {
            if (selectElement.options[i].selected) {
                selectedCodes.push(selectElement.options[i].text);
            }
        }
        // Προσθήκη επιλεγμένων κωδικών στο πεδίο κειμένου
        var textFieldElement = document.getElementById("selectedCodesText");
        textFieldElement.value = selectedCodes.join(", ");
    }
   
</script>
 <script type='text/javascript' src='js/listTrack.js'></script>
<script type='text/javascript' src='js/filterScroll.js'></script>
        
        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>
