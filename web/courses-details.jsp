<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        <title>Course Details - ${courseDetail.courseName}</title>
        <style>
            /* Base styles for the entire page (if not already defined by your template) */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f7f6;
            }

            /* Styles for the chatbot icon */
            .chatbot-icon {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 60px;
                height: 60px;
                background-color: #4CAF50;
                color: white;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 2em;
                cursor: pointer;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                transition: background-color 0.3s ease;
            }

            .chatbot-icon:hover {
                background-color: #45a049;
            }

            /* Styles for the chat container */
            .chat-container {
                position: fixed;
                bottom: 100px;
                right: 30px;
                width: 350px; /* Kích thước mặc định */
                height: 450px; /* Kích thước mặc định */
                min-width: 280px; /* Kích thước tối thiểu */
                min-height: 350px; /* Kích thước tối thiểu */
                max-width: 90vw; /* Giới hạn kích thước tối đa theo viewport */
                max-height: 90vh; /* Giới hạn kích thước tối đa theo viewport */
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                display: none;
                flex-direction: column;
                z-index: 999;
                transition: all 0.3s ease-in-out;
                transform-origin: bottom right;
                transform: scale(0);
                resize: none; /* Tắt resize mặc định của trình duyệt */
                /* Thêm relative để các grips định vị theo nó */
                position: fixed; /* Quan trọng để nó nổi */
            }

            .chat-container.open {
                display: flex;
                transform: scale(1);
            }

            /* Resizable Grips */
            .resizer {
                position: absolute;
                background: transparent; /* Hoặc một màu nhỏ để dễ debug, sau đó làm transparent */
                z-index: 1001; /* Đảm bảo grips nằm trên cùng */
            }

            .resizer.bottom-right {
                width: 15px;
                height: 15px;
                bottom: 0;
                right: 0;
                cursor: nwse-resize;
            }

            .resizer.bottom {
                width: 100%;
                height: 8px;
                bottom: 0;
                left: 0;
                cursor: ns-resize;
            }

            .resizer.right {
                width: 8px;
                height: 100%;
                top: 0;
                right: 0;
                cursor: ew-resize;
            }

            /* Existing Chatbot CSS (modified for floating behavior) */
            .chat-header {
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                font-size: 1.1em;
                text-align: center;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                cursor: grab; /* Chỉ ra nó có thể được kéo */
                flex-shrink: 0; /* Đảm bảo header không bị co lại */
            }
            .chat-messages {
                flex-grow: 1;
                padding: 15px;
                overflow-y: auto;
                border-bottom: 1px solid #eee;
                background-color: #e5ddd5;
                /* Thay flex-basis: 0; bằng min-height: 0; để không bị lỗi trên một số trình duyệt */
                min-height: 0; /* Cho phép nó co lại khi container thay đổi kích thước */
            }
            .message {
                margin-bottom: 10px;
                padding: 8px 12px;
                border-radius: 15px;
                max-width: 80%;
                word-wrap: break-word;
            }
            .message.user {
                background-color: #dcf8c6;
                align-self: flex-end;
                margin-left: auto;
                text-align: right;
            }
            .message.bot {
                background-color: #fff;
                align-self: flex-start;
                margin-right: auto;
                border: 1px solid #ddd;
            }
            /* CSS cho các gợi ý prompt */
            .prompt-suggestions {
                display: flex;
                overflow-x: auto;
                white-space: nowrap;
                padding: 10px 15px;
                gap: 10px;
                border-top: 1px solid #eee;
                background-color: #f8f8f8;
                -webkit-overflow-scrolling: touch;
                flex-shrink: 0;
            }

            .prompt-suggestion-button {
                flex-shrink: 0;
                padding: 8px 12px;
                border: 1px solid #007bff;
                border-radius: 20px;
                background-color: #eaf5ff;
                color: #007bff;
                cursor: pointer;
                font-size: 13px;
                white-space: nowrap;
                transition: background-color 0.2s, color 0.2s;
            }

            .prompt-suggestion-button:hover {
                background-color: #007bff;
                color: white;
            }
            /* Kết thúc CSS cho gợi ý prompt */

            .chat-input {
                display: flex;
                padding: 10px 15px;
                border-top: 1px solid #eee;
                flex-shrink: 0;
            }
            .chat-input input[type="text"] {
                flex-grow: 1;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 20px;
                margin-right: 10px;
                outline: none;
                font-size: 0.95em;
            }
            .chat-input button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 20px;
                cursor: pointer;
                font-size: 0.95em;
                transition: background-color 0.3s ease;
            }
            .chat-input button:hover {
                background-color: #45a049;
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
            <div class="content-block">
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-9 col-md-8 col-sm-12">
                                <div class="courses-post">
                                    <div class="ttr-post-media media-effect">
                                        <a href="#"><img src="${courseDetail.thumbnail}" alt=""></a>
                                    </div>
                                    <div class="ttr-post-info">
                                        <div class="ttr-post-title">
                                            <h2 class="post-title">${courseDetail.courseName}</h2>
                                            <h4 class="tagline">${courseDetail.courseCategory}</h4>
                                        </div>
                                        <div class="ttr-post-text">
                                            <p>${courseDetail.briefInfo}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="courese-overview" id="overview">
                                    <h4>Course Overview</h4>
                                    <div class="row">
                                        <div class="col-md-12 col-lg-4">
                                            <ul class="course-features">
                                                <li><i class="ti-money"></i> <span class="label">Original Price</span> <span class="value"><del>$${courseDetail.listPrice}</del></span></li>
                                                <li><i class="ti-tag"></i> <span class="label">Sale Price</span> <span class="value text-danger">$${courseDetail.salePrice}</span></li>
                                            </ul>
                                        </div>
                                        <div class="col-md-12 col-lg-8">
                                            <h5 class="m-b5">Product Description</h5>
                                            <p>${courseDetail.description}</p>
                                            <a href="showRegistration?courseId=${courseDetail.courseID}" class="btn btn-primary mt-3">Register Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                <div class="widget courses-search-bx placeani">
                                    <div class="form-group ${requestScope.search != null ? 'focused' : ''}">
                                        <label>Search Courses</label>
                                        <form role="search" method="get" action="courseslist">
                                            <input type="hidden" name="pageforward" value="courselist" />
                                            <div class="input-group">
                                                <input style="width: 100%; height: 40px;" name="search" type="text" value="${requestScope.search}" class="form-control">
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <div class="widget widget_archive">
                                    <h5 class="widget-title style-1">Subject Category</h5>
                                    <ul>
                                        <li class="${requestScope.categoryId == null ? 'active' : ''}">
                                            <a href="courseslist?search=${requestScope.search}">All Categories</a>
                                        </li>
                                        <c:forEach var="cat" items="${sessionScope.courseCategoryList}">
                                            <li class="${requestScope.categoryId == cat.courseCategory ? 'active' : ''}">
                                                <a href="courseslist?categoryId=${cat.courseCategory}&search=${requestScope.search}&pageforward=courselist">${cat.courseCategoryName}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>

                                <div class="widget recent-posts-entry widget-courses">
                                    <div style="display: flex; align-items: center; justify-content: space-between;">
                                        <h5 class="widget-title style-1">Featured Subject</h5>
                                        <div id="showMoreFeatured" class="widget-title" style="font-size: 18px; background: #fff; cursor: pointer;">▼</div>
                                    </div>
                                    <div class="widget-post-bx" id="featuredList">
                                        <c:forEach var="course" items="${sessionScope.courseListByFeature}" varStatus="status">
                                            <div class="widget-post clearfix featured-item" ${status.index >= 2 ? 'style="display:none;"' : ''}>
                                                <div class="ttr-post-media">
                                                    <img src="${course.thumbnail}" width="200" height="143" alt="${course.courseName}">
                                                </div>
                                                <div class="ttr-post-info">
                                                    <div class="ttr-post-header">
                                                        <h6 class="post-title"><a href="courseslist?courseId=${course.courseID}&pageforward=coursedetail">${course.courseName}</a></h6>
                                                    </div>
                                                    <div class="ttr-post-meta">
                                                        <ul>
                                                            <li class="price">
                                                                <del>$${course.listPrice}</del>
                                                                <h5>$${course.salePrice}</h5>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        var btn = document.getElementById('showMoreFeatured');
                                        var featuredItems = document.querySelectorAll('.featured-item');
                                        var expanded = false;
                                        btn.addEventListener('click', function () {
                                            expanded = !expanded;
                                            featuredItems.forEach(function (item, idx) {
                                                if (expanded) {
                                                    item.style.display = '';
                                                } else {
                                                    if (idx >= 2)
                                                        item.style.display = 'none';
                                                }
                                            });
                                            btn.innerHTML = expanded ? '▲' : '▼';
                                        });
                                    });
                                </script>

                                <div class="widget static-contact-entry widget-courses">
                                    <h5 class="widget-title style-1">Static Contact</h5>
                                    <div><a href="contact-1.jsp"><i class="fa fa-envelope-o"></i> Contact</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="chatbot-icon" id="chatbotIcon">
                💬
            </div>

            <div class="chat-container" id="chatContainer">
                <div class="chat-header" id="chatHeader">
                    Chatbot Tư Vấn Khóa Học
                </div>
                <div class="chat-messages" id="chatMessages">
                    <div class="message bot">Chào bạn! Tôi là Chatbot tư vấn khóa học. Bạn muốn tìm hiểu khóa học nào?</div>
                </div>
                <div class="resizer bottom-right"></div>
                <div class="resizer bottom"></div>
                <div class="resizer right"></div>

                <div class="prompt-suggestions" id="promptSuggestions">
                </div>
                <div class="chat-input">
                    <input type="text" id="userInput" placeholder="Nhập tin nhắn của bạn...">
                    <button onclick="sendMessage()">Gửi</button>
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
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center"><a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
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
        <script src="assets/js/jquery.scroller.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src="assets/vendors/switcher/switcher.js"></script>

        <script>
                        const chatbotIcon = document.getElementById('chatbotIcon');
                        const chatContainer = document.getElementById('chatContainer');
                        const chatMessages = document.getElementById('chatMessages');
                        const userInput = document.getElementById('userInput');
                        const promptSuggestionsContainer = document.getElementById('promptSuggestions');
                        const chatHeader = document.getElementById('chatHeader'); // For dragging

                        let isDragging = false;
                        let offsetX, offsetY;
                        let isResizing = false;
                        let resizeDirection = ''; // 'bottom-right', 'bottom', 'right'
                        let startX, startY, startWidth, startHeight;

                        // Toggle chatbot visibility
                        chatbotIcon.addEventListener('click', () => {
                            chatContainer.classList.toggle('open');
                            if (chatContainer.classList.contains('open')) {
                                scrollToBottom();
                                displayPromptSuggestions();
                            }
                        });

                        // Make chatbot draggable
                        chatHeader.addEventListener('mousedown', (e) => {
                            if (e.target === chatHeader) { // Only drag if clicking on the header itself, not children
                                isDragging = true;
                                offsetX = e.clientX - chatContainer.getBoundingClientRect().left;
                                offsetY = e.clientY - chatContainer.getBoundingClientRect().top;
                                chatContainer.style.cursor = 'grabbing';
                                // Prevent selection issues during drag
                                document.body.style.userSelect = 'none';
                            }
                        });

                        // Add event listeners for resizers
                        document.querySelectorAll('.resizer').forEach(resizer => {
                            resizer.addEventListener('mousedown', (e) => {
                                isResizing = true;
                                resizeDirection = resizer.classList[1]; // e.g., 'bottom-right'
                                startX = e.clientX;
                                startY = e.clientY;
                                startWidth = chatContainer.offsetWidth;
                                startHeight = chatContainer.offsetHeight;
                                // Prevent selection issues during resize
                                document.body.style.userSelect = 'none';
                                e.preventDefault(); // Prevent default drag behavior
                            });
                        });

                        document.addEventListener('mousemove', (e) => {
                            // Handle dragging
                            if (isDragging) {
                                // Calculate new position
                                let newLeft = e.clientX - offsetX;
                                let newTop = e.clientY - offsetY;

                                // Ensure it stays within viewport boundaries
                                const viewportWidth = window.innerWidth;
                                const viewportHeight = window.innerHeight;
                                const containerWidth = chatContainer.offsetWidth;
                                const containerHeight = chatContainer.offsetHeight;

                                if (newLeft < 0)
                                    newLeft = 0;
                                if (newTop < 0)
                                    newTop = 0;
                                if (newLeft + containerWidth > viewportWidth)
                                    newLeft = viewportWidth - containerWidth;
                                if (newTop + containerHeight > viewportHeight)
                                    newTop = viewportHeight - containerHeight;

                                chatContainer.style.left = newLeft + 'px';
                                chatContainer.style.top = newTop + 'px';
                                // Reset right/bottom to allow dynamic positioning when dragging
                                chatContainer.style.right = 'auto';
                                chatContainer.style.bottom = 'auto';
                            }

                            // Handle resizing
                            if (isResizing) {
                                const dx = e.clientX - startX;
                                const dy = e.clientY - startY;

                                let newWidth = startWidth;
                                let newHeight = startHeight;

                                if (resizeDirection.includes('right')) {
                                    newWidth = startWidth + dx;
                                }
                                if (resizeDirection.includes('bottom')) {
                                    newHeight = startHeight + dy;
                                }

                                // Apply min/max constraints
                                newWidth = Math.max(chatContainer.style.minWidth ? parseFloat(chatContainer.style.minWidth) : 280, newWidth);
                                newHeight = Math.max(chatContainer.style.minHeight ? parseFloat(chatContainer.style.minHeight) : 350, newHeight);

                                // Ensure it doesn't exceed viewport
                                newWidth = Math.min(window.innerWidth * 0.9, newWidth);
                                newHeight = Math.min(window.innerHeight * 0.9, newHeight);

                                chatContainer.style.width = newWidth + 'px';
                                chatContainer.style.height = newHeight + 'px';

                                // Recalculate right/bottom from current position
                                const currentRect = chatContainer.getBoundingClientRect();
                                chatContainer.style.right = (window.innerWidth - (currentRect.left + newWidth)) + 'px';
                                chatContainer.style.bottom = (window.innerHeight - (currentRect.top + newHeight)) + 'px';
                                chatContainer.style.left = 'auto';
                                chatContainer.style.top = 'auto';

                                scrollToBottom(); // Scroll to bottom when resize
                            }
                        });

                        document.addEventListener('mouseup', () => {
                            isDragging = false;
                            isResizing = false;
                            chatContainer.style.cursor = 'grab'; // Reset cursor
                            document.body.style.userSelect = ''; // Re-enable text selection
                        });

                        // Scroll to bottom of chat messages
                        function scrollToBottom() {
                            chatMessages.scrollTop = chatMessages.scrollHeight;
                        }

                        // Add message to chat
                        function addMessage(text, sender) {
                            const messageDiv = document.createElement('div');
                            messageDiv.classList.add('message', sender);
                            messageDiv.innerText = text;
                            chatMessages.appendChild(messageDiv);
                            scrollToBottom();
                        }

                        // Display prompt suggestions for Course Details
                        function displayPromptSuggestions() {
                            const suggestions = [
                                "Thông tin khóa học Full-Stack Web Development",
                                "Loại của khóa học Game Development with Unity",
                                "Giá khóa học Mastering Python & Java?",
                                "Các khóa học có Java",
                                "Thông tin khóa học Software Architecture with Git"
                            ];

                            promptSuggestionsContainer.innerHTML = '';
                            suggestions.forEach(text => {
                                const button = document.createElement('button');
                                button.textContent = text;
                                button.classList.add('prompt-suggestion-button');
                                button.onclick = function () {
                                    userInput.value = text;
                                    sendMessage();
                                };
                                promptSuggestionsContainer.appendChild(button);
                            });
                            promptSuggestionsContainer.style.display = 'flex';
                        }

                        // Hide prompt suggestions
                        function hidePromptSuggestions() {
                            promptSuggestionsContainer.style.display = 'none';
                        }

                        async function sendMessage() {
                            const message = userInput.value.trim();
                            if (message === '')
                                return;

                            addMessage(message, 'user');
                            userInput.value = '';
                            hidePromptSuggestions();

                            try {
                                const response = await fetch('<%= request.getContextPath() %>/chat', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: JSON.stringify({message: message, pageforward: 'coursedetail'})
                                });

                                if (!response.ok) {
                                    throw new Error(`HTTP error! status: ${response.status}`);
                                }

                                const data = await response.json();
                                addMessage(data.response, 'bot');

                                displayPromptSuggestions();

                            } catch (error) {
                                console.error('Error:', error);
                                addMessage('Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại sau.', 'bot');
                                displayPromptSuggestions();
                            }
                        }

                        // Allow sending message with Enter key
                        userInput.addEventListener('keypress', function (event) {
                            if (event.key === 'Enter') {
                                sendMessage();
                            }
                        });

                        // Initialize prompt suggestions on page load
                        window.onload = displayPromptSuggestions;
        </script>

    </body>

</html>
