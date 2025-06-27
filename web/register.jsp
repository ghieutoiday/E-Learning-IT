<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <style>
            /* Căn giữa form đăng ký */
            .account-form-inner {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 40px 15px;
            }

            /* Form container */
            .account-container {
                background: #ffffff;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                padding: 30px;
                max-width: 500px;
                width: 100%;
            }

            /* Tiêu đề */
            .heading-bx h2 {
                font-size: 30px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .heading-bx p {
                margin-bottom: 20px;
                font-size: 14px;
            }

            /* Nhóm form */
            .form-group {
                margin-bottom: 20px;
            }

            .input-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 6px;
                color: #333;
            }

            .input-group input[type="text"],
            .input-group input[type="email"],
            .input-group input[type="password"],
            .input-group input[type="tel"] {
                width: 100%;
                padding: 10px 15px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
                transition: border-color 0.3s;
            }

            .input-group input:focus {
                border-color: #0d6efd;
                outline: none;
            }

            /* Radio buttons (gender) */
            .form-group input[type="radio"] {
                margin-right: 6px;
            }
            .form-group label[for="gender"] {
                font-weight: 600;
                margin-bottom: 5px;
                display: block;
            }

            /* Button */
            .btn.button-md {
                background-color: #0d6efd;
                color: white;
                border: none;
                padding: 12px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            .btn.button-md:hover {
                background-color: #0b5ed7;
            }

            /* Social buttons */
            .facebook {
                background-color: #3b5998;
                color: white;
            }

            .google-plus {
                background-color: #db4437;
                color: white;
            }

            .facebook:hover {
                background-color: #2d4373;
            }

            .google-plus:hover {
                background-color: #c23321;
            }

            /* Responsive */
            @media (max-width: 576px) {
                .account-container {
                    padding: 20px;
                }

                .btn.flex-fill {
                    font-size: 14px;
                }
            }
        </style>

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <div class="account-form">
                <div class="account-head" style="background-image:url(assets/images/background/bg2.jpg);">
                    <a href="index.jsp"><img src="assets/images/logo-white-2.png" alt=""></a>
                </div>
                <div class="account-form-inner">
                    <div class="account-container">
                        <div class="heading-bx left">
                            <h2 class="title-head">Sign Up <span>Now</span></h2>
                            <p>Already have an account? <a href="login.jsp">Click here</a></p>
                        </div>	

                        <!-- FORM ĐĂNG KÝ -->
                        <form class="contact-bx" action="signup" method="post">
                            <div class="row placeani">

                                <!-- FULL NAME -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Full Name</label>
                                            <input name="fullName" type="text" required class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <!-- GENDER -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Gender</label><br/>
                                        <label class="m-r10">
                                            <input type="radio" name="gender" value="Male" required> Male
                                        </label>
                                        <label>
                                            <input type="radio" name="gender" value="Female"> Female
                                        </label>
                                    </div>
                                </div>

                                <!-- EMAIL -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Email Address</label>
                                            <input name="email" type="email" required class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <!-- MOBILE -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Mobile</label>
                                            <input name="mobile" type="text" required class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <!-- PASSWORD -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label>Password</label>
                                            <input name="password" type="password" required class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <!-- SUBMIT BUTTON -->
                                <div class="col-lg-12 m-b30">
                                    <button name="submit" type="submit" value="Submit" class="btn button-md">Sign Up</button>
                                </div>

                                <!-- SOCIAL LOGIN -->
                                <div class="col-lg-12">
                                    <h6>Or Sign Up with Social Media</h6>
                                    <div class="d-flex">
                                        <a class="btn flex-fill m-l5 google-plus" href="#"><i class="fa fa-google-plus"></i>Google</a>
                                    </div>
                                </div>

                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>
    </body>

</html>
