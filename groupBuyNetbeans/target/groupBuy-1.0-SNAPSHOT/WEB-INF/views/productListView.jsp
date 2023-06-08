<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <div class="layout track-container border-red">
                    <!-- Item slider-->
                    <div id='image-track' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <a href='subject_details.php?subj=Math&subjID=1'><img class='image' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Physics&subjID=2'><img class='image' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Chemistry&subjID=3'><img class='image' src='assets/img/smartphone.png' draggable='false' /></a>
                    </div>
                    
                    <!-- Item slider end-->
                </div>
                <br>
                <div class="layout"><h4>Products</h4></div>
                <div class="layout track-container border-yellow">
                    <!-- Item slider-->
                    <div id='image-track2' class="image-track" data-mouse-down-at='0' data-prev-percentage='0'>
                        <a href='subject_details.php?subj=Math&subjID=1'><img class='image' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Physics&subjID=2'><img class='image' src='assets/img/smartphone.png' draggable='false' /></a>
                        <a href='subject_details.php?subj=Chemistry&subjID=3'><img class='image' src='assets/img/smartphone.png' draggable='false' /></a>
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