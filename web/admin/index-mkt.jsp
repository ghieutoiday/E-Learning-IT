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

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:08:15 GMT -->
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
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon3.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>E-Learning IT : Education HTML Template </title>

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
            .wc-title{
                padding-bottom: 10px;
            }
            .card-courses-list admin-courses th{
                background-color: #E5E7EB;
            }
            #orderTrendChart {
                width: 1050px !important;
                height: 550px !important;
                margin-left: 45px;
            }
            .wc-progress-bx{
                font-size: 14px;
            }
            .wc-title{
                font-size: 18px;
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
                                    <li><a href="userProfileController">My profile</a></li>
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
                                    <a href="userProfileController" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
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

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Dashboard</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Dashboard</li>
                    </ul>
                </div>	
                <c:if test="${not empty error}">
                    <div style="color: red; font-weight: bold; margin-bottom: 12px;">
                        ${error}
                    </div>
                </c:if>
                <form method="get" action="dashboard" style="display: flex; gap: 24px; align-items: center; margin-bottom: 24px;" onsubmit="return validateDates()">
                    <label style="color: black;font-size: 18px; font-weight: normal;">Start Date: <input type="date" name="startDate" value="${startDate}"></label>
                    <label style="color: black;font-size: 18px; font-weight: normal;">End Date: <input type="date" name="endDate" value="${endDate}"></label>
                    <button type="submit" class="btn btn-warning search" style="padding: 6px 10px;margin-bottom: 11px;">Change</button>

                </form>
                <!-- Card -->
                <div class="row">
                    <div class="col-md-4 col-lg-4 col-xl-4 col-sm-4 col-12">
                        <div class="widget-card widget-bg1">                     
                            <div class="wc-item">
                                <h4 class="wc-title">New Subject</h4>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">New Subject</span>
                                    <span class="wc-number ml-auto">All Subject</span>
                                </span>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">${dashboardStats.newSubject}</span>
                                    <span class="wc-number ml-auto">${dashboardStats.allSubject}</span>
                                </span>
                            </div>                     
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-xl-4 col-sm-4 col-12">
                        <div class="widget-card widget-bg2">                     
                            <div class="wc-item">
                                <h4 class="wc-title">New Registrations</h4>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">Successful</span>
                                    <span class="wc-number ml-auto">Cancelled</span>
                                    <span class="wc-number ml-auto">Submitted</span>
                                </span>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">${dashboardStats.successfulRegistration}</span>
                                    <span class="wc-number ml-auto">${dashboardStats.cancelledRegistration}</span>
                                    <span class="wc-number ml-auto">${dashboardStats.submittedRegistration}</span>
                                </span>
                            </div>                     
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-xl-4 col-sm-4 col-12">
                        <div class="widget-card widget-bg3">                     
                            <div class="wc-item">
                                <h4 class="wc-title">Customers</h4>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">New Accounts</span>
                                    <span class="wc-number ml-auto">New bought</span>
                                </span>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">${dashboardStats.newCustomer}</span>
                                    <span class="wc-number ml-auto">${dashboardStats.newBought}</span>
                                </span>
                            </div>                     
                        </div>
                    </div>
                </div>
                <!-- Revenues -->
                <div class="widget-revenues">
                    <h4 class="wc-title" style="font-size: 20px;">
                        Revenues
                    </h4>
                    <h6 class="wc-title" style="font-weight: normal;font-size: 16px;margin-top: -15px;">
                        Total Revenue: ${dashboardStats.totalRevenue} $
                    </h6>
                    <div class="card-courses-list admin-courses">
                        <table border="1">
                            <thead>
                                <tr style="background-color: #E5E7EB;">
                                    <th style="padding: 10px;width: 70%;">Category</th>
                                    <th style="padding: 10px;width: 30%;">Revenue($)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty dashboardStats.categoryNames and not empty dashboardStats.categoryRevenues}">
                                        <c:forEach var="categoryName" items="${dashboardStats.categoryNames}" varStatus="status">
                                            <tr>
                                                <td>${categoryName}</td>
                                                <td>${dashboardStats.categoryRevenues[status.index]}$</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="2" style="text-align:center; color: #888;">No revenue data for this period.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Card END -->
                <!-- Order Counts Trend -->
                <div class="bg-white p-6 rounded-lg shadow col-span-1 md:col-span-2" style="margin-bottom: 30px;padding-bottom: 30px;padding-top: 15px;">
                    <h4 class="text-xl font-semibold mb-4" style="margin-left: 10px;font-size: 20px;">
                        Order Counts Trend
                        <c:if test="${not empty startDate and not empty endDate}">
                            (${startDate} -> ${endDate})
                        </c:if>
                    </h4>
                    <canvas id="orderTrendChart"></canvas>
                </div>



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
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/chart/chart.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/admin.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/calendar/moment.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/calendar/fullcalendar.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/switcher/switcher.js"></script>

        <!--Script để khởi tạo mảng dữ liệu biểu đồ từ dashboardStats-->
        <script>
                    // Mảng nhãn (trục x) từ dashboardStats.orderLabels
                    var orderTrendLabels = [
            <c:forEach var="label" items="${dashboardStats.orderLabels}" varStatus="status">
                    '${label}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                    ];
                    // Mảng số lượng đơn hàng từ dashboardStats.orderCounts
                    var orderTrendAll = [
            <c:forEach var="count" items="${dashboardStats.orderCounts}" varStatus="status">
                ${count}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                    ];
                    // Mảng số lượng đơn hàng thành công từ dashboardStats.successfulOrderCounts
                    var orderTrendPaid = [
            <c:forEach var="count" items="${dashboardStats.successfulOrderCounts}" varStatus="status">
                ${count}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                    ];
                    // Ghi log các mảng dữ liệu ra console để debug
                    console.log('orderTrendLabels:', orderTrendLabels);
                    console.log('orderTrendAll:', orderTrendAll);
                    console.log('orderTrendPaid:', orderTrendPaid);
        </script>
        <!<!-- Script để vẽ biểu đồ sử dụng Chart.js -->
        <script>
            // Chờ DOM tải xong trước khi khởi tạo biểu đồ
            document.addEventListener("DOMContentLoaded", function () {
                var ctx = document.getElementById('orderTrendChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    // Các tập dữ liệu cho biểu đồ
                    data: {
                        // Tập dữ liệu cho Tất cả đơn hàng
                        labels: orderTrendLabels,
                        datasets: [
                            {
                                label: 'All Orders',
                                data: orderTrendAll,
                                borderColor: 'rgba(255,99,132,1)',
                                backgroundColor: 'rgba(255,99,132,0.1)',
                                borderWidth: 2,
                                fill: false,
                                tension: 0.3
                            },
                            // Tập dữ liệu cho Đơn hàng thành công
                            {
                                label: 'Successful Orders',
                                data: orderTrendPaid,
                                borderColor: 'rgba(54,162,235,1)',
                                backgroundColor: 'rgba(54,162,235,0.1)',
                                borderWidth: 2,
                                fill: false,
                                tension: 0.3
                            }
                        ]
                    },
                    // Cấu hình tùy chọn cho biểu đồ
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {display: true}
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {display: true, text: 'Order Count'}
                            }
                        }
                    }
                });
            });
        </script>   
        <script>
            function validateDates() {
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;
                if (startDate && endDate && startDate > endDate) {
                    alert("Start Date cannot be after End Date.");
                    return false;
                }
                return true;
            }
        </script>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>