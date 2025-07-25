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

        <!--[if lt IE 9]>
        <script src="<%=request.getContextPath()%>/admin/assets/js/html5shiv.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/respond.min.js"></script>
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
            .action-bar {
                display: flex;
                justify-content: flex-end;
                margin: 20px auto;
                max-width: 1200px; /* Căn giữa với chiều rộng tối đa */
            }
            .add-new-btn {
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
            .add-new-btn:hover {
                background-color: #084298;
                transform: translateY(-2px);
            }
            .add-new-btn:active {
                transform: translateY(0);
            }
            table {
                max-width: 1200px; /* Giới hạn chiều rộng bảng */
                width: 100%;
                border-collapse: collapse;
                margin: 20px auto; /* Căn giữa bảng */
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            th, td {
                border: 1px solid #e0e0e0;
                padding: 12px 15px;
                text-align: center;
                font-size: 14px;
            }
            th {
                background-color: #f8f9fa;
                color: #333;
                font-weight: 600;
                position: relative;
                cursor: pointer;
                user-select: none;
                transition: background-color 0.3s ease;
            }
            th:hover {
                background-color: #e9ecef;
            }
            tr {
                transition: background-color 0.3s ease;
            }
            tr:hover {
                background-color: #f1f3f5;
            }
            .action-link {
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }
            .action-link:hover {
                color: #0056b3;
                text-decoration: underline;
            }
            .pagination {
                text-align: center;
                margin: 20px 0;
                padding: 10px;
            }
            .pagination button {
                padding: 8px 15px;
                margin: 0 5px;
                font-weight: 500;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
            }
            .pagination button:hover {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .pagination .active {
                background-color: #007bff;
                color: #fff;
                border: none;
            }
            .sort-icon {
                display: inline-flex;
                flex-direction: column;
                margin-left: 5px;
                vertical-align: middle;
            }
            .sort-icon::before,
            .sort-icon::after {
                content: '';
                display: block;
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
            }
            .sort-icon::before {
                border-bottom: 5px solid #999;
                opacity: 0.5;
            }
            .sort-icon::after {
                border-top: 5px solid #999;
                opacity: 0.5;
                margin-top: 2px;
            }
            .sort-asc .sort-icon::before {
                opacity: 1;
                border-bottom: 5px solid #007bff;
            }
            .sort-desc .sort-icon::after {
                opacity: 1;
                border-top: 5px solid #007bff;
            }
            .header-label {
                display: inline-flex;
                align-items: center;
                gap: 4px;
            }
            .sort-icon {
                font-size: 12px;
            }
            .filter-form-container {
                max-width: 1200px; /* Căn giữa biểu mẫu với chiều rộng tối đa */
                margin: 0 auto 20px auto;
            }
            .filter-form {
                padding: 15px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #f9f9f9;
                display: flex;
                gap: 10px;
                align-items: center;
                flex-wrap: nowrap;
                white-space: nowrap;
                overflow: visible;
                position: relative;
            }
            .filter-form input[type="text"],
            .filter-form select,
            .filter-form button {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .filter-form button {
                background-color: #007bff;
                color: white;
                cursor: pointer;
                border: none;
            }
            .filter-form button:hover {
                background-color: #0056b3;
            }
        </style>
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
        <!-- Main container -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="page-content bg-white">
                    <!-- inner page banner -->
                    <div class="page-banner ovbl-dark">
                        <div class="container">
                            <div class="page-banner-entry">
                                <h1 class="text-white">Registration List</h1>
                            </div>
                        </div>
                    </div>
                    <!-- contact area -->
                    <div class="content-block">
                        <div class="section-area section-sp1">
                            <div class="container">
                                <div class="action-bar">
                                    <a href="registrationsalercontroller?action=new" class="add-new-btn btn btn-primary">Add New</a>
                                </div>
                                <div class="filter-form-container">
                                    <form action="registrationsalercontroller" method="GET" class="filter-form">
                                        <input type="text" name="emailSearch" placeholder="Search Email" value="${param.emailSearch != null ? param.emailSearch : ''}"/>
                                        <select name="courseName">
                                            <option value="">All Courses</option>
                                            <c:forEach var="course" items="${courseList}">
                                                <option value="${course.courseName}" ${param.courseName != null && param.courseName == course.courseName ? 'selected' : ''}>
                                                    ${course.courseName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <select name="name">
                                            <option value="">All Packages</option>
                                            <c:forEach var="pkg" items="${packageList}">
                                                <option value="${pkg.name}" ${name != null && name.equals(pkg.name) ? 'selected' : ''}>
                                                    ${pkg.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <select name="status">
                                            <option value="">All Status</option>
                                            <option value="Submitted" ${param.status == 'Submitted' ? 'selected' : ''}>Submitted</option>
                                            <option value="Paid" ${param.status == 'Paid' ? 'selected' : ''}>Paid</option>
                                            <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                        <button type="submit">Apply Filter</button>
                                    </form>
                                </div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=registrationID&sortOrder=${sortBy == 'registrationID' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'registrationID' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        ID
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'registrationID' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'registrationID' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=email&sortOrder=${sortBy == 'email' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'email' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Email
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'email' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'email' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=registrationTime&sortOrder=${sortBy == 'registrationTime' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'registrationTime' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Registration Time
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'registrationTime' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'registrationTime' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=courseName&sortOrder=${sortBy == 'courseName' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'courseName' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Subject
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'courseName' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'courseName' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=name&sortOrder=${sortBy == 'name' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'name' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Package
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'name' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'name' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=totalCost&sortOrder=${sortBy == 'totalCost' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'totalCost' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Total Cost
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'totalCost' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'totalCost' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=status&sortOrder=${sortBy == 'status' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'status' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Status
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'status' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'status' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=validFrom&sortOrder=${sortBy == 'validFrom' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'validFrom' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Valid From
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'validFrom' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'validFrom' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=validTo&sortOrder=${sortBy == 'validTo' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'validTo' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Valid To
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'validTo' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'validTo' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th class="sortable-header">
                                                <a href="registrationsalercontroller?sortBy=fullName&sortOrder=${sortBy == 'fullName' && sortOrder == 'asc' ? 'desc' : 'asc'}" class="${sortBy == 'fullName' ? 'active-sort' : ''}">
                                                    <span class="header-label">
                                                        Last Update By
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'fullName' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'fullName' && sortOrder == 'desc'}">▼</c:when>
                                                            </c:choose>
                                                        </span>
                                                    </span>
                                                </a>
                                            </th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listRegistrationBySaler}" var="Saler">
                                            <tr>
                                                <td>${Saler.registrationID}</td>
                                                <td>${Saler.user.email}</td>
                                                <td><fmt:formatDate value="${Saler.registrationTime}" pattern="dd-MM-yyyy"/></td>
                                                <td>${Saler.course.courseName}</td>
                                                <td>${Saler.pricePackage.name}</td>
                                                <td>${Saler.totalCost}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${Saler.status == 'Submitted'}">
                                                            <span class="status-submitted">Submitted</span>
                                                        </c:when>
                                                        <c:when test="${Saler.status == 'Paid'}">
                                                            <span class="status-paid">Paid</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-cancelled">Cancelled</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><fmt:formatDate value="${Saler.validFrom}" pattern="dd-MM-yyyy"/></td>
                                                <td><fmt:formatDate value="${Saler.validTo}" pattern="dd-MM-yyyy"/></td>
                                                <td>${Saler.lastUpdateBy.fullName}</td>
                                                <td>
                                                    <span class="action-link">
                                                        <a href="registrationsalercontroller?action=edit&registrationID=${Saler.registrationID}">Edit</a>  
                                                        <a href="registrationsalercontroller?action=detail&registrationID=${Saler.registrationID}">Detail</a>
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
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
                                <div class="col-lg-12 col-md-12 col-sm-12 text-center"><a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                            </div>
                        </div>
                    </div>
            </footer>
            <!-- Footer END ==== -->
            <!-- scroll top button -->
            <button class="back-to-top fa fa-chevron-up"></button>
        </div>
    </main>
    <div class="ttr-overlay"></div>
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
```