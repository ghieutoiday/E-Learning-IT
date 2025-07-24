<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

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
        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut filter" type="image/x-icon" href="<%=request.getContextPath()%>/admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Quizzes List</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

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
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f9;
            }
            .container {
                width: 85%;
                margin: 15px auto;
            }
            /* Sử dụng flexbox để các form và input nằm cùng một hàng */
            .filter-search-container {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-bottom: 15px;
                align-items: center;
            }

            .filter-form, .search-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .filter-form select,
            .search-form input[type="text"],
            .filter-form button,
            .search,
            .reset {
                padding: 6px;
                font-size: 13px;
                border: 1px solid #ccc;
                border-radius: 3px;
                height: 32px;
            }
            .filter-form select {
                width: 120px;
            }
            .search-form input[type="text"] {
                width: 160px;
            }
            .filter-form button,
            .search,
            .reset {
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                padding: 6px 12px;
            }
            .filter-form button:hover,
            .search:hover,
            .reset:hover {
                background-color: #0056b3;
            }
            
            .quizlist {
                font-size: 13px;
                border: 1px solid #ccc;
                border-radius: 3px;
                height: 32px;
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                padding: 6px 12px;
            }
            
            table {
                width: 95%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid #ddd;
                font-size: 13px;
            }
            th, td {
                padding: 8px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #d9eaff;
                font-weight: bold;
            }
            .action a {
                color: #007bff;
                text-decoration: none;
            }
            .action a:hover {
                text-decoration: underline;
            }
            .pagination {
                text-align: center;
                margin-top: 15px;
            }
            .pagination a {
                padding: 6px 10px;
                margin: 0 4px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #ddd;
                border-radius: 3px;
            }
            .pagination a.active {
                background-color: #007bff;
                color: #fff;
                border: none;
            }
            .pagination a:hover {
                background-color: #e9ecef;
            }

            /* CSS bổ sung từ file gốc */
            .widget-box {
                background-color: #fff;
                border-radius: 6px;
                box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
                padding: 15px;
                margin-top: -8px;
            }
            .top-bar {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                gap: 8px;
                flex-wrap: nowrap;
                margin-bottom: 12px;
                padding-top: 0px;
            }
            .search-input {
                flex: 1;
                min-width: 40%;
                padding: 5px 10px;
                font-size: 13px;
            }
            .btn-warning {
                white-space: nowrap;
                padding: 6px 15px;
                font-size: 13px;
                background-color: #007bff;
                margin-left: 15px;
                color: #fff;
            }
            .btn-warning:hover {
                background-color: #0056b3;
            }
            .sort-select {
                width: auto;
                padding: 5px 12px;
                font-size: 13px;
            }
            .sort-by-select {
                width: 80px;
                text-align: center;
            }
            .filters {
                display: flex;
                gap: 50px;
            }
            .filters select {
                padding: 6px 6px;
                border: 1px solid #ddd;
                border-radius: 3px;
                background-color: #fff;
                cursor: pointer;
                font-size: 13px;
                color: #555;
                text-align: center;
                margin-left: 8px;
                width: 120px;
            }
            .filters select option {
                text-align: left;
            }
            .filters button {
                white-space: nowrap;
                padding: 6px 12px;
                font-size: 13px;
                background-color: #007bff;
                margin-left: 12px;
                color: #fff;
            }
            .filters button:hover {
                background-color: #0056b3;
            }
            table td {
                vertical-align: middle;
            }
            table td img {
                width: 40px;
                height: 40px;
                object-fit: cover;
                border-radius: 3px;
            }
            .status {
                display: inline-flex;
                align-items: center;
                gap: 4px;
            }
            .status .dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                display: inline-block;
            }
            .status .dot.active {
                background-color: #28a745;
            }
            .status .dot.inactive {
                background-color: #dc3545;
            }
            .action-buttons a {
                text-decoration: none;
                color: #007bff;
                font-size: 13px;
                margin-left: 4px;
            }
            .action-buttons a:hover {
                text-decoration: underline;
            }
            .pagination-bx {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin-top: 15px;
            }
            .pagination-bx a, .pagination-bx span {
                padding: 6px 10px;
                border: 1px solid #ddd;
                border-radius: 3px;
                text-decoration: none;
                font-size: 13px;
            }
            .pagination-bx a {
                color: #007bff;
                background-color: #fff;
            }
            .pagination-bx span {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .pagination-bx a:hover {
                background-color: #f0f0f0;
            }
            .select {
                display: block;
            }
            .option {
                display: block;
            }
            .add-slider-btn {
                margin-left: 900px;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- Header -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!--sidebar menu toggler start -->
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <!--sidebar menu toggler end -->
                <!--logo start -->
                <div class="ttr-logo-box">
                    <div>
                        <a href="index.jsp" class="ttr-logo">
                            <img alt="" class="ttr-logo-mobile"
                                 src="assets/images/logo-mobile.png" width="30" height="30">
                            <img alt="" class="ttr-logo-desktop"
                                 src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-menu">
                    <!-- header left menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="home"
                               class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK
                                MENU <i class="fa fa-angle-down"></i></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="home">Our Sliders List</a></li>
                                    <li><a href="event.jsp">New Event</a></li>
                                    <li><a href="membership.jsp">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-search-toggle"><i
                                    class="fa fa-search"></i></a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><i
                                    class="fa fa-bell"></i></a>
                            <div class="ttr-header-submenu noti-menu">
                                <div class="ttr-notify-header">
                                    <span class="ttr-notify-text-top">9 New</span>
                                    <span class="ttr-notify-text">User Notifications</span>
                                </div>
                                <div class="noti-box-list">
                                    <ul>
                                        <li>
                                            <span class="notification-icon dashbg-gray">
                                                <i class="fa fa-check"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 02:14</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-yellow">
                                                <i class="fa fa-shopping-cart"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Your order is placed</a> sent you a
                                                message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 7 Min</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-red">
                                                <i class="fa fa-bullhorn"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Your item is shipped</span> sent you a
                                                message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 2 May</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-green">
                                                <i class="fa fa-comments-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Sneha Jogi</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 14 July</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-primary">
                                                <i class="fa fa-file-word-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 15 Min</span>
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span
                                    class="ttr-user-avatar"><img alt=""
                                                             src="assets/images/testimonials/pic3.jpg" width="32"
                                                             height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="user-profile.jsp">My profile</a></li>
                                    <li><a href="list-view-calendar.jsp">Activity</a></li>
                                    <li><a href="mailbox.jsp">Messages</a></li>
                                    <li><a href="../login.jsp">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="ttr-hide-on-mobile">
                            <a href="#" class="ttr-material-button"><i
                                    class="ti-layout-grid3-alt"></i></a>
                            <div class="ttr-header-submenu ttr-extra-menu">
                                <a href="#">
                                    <i class="fa fa-music"></i>
                                    <span>Musics</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-youtube-play"></i>
                                    <span>Videos</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-envelope"></i>
                                    <span>Emails</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-book"></i>
                                    <span>Reports</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-smile-o"></i>
                                    <span>Persons</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-picture-o"></i>
                                    <span>Pictures</span>
                                </a>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
                <!--header search panel start -->
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..."
                                   class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i
                                    class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle">
                            <i class="ti-close"></i>
                        </span>
                    </form>
                </div>
                <!--header search panel end -->
            </div>
        </header>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="coursecontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Subject List</span>
                            </a>
                        </li>
                        <li>
                            <a href="quizcontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Quizzes List</span>
                            </a>
                        </li>
                        <li>
                            <a href="coursecontroller?action=create" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Add Course</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">My Profile</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="user-profile.jsp" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
                                </li>
                                <li>
                                    <a href="teacher-profile.jsp" class="ttr-material-button"><span class="ttr-label">Teacher Profile</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    <!-- sidebar menu end -->
                </nav>
                <!-- sidebar menu end -->
            </div>
        </div>

        <!-- Main container -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <div class="db-breadcrumb">
                                    <h4 class="breadcrumb-title" style="font-size: 24px;">Quizzes List</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                        <li>Quizzes List</li>
                                    </ul>
                                </div>

                                <form action="quizcontroller" method="GET" class="d-flex flex-wrap align-items-center" style="color: black;">
                                    <input type="hidden" name="action" value="list" />

                                    <div class="top-bar" style="width: 80%; display: flex; align-items: center; justify-content: flex-start; gap: 10px; flex-wrap: nowrap; margin-bottom: 15px; padding-top: 0px;">
                                        <input type="text" name="search" value="${param.search}" placeholder="Search by quiz name" class="search-input flex-grow-1" style="min-width: 50px; padding: 8px;" />
                                        <button type="submit" class="search">Search</button>

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

                                        <div class="d-flex align-items-center" style="margin-top: 10px;">
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
                                        <button type="submit" class="filters button">Apply Filters</button>
                                        <a href="quizcontroller" class="reset">Reset Filters</a>
                                    </div>
                                </form>
                            </div>

                            <div class="widget-inner">
                                <div class="card-courses-list admin-courses">
                                    <table>
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
                                                    <td class="action">
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
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="<%=request.getContextPath()%>/admin/assets/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/masonry.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/filter.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='<%=request.getContextPath()%>/admin/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/functions.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/chart/chart.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/admin.js"></script>

    </body>
</html>
