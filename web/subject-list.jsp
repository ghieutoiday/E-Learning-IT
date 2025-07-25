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
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Subject List</title>

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
                width: 90%;
                margin: 20px auto;
            }
            /* S? d?ng flexbox ?? các form và input n?m cùng m?t hàng */
            .filter-search-container {
                display: flex;
                flex-wrap: wrap; /* Cho phép các m?c xu?ng dòng n?u không ?? ch? */
                gap: 15px; /* Kho?ng cách gi?a các form */
                margin-bottom: 20px;
                align-items: center; /* C?n ch?nh theo chi?u d?c */
            }

            .filter-form, .search-form {
                display: flex;
                align-items: center;
                gap: 15px; /* Kho?ng cách gi?a các ph?n t? trong m?i form */
            }

            .filter-form select,
            .search-form input[type="text"],
            .filter-form button {
                padding: 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                height: 38px; /* Consistent height for all elements */
            }
            .filter-form select {
                width: 150px; /* Fixed width for dropdowns */
            }
            .search-form input[type="text"] {
                width: 200px; /* Fixed width for search input */
            }
            .filter-form button {
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                padding: 8px 16px;
            }
            .filter-form button:hover {
                background-color: #0056b3;
            }
            
            .quizlist {
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                height: 38px;
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                padding: 8px 16px;
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                border: 1px solid #ddd;
            }
            th, td {
                padding: 12px;
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
                margin-top: 20px;
            }
            .pagination a {
                padding: 8px 12px;
                margin: 0 5px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .pagination a.active {
                background-color: #007bff;
                color: #fff;
                border: none;
            }
            .pagination a:hover {
                background-color: #e9ecef;
            }

            /* CSS b? sung t? file g?c */
            .widget-box {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: -10px;
            }
            .top-bar {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                gap: 10px;
                flex-wrap: nowrap;
                margin-bottom: 15px;
                padding-top: 0px;
            }
            .search-input {
                flex: 1;
                min-width: 50%;
                padding: 6px 12px;
                font-size: 14px;
            }
            .btn-warning {
                white-space: nowrap;
                padding: 8px 19px;
                font-size: 14px;
                background-color: #f8c61b;
                margin-left: 20px;
            }
            .sort-select {
                width: auto;
                padding: 6px 14px;
                font-size: 14px;
            }
            .sort-by-select {
                width: 100px;
                text-align: center;
            }
            .filters {
                display: flex;
                gap: 70px;
            }
            .filters select {
                padding: 8px 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #fff;
                cursor: pointer;
                font-size: 14px;
                color: #555;
                text-align: center;
                margin-left: 10px;
                width: 150px;
            }
            .filters select option {
                text-align: left;
            }
            .filters button {
                white-space: nowrap;
                padding: 8px 8px;
                font-size: 14px;
                background-color: #f8c61b;
                margin-left: 15px;
                gap: 15px;
            }
            table td {
                vertical-align: middle;
            }
            table td img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 4px;
            }
            .status {
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }
            .status .dot {
                width: 10px;
                height: 10px;
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
                font-size: 14px;
                margin-left: 5px;
            }
            .action-buttons a:hover {
                text-decoration: underline;
            }
            .pagination-bx {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }
            .pagination-bx a, .pagination-bx span {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
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
                margin-left: 915px;
            }
            .reset {
                padding-left: 7px;
                padding-right: 8px;
            }
            .search {
                padding-left: 25px;
                padding-right: 20px;
                margin-left: 20px;
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
                        <a href="coursecontroller" class="ttr-logo">
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
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            
                        </li>
                        <li>
                            
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span
                                    class="ttr-user-avatar"><img alt=""
                                                             src="assets/images/testimonials/pic3.jpg" width="32"
                                                             height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="userProfileController">My profile</a></li>
                                    <li><a href="logout">Logout</a></li>
                                </ul>
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
                            <a href="questionList" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Question List</span>
                            </a>
                        </li>
                        <li>
                            <a href="coursecontroller?action=create" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Add Course</span>
                            </a>
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
                                    <h4 class="breadcrumb-title" style="font-size: 24px;">Subject List</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                        <li>Subject List</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="widget-inner">
                                <div class="filter-search-container">
                                    <form action="coursecontroller" method="get" class="filter-form">
                                        <input type="hidden" name="action" value="filter">
                                        <select name="category" onchange="this.form.submit()">
                                            <option value="allCategory" ${param.category eq 'allCategory' ? 'selected' : ''}>All Categories</option>
                                            <c:forEach var="i" items="${sessionScope.courseCategoryList}">
                                                <option value="${i.courseCategoryName}" ${param.category == i.courseCategoryName ? 'selected' : ''}>${i.courseCategoryName}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="status" onchange="this.form.submit()">
                                            <option value="allStatus" ${param.status eq 'allStatus' ? 'selected' : ''}>All Status</option>
                                            <option value="active" ${param.status eq 'active' ? 'selected' : ''}>Active</option>
                                            <option value="inactive" ${param.status eq 'inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>
                                        
                                    </form>
                                    <form action="coursecontroller" method="post" class="search-form">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="text" name="search" placeholder="Search" value="${param.search}" onkeypress="if (event.key === 'Enter') this.form.submit();">
                                    </form>
                                    
                                </div>
                                <div class="card-courses-list admin-courses">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Category</th>
                                                <th>Number of Lesson</th>
                                                <th>Owner</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="i" items="${sessionScope.courseList}" varStatus="loop">
                                                <tr>
                                                    <td>${i.courseID}</td>
                                                    <td>${i.courseName}</td>
                                                    <td>${i.courseCategory}</td>
                                                    <td>${i.numberOfLesson}</td>
                                                    <td>${i.owner}</td>
                                                    <td>${i.status}</td>
                                                    <td class="action">
                                                        <a href="coursecontroller?action=detail&service=overview&id=${i.courseID}">Details</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- Pagination -->
                                <div class="pagination-bx rounded-sm gray clearfix">
                                    <ul class="pagination">
                                        <c:set var="baseQuery" value="action=view" />
                                        <c:if test="${not empty param.search}"><c:set var="baseQuery" value="${baseQuery}&search=${param.search}" /></c:if>
                                        <c:if test="${not empty param.category}"><c:set var="baseQuery" value="${baseQuery}&category=${param.category}" /></c:if>
                                        <c:if test="${not empty param.status}"><c:set var="baseQuery" value="${baseQuery}&status=${param.status}" /></c:if>

                                        <c:if test="${currentPage > 1}">
                                            <li class="previous">
                                                <a href="coursecontroller?${baseQuery}&pageSubjectList=${currentPage - 1}">
                                                    <i class="ti-arrow-left"></i> Prev
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${sessionScope.endPage}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="coursecontroller?${baseQuery}&pageSubjectList=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < sessionScope.endPage}">
                                            <li class="next">
                                                <a href="coursecontroller?${baseQuery}&pageSubjectList=${currentPage + 1}">
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
