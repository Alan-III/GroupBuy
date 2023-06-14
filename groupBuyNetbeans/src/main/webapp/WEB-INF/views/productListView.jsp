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
        <link rel="stylesheet" href="styles/productListStyles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="_menu.jsp"></jsp:include>
            <div class="main_box">
                <input type="checkbox" id="check" title="cb" placeholder="..">
                <div class="btn_one">
                    <label for="check">
                        <i class="fas fa-bars"></i>
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
                                <li><i class="fas fa-qrcode"></i>
                                    <a href="#">No filters for this Category</a>
                                </li>
                            </c:if>

                            <c:forEach items="${filtersList}" var="item">
                                <li class="filter-item">
                                    <i class="fas fa-qrcode"></i>
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
            <div class="layout track-container border-red" id="trackcontainer">
                <!-- Item slider-->
                <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                    <%--<c:forEach items="${list}" var="item">--%>
                    <!--LIST OF OFFERS WITH IMAGES ETC -->
                    <div class='product'>
                        <a class="product-image" href='subject_details.php?subj=${item.getCode()}'>
                            <img src='assets/img/smartphone.png' draggable='false' />
                        </a>
                        <c:if test="${logineduser.getUserName()!='tomcruz'}">
                            <p class="image-left">
                                <a class="fas fa-bars" href='editproduct?proid=${item.getId()}'></a>
                            </p>
                            <p class="image-right">
                                <a href="#" onclick="confirmRedirect(${item.getId()})">
                                    <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                </a>
                            </p>
                        </c:if>
                        <p class="image-left image-bottom">${item.getName()}</p>
                        <p class="image-right image-bottom">${item.getPrice()}$</p>
                    </div>                            
                    <%--</c:forEach>--%>

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
            <div class="layout track-container border-yellow" id="trackcontainer2">
                <!-- Item slider-->
                <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                    <c:forEach items="${productList}" var="item">
                        <div class='product'>
                            <a class="product-image" href='${pageContext.request.contextPath}/productdetails?productCode=${item.getCode()}'>
                                <img src='${item.getFirstImagePath()}' draggable='false' />
                            </a>
                            <c:if test="${loginedbusiness.getBusinessName()=='c'}">
                                <p class="image-left">
                                    <a class="fas fa-bars" href='editproduct?proid=${item.getId()}'></a>
                                </p>
                                <p class="image-right">
                                    <a href="#" onclick="confirmRedirect(${item.getId()})">
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
            <c:if test="${logineduser.getUserName()!='tomcruz'}">
      <p class="image-left">
        <a class="fas fa-bars" href='editproduct?proid=` + item.id + `'></a>
      </p>
      <p class="image-right">
        <a href="#" onclick="confirmRedirect(` + item.id + `">
          <img class="small-icon" src='assets/img/delete.png' draggable='false' />
        </a>
      </p>
            </c:if>
    <p class="image-left image-bottom">` + item.name + `</p>
    <p class="image-right image-bottom">` + item.price + `</p>
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