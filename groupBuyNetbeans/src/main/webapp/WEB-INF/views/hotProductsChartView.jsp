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
        <title>GroupBuy - Business charts</title>
        <link rel="stylesheet" href="styles/userInfoStyles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                            <a href="${pageContext.request.contextPath}/hotproductschart">
                                <i class="fa fa-chart-line fa-2x"></i>
                                <span class="nav-text">
                                    Analytics
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
                <h3 class="text-center text-white pt-5">Update Business</h3>
                <br>
                                <form method="post" action="${pageContext.request.contextPath}/chartdetails">

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
                </div>

                <div class="layout mb-2">
                    <h4 class="text-center">Customer wishes </h4>
                </div>
            
                <div class="layout mb-2">
                    <h4 class="text-center">Top 10 products for today</h4>
                </div>
                <div class="layout mb-2">
                    <h4 class="text-center">Long term analysis </h4>
                    
                <div class="layout mb-2">
                    <h6 class="text-center">Select the period you want to analyze</h6>
                </div>
              <div >

                    <label for="startDate" class="form-label" >From:</label>
                    <input type="date" id="startDate" name="startDate" required>
  
                    <label for="endDate" class="form-label">to</label>
                    <input type="date" id="endDate" name="endDate" required>
                    <br> 
                     <button type="submit">Υποβολή</button>
              </div>
                    
                </div>
                </form>
                                <div id="piechart" style="    display: flex;    position: relative;    justify-content: center;"></div>
            </div>
        </div>
              
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
  
        
    if(${productList2}){
        google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);
        }

        function drawChart() {
            var data = ${productList2};
            console.log(data);
            var chartData = new google.visualization.DataTable();
            chartData.addColumn('string', 'Product');
            chartData.addColumn('number', 'Count');
            chartData.addRows(data.length);
            for (var i = 0; i < data.length; i++) {
                chartData.setCell(i, 0, data[i].name);
                chartData.setCell(i, 1, data[i].dailyCounterSearches);
            }

            var options = {
                title: 'Top Searches',
                width: 400,
                height: 300
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));
            chart.draw(chartData, options);
        }
    </script>
                                
<script>
  function validateForm() {
    var startDate = new Date(document.getElementById("startDate").value);
    var endDate = new Date(document.getElementById("endDate").value);
    var today = new Date();
    var oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());

    // Έλεγχος αν η startDate είναι μεταγενέστερη από την endDate
    if (startDate > endDate) {
      alert("Η ημερομηνία 'Από' πρέπει να είναι προγενέστερη από την ημερομηνία 'Έως'.");
      return false;
    }

    // Έλεγχος αν οι ημερομηνίες είναι προγενέστερες του ενός μήνα από τη σημερινή ημερομηνία
    if (startDate < oneMonthAgo || endDate < oneMonthAgo) {
      alert("Οι ημερομηνίες πρέπει να είναι μέσα στον τελευταίο μήνα.");
      return false;
    }

    // Έλεγχος αν η startDate είναι ίδια ή μεγαλύτερη από τη σημερινή ημερομηνία
    if (startDate > today) {
      alert("Η ημερομηνία 'Από' δεν μπορεί να είναι μεγαλύτερη από τη σημερινή ημερομηνία.");
      return false;
    }

    return true;
  }
  
</script>

                                
                                
                                
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