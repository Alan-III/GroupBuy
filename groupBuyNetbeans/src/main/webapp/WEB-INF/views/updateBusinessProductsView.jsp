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
        <link rel="stylesheet" href="styles/filterSidebarStyles.css">
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
                            <ul id="filtersContainer">
                                <li><i class="fas fa-qrcode"></i>
                                    <a href="#">Please Select Category</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>


                <div id="userinfo" class="layout">
                    <h3 class="text-center text-white pt-5">Create Product</h3>
                    <br>
                    <div class="loginclamp">
                        <form id="createproductform" class="form-container" method="post" action="${pageContext.request.contextPath}/createproduct" enctype="multipart/form-data">
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="pname" name="pname" />
                            <label class="form-label" for="pname" >Product Name</label> 
                        </div>
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="pbarcode" name="pbarcode" />
                            <label class="form-label" for="pbarcode">Product Barcode</label> 
                        </div>
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="pprice" name="pprice" />
                            <label class="form-label" for="pprice">Price</label> 
                        </div>
                        <div class="input-field">
                            <input type="text" class="form-control" required="required" id="pdetails" name="pdetails" rows="4" cols="50" />
                            <label class="form-label" for="pdetails">Details</label> 
                        </div>

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
                        <div class="input-field">
                            <input type="file" class="form-control" required="required" id="pimage" name="pimage[]" multiple/>
                            <label class="input-label-focused" for="pimage">Images</label> 
                        </div>
<!--                        <button type="submit" name="submit" class="btn btn-primary btn-block mb-4">Submit</button>-->
                         <!-- Button to trigger the submission -->
                        <button type="button" class="btn btn-primary btn-block mb-4" onclick="submitForm()">Submit</button>
                    </form>
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
            //show filters
            var filtercheck = document.getElementById("check");
            filtercheck.checked = true;
            populateFilters();
            });
            //--------------------//
            // Handle category selection change
            var categorySelect = document.getElementById("category");
            categorySelect.addEventListener("change", function () {
            var subcategoryName = this.value;
            var subcategorySelect = document.getElementById("subcategory");
            // Clear existing options
            subcategorySelect.innerHTML = '<option value="" disabled selected></option>';
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
            populateFilters();
            });
            //--------------------//
            // POPULATE FILTERS
            var categoryFilterMap = JSON.parse('${categoryFilterMapJson}');
            // Function to populate filters based on selected category
            function populateFilters() {
            var selectedCategory = document.getElementById("subcategory").value ||
                    document.getElementById("category").value ||
                    document.getElementById("generalCategory").value;
            var filtersContainer = document.getElementById("filtersContainer");
            filtersContainer.innerHTML = ""; // Clear existing filters

            if (selectedCategory) {
            var filters = categoryFilterMap[selectedCategory];
            if (filters && filters.length > 0) {
            filters.forEach(function(filter) {
            var filterElement = document.createElement("div");
            filterElement.className = "input-field mt-2";
            var filterInput = document.createElement("input");
            filterInput.type = "text";
            filterInput.className = "form-control filterinput";
            filterInput.required = "required";
            filterInput.id = filter;
            filterInput.name = filter;
            var filterLabel = document.createElement("label");
            filterLabel.className = "form-label";
            filterLabel.htmlFor = filter;
            filterLabel.textContent = filter;
            filterElement.appendChild(filterInput);
            filterElement.appendChild(filterLabel);
            filtersContainer.appendChild(filterElement);
            });
            } else {
            var noFiltersElement = document.createElement("li");
            var filterLink = document.createElement("a");
            filterLink.href = "#";
            filterLink.textContent = "No filters available for the selected category.";
            noFiltersElement.appendChild(filterLink);
            filtersContainer.appendChild(noFiltersElement);
            }
            } else {
            var selectCategoryElement = document.createElement("li");
            var filterLink = document.createElement("a");
            filterLink.href = "#";
            filterLink.textContent = "Please select a category.";
            selectCategoryElement.appendChild(filterLink);
            filtersContainer.appendChild(selectCategoryElement);
            }
            }


            // Handle subcategory selection change
            var subcategorySelect = document.getElementById("subcategory");
            subcategorySelect.addEventListener("change", populateFilters);
            //--------------------//
            //Get filters with submit
            function submitForm() {
            // Create an array to store the filter inputs
            var filterInputs = [];
            // Iterate over each filter input element
            $(".filterinput").each(function() {
                var name = $(this).attr("name");
                var value = $(this).val();
            // Create an object with name and value properties
                var filterInput = {
                    name: name,
                    value: value
            };
            // Add the filter input object to the array
            filterInputs.push(filterInput);
            });
            // Create a hidden input field for the filter inputs
            var filterInputsInput = $("<input>")
                    .attr("type", "hidden")
                    .attr("name", "filterInputs")
                    .val(JSON.stringify(filterInputs));
            $("form").append(filterInputsInput);
            // Submit the form
            $("form").submit();
            }
        </script>


        <script type='text/javascript' src='js/filterScroll.js'></script>
        <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>