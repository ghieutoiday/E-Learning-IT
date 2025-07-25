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
        <link rel="icon" href="<%=request.getContextPath()%>/admin/assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/color/color-1.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
            }
            .page-banner {
                background-image: url('<%=request.getContextPath()%>/admin/assets/images/banner/banner2.jpg');
                background-size: cover;
                background-position: center;
                padding: 60px 0;
                position: relative;
                overflow: hidden;
            }
            .page-banner::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
            }
            .page-banner-entry {
                position: relative;
                z-index: 1;
                text-align: center;
                color: #fff;
            }
            .container {
                max-width: 1200px; /* Center main container */
                margin: 0 auto;
            }
            .registration-card {
                max-width: 850px;
                margin: 0 auto;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
                border-radius: 16px;
                padding: 30px;
                background-color: #fff;
            }
            .form-label {
                font-weight: 500;
            }
            .form-section-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-top: 25px;
                margin-bottom: 10px;
                color: #333;
            }
            .btn-primary {
                padding: 10px 20px;
                font-size: 16px;
                font-weight: 500;
                background-color: #0d6efd;
                border-color: #0d6efd;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.1s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .btn-primary:hover {
                background-color: #084298;
                transform: translateY(-2px);
            }
            .btn-primary:active {
                transform: translateY(0);
            }
            .btn-secondary {
                padding: 10px 20px;
                font-size: 16px;
                font-weight: 500;
                background-color: #6c757d;
                border-color: #6c757d;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.1s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .btn-secondary:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
            }
            .btn-secondary:active {
                transform: translateY(0);
            }
            .registration-card h3.text-primary.mb-0 {
                color: #0d6efd;
            }
            .error-message {
                color: red;
                margin-bottom: 15px;
                text-align: center;
            }
            /* Dropdown styling */
            .ttr-header-submenu {
                display: none !important;
                position: absolute !important;
                top: 100% !important;
                right: 0 !important;
                background: #fff !important;
                border: 1px solid #ddd !important;
                border-radius: 4px !important;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
                z-index: 1000 !important;
                min-width: 150px !important;
                padding: 10px 0 !important;
            }
            .ttr-header-submenu.show {
                display: block !important;
            }
            .ttr-header-submenu ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .ttr-header-submenu li {
                padding: 8px 20px;
            }
            .ttr-header-submenu li a {
                color: #333;
                text-decoration: none;
                display: block;
            }
            .ttr-header-submenu li a:hover {
                background: #f0f0f0;
            }
            .ttr-header-right {
                position: relative;
            }
        </style>
        <script defer>
            document.addEventListener('DOMContentLoaded', function() {
                console.log('Attempting to initialize dropdown');
                try {
                    const submenuToggle = document.querySelector('.ttr-submenu-toggle');
                    const submenu = document.querySelector('.ttr-header-submenu');
                    if (!submenuToggle || !submenu) {
                        console.error('Header elements missing: submenuToggle or submenu not found');
                    } else {
                        console.log('Header elements found. Adding click event');
                        submenuToggle.addEventListener('click', function(e) {
                            e.preventDefault();
                            console.log('Toggle clicked. Current class:', submenu.classList);
                            submenu.classList.toggle('show');
                        });
                        document.addEventListener('click', function(e) {
                            if (!submenu.contains(e.target) && !submenuToggle.contains(e.target)) {
                                console.log('Clicked outside. Closing submenu');
                                submenu.classList.remove('show');
                            }
                        });
                    }
                } catch (error) {
                    console.error('Error initializing dropdown: ', error);
                }
            });
        </script>
    </head>
    <body>
        <!-- Header -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!--logo start -->
                <div class="ttr-logo-box">
                    <div>
                        <a href="home" class="ttr-logo">
                            <img alt="" class="ttr-logo-mobile" src="assets/images/logowhite1.png" width="30" height="30">
                            <img alt="" class="ttr-logo-desktop" src="assets/images/logowhite1.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="<%=request.getContextPath()%>/admin/assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="userProfileController">My profile</a></li>
                                    <c:if test="${sessionScope.loggedInUser ne null}">
                                    <li><a href="logout">Logout</a></li>
                                    </c:if>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
            </div>
        </header>
        <!-- header end -->
        <!-- Content -->
        <div class="page-content bg-white">
            <!-- inner page banner -->
            <div class="page-banner ovbl-dark">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white">Edit Registration</h1>
                    </div>
                </div>
            </div>
            <!-- contact area -->
            <div class="container py-5">
                <div class="registration-card">
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">${errorMessage}</div>
                    </c:if>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="text-primary mb-0"></h3>
                        <a href="registrationsalercontroller?action=new" class="btn btn-primary add-new-btn">Add New</a>
                    </div>
                    <form action="registrationsalercontroller?action=edit" method="POST">
                        <input type="hidden" name="registrationID" value="${Saler.registrationID}" />
                        <input type="hidden" name="pricePackageID" value="${Saler.pricePackage.pricePackageID}" />
                        <input type="hidden" name="userID" value="${Saler.user.userID}" />

                        <!-- Course -->
                        <div class="form-section-title">Course Information</div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label">Course</label>
                                <select class="form-control" id="courseID" name="courseID" required>
                                    <c:forEach var="course" items="${courseList}">
                                        <option value="${course.courseID}" 
                                                ${Saler.course.courseID == course.courseID ? 'selected' : ''}>
                                            ${course.courseName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <!-- Package Info -->
                        <div class="form-section-title">Package Details</div>
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Package Name</label>
                                <select class="form-control" id="name" name="name" required>
                                    <c:forEach var="pkg" items="${packageList}">
                                        <option value="${pkg.name}" 
                                                ${Saler.pricePackage.pricePackageID == pkg.pricePackageID ? 'selected' : ''}>
                                            ${pkg.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">List Price (USD)</label>
                                <input type="number" class="form-control" name="listPrice" value="${Saler.pricePackage.listPrice}" />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Sale Price (USD)</label>
                                <input type="number" class="form-control" name="salePrice" value="${Saler.pricePackage.salePrice}" />
                            </div>
                        </div>
                        <!-- Learner Info -->
                        <div class="form-section-title">Learner Information</div>
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullName" class="form-control" value="${Saler.user.fullName}" />
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Gender</label>
                                <input type="text" class="form-control" name="gender" value="${Saler.user.gender}" />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" value="${Saler.user.email}" />
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Phone Number</label>
                                <input type="text" name="mobile" class="form-control" value="${Saler.user.mobile}" />
                            </div>
                        </div>
                        <!-- Registration Details -->
                        <div class="form-section-title">Registration Details</div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Registration Time</label>
                                <input type="datetime-local" name="registrationTime" class="form-control" value="<fmt:formatDate value='${Saler.registrationTime}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" readonly />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Sale</label>
                                <input type="text" name="sale" class="form-control"
                                       value="<fmt:formatNumber value='${100 - (Saler.pricePackage.salePrice * 100.0 / Saler.pricePackage.listPrice)}' type='number' maxFractionDigits='2' />%" readonly />
                            </div>
                        </div>
                        <!-- Valid Time -->
                        <div class="form-section-title">Validity Period</div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Valid From</label>
                                <input type="date" name="validFrom" class="form-control" value="<fmt:formatDate value='${Saler.validFrom}' pattern='yyyy-MM-dd'/>" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Valid To</label>
                                <input type="date" name="validTo" class="form-control" value="<fmt:formatDate value='${Saler.validTo}' pattern='yyyy-MM-dd'/>" />
                            </div>
                        </div>
                        <!-- Status & Notes -->
                        <div class="form-section-title">Registration Status</div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Status</label>
                                <select name="status" class="form-control" required>
                                    <option value="Submitted" ${Saler.status == 'Submitted' ? 'selected' : ''}>Submitted</option>
                                    <option value="Paid" ${Saler.status == 'Paid' ? 'selected' : ''}>Paid</option>
                                    <option value="Cancelled" ${Saler.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Notes</label>
                                <input type="text" name="note" class="form-control" value="${Saler.note}" />
                            </div>
                        </div>
                        <!-- Submit -->
                        <div class="text-end">
                            <a href="registrationsalercontroller" class="btn btn-secondary me-2">Back to List</a>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Content END-->
        <!-- Footer ==== -->
        <footer>
            <div class="footer-top">
                <div class="pt-exebar">
                    <div class="container">
                        <div class="d-flex align-items-stretch">
                            <div class="pt-logo mr-auto">
                                <a href="home"><img src="assets/images/logowhite1.png" alt=""></a>
                            </div>
                            <div class="pt-social-link">
                                <ul class="list-inline m-a0">
                                    <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                    <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                    <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                </ul>
                            </div>
                            <div class="pt-btn-join">
                                <a href="#" class="btn">Join Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-12 col-sm-12 footer-col-4">
                            <div class="widget">
                                <h5 class="footer-title">Sign Up For A Newsletter</h5>
                                <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting edge advices on job searching.</p>
                                <div class="subscribe-form m-b20">
                                    <form class="subscription-form" action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php" method="post">
                                        <div class="ajax-message"></div>
                                        <div class="input-group">
                                            <input name="email" required="required" class="form-control" placeholder="Your Email Address" type="email">
                                            <span class="input-group-btn">
                                                <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                            </span>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-5 col-md-7 col-sm-12">
                            <div class="row">
                                <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                    <div class="widget footer_widget">
                                        <h5 class="footer-title">Company</h5>
                                        <ul>
                                            <li><a href="index.jsp">Home</a></li>
                                            <li><a href="about-1.jsp">About</a></li>
                                            <li><a href="faq-1.jsp">FAQs</a></li>
                                            <li><a href="contact-1.jsp">Contact</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                    <div class="widget footer_widget">
                                        <h5 class="footer-title">Get In Touch</h5>
                                        <ul>
                                            <li><a href="http://educhamp.themetrades.com/admin/index.jsp">Dashboard</a></li>
                                            <li><a href="blog-classic-grid.jsp">Blog</a></li>
                                            <li><a href="portfolio.jsp">Portfolio</a></li>
                                            <li><a href="event.jsp">Event</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                    <div class="widget footer_widget">
                                        <h5 class="footer-title">Courses</h5>
                                        <ul>
                                            <li><a href="courses.jsp">Courses</a></li>
                                            <li><a href="courses-details.jsp">Details</a></li>
                                            <li><a href="membership.jsp">Membership</a></li>
                                            <li><a href="profile.jsp">Profile</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-3 col-md-5 col-sm-12 footer-col-4">
                            <div class="widget widget_gallery gallery-grid-4">
                                <h5 class="footer-title">Our Gallery</h5>
                                <ul class="magnific-image">
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic1.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic1.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic2.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic2.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic3.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic3.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic4.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic4.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic5.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic5.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic6.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic6.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic7.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic7.jpg" alt=""></a></li>
                                    <li><a href="<%=request.getContextPath()%>/admin/assets/images/gallery/pic8.jpg" class="magnific-anchor"><img src="<%=request.getContextPath()%>/admin/assets/images/gallery/pic8.jpg" alt=""></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center">
                                <a target="_blank" href="https://www.templateshub.net">Templates Hub</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- Footer END ==== -->
            <!-- scroll top button -->
            <button class="back-to-top fa fa-chevron-up"></button>
        </div>
        <!-- External JavaScripts -->
        <script src="<%=request.getContextPath()%>/admin/assets/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/masonry.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/filter.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/scroll/scrollbar.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/functions.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/contact.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/switcher/switcher.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/chart/chart.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/admin.js"></script>
    </body>
</html>
