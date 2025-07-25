<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <title>User List</title>
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
            .filter-search-container {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 20px;
                align-items: center;
            }
            .filter-form, .search-form {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .filter-form select,
            .search-form input[type="text"],
            .filter-form button {
                padding: 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                height: 38px;
            }
            .filter-form select {
                width: 150px;
            }
            .search-form input[type="text"] {
                width: 200px;
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
            .sortable-header {
                position: relative;
                padding-right: 25px;
            }
            .sortable-header a {
                text-decoration: none;
                color: black;
                display: block;
                padding-right: 0;
            }
            .sort-icon {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 0.9em;
                color: #888;
                transition: color 0.2s ease;
            }
            .sortable-header:hover .sort-icon {
                color: #000;
            }
            .sortable-header a.active-sort .sort-icon {
                color: #007bff;
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
            .widget-box {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: -10px;
            }
            .wc-title .db-breadcrumb {
                margin-bottom: 15px;
            }
            .wc-title h4.breadcrumb-title {
                font-size: 24px;
            }
            .add-user-form-container {
                padding: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-top: 15px;
                background-color: #f9f9f9;
                display: ${showAddUserFormOnErrorForJSP == true ? 'block' : 'none'};
            }
            .add-user-form-container h2 {
                margin-top: 0;
                font-size: 18px;
            }
            .add-user-form-container label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .add-user-form-container input[type="text"],
            .add-user-form-container input[type="email"],
            .add-user-form-container input[type="password"],
            .add-user-form-container select {
                width: calc(100% - 16px);
                padding: 6px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-sizing: border-box;
                font-size: 13px;
            }
            .add-user-form-container .form-row {
                display: flex;
                gap: 10px;
                margin-bottom: 10px;
            }
            .add-user-form-container .form-row > div {
                flex: 1;
            }
            .add-user-form-container .form-row input,
            .add-user-form-container .form-row select {
                width: calc(100% - 16px);
                margin-bottom: 0;
            }
            .add-user-form-container button[type="submit"] {
                background-color: #007bff;
                color: white;
                padding: 6px 12px;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                font-size: 13px;
            }
            .add-user-form-container button[type="submit"]:hover {
                background-color: #0056b3;
            }
            .message {
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 4px;
                text-align: center;
            }
            .success-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .header-section .action-button {
                text-decoration: none;
                color: #fff;
                font-weight: bold;
                padding: 6px 12px;
                border: 1px solid #28a745;
                border-radius: 3px;
                transition: all 0.3s ease;
                cursor: pointer;
                background-color: #28a745;
                font-size: 13px;
            }
            .header-section .action-button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- Header -->
        <header class="ttr-header">

            <div class="ttr-header-wrapper">
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <div class="ttr-logo-box">
                    <div>
                        <a href="index.jsp" class="ttr-logo">
                            <img alt="" class="ttr-logo-mobile" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img alt="" class="ttr-logo-desktop" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <div class="ttr-header-menu">
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="home" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK MENU <i class="fa fa-angle-down"></i></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="home">Our Sliders List</a></li>
                                    <li><a href="event.jsp">New Event</a></li>
                                    <li><a href="membership.jsp">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a>
                            <div class="ttr-header-submenu noti-menu">
                                <div class="ttr-notify-header">
                                    <span class="ttr-notify-text-top">9 New</span>
                                    <span class="ttr-notify-text">User Notifications</span>
                                </div>
                                <div class="noti-box-list">
                                    <ul>
                                        <li><span class="notification-icon dashbg-gray"><i class="fa fa-check"></i></span><span class="notification-text"><span>Sneha Jogi</span> sent you a message.</span><span class="notification-time"><a href="#" class="fa fa-close"></a><span> 02:14</span></span></li>
                                        <li><span class="notification-icon dashbg-yellow"><i class="fa fa-shopping-cart"></i></span><span class="notification-text"><a href="#">Your order is placed</a> sent you a message.</span><span class="notification-time"><a href="#" class="fa fa-close"></a><span> 7 Min</span></span></li>
                                        <li><span class="notification-icon dashbg-red"><i class="fa fa-bullhorn"></i></span><span class="notification-text"><span>Your item is shipped</span> sent you a message.</span><span class="notification-time"><a href="#" class="fa fa-close"></a><span> 2 May</span></span></li>
                                        <li><span class="notification-icon dashbg-green"><i class="fa fa-comments-o"></i></span><span class="notification-text"><a href="#">Sneha Jogi</a> sent you a message.</span><span class="notification-time"><a href="#" class="fa fa-close"></a><span> 14 July</span></span></li>
                                        <li><span class="notification-icon dashbg-primary"><i class="fa fa-file-word-o"></i></span><span class="notification-text"><span>Sneha Jogi</span> sent you a message.</span><span class="notification-time"><a href="#" class="fa fa-close"></a><span> 15 Min</span></span></li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
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
                            <a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
                            <div class="ttr-header-submenu ttr-extra-menu">
                                <a href="#"><i class="fa fa-music"></i><span>Musics</span></a>
                                <a href="#"><i class="fa fa-youtube-play"></i><span>Videos</span></a>
                                <a href="#"><i class="fa fa-envelope"></i><span>Emails</span></a>
                                <a href="#"><i class="fa fa-book"></i><span>Reports</span></a>
                                <a href="#"><i class="fa fa-smile-o"></i><span>Persons</span></a>
                                <a href="#"><i class="fa fa-picture-o"></i><span>Pictures</span></a>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle"><i class="ti-close"></i></span>
                    </form>
                </div>
            </div>
        </header>
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button"><i class="ti-arrow-left"></i></div>
                </div>
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="index.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashborad</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/settingController" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Setting List</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/usercontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">User List</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/coursecontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Subject List</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/quizcontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Quizzes List</span>
                            </a>
                        </li>
                        <li>
                            <a href="add-listing.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Add listing</span>
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
                                    <h4 class="breadcrumb-title" style="font-size: 24px;">User List</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                        <li>User List</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="header-section">

                                <h1>All Users</h1>
                                <button id="toggleAddUserFormBtn" class="action-button">Add New User</button>
                            </div>
                            <%-- Display Success/Error Messages --%>
                            <c:if test="${not empty pageSuccessMessage}">
                                <div class="message success-message">${pageSuccessMessage}</div>
                            </c:if>
                            <c:if test="${not empty pageErrorMessage}">
                                <div class="message error-message">${pageErrorMessage}</div>
                            </c:if>

                            <%-- Add User Form Container (initially hidden) --%>
                            <div id="addUserFormContainer" class="add-user-form-container" style="display: ${showAddUserFormOnErrorForJSP == true ? 'block' : 'none'};">
                                <h2>Add New User</h2>
                                <form action="userController" method="POST">
                                    <input type="hidden" name="formAction" value="addUser">
                                    <%-- Include current query string to maintain filter/sort/page state after redirect --%>
                                    <input type="hidden" name="currentQueryString" value="${pageContext.request.queryString != null ? pageContext.request.queryString.replaceAll('&?formAction=addUser','').replaceAll('formAction=addUser&?','') : ''}">

                                    <div class="form-row">
                                        <div>
                                            <label for="newUser_fullName">Full Name*:</label>
                                            <input type="text" id="newUser_fullName" name="newUser_fullName" value="${sessionScope.input_newUser_fullName != null ? sessionScope.input_newUser_fullName : ''}" required>
                                        </div>
                                        <div>
                                            <label for="newUser_email">Email*:</label>
                                            <input type="email" id="newUser_email" name="newUser_email" value="${sessionScope.input_newUser_email != null ? sessionScope.input_newUser_email : ''}" required>
                                        </div>
                                    </div>

                                    <label for="newUser_password">Password*:</label>
                                    <input type="password" id="newUser_password" name="newUser_password" required>

                                    <div class="form-row">
                                        <div>
                                            <label for="newUser_gender">Gender:</label>
                                            <select id="newUser_gender" name="newUser_gender">
                                                <option value="Male" ${sessionScope.input_newUser_gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${sessionScope.input_newUser_gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${sessionScope.input_newUser_gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="newUser_mobile">Mobile:</label>
                                            <input type="text" id="newUser_mobile" name="newUser_mobile" value="${sessionScope.input_newUser_mobile != null ? sessionScope.input_newUser_mobile : ''}">
                                        </div>
                                    </div>

                                    <label for="newUser_address">Address:</label>
                                    <input type="text" id="newUser_address" name="newUser_address" value="${sessionScope.input_newUser_address != null ? sessionScope.input_newUser_address : ''}">

                                    <div class="form-row">
                                        <div>
                                            <label for="newUser_roleID">Role*:</label>
                                            <select id="newUser_roleID" name="newUser_roleID" required>
                                                <option value="">-- Select Role --</option>
                                                <c:forEach var="role" items="${rolesList}">
                                                    <option value="${role.roleID}" ${sessionScope.input_newUser_roleID == role.roleID ? 'selected' : ''}>
                                                        ${role.roleName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="newUser_status">Status:</label>
                                            <select id="newUser_status" name="newUser_status">
                                                <option value="Active" ${sessionScope.input_newUser_status == 'Active' ? 'selected' : ''}>Active</option>
                                                <option value="Inactive" ${sessionScope.input_newUser_status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                            </select>
                                        </div>
                                    </div>

                                    <%-- Avatar is excluded as per requirement --%>
                                    <%-- <label for="newUser_avatar">Avatar URL:</label> --%>
                                    <%-- <input type="text" id="newUser_avatar" name="newUser_avatar" value="${sessionScope.input_newUser_avatar != null ? sessionScope.input_newUser_avatar : ''}"> --%>

                                    <button type="submit">Submit New User</button>
                                </form>
                            </div>
                            <script>
                                document.getElementById('toggleAddUserFormBtn').addEventListener('click', function () {
                                    var formContainer = document.getElementById('addUserFormContainer');
                                    if (formContainer.style.display === 'none' || formContainer.style.display === '') {
                                        formContainer.style.display = 'block';
                                        this.textContent = 'Cancel Adding User';
                                    } else {
                                        formContainer.style.display = 'none';
                                        this.textContent = 'Add New User';
                                    }
                                });
                            </script>
                            <div class="widget-inner">
                                <div class="filter-search-container">
                                    <form action="userController" method="GET" class="filter-form">
                                        <input type="text" name="search" placeholder="Search by name, email, mobile"
                                               value="${searchValue != null ? searchValue : ''}">

                                        <select name="gender">
                                            <option value="all" ${genderFilter == null || genderFilter == 'all' ? 'selected' : ''}>All Genders</option>
                                            <option value="Male" ${genderFilter == 'Male' ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${genderFilter == 'Female' ? 'selected' : ''}>Female</option>
                                        </select>

                                        <select name="roleID">
                                            <option value="" ${roleIDFilter == null || roleIDFilter == '' ? 'selected' : ''}>All Roles</option> <%-- Ensure empty value for "All Roles" matches controller logic --%>
                                            <c:forEach var="role" items="${rolesList}">
                                                <option value="${role.roleID}" ${roleIDFilter != null && roleIDFilter == role.roleID ? 'selected' : ''}>
                                                    ${role.roleName}
                                                </option>
                                            </c:forEach>
                                        </select>

                                        <select name="status">
                                            <option value="all" ${statusFilter == null || statusFilter == 'all' ? 'selected' : ''}>All Statuses</option>
                                            <option value="Active" ${statusFilter == 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${statusFilter == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>

                                        <button type="submit">Apply Filter</button>
                                    </form>
                                </div>
                                <div class="card-courses-list admin-courses">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=userID&sortOrder=${sortBy == 'userID' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'userID' ? 'active-sort' : ''}">
                                                        ID  
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'userID' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'userID' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=fullName&sortOrder=${sortBy == 'fullName' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'fullName' ? 'active-sort' : ''}">
                                                        Name
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'fullName' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'fullName' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=gender&sortOrder=${sortBy == 'gender' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'gender' ? 'active-sort' : ''}">
                                                        Sex
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'gender' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'gender' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=email&sortOrder=${sortBy == 'email' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'email' ? 'active-sort' : ''}">
                                                        Email
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'email' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'email' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=mobile&sortOrder=${sortBy == 'mobile' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'mobile' ? 'active-sort' : ''}">
                                                        Mobile
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'mobile' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'mobile' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=roleID&sortOrder=${sortBy == 'roleID' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'roleID' ? 'active-sort' : ''}">
                                                        Role
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'roleID' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'roleID' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th class="sortable-header">
                                                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=status&sortOrder=${sortBy == 'status' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                                       class="${sortBy == 'status' ? 'active-sort' : ''}">
                                                        Status
                                                        <span class="sort-icon">
                                                            <c:choose>
                                                                <c:when test="${sortBy == 'status' && sortOrder == 'asc'}">▲</c:when>
                                                                <c:when test="${sortBy == 'status' && sortOrder == 'desc'}">▼</c:when>
                                                                <c:otherwise>◊</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </a>
                                                </th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${userList}">
                                                <tr>
                                                    <td>${user.userID}</td>
                                                    <td>${user.fullName}</td>
                                                    <td>${user.gender}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.mobile}</td>
                                                    <td>${user.role.roleName}</td>
                                                    <td>${user.status}</td>
                                                    <td><a href="viewUser?id=${user.userID}">View</a></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty userList}">
                                                <tr><td colspan="8">No users found.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="pagination-bx rounded-sm gray clearfix">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="previous">
                                                <a href="userController?page=${currentPage - 1}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}"><i class="ti-arrow-left"></i> Prev</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <li class="${i == currentPage ? 'active' : ''}">
                                                <a href="userController?page=${i}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPage}">
                                            <li class="next">
                                                <a href="userController?page=${currentPage + 1}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">Next <i class="ti-arrow-right"></i></a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
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
        <script>
                                            document.getElementById('toggleAddUserFormBtn').addEventListener('click', function () {
                                                var formContainer = document.getElementById('addUserFormContainer');
                                                if (formContainer.style.display === 'none' || formContainer.style.display === '') {
                                                    formContainer.style.display = 'block';
                                                    this.textContent = 'Cancel Adding User';
                                                } else {
                                                    formContainer.style.display = 'none';
                                                    this.textContent = 'Add New User';
                                                }
                                            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Đoạn script này có thể cần hoặc không tùy thuộc vào file mới của bạn
                // Nếu bạn muốn có nút "Add New User" để bật/tắt form, hãy giữ lại nó.
                var toggleBtn = document.getElementById('toggleAddUserFormBtn');
                if (toggleBtn) {
                    toggleBtn.addEventListener('click', function () {
                        var formContainer = document.getElementById('addUserFormContainer');
                        if (formContainer.style.display === 'none' || formContainer.style.display === '') {
                            formContainer.style.display = 'block';
                            this.textContent = 'Cancel Adding User';
                        } else {
                            formContainer.style.display = 'none';
                            this.textContent = 'Add New User';
                        }
                    });
                }
            });
        </script>
    </body>
</html>