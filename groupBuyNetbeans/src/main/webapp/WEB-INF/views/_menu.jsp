<%-- 
    Document   : _menu
    Created on : May 10, 2023, 11:23:40 AM
    Author     : Alan
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand" href="/groupbuy/home"><img src="assets/img/navbar-logo.png" alt="..." /> Group Buy</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars ms-1"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                <li class="nav-item"><a class="nav-link" href="/groupbuy/home#categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="/groupbuy/home#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="/groupbuy/home#team">Team</a></li>
                <li class="nav-item"><a class="nav-link" href="/groupbuy/home#contact">Contact</a></li>
                    <c:if test="${logineduser==null && loginedbusiness==null}">
                    <li class="nav-item"><a class="nav-link" href="/groupbuy/login">Sign In/Up</a></li>
                    </c:if>
                    <c:if test="${logineduser!=null}">
                        <li class="nav-item"><a class="nav-link" href="/groupbuy/userInfo">${logineduser.getUserName()}</a></li>
                        <li class="nav-item"><a class="nav-link far fa-bell" href="/groupbuy/usernotifications"></a></li>
                    </c:if>
                    <c:if test="${loginedbusiness!=null}">
                        <li class="nav-item"><a class="nav-link" href="/groupbuy/businessInfo">${loginedbusiness.getBusinessName()}</a></li>
                        <li class="nav-item"><a class="nav-link" href="/groupbuy/businessnotifications">
<!--                            <c:if test="${loginedbusiness!=null}">notifications not null-->
                                <div class="far fa-bell"></div><div class = "number">2</div>
                            </c:if>
                        </a></li>
                    </c:if>
            </ul>
        </div>
    </div>
</nav>
<c:if test="${errorString!=null}">
    <script>
        alert("${errorString}");
    </script>
</c:if>