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
                            <ul>
                                <%--<c:forEach items="${list}" var="item">--%>
                                <li><i class="fas fa-qrcode"></i>
                                    <a href="#">RAM</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">CPU</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <li>
                                    <i class="fas fa-link"></i>
                                    <a href="#">MAKE filter</a>
                                </li>
                                <%--</c:forEach>--%>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="layout">
                    <div class="search_bar-small">
                        <img src="https://cdn.pixabay.com/photo/2013/07/12/15/55/clues-150586_960_720.png" alt="glass" height="35rem" width="35rem" />
                        <input class="typewriter" type="text" placeholder="Type here to search..."/>
                    </div>
                </div> 
                <br>
                <div class="layout"><h4>Offers</h4></div>
                <div class="layout track-container border-red" id="trackcontainer">
                    <!-- Item slider-->
                    <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <%--<c:forEach items="${list}" var="item">--%>
                            <!--{item.getPath()} sto src-->
                            <div class='product'>
                                <a class="product-image" href='subject_details.php?subj=${item.getCode()}'>
                                  <img src='assets/img/smartphone.png' draggable='false' />
                                </a>
                                <c:if test="${logineduser.getUserName()=='tomcruz'}">
                                    <p class="image-left">
                                        <a class="fas fa-bars" href='urltoedit'></a>
                                    </p>
                                    <p class="image-right">
                                        <a href='urltodelete'>
                                            <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                        </a>
                                    </p>
                                </c:if>
                                <p class="image-left image-bottom">${item.getName()}Product Name can't be longer 1 2 3</p>
                                <p class="image-right image-bottom">${item.getPrice()}1.000$</p>
                            </div>                            
                        <%--</c:forEach>--%>
                            
                        <a href='subject_details.php?subj=Math&subjID=1'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Physics&subjID=2'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Chemistry&subjID=3'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                    </div>
                    
                    <!-- Item slider end-->
                </div>
                <br>
                <div class="layout"><h4>Products</h4></div>
                <div class="layout track-container border-yellow" id="trackcontainer2">
                    <!-- Item slider-->
                    <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <%--<c:forEach items="${list}" var="item">--%>
                            <!--{item.getPath()} sto src-->
                            <div class='product'>
                                <a class="product-image" href='subject_details.php?subj=${item.getCode()}'>
                                  <img src='assets/img/smartphone.png' draggable='false' />
                                </a>
                                <c:if test="${logineduser.getUserName()=='tomcruz'}">
                                    <p class="image-left">
                                        <a class="fas fa-bars" href='urltoedit'></a>
                                    </p>
                                    <p class="image-right">
                                        <a href='urltodelete'>
                                            <img class="small-icon" src='assets/img/delete.png' draggable='false' />
                                        </a>
                                    </p>
                                </c:if>
                                <p class="image-left image-bottom">${item.getName()}Product Name can't be longer 1 2 3</p>
                                <p class="image-right image-bottom">${item.getPrice()}1.000$</p>
                            </div>                            
                        <%--</c:forEach>--%>
                            
                        <a href='subject_details.php?subj=Math&subjID=1'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Physics&subjID=2'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Chemistry&subjID=3'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Math&subjID=1'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Physics&subjID=2'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Chemistry&subjID=3'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Math&subjID=1'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Physics&subjID=2'><img class='product' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Chemistry&subjID=3'><img class='product' src='assets/img/delete.png' draggable='false' /></a>
                    </div>
                    
                    <!-- Item slider end-->
                </div>

            </div>
            <script type='text/javascript' src='js/subjectsTrack.js'></script>
            <!-- Footer-->
        <jsp:include page="_footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>