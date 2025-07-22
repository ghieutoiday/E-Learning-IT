<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="model.User" %>
<%@ page import="model.Role" %>
<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || user.getRole() == null || user.getRole().getRoleID() != 2) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>
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
        <title>Sliders List</title>

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
            /* CSS */
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            /* Container chÃ­nh */
            .container-fluid {
                padding: 20px;
            }

            .widget-box {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: -10px
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
                min-width: 365%;
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
                width: 100px;
                padding: 6px 14px;
                font-size: 14px;
            }

            .sort-by-select {
                width: 100px;
                text-align: center;
            }

            /* Bá» lá»c */
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
                width: 81px;
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

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                border: 1px solid #ddd;
            }

            table th, table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
                font-size: 14px;
            }

            table th {
                background-color: #f0f0f0;
                font-weight: bold;
                color: #555;
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

            /* Tráº¡ng thÃ¡i Active/Inactive */
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

            /* NÃºt hÃ nh Äá»ng */
            .action-buttons a {
                text-decoration: none;
                color: #007bff;
                font-size: 14px;
                margin-left: 5px;
            }

            .action-buttons a:hover {
                text-decoration: underline;
            }

            /* PhÃ¢n trang */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .pagination a, .pagination span {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
            }

            .pagination a {
                color: #007bff;
                background-color: #fff;
            }

            .pagination span {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }

            .pagination a:hover {
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

            .search-container {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            .search-input {
                flex: 1;
                min-width: 300px;
                padding: 8px;
            }

            .filters {
                display: flex;
                gap: 25px;
                margin-bottom: 20px;
            }

            .filters select {
                padding: 8px;
                min-width: 89px;
            }

            .btn-add-slider {
                white-space: nowrap;
                margin-right: 10px;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
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
                        <a href="home" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logowhite1.png" width="125" height="25">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-menu">
                    <!-- header left menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="home" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>

                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="${user.avatar}" width="32" height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="viewUser?id=${user.userID}">My profile</a></li>
                                    <li><a href="logout">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
            </div>
        </header>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="home"><img alt="" src="assets/images/logoblack1.png" width="100" height="20" style="margin-left: -12px;"></a>
                    <!-- <div class="ttr-sidebar-pin-button" title="Pin/Unpin Menu">
                            <i class="material-icons ttr-fixed-icon">gps_fixed</i>
                            <i class="material-icons ttr-not-fixed-icon">gps_not_fixed</i>
                    </div> -->
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="dashboard" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashborad</span>
                            </a>
                        </li>
                        <br/>
                        <li>
                            <a href="postcontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Post List</span>
                            </a>
                        </li>
                        <br/>
                        <li>
                            <a href="slidercontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-calendar"></i></span>
                                <span class="ttr-label">Slider List</span>
                            </a>
                        </li>
                        <br/>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">My Profile</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="viewUser?id=${user.userID}" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
                                </li>
                                <li>
                                    <a href="logout" class="ttr-material-button"><span class="ttr-label">Logout</span></a>
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
        <!-- Left sidebar menu end -->



        <!-- Main container -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <div class="db-breadcrumb">
                                    <h4 class="breadcrumb-title" style="font-size: 24px;">Sliders List</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                        <li>Sliders List</li>
                                    </ul>
                                </div>

                                <form action="slidercontroller" method="GET" class="d-flex flex-wrap align-items-center" style="color: black;">
                                    <input type="hidden" name="action" value="list" />

                                    <div class="top-bar" style="width: 100%; display: flex; align-items: center; justify-content: flex-start; gap: 10px; flex-wrap: nowrap; margin-bottom: 15px; padding-top: 0px;">
                                        <input type="text" name="search" value="${param.search}" placeholder="Search by Title or Backlink..." class="search-input flex-grow-1" style="min-width: 300px; padding: 8px;" />
                                        <button type="submit" class="btn btn-warning search">Filter</button>
                                    </div>

                                    <div class="filters" style="display: flex; flex-wrap: wrap; gap: 25px; align-items: center; margin-bottom: 20px; width: 100%;">
                                        <div class="d-flex align-items-center">
                                            <span>Number per page:</span>
                                            <input type="number" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 5}" min="1" class="form-control" style="height: 32px;width: 75px; margin-left: 10px; padding: 6px;" />
                                        </div>

                                        <div class="d-flex align-items-center">
                                            <span>Column to hide:</span>
                                            <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideID" value="true" ${param.hideID == 'true' ? 'checked' : ''}> ID</label>
                                            <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideImage" value="true" ${param.hideImage == 'true' ? 'checked' : ''}> Image</label>

                                            <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideBacklink" value="true" ${param.hideBacklink == 'true' ? 'checked' : ''}> Backlink</label>
                                            <label style="margin-left: 15px;margin-top: 13px;font-weight: normal"><input type="checkbox" name="hideStatus" value="true" ${param.hideStatus == 'true' ? 'checked' : ''}> Status</label>
                                        </div>



                                        <select name="status" class="sort-select">
                                            <option value="" disabled selected hidden>Status</option>
                                            <option value="Active" ${param.status eq 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${param.status eq 'Inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>

                                        <input type="hidden" name="page" value="1" />
                                        <button type="submit" class="btn btn-warning">Apply Filters</button>
                                        <a href="slidercontroller" class="btn btn-warning reset">Reset Filters</a>
                                    </div>
                                </form>
                            </div>

                            <div class="widget-inner">
                                <div class="card-courses-list admin-courses">
                                    <table border="1">
                                        <thead>
                                            <tr>
                                                <c:if test="${param.hideID != 'true'}"><th>ID</th></c:if>
                                                <c:if test="${param.hideImage != 'true'}"><th>Image</th></c:if>
                                                    <th>Title</th>
                                                <c:if test="${param.hideBacklink != 'true'}"><th>Backlink</th></c:if>
                                                <c:if test="${param.hideStatus != 'true'}"><th>Status</th></c:if>
                                                    <!-- <th>Notes</th> -->
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="slider" items="${sliders}" varStatus="loop">
                                                <tr>
                                                    <c:if test="${param.hideID != 'true'}"><td>${slider.sliderID}</td></c:if>
                                                    <c:if test="${param.hideImage != 'true'}"><td><img src="assets/images/sliderlist/${slider.image}" alt="Slider Image" style="width: 50px; height: 50px; object-fit: cover;"></td></c:if>
                                                    <td>${slider.title}</td>
                                                    <c:if test="${param.hideBacklink != 'true'}"><td><a href="${slider.backlink}">${slider.backlink}</a></td></c:if>
                                                        <c:if test="${param.hideStatus != 'true'}">
                                                        <td>
                                                            <span class="status">
                                                                <span class="dot ${slider.status eq 'Active' ? 'active' : 'inactive'}"></span>
                                                                ${slider.status}
                                                            </span>
                                                        </td>
                                                    </c:if>
                                                    <!-- <td>${slider.notes}</td> -->
                                                    <td class="action-buttons">
                                                        <a href="slidercontroller?action=view&id=${slider.sliderID}">View</a>
                                                        <a href="slidercontroller?action=showEditForm&id=${slider.sliderID}">Edit</a>
                                                        <a href="slidercontroller?action=toggleStatus&id=${slider.sliderID}">${slider.status eq 'Active' ? 'Hide' : 'Show'}</a>
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
                                        <c:if test="${not empty param.sortBy}"><c:set var="baseQuery" value="${baseQuery}&sortBy=${param.sortBy}" /></c:if>
                                        <c:if test="${not empty param.status}"><c:set var="baseQuery" value="${baseQuery}&status=${param.status}" /></c:if>
                                        <c:if test="${not empty param.rowsPerPage}"><c:set var="baseQuery" value="${baseQuery}&rowsPerPage=${param.rowsPerPage}" /></c:if>
                                        <c:if test="${param.hideID == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideID=true" /></c:if>
                                        <c:if test="${param.hideImage == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideImage=true" /></c:if>

                                        <c:if test="${param.hideBacklink == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideBacklink=true" /></c:if>
                                        <c:if test="${param.hideStatus == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideStatus=true" /></c:if>

                                        <c:if test="${currentPage > 1}">
                                            <li class="previous">
                                                <a href="slidercontroller?${baseQuery}&page=${currentPage - 1}">
                                                    <i class="ti-arrow-left"></i> Prev
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="slidercontroller?${baseQuery}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="next">
                                                <a href="slidercontroller?${baseQuery}&page=${currentPage + 1}">
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