/*!
* Start Bootstrap - Agency v7.0.12 (https://startbootstrap.com/theme/agency)
* Copyright 2013-2023 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-agency/blob/master/LICENSE)
*/
//
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Navbar shrink function
    var navbarShrink = function () {
        const navbarCollapsible = document.body.querySelector('#mainNav');
        if (!navbarCollapsible) {
            return;
        }
        if (window.scrollY === 0) {
            navbarCollapsible.classList.remove('navbar-shrink')
        } else {
            navbarCollapsible.classList.add('navbar-shrink')
        }

    };

    // Shrink the navbar 
    navbarShrink();

    // Shrink the navbar when page is scrolled
    document.addEventListener('scroll', navbarShrink);

    //  Activate Bootstrap scrollspy on the main nav element
    const mainNav = document.body.querySelector('#mainNav');
    if (mainNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#mainNav',
            rootMargin: '0px 0px -40%',
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

});

const tabRegister = document.getElementById("tab-register");
const tabLogin = document.getElementById("tab-login");
const tabRegisterCompany = document.getElementById("tab-register-company");
const pillsLogin = document.getElementById("pills-login");
const pillsRegister= document.getElementById("pills-register");
const pillsRegisterCompany= document.getElementById("pills-register-company");

tabRegister.addEventListener("click", function(){ 
    pillsLogin.classList.remove("show");
    pillsLogin.classList.remove("active")
    pillsRegisterCompany.classList.remove("show");
    pillsRegisterCompany.classList.remove("active")
    tabLogin.setAttribute("aria-selected", "false");
    tabLogin.classList.remove("active");
    tabRegisterCompany.setAttribute("aria-selected", "false");
    tabRegisterCompany.classList.remove("active");
    pillsRegister.classList.add("show");
    pillsRegister.classList.add("active");
    tabRegister.setAttribute("aria-selected", "true");
    tabRegister.classList.add("active");
});
tabLogin.addEventListener("click", function(){ 
    pillsRegister.classList.remove("show");
    pillsRegister.classList.remove("active");
    pillsRegisterCompany.classList.remove("show");
    pillsRegisterCompany.classList.remove("active")
    tabRegister.setAttribute("aria-selected", "false");
    tabRegister.classList.remove("active");
    tabRegisterCompany.setAttribute("aria-selected", "false");
    tabRegisterCompany.classList.remove("active");
    pillsLogin.classList.add("show");
    pillsLogin.classList.add("active");
    tabLogin.setAttribute("aria-selected", "true");
    tabLogin.classList.add("active");
});

tabRegisterCompany.addEventListener("click", function(){ 
    pillsRegister.classList.remove("show");
    pillsRegister.classList.remove("active");
    pillsLogin.classList.remove("show");
    pillsLogin.classList.remove("active")
    tabRegister.setAttribute("aria-selected", "false");
    tabRegister.classList.remove("active");
    tabLogin.setAttribute("aria-selected", "false");
    tabLogin.classList.remove("active");
    pillsRegisterCompany.classList.add("show");
    pillsRegisterCompany.classList.add("active");
    tabRegisterCompany.setAttribute("aria-selected", "true");
    tabRegisterCompany.classList.add("active");
});
