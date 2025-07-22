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
        <meta name="description" content="EduChamp : Education HTML Template" />
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template</title>

        <!-- CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Include jQuery first -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            /* Body Styling */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa; /* Nền xám nhạt nhẹ nhàng */
                margin: 0;
                padding: 0;
                color: #333; /* Màu chữ xám đậm */
            }

            /* Page Banner Styling */
            .page-banner {
                background-image: url('assets/images/banner/banner2.jpg');
                background-size: cover;
                background-position: center;
                padding: 80px 0;
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
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.4)); /* Lớp phủ gradient tối */
            }
            .page-banner-entry {
                position: relative;
                z-index: 1;
                text-align: center;
                color: #fff; /* Chữ trắng cho banner */
            }
            .page-banner-entry h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
            }

            /* Breadcrumb Styling */
            .breadcrumb-row {
                background-color: #fff; /* Nền trắng */
                padding: 15px 0;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); /* Bóng đổ nhẹ */
            }
            .breadcrumb-row ul.list-inline li {
                font-size: 14px;
                color: #666; /* Màu xám cho chữ */
            }
            .breadcrumb-row ul.list-inline li a {
                color: #0d6efd; /* Màu xanh cho liên kết */
                text-decoration: none;
            }
            .breadcrumb-row ul.list-inline li a:hover {
                text-decoration: underline; /* Gạch chân khi di chuột */
            }

            /* Registration Card Styling */
            .registration-card {
                max-width: 900px;
                margin: 40px auto;
                background-color: #fff; /* Nền trắng cho thẻ */
                border-radius: 12px; /* Bo góc mềm mại */
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); /* Bóng đổ nổi bật */
                padding: 40px;
                transition: all 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */
            }
            .registration-card h2 {
                font-size: 2rem;
                font-weight: 700;
                color: #0d6efd; /* Màu xanh cho tiêu đề */
                text-align: center;
                margin-bottom: 30px;
            }

            /* Form Elements Styling */
            .form-label {
                font-weight: 600;
                color: #444; /* Màu xám đậm cho nhãn */
                margin-bottom: 8px;
                display: block;
            }
            .form-control, .form-select {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd; /* Viền xám nhạt */
                border-radius: 8px; /* Bo góc nhẹ */
                font-size: 14px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng viền và bóng khi tương tác */
            }
            .form-control:focus, .form-select:focus {
                border-color: #0d6efd; /* Viền xanh khi tập trung */
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.25); /* Ánh sáng xanh khi tập trung */
                outline: none;
            }
            .form-control::placeholder {
                color: #aaa; /* Màu xám nhạt cho chữ gợi ý */
            }
            .form-section-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #333; /* Màu xám đậm cho tiêu đề phần */
                margin: 30px 0 15px;
                border-bottom: 1px solid #eee; /* Đường viền dưới xám nhạt */
                padding-bottom: 5px;
            }

            /* Button Styling */
            .btn-primary {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                font-weight: 600;
                background-color: #0d6efd; /* Nền xanh chính */
                border: none;
                border-radius: 8px; /* Bo góc nút */
                color: #fff; /* Chữ trắng */
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease; /* Hiệu ứng mượt mà */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Bóng đổ nhẹ */
            }
            .btn-primary:hover {
                background-color: #0b5ed7; /* Xanh đậm hơn khi di chuột */
                transform: translateY(-2px); /* Nhấc nhẹ nút khi di chuột */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15); /* Bóng đổ đậm hơn */
            }
            .btn-primary:active {
                transform: translateY(0); /* Trở lại vị trí ban đầu khi nhấn */
            }

            /* Khu vực thả ảnh */
            .drop-zone {
                border: 2px dashed #ced4da; /* Đường viền nét đứt màu xám nhạt */
                border-radius: 12px; /* Bo góc 12px cho mềm mại */
                padding: 40px 20px; /* Khoảng cách bên trong rộng rãi */
                text-align: center; /* Căn giữa nội dung */
                background-color: #f8fafc; /* Màu nền xám nhạt nhẹ nhàng */
                transition: all 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */
                cursor: pointer; /* Con trỏ chuột thành kiểu nhấn được */
                position: relative;
                min-height: 180px; /* Chiều cao tối thiểu để khu vực rõ ràng */
                display: flex;
                flex-direction: column;
                justify-content: center; /* Căn giữa theo chiều dọc */
                align-items: center; /* Căn giữa theo chiều ngang */
            }
            .drop-zone:hover, .drop-zone.dragover {
                border-color: #0d6efd; /* Đường viền xanh khi di chuột hoặc thả */
                background-color: #e9f2ff; /* Nền xanh nhạt khi tương tác */
                box-shadow: 0 4px 12px rgba(13, 110, 253, 0.1); /* Bóng đổ nhẹ khi tương tác */
            }
            .drop-zone svg {
                width: 60px; /* Kích thước biểu tượng lớn hơn */
                height: 60px;
                color: #6c757d; /* Màu xám trung tính cho biểu tượng */
                margin-bottom: 20px; /* Khoảng cách dưới biểu tượng */
                transition: color 0.3s ease; /* Hiệu ứng đổi màu mượt mà */
            }
            .drop-zone:hover svg, .dropzone.dragover svg {
                color: #0d6efd; /* Biểu tượng chuyển xanh khi tương tác */
            }
            .drop-zone p {
                margin: 5px 0; /* Khoảng cách giữa các đoạn văn */
                color: #6c757d; /* Màu xám cho chữ */
                font-size: 16px; /* Cỡ chữ rõ ràng */
                font-weight: 500; /* Độ đậm vừa phải */
            }
            .drop-zone p.text-sm {
                font-size: 13px; /* Cỡ chữ nhỏ cho ghi chú */
                color: #adb5bd; /* Màu xám nhạt cho ghi chú */
                font-style: italic; /* Chữ nghiêng cho phong cách */
            }

            /* Khu vực xem trước ảnh */
            .image-preview {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); /* Cột tự động, tối thiểu 160px */
                gap: 20px; /* Khoảng cách giữa các ảnh */
                margin-top: 25px; /* Khoảng cách trên */
                margin-bottom: 40px; /* Khoảng cách dưới để tránh đè nút */
                padding: 10px; /* Đệm bên trong */
            }
            .image-wrapper {
                position: relative;
                width: 100%;
                height: auto;
                display: flex;
                flex-direction: column;
                background-color: #fff; /* Nền trắng cho khung ảnh */
                border-radius: 10px; /* Bo góc mềm mại */
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); /* Bóng đổ nhẹ */
                overflow: hidden; /* Ẩn phần thừa của ảnh */
                transition: all 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */
            }
            .image-wrapper:hover {
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); /* Bóng đổ đậm hơn khi di chuột */
                transform: translateY(-3px); /* Nhấc nhẹ khung khi di chuột */
            }
            .image-wrapper img {
                width: 100%;
                height: 160px; /* Chiều cao cố định cho đồng nhất */
                object-fit: cover; /* Ảnh lấp đầy khung, không méo */
                border-radius: 10px 10px 0 0; /* Bo góc trên, không bo góc dưới */
                border: none; /* Bỏ viền cho gọn gàng */
                transition: transform 0.3s ease; /* Hiệu ứng phóng to mượt mà */
            }
            .image-wrapper:hover img {
                transform: scale(1.08); /* Phóng to ảnh nhẹ khi di chuột */
            }
            .image-wrapper .remove-btn {
                position: absolute;
                top: 8px; /* Đặt gần góc trên */
                right: 8px; /* Đặt gần góc phải */
                background-color: #ef4444; /* Nền đỏ cho nút xóa */
                color: #fff; /* Chữ trắng */
                border: none;
                border-radius: 50%; /* Nút tròn */
                width: 28px; /* Kích thước lớn hơn một chút */
                height: 28px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px; /* Cỡ chữ cho biểu tượng xóa */
                cursor: pointer;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2); /* Bóng đổ cho nút */
                transition: all 0.3s ease; /* Hiệu ứng mượt mà */
                opacity: 0.8; /* Độ trong suốt nhẹ ban đầu */
            }
            .image-wrapper .remove-btn:hover {
                background-color: #dc2626; /* Đỏ đậm hơn khi di chuột */
                opacity: 1; /* Hiển thị đầy đủ */
                transform: scale(1.1); /* Phóng to nhẹ nút khi di chuột */
            }
            .image-wrapper .caption-input {
                width: 100%;
                margin-top: 10px; /* Khoảng cách trên cho ô nhập chú thích */
                padding: 10px; /* Đệm bên trong thoải mái */
                border: 1px solid #e2e8f0; /* Viền xám nhạt */
                border-radius: 6px; /* Bo góc nhẹ */
                font-size: 13px; /* Cỡ chữ nhỏ gọn */
                color: #495057; /* Màu chữ xám đậm */
                background-color: #f8fafc; /* Nền xám nhạt nhẹ */
                transition: all 0.3s ease; /* Hiệu ứng mượt mà */
            }
            .image-wrapper .caption-input:focus {
                border-color: #0d6efd; /* Viền xanh khi nhấn vào */
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.2); /* Ánh sáng xanh khi tập trung */
                outline: none;
                background-color: #fff; /* Nền trắng khi nhập */
            }

            /* Checkbox Styling */
            .form-checkbox {
                width: 18px;
                height: 18px;
                margin-right: 10px;
                accent-color: #0d6efd; /* Màu xanh cho checkbox */
            }
            .checkbox-label {
                display: flex;
                align-items: center;
                color: #555; /* Màu xám cho nhãn checkbox */
                font-size: 14px;
            }

            /* Hidden Input Styling */
            .hidden-input {
                display: none; /* Ẩn input file */
            }
        </style>
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
                                    <c:if test="${sessionScope.loggedInUser eq null}">
                                        <button id="openLoginModal">Login</button>
                                    </c:if>
                                    <c:if test="${sessionScope.loggedInUser eq null}">
                                        <button id="openSignupModal" >Sign Up</button>
                                    </c:if>
                                    <c:if test="${sessionScope.loggedInUser ne null}">
                                        <li><a href="logout">Logout</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <div class="menu-logo">
                                <a href="home"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <div class="secondary-menu">
                                <div class="secondary-inner">
                                    <ul>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li class="search-btn"><button id="quik-search-btn" type="button" class="btn-link"><i class="fa fa-search"></i></button></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="nav-search-bar">
                                <form action="#">
                                    <input name="search" value="" type="text" class="form-control" placeholder="Type to search">
                                    <span><i class="ti-search"></i></span>
                                </form>
                                <span id="search-remove"><i class="ti-close"></i></span>
                            </div>
                            <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                                <div class="menu-logo">
                                    <a href="home"><img src="assets/images/logoblack1.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">	
                                    <li class="active"><a href="javascript:;">Home <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="home">Home 1</a></li>
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
                                            <li><a href="postcontroller?pageforward=bloglist">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a></li>
                                            <li><a href="postcontroller?pageforward=blogdetail">Blog Details</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-dashboard"><a href="javascript:;">Dashboard <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="admin/home">Dashboard</a></li>
                                            <li><a href="admin/add-listing.jsp">Add Listing</a></li>
                                            <li><a href="admin/bookmark.jsp">Bookmark</a></li>
                                            <li><a href="admin/courses.jsp">Courses</a></li>
                                            <li><a href="admin/review.jsp">Review</a></li>
                                            <li><a href="admin/teacher-profile.jsp">Teacher Profile</a></li>
                                            <li><a href="admin/user-profile.jsp">User Profile</a></li>
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
                        </div>
                    </div>
                </div>
            </header>
            <!-- Header END ==== -->

            <!-- Content -->
            <div class="page-content bg-white">
                <div class="page-banner ovbl-dark">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">New Course</h1>
                        </div>
                    </div>
                </div>
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>New Course</li>
                        </ul>
                    </div>
                </div>
                <div class="registration-card">
                    <h2>Create New Course</h2>
                    <form id="addCourseForm" action="coursecontroller" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="create">
                        <!-- Course Name -->
                        <div class="mb-4">
                            <label class="form-label" for="courseName">Course Name *</label>
                            <input class="form-control" type="text" id="courseName" name="courseName" placeholder="Enter course name" required>
                        </div>

                        <!-- Category -->
                        <div class="mb-4">
                            <label class="form-label" for="category">Category *</label>
                            <select class="form-select" id="courseCategory" name="courseCategory" required>
                                <option value="" disabled selected>-- Select Category --</option>
                                <c:forEach var="category" items="${courseCategoryList}">
                                    <option value="${category.courseCategory}" 
                                            ${param.courseCategory != null && param.courseCategory.equals(category.courseCategory.toString()) ? 'selected' : ''}>
                                        ${category.courseCategoryName}
                                    </option>                                
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Owner -->
                        <div class="mb-4">
                            <label class="form-label" for="owner">Owner *</label>
                            <select class="form-select" id="owner" name="owner" required>
                                <option value="" disabled selected>-- Select Owner --</option>
                                <c:forEach var="user" items="${UserListIds}">
                                    <option value="${user.userID}" 
                                            ${param.owner != null && param.owner == user.userID ? 'selected' : ''}>
                                        ${user.fullName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>


                        <!-- Description -->
                        <div class="mb-4">
                            <label class="form-label" for="description">Course Description</label>
                            <textarea class="form-control" id="description" name="description" rows="5" placeholder="Describe your course..."></textarea>
                        </div>

                        <!-- Featured -->
                        <div class="mb-4">
                            <label class="checkbox-label">
                                <input type="checkbox" class="form-checkbox" id="feature" name="feature" value="1">
                                <span>Mark as Featured Course</span>
                            </label>
                        </div>

                        <!-- Drag & Drop Image Upload -->
                        <div class="mb-4">
                            <label class="block text-bgray-600 font-medium mb-2">Hình ảnh</label>
                            <div id="dropZone" 
                                 class="dropzone border-2 border-dashed border-bgray-200 rounded-lg p-8 text-center
                                 hover:border-success-300 transition-colors cursor-pointer">
                                <!-- Upload Icon and Text -->
                                <div class="upload-click-area flex flex-col items-center">
                                    <svg class="w-12 h-12 text-bgray-400 dark:text-bgray-600 mb-4" 
                                         fill="none" 
                                         stroke="currentColor" 
                                         viewBox="0 0 24 24">
                                    <path stroke-linecap="round" 
                                          stroke-linejoin="round" 
                                          stroke-width="2" 
                                          d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                    </svg>
                                    <p class="text-bgray-600 dark:text-white mb-2">Kéo thả hoặc click để chọn ảnh</p>
                                    <p class="text-sm text-bgray-400">PNG, JPG (tối đa 10MB)</p>
                                </div>

                                <!-- Hidden File Input -->
                                <input type="file" 
                                       id="imageInput" 
                                       name="images" 
                                       multiple 
                                       accept="image/*"
                                       class="hidden">

                                <!-- Image Preview Area -->
                                <div id="imagePreview" 
                                     class="grid grid-cols-2 md:grid-cols-4 gap-4 mt-4">
                                </div>
                            </div>
                        </div>

                        <!-- Submit -->
                        <button class="btn-primary" type="submit">Save Course</button>
                    </form>
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
                                    <a href="home"><img src="assets/images/logo-white.png" alt=""/></a>
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
                                                <li><a href="home">Home</a></li>
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
                                                <li><a href="http://educhamp.themetrades.com/admin/home">Dashboard</a></li>
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
                    <div class="footer-bottom">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 text-center">
                                    <a target="_blank" href="https://www.templateshub.net">Templates Hub</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- Footer END ==== -->
            <button class="back-to-top fa fa-chevron-up"></button>
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
        <script>
            let selectedFiles = [];// Mảng lưu trữ các file đã chọn
            document.addEventListener('DOMContentLoaded', function () {
                const dropZone = document.getElementById('dropZone');
                const imageInput = document.getElementById('imageInput');
                const imagePreview = document.getElementById('imagePreview');

                // Trigger file input when drop zone is clicked
                dropZone.addEventListener('click', function () {
                    imageInput.click();
                });

                // Handle file selection
                imageInput.addEventListener('change', function () {
                    handleFiles(this.files);
                });

                // Handle drag and drop
                dropZone.addEventListener('dragover', function (e) {
                    e.preventDefault();
                    dropZone.classList.add('border-blue-500', 'bg-blue-50');
                });

                dropZone.addEventListener('dragleave', function () {
                    dropZone.classList.remove('border-blue-500', 'bg-blue-50');
                });

                dropZone.addEventListener('drop', function (e) {
                    e.preventDefault();
                    dropZone.classList.remove('border-blue-500', 'bg-blue-50');

                    if (e.dataTransfer.files.length > 0) {
                        imageInput.files = e.dataTransfer.files;
                        handleFiles(e.dataTransfer.files);
                    }
                });

                // Function to handle files and create previews
                function handleFiles(files) {
                    imagePreview.innerHTML = ''; // Clear previous previews


                    const maxFileSize = 10 * 1024 * 1024; // 10MB
                    const maxFiles = 5;

                    if (selectedFiles.length + files.length > maxFiles) {
                        console.warn(`Too many files. Current: ${selectedFiles.length}, Adding: ${files.length}, Max: ${maxFiles}`);
                        alert(`Bạn chỉ có thể upload tối đa ${maxFiles} ảnh`);
                        return;
                    }


                    Array.from(files).forEach(file => {
                        if (!file.type.match('image.*')) {
                            alert('Vui lòng chỉ upload file ảnh');
                            return;
                        }

                        // Kiểm tra kích thước file
                        if (file.size > maxFileSize) {
                            console.warn('File too large:', file.size, 'bytes');
                            alert('Kích thước file không được vượt quá 10MB');
                            return;
                        }

                        // Thêm file vào mảng
                        selectedFiles.push(file);
                        const fileIndex = selectedFiles.length - 1;
                        console.log(`Added file to selectedFiles at index ${fileIndex}. Total files: ${selectedFiles.length}`);


                        const reader = new FileReader(); // Đọc dữ liệu file thành dạng base64
                        reader.onload = function (e) {
                            const div = document.createElement('div');
                            div.className = 'relative';
                            div.dataset.fileIndex = fileIndex;

                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.className = 'w-full h-32 object-cover rounded-lg';

                            const removeBtn = document.createElement('button');
                            removeBtn.type = 'button';
                            removeBtn.className = 'absolute top-2 right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600';
                            removeBtn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" /></svg>';
                            removeBtn.onclick = function () {
                                div.remove();
                            };

                            div.appendChild(img); // Gắn ảnh vào div
                            div.appendChild(removeBtn); // Gắn nút xóa vào div
                            imagePreview.appendChild(div); // Thêm div vào vùng preview
                        };

                        reader.readAsDataURL(file); // Đọc file thành chuỗi base64 để hiển thị
                    });
                }
            });

        </script>

    </body>
</html>