<%-- 
    Document   : loginView
    Created on : May 17, 2023, 10:26:23 AM
    Author     : Alan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>GroupBuy - Login</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="styles/BootstrapStyles.css" rel="stylesheet" />
        
    </head>
    <body>
        <jsp:include page="_menu.jsp"></jsp:include>
            <header id="login" class="masthead">
                <!--                <div class="container">
                                    <p>${errorString}</p>
                                    <div id="login-row" class="row justify-content-center align-items-center">
                                        <div id="login-column" class="col-md-6">
                                            <div id="login-box" class="col-md-12">
                                                <form id="login-form" class="form" action="${pageContext.request.contextPath}/login" method="post">
                                                <div class="form-group">
                                                    <label for="username" class="text-info">Username:</label><br>
                                                    <input type="text" value="${logineduser.getUserName()}" name="userName" id="username" class="form-control">
                                                </div>
                                                <div class="form-group">
                                                    <label for="password" class="text-info">Password:</label><br>
                                                    <input type="text" name="password" id="password" class="form-control">
                                                </div>
                                                <div class="form-group">
                                                    <label for="remember-me" class="text-info"><span>Remember me</span> <span><input id="remember-me" name="rememberMe" type="checkbox"></span></label><br>
                                                    <input type="submit" name="submit" class="btn btn-info btn-md" value="submit">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>-->
            
            
            <!-- Pills navs -->
            <ul class="nav nav-pills nav-justified mb-3 loginclamp" id="ex1" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="tab-login" data-mdb-toggle="pill" role="button"
                       aria-controls="pills-login" aria-selected="true">Login<br> User/Corp</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab-register" data-mdb-toggle="pill" role="button" 
                       aria-controls="pills-register" aria-selected="false">Register<br> User</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab-register-company" data-mdb-toggle="pill" role="button" 
                       aria-controls="pills-register-company" aria-selected="false">Register<br> Company</a>
                </li>
            </ul>
            <!-- Pills navs -->

            <!-- Pills content -->
            <div class="tab-content loginclamp">
                <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                    <form method="post" action="${pageContext.request.contextPath}/login">
                        <div class="text-center mb-3">
                            <p>Sign in with:</p>
                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-facebook-f"></i>
                            </button>

                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-google"></i>
                            </button>

                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-twitter"></i>
                            </button>

                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-github"></i>
                            </button>
                        </div>

                        <p class="text-center">or:</p>

                        <!-- Email input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="text" id="loginName" name="loginEmail" class="form-control" required="required" />
                            <label class="form-label" for="loginName">Email or username</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="password" id="loginPassword" name="loginPassword" class="form-control" required="required" />
                            <label class="form-label" for="loginPassword">Password</label>
                        </div>

                        <!-- 2 column grid layout -->
                        <div class="row mb-4">
                            <div class="col-md-6 d-flex justify-content-center">
                                <!-- Checkbox -->
                                <div class="form-check mb-3 mb-md-0">
                                    <input class="form-check-input" type="checkbox" value="" id="loginCheck" name="loginCheck" checked />
                                    <label class="form-check-label" for="loginCheck"> Remember me </label>
                                </div>
                            </div>

                            <div class="col-md-6 d-flex justify-content-center">
                                <!-- Simple link -->
                                <a href="#!">Forgot password?</a>
                            </div>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" name="submitLogin" class="btn btn-primary btn-block mb-4">Sign in</button>
                    </form>
                </div>
                <div class="tab-pane fade" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                    <form method="post" action="${pageContext.request.contextPath}/registerUser">
                        <div class="text-center mb-3">
                            <p>Sign up with:</p>
                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-facebook-f"></i>
                            </button>

                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-google"></i>
                            </button>

                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-twitter"></i>
                            </button>

                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-github"></i>
                            </button>
                        </div>

                        <p class="text-center">or:</p>

                        <!-- First Name input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="text" id="registerFirstNameU" name="registerFirstNameU" class="form-control" required="required" />
                            <label class="form-label" for="registerFirstNameU">First Name</label>
                        </div>
                        <!-- Last Name input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="text" id="registerLastNameU" name="registerLastNameU" class="form-control" required="required" />
                            <label class="form-label" for="registerLastNameU">Last Name</label>
                        </div>
                        <!-- Username input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="text" id="registerUsernameU" name="registerUsernameU" class="form-control" required="required" />
                            <label class="form-label" for="registerUsernameU">Username</label>
                        </div>

                        <!-- Email input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="email" id="registerEmailU" name="registerEmailU" class="form-control" required="required" />
                            <label class="form-label" for="registerEmailU">Email</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="password" id="registerPasswordU" name="registerPasswordU" class="form-control" required="required" />
                            <label class="form-label" for="registerPasswordU">Password</label>
                        </div>

                        <!-- Repeat Password input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="password" id="registerRepeatPasswordU" name="registerRepeatPasswordU" class="form-control" required="required" />
                            <label class="form-label " for="registerRepeatPasswordU">Repeat password</label>
                        </div>

                        <!-- Checkbox -->
                        <div class="form-check d-flex justify-content-center mb-4">
                            <input class="form-check-input me-2" type="checkbox" id="registerCheck" 
                                   name="registerCheckU" aria-describedby="registerCheckHelpText" />
                            <label class="form-check-label" for="registerCheck">
                                I have read and agree to the terms
                            </label>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" name="submitRegister" class="btn btn-primary btn-block mb-3">Sign up</button>
                    </form>
                </div>
                <div class="tab-pane fade" id="pills-register-company" role="tabpanel" aria-labelledby="tab-register-company">
                    <form method="post" action="${pageContext.request.contextPath}/registerCompany">
                        <div class="text-center mb-3">
                        <h4>Contact Information</h4>    
                        <!-- Company Name input -->
                        <div  class="form-outline mb-4 input-field">
                            <input type="text" id="registerNameC" name="registerNameC" class="form-control" required="required" />
                            <label class="form-label" for="registerNameC">Company Name</label>
                        </div>
                        <!-- Email input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="email" id="registerEmailC" name="registerEmailC" class="form-control" required="required" />
                            <label class="form-label" for="registerEmailC">Email Address</label>
                        </div>
                        <!-- IBAN input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="email" id="registeriban" name="registeriban" class="form-control" required="required" />
                            <label class="form-label" for="registeriban">IBAN</label>
                        </div>
                        <!-- AFM input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="email" id="registerafm" name="registerafm" class="form-control" required="required" />
                            <label class="form-label" for="registerafm">Tax Code</label>
                        </div>
                        
                        <h4>Company Representative</h4>
                        <!-- SUpervisor First Name input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="text" id="registerFirstNameC" name="registerFirstNameC" class="form-control" required="required" />
                            <label class="form-label" for="registerFirstNameC">Primary Contact First Name</label>
                        </div>
                        <!-- SUpervisor First Name input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="text" id="registerLastNameC" name="registerLastNameC" class="form-control" required="required" />
                            <label class="form-label" for="registerLastNameC">Primary Contact Last Name</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="password" id="registerPasswordC" name="registerPasswordC" class="form-control" required="required" />
                            <label class="form-label" for="registerPasswordC">Password</label>
                        </div>

                        <!-- Repeat Password input -->
                        <div class="form-outline mb-4 input-field">
                            <input type="password" id="registerRepeatPasswordC" name="registerRepeatPasswordC" class="form-control" required="required" />
                            <label class="form-label" for="registerRepeatPasswordC">Repeat password</label>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" name="submitRegisterCompany" class="btn btn-primary btn-block mb-3">Sign up</button>
                    </form>
                </div>        
            </div>
            <!-- Pills content -->
        </header>
        <script src="js/scripts.js"></script>
        <jsp:include page="_footer.jsp"></jsp:include>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    </body>
</html>
