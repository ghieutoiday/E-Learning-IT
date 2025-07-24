<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

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

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <header class="header rs-nav">
                <div class="top-bar">
                    <div class="container">
                        <div class="row d-flex justify-content-between">
                            <div class="topbar-left">
                                <ul>
                                    <li><a href="faq-1.jsp"><i class="fa fa-question-circle"></i>Ask a Question</a></li>
                                    <li><a href="javascript:;"><i class="fa fa-envelope-o"></i>Support@website.com</a></li>
                                </ul>
                            </div>
                            <div class="topbar-right">
                                <ul>
                                    <li>
                                        <select class="header-lang-bx">
                                            <option data-icon="flag flag-uk">English UK</option>
                                            <option data-icon="flag flag-us">English US</option>
                                        </select>
                                    </li>
                                    <li><a href="login.jsp">Login</a></li>
                                    <li><a href="register.jsp">Register</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <!-- Header Logo ==== -->
                            <div class="menu-logo">
                                <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <!-- Mobile Nav Button ==== -->
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <!-- Author Nav ==== -->
                            <div class="secondary-menu">
                                <div class="secondary-inner">
                                    <ul>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <!-- Search Button ==== -->
                                        <li class="search-btn"><button id="quik-search-btn" type="button" class="btn-link"><i class="fa fa-search"></i></button></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- Search Box ==== -->
                            <div class="nav-search-bar">
                                <form action="#">
                                    <input name="search" value="" type="text" class="form-control" placeholder="Type to search">
                                    <span><i class="ti-search"></i></span>
                                </form>
                                <span id="search-remove"><i class="ti-close"></i></span>
                            </div>
                            <!-- Navigation Menu ==== -->
                            <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                                <div class="menu-logo">
                                    <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">	
                                    <li class="active"><a href="javascript:;">Home <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="index.jsp">Home 1</a></li>
                                            <li><a href="index-2.jsp">Home 2</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Pages <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="javascript:;">About<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="about-1.jsp">About 1</a></li>
                                                    <li><a href="about-2.jsp">About 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Event<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="event.jsp">Event</a></li>
                                                    <li><a href="events-details.jsp">Events Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">FAQ's<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="faq-1.jsp">FAQ's 1</a></li>
                                                    <li><a href="faq-2.jsp">FAQ's 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Contact Us<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="contact-1.jsp">Contact Us 1</a></li>
                                                    <li><a href="contact-2.jsp">Contact Us 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="portfolio.jsp">Portfolio</a></li>
                                            <li><a href="profile.jsp">Profile</a></li>
                                            <li><a href="membership.jsp">Membership</a></li>
                                            <li><a href="error-404.jsp">404 Page</a></li>
                                        </ul>
                                    </li>
                                    <li class="add-mega-menu"><a href="javascript:;">Our Courses <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu add-menu">
                                            <li class="add-menu-left">
                                                <h5 class="menu-adv-title">Our Courses</h5>
                                                <ul>
                                                    <li><a href="courses.jsp">Courses </a></li>
                                                    <li><a href="courses-details.jsp">Courses Details</a></li>
                                                    <li><a href="profile.jsp">Instructor Profile</a></li>
                                                    <li><a href="event.jsp">Upcoming Event</a></li>
                                                    <li><a href="membership.jsp">Membership</a></li>
                                                </ul>
                                            </li>
                                            <li class="add-menu-right">
                                                <img src="assets/images/adv/adv.jpg" alt=""/>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Blog <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="blog-classic-grid.jsp">Blog Classic</a></li>
                                            <li><a href="blog-classic-sidebar.jsp">Blog Classic Sidebar</a></li>
                                            <li><a href="blog-list-sidebar.jsp">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a></li>
                                            <li><a href="blog-details.jsp">Blog Details</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-dashboard"><a href="javascript:;">Dashboard <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="admin/index.jsp">Dashboard</a></li>
                                            <li><a href="admin/add-listing.jsp">Add Listing</a></li>
                                            <li><a href="admin/bookmark.jsp">Bookmark</a></li>
                                            <li><a href="admin/postslist.jsp">Posts List</a></li>
                                            <li><a href="admin/review.jsp">Review</a></li>
                                            <li><a href="admin/teacher-profile.jsp">Teacher Profile</a></li>
                                            <li><a href="admin/user-profile.jsp">User Profile</a></li>
                                            <li><a href="coursecontroller">Subject List</a></li>
                                            <li><a href="change-password.jsp">Change Password</a></li>
                                            <li><a href="javascript:;">Calendar<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="admin/basic-calendar.jsp">Basic Calendar</a></li>
                                                    <li><a href="admin/list-view-calendar.jsp">List View Calendar</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Mailbox<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="admin/mailbox.jsp">Mailbox</a></li>
                                                    <li><a href="admin/mailbox-compose.jsp">Compose</a></li>
                                                    <li><a href="admin/mailbox-read.jsp">Mail Read</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="nav-social-link">
                                    <a href="javascript:;"><i class="fa fa-facebook"></i></a>
                                    <a href="javascript:;"><i class="fa fa-google-plus"></i></a>
                                    <a href="javascript:;"><i class="fa fa-linkedin"></i></a>
                                </div>
                            </div>
                            <!-- Navigation Menu END ==== -->
                        </div>
                    </div>
                </div>
            </header>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Events</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Events</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- contact area -->
                <main class="ttr-wrapper">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12 m-b30">
                                <div class="widget-box">
                                    <div class="wc-title">
                                        <div class="db-breadcrumb">
                                            <h4 class="breadcrumb-title" style="font-size: 24px;">Quizzes List</h4>
                                            <ul class="db-breadcrumb-list">
                                                &nbsp;
                                                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                                <li>Quizzes List</li>
                                            </ul>
                                        </div>

                                        <form action="quizcontroller" method="GET" class="d-flex flex-wrap align-items-center" style="color: black;">
                                            <input type="hidden" name="action" value="list" />

                                            <div class="top-bar" style="width: 80%; display: flex; align-items: center; justify-content: flex-start; gap: 10px; flex-wrap: nowrap; margin-bottom: 15px; padding-top: 0px;">
                                                <input type="text" name="search" value="${param.search}" placeholder="Search by quiz name" class="search-input flex-grow-1" style="min-width: 50px; padding: 8px;" />
                                                <button type="submit" class="btn btn-warning search">Search</button>

                                                <select name="filterbysubject" class="sort-select">
                                                    <option value="-1" ${param.filterbysubject eq '-1' ? 'selected' : ''}>All Subject</option>
                                                    <c:forEach var="b" items="${requestScope.listAllCourse}">
                                                        <option value="${b.courseID}" ${param.filterbysubject == b.courseID ? 'selected' : ''}>${b.courseName}</option>
                                                    </c:forEach>
                                                </select>

                                                <select name="quiztype" class="sort-select">
                                                    <option value="-1" ${param.quiztype eq '-1' ? 'selected' : ''}>All Quiz Type</option>
                                                    <c:forEach var="c" items="${requestScope.listAllQuizType}">
                                                        <option value="${c}" ${param.quiztype == c ? 'selected' : ''}>${c}</option>
                                                    </c:forEach>
                                                </select>


                                            </div>

                                            <div class="filters" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center; margin-bottom: 20px; width: 100%;">
                                                <div class="d-flex align-items-center">
                                                    <span>Records per page:</span>
                                                    <input type="number" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 5}" min="1" class="form-control" style="height: 32px;width: 75px; margin-left: 10px; padding: 6px;" />
                                                </div>

                                                <div class="d-flex align-items-center">
                                                    <span>Choose column to hide: </span>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideID" value="true" ${param.hideID == 'true' ? 'checked' : ''}> ID</label>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideSubject" value="true" ${param.hideSubject == 'true' ? 'checked' : ''}> Subject</label>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideLevel" value="true" ${param.hideLevel == 'true' ? 'checked' : ''}> Level</label>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideNOQ" value="true" ${param.hideNOQ == 'true' ? 'checked' : ''}> Number of Question</label>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideDuration" value="true" ${param.hideDuration == 'true' ? 'checked' : ''}> Duration</label>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hidePassRate" value="true" ${param.hidePassRate == 'true' ? 'checked' : ''}> Pass Rate</label>
                                                    <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideQuizType" value="true" ${param.hideQuizType == 'true' ? 'checked' : ''}> Quiz Type</label>
                                                </div>

                                                <input type="hidden" name="page" value="1" />
                                                <button type="submit" class="btn btn-warning">Apply Filters</button>
                                                <a href="quizcontroller" class="btn btn-warning reset">Reset Filters</a>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="widget-inner">
                                        <div class="card-courses-list admin-courses">
                                            <table border="1">
                                                <thead>
                                                    <tr>
                                                        <c:if test="${param.hideID != 'true'}"><th>ID</th></c:if>
                                                            <th>Quiz Name</th>
                                                        <c:if test="${param.hideSubject != 'true'}"><th>Subject</th></c:if>
                                                        <c:if test="${param.hideLevel != 'true'}"><th>Level</th></c:if>
                                                        <c:if test="${param.hideNOQ != 'true'}"><th>Number of Question</th></c:if>
                                                        <c:if test="${param.hideDuration != 'true'}"><th>Duration</th></c:if>
                                                        <c:if test="${param.hidePassRate != 'true'}"><th>Pass Rate</th></c:if>
                                                        <c:if test="${param.hideQuizType != 'true'}"><th>Quiz Type</th></c:if>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="a" items="${listAllQuiz}" varStatus="loop">
                                                        <tr>
                                                            <c:if test="${param.hideID != 'true'}"><td>${a.quizID}</td></c:if>
                                                            <td>${a.name}</td>
                                                            <c:if test="${param.hideSubject != 'true'}"><td>${a.course.courseName}</td></c:if>
                                                            <c:if test="${param.hideLevel != 'true'}"><td>${a.level}</td></c:if>
                                                            <c:if test="${param.hideNOQ != 'true'}"><td>${a.numberQuestions}</td></c:if>
                                                            <c:if test="${param.hideDuration != 'true'}"><td>${a.duration}</td></c:if>
                                                            <c:if test="${param.hidePassRate != 'true'}"><td>${a.passRate}</td></c:if>
                                                            <c:if test="${param.hideQuizType != 'true'}"><td>${a.quizType}</td></c:if>

                                                                <td class="action-buttons">
                                                                    <a href="#">Edit</a>
                                                                    <a href="#">Delete</a>
                                                                </td>
                                                            </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- Pagination -->
                                        <div class="pagination-bx rounded-sm gray clearfix">
                                            <ul class="pagination">
                                                <c:set var="baseQuery" value="action=list" />
                                                <c:if test="${not empty param.search}"><c:set var="baseQuery" value="${baseQuery}&search=${param.search}" /></c:if>
                                                <c:if test="${not empty param.filterbysubject}"><c:set var="baseQuery" value="${baseQuery}&filterbysubject=${param.filterbysubject}" /></c:if>
                                                <c:if test="${not empty param.quiztype}"><c:set var="baseQuery" value="${baseQuery}&quiztype=${param.quiztype}" /></c:if>
                                                <c:if test="${not empty param.rowsPerPage}"><c:set var="baseQuery" value="${baseQuery}&rowsPerPage=${param.rowsPerPage}" /></c:if>
                                                <c:if test="${param.hideID == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideID=true" /></c:if>
                                                <c:if test="${param.hideSubject == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideSubject=true" /></c:if>
                                                <c:if test="${param.hideLevel == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideLevel=true" /></c:if>
                                                <c:if test="${param.hideNOQ == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideNOQ=true" /></c:if>
                                                <c:if test="${param.hideDuration == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideDuration=true" /></c:if>
                                                <c:if test="${param.hidePassRate == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hidePassRate=true" /></c:if>
                                                <c:if test="${param.hideQuizType == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideQuizType=true" /></c:if>

                                                <c:if test="${currentPage > 1}">
                                                    <li class="previous">
                                                        <a href="quizcontroller?${baseQuery}&page=${currentPage - 1}">
                                                            <i class="ti-arrow-left"></i> Prev
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="${currentPage == i ? 'active' : ''}">
                                                        <a href="quizcontroller?${baseQuery}&page=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="next">
                                                        <a href="quizcontroller?${baseQuery}&page=${currentPage + 1}">
                                                            Next <i class="ti-arrow-right"></i>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </main>
                <!-- contact area END -->
            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="index.jsp"><img src="assets/images/logo-white.png" alt=""/></a>
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
                                    <a href="#" class="btn ">Join Now</a>
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
                                                <input name="email" required="required"  class="form-control" placeholder="Your Email Address" type="email">
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
                                        <li><a href="assets/images/gallery/pic1.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic2.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic3.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic4.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic5.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic6.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic7.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic8.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- Footer END ==== -->
            <button class="back-to-top fa fa-chevron-up" ></button>
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
