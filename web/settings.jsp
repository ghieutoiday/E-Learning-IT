<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
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
        <title>Settings Management</title>
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
            .table th a {
                text-decoration: none;
                color: inherit;
            }
            .table th a:hover {
                text-decoration: underline;
            }
            .action-buttons a {
                margin-right: 5px;
            }
            .sort-icon {
                color: #ccc;
            }
            .sort-icon.active {
                color: #212529;
            }
            .card {
                border: none;
                border-radius: 0.75rem;
            }
            .add-form-container {
                display: ${showAddForm ? 'block' : 'none'};
            }
            .column-hidden {
                display: none;
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
                                    <h4 class="breadcrumb-title" style="font-size: 24px;">Settings Management</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                        <li>Settings Management</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="widget-inner">
                                <%@ page import="model.User" %>
                                <%@ page import="model.Role" %>
                                <%
                                    User user = (User) session.getAttribute("loggedInUser");
                                    if (user == null || user.getRole() == null || user.getRole().getRoleID() != 5) {
                                        response.sendRedirect(request.getContextPath() + "/home");
                                        return;
                                    }
                                %>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h2 class="mb-0">Settings Management</h2>
                                    <c:choose>
                                        <c:when test="${showAddForm}"><a href="settingController" class="btn btn-danger"><i class="fas fa-times me-2"></i>Cancel Adding</a></c:when>
                                        <c:otherwise><a href="settingController?action=add" class="btn btn-success"><i class="fas fa-plus me-2"></i>Add New Setting</a></c:otherwise>
                                    </c:choose>
                                </div>
                                <c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show" role="alert">${success}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>
                                <c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Error:</strong> ${error}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>
                                <div class="add-form-container mb-4">
                                    <div class="card shadow-sm"><div class="card-header bg-primary text-white"><h3>Add New Setting</h3></div><div class="card-body p-4"><form action="settingController" method="post"><div class="row"><div class="col-md-6 mb-3"><label for="type" class="form-label fw-bold">Type (Group)</label><input list="setting-types" class="form-control" id="type" name="type" required><datalist id="setting-types"><c:forEach var="t" items="${settingTypes}"><option value="${t}"></option></c:forEach></datalist></div><div class="col-md-6 mb-3"><label for="settingKey" class="form-label fw-bold">Setting Name (Key)</label><input type="text" class="form-control" id="settingKey" name="settingKey" required></div></div><div class="mb-3"><label for="value" class="form-label fw-bold">Value</label><input type="text" class="form-control" id="value" name="value"></div><div class="mb-3"><label for="description" class="form-label fw-bold">Description</label><textarea class="form-control" id="description" name="description" rows="2"></textarea></div><div class="row"><div class="col-md-6 mb-3"><label for="orderNum" class="form-label fw-bold">Order</label><input type="number" class="form-control" id="orderNum" name="orderNum" required></div><div class="col-md-6 mb-3"><label for="status" class="form-label fw-bold">Status</label><select class="form-select" id="status" name="status"><option value="Active" selected>Active</option><option value="Inactive">Inactive</option></select></div></div><div class="d-flex justify-content-end pt-3 border-top"><button type="submit" class="btn btn-primary px-4">Save Setting</button></div></form></div></div>
                                </div>
                                <div class="card shadow-sm">
                                    <div class="card-header bg-light"><i class="fas fa-filter me-2"></i>Filter, Search & View Options</div>
                                    <div class="card-body">
                                        <form action="settingController" method="get">
                                            <div class="row align-items-end">
                                                <div class="col-lg-2 col-md-4 mb-3">
                                                    <label for="pageSize" class="form-label">Items/Page</label>
                                                    <input type="number" class="form-control" id="pageSize" name="pageSize" value="${not empty currentPSize ? currentPSize : 5}">
                                                </div>
                                                <div class="col-lg-3 col-md-8 mb-3">
                                                    <label for="search" class="form-label">Search</label>
                                                    <input type="text" class="form-control" id="search" name="search" value="${currentSearch}">
                                                </div>
                                                <div class="col-lg-3 col-md-6 mb-3">
                                                    <label for="filterType" class="form-label">Filter by Type</label>
                                                    <select class="form-select" id="filterType" name="type">
                                                        <option value="all">All</option>
                                                        <c:forEach var="t" items="${settingTypes}">
                                                            <option value="${t}" ${currentType==t?'selected':''}>${t}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-lg-2 col-md-6 mb-3">
                                                    <label for="filterStatus" class="form-label">Status</label>
                                                    <select class="form-select" id="filterStatus" name="status">
                                                        <option value="all">All</option>
                                                        <option value="Active" ${currentStatus=='Active'?'selected':''}>Active</option>
                                                        <option value="Inactive" ${currentStatus=='Inactive'?'selected':''}>Inactive</option>
                                                    </select>
                                                </div>
                                                <div class="col-lg-2 col-md-12 mb-3">
                                                    <button type="submit" class="btn btn-primary w-100">Apply</button>
                                                </div>
                                            </div>
                                        </form>
                                        <div id="column-toggler" class="mt-3 border-top pt-3">
                                            <strong class="me-3">Show columns:</strong>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="hide-id" data-column="id" checked>
                                                <label class="form-check-label" for="hide-id">ID</label>
                                            </div>
                                 
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="hide-value" data-column="value" checked>
                                                <label class="form-check-label" for="hide-value">Value</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="hide-order" data-column="order" checked>
                                                <label class="form-check-label" for="hide-order">Order</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="hide-status" data-column="status" checked>
                                                <label class="form-check-label" for="hide-status">Status</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card mt-4 shadow-sm">
                                    <div class="card-body table-responsive">
                                        <table class="table table-hover table-bordered align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <c:set var="p" value="pageSize=${currentPSize}&search=${currentSearch}&type=${currentType}&status=${currentStatus}" />
                                                    <c:set var="sI"><i class="fas fa-sort sort-icon ms-1"></i></c:set>
                                                    <c:set var="sA"><i class="fas fa-sort-up sort-icon active ms-1"></i></c:set>
                                                    <c:set var="sD"><i class="fas fa-sort-down sort-icon active ms-1"></i></c:set>
                                                    <th class="col-id"><a href="settingController?sortBy=settingID&sortOrder=${currentSortBy=='settingID' && currentSortOrder=='asc'?'desc':'asc'}&${p}">ID${currentSortBy=='settingID'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                                                    <th class="col-type"><a href="settingController?sortBy=type&sortOrder=${currentSortBy=='type' && currentSortOrder=='asc'?'desc':'asc'}&${p}">Setting Name${currentSortBy=='type'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                                                    <th class="col-value"><a href="settingController?sortBy=value&sortOrder=${currentSortBy=='value' && currentSortOrder=='asc'?'desc':'asc'}&${p}">Value${currentSortBy=='value'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                                                    <th class="col-order"><a href="settingController?sortBy=ordernum&sortOrder=${currentSortBy=='ordernum' && currentSortOrder=='asc'?'desc':'asc'}&${p}">Order${currentSortBy=='ordernum'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                                                    <th class="col-status"><a href="settingController?sortBy=status&sortOrder=${currentSortBy=='status' && currentSortOrder=='asc'?'desc':'asc'}&${p}">Status${currentSortBy=='status'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                                                    <th class="text-center">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${empty settingsList}"><td colspan="6" class="text-center p-4">No settings found.</td></c:if>
                                                <c:forEach var="s" items="${settingsList}">
                                                    <tr>
                                                        <td class="col-id">${s.settingID}</td>
                                                        <td class="col-type">${s.settingKey}</td>
                                                        <td class="col-value">${s.value}</td>
                                                        <td class="col-order">${s.orderNum}</td>
                                                        <td class="col-status"><span class="badge ${s.status=='Active'?'bg-success':'bg-secondary'}">${s.status}</span></td>
                                                        <td class="text-center action-buttons">
                                                            <c:url var="detailsUrl" value="/settingDetailsController">
                                                                <c:param name="id" value="${s.settingID}"/>
                                                            </c:url>
                                                            <a href="${detailsUrl}" class="btn btn-sm btn-info" title="View/Edit">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <c:choose>
                                                                <c:when test="${s.status=='Active'}">
                                                                    <c:url var="statusUrl" value="/settingController">
                                                                        <c:param name="action" value="update-status"/>
                                                                        <c:param name="id" value="${s.settingID}"/>
                                                                        <c:param name="status" value="Inactive"/>
                                                                    </c:url>
                                                                    <a href="${statusUrl}" class="btn btn-sm btn-success" title="Deactivate">
                                                                        <i class="fas fa-toggle-on"></i>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:url var="statusUrl" value="/settingController">
                                                                        <c:param name="action" value="update-status"/>
                                                                        <c:param name="id" value="${s.settingID}"/>
                                                                        <c:param name="status" value="Active"/>
                                                                    </c:url>
                                                                    <a href="${statusUrl}" class="btn btn-sm btn-secondary" title="Activate">
                                                                        <i class="fas fa-toggle-off"></i>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <c:if test="${totalPages > 1}"><nav class="mt-4"><ul class="pagination justify-content-center"><c:set var="pgP" value="pageSize=${currentPSize}&search=${currentSearch}&type=${currentType}&status=${currentStatus}&sortBy=${currentSortBy}&sortOrder=${currentSortOrder}" /><li class="page-item ${currentPage==1?'disabled':''}"><a class="page-link" href="settingController?page=${currentPage-1}&${pgP}">Previous</a></li><c:forEach begin="1" end="${totalPages}" var="i"><li class="page-item ${currentPage==i?'active':''}"><a class="page-link" href="settingController?page=${i}&${pgP}">${i}</a></li></c:forEach><li class="page-item ${currentPage==totalPages?'disabled':''}"><a class="page-link" href="settingController?page=${currentPage+1}&${pgP}">Next</a></li></ul></nav></c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- Footer -->
        <footer class="ttr-footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p>&copy; 2025 EduChamp. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/js/all.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toggler = document.getElementById('column-toggler');
                if (!toggler) return;

                const checkboxes = toggler.querySelectorAll('input[type="checkbox"]');

                function updateColumnVisibility(columnName, isVisible) {
                    const cells = document.querySelectorAll('.col-' + columnName);
                    cells.forEach(cell => {
                        if (isVisible) {
                            cell.classList.remove('column-hidden');
                        } else {
                            cell.classList.add('column-hidden');
                        }
                    });
                }

                checkboxes.forEach(checkbox => {
                    const columnName = checkbox.dataset.column;
                    const savedState = localStorage.getItem('setting_col_hidden_' + columnName);

                    if (savedState === 'true') {
                        checkbox.checked = false;
                    }

                    updateColumnVisibility(columnName, checkbox.checked);

                    checkbox.addEventListener('change', () => {
                        const isVisible = checkbox.checked;
                        updateColumnVisibility(columnName, isVisible);

                        if (isVisible) {
                            localStorage.removeItem('setting_col_hidden_' + columnName);
                        } else {
                            localStorage.setItem('setting_col_hidden_' + columnName, 'true');
                        }
                    });
                });
            });
        </script>
    </body>
</html>