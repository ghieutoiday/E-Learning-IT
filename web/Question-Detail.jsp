<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="EduChamp : Education HTML Template" />
        <meta name="author" content="" />
        <meta name="keywords" content="" />
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta name="format-detection" content="telephone=no">

        <title>EduChamp : Question Form</title>

        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- CSS Files -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 0;
                line-height: 1.6;
            }
            .page-wraper {
                background-color: #fff;
                min-height: 100vh;
            }
            .page-banner {
                background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('assets/images/banner/banner2.jpg');
                background-size: cover;
                background-position: center;
                padding: 80px 0;
                color: #fff;
                text-align: center;
            }
            .page-banner h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
            }
            .breadcrumb-row {
                background-color: #f8f9fa;
                padding: 15px 0;
            }
            .breadcrumb-row ul {
                margin: 0;
                padding: 0;
                list-style: none;
            }
            .breadcrumb-row li {
                display: inline;
                margin-right: 5px;
            }
            .breadcrumb-row li a {
                color: #007bff;
                text-decoration: none;
            }
            .breadcrumb-row li a:hover {
                text-decoration: underline;
            }
            .registration-card {
                max-width: 900px;
                margin: 40px auto;
                padding: 30px;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }
            .registration-card h2 {
                font-size: 1.8rem;
                color: #0d6efd;
                margin-bottom: 20px;
                font-weight: 600;
            }
            .form-section-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #333;
                margin: 30px 0 15px;
                border-bottom: 2px solid #e9ecef;
                padding-bottom: 10px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                font-weight: 500;
                color: #333;
                margin-bottom: 8px;
                display: block;
            }
            .form-control {
                border-radius: 8px;
                border: 1px solid #ced4da;
                padding: 10px;
                font-size: 0.95rem;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            .form-control:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 5px rgba(13, 110, 253, 0.2);
            }
            .form-text {
                font-size: 0.85rem;
                color: #6c757d;
            }
            .media-container {
                border: 2px dashed #e9ecef;
                border-radius: 10px;
                padding: 20px;
                background-color: #f8f9fa;
                text-align: center;
                margin-bottom: 20px;
            }
            .media-preview {
                max-width: 100%;
                max-height: 200px;
                border-radius: 8px;
                margin-top: 15px;
                border: 1px solid #dee2e6;
            }
            .answer-option {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 15px;
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 8px;
            }
            .answer-option input[type="text"] {
                flex-grow: 1;
            }
            .answer-key-checkbox {
                display: flex;
                align-items: center;
                gap: 5px;
            }
            .btn-primary {
                background-color: #0d6efd;
                border-color: #0d6efd;
                padding: 12px 24px;
                font-size: 1rem;
                font-weight: 500;
                border-radius: 8px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-primary:hover {
                background-color: #0b5ed7;
                transform: translateY(-2px);
            }
            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
                padding: 12px 24px;
                font-size: 1rem;
                font-weight: 500;
                border-radius: 8px;
            }
            .btn-secondary:hover {
                background-color: #5c636a;
            }
            .btn-danger {
                padding: 8px 16px;
                font-size: 0.9rem;
                border-radius: 6px;
            }
            .add-answer-btn {
                margin-top: 10px;
                font-size: 0.9rem;
            }
            .form-actions {
                display: flex;
                gap: 10px;
                margin-top: 30px;
            }
            /* Updated top-bar styling to ensure right alignment */
            .top-bar {
                background-color: #f8f9fa;
                padding: 10px 0;
            }
            .top-bar .container {
                max-width: 1200px;
                margin: 0 auto;
            }
            .top-bar .row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }
            .topbar-left, .topbar-right {
                display: flex;
                align-items: center;
            }
            .topbar-left ul, .topbar-right ul {
                list-style: none;
                margin: 0;
                padding: 0;
                display: flex;
                gap: 15px;
            }
            .topbar-right {
                margin-left: auto; /* Pushes topbar-right to the far right */
            }
            .topbar-right ul li {
                margin: 0;
            }
            .topbar-right ul li a {
                color: #333;
                text-decoration: none;
                font-size: 0.9rem;
                font-weight: 500;
                transition: color 0.3s ease;
            }
            .topbar-right ul li a:hover {
                color: #0d6efd;
            }
            .header-lang-bx {
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 5px;
                font-size: 0.9rem;
            }
            @media (max-width: 768px) {
                .registration-card {
                    margin: 20px;
                    padding: 20px;
                }
                .answer-option {
                    flex-direction: column;
                    align-items: stretch;
                }
                .answer-key-checkbox {
                    margin-top: 10px;
                }
                .top-bar .row {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }
                .topbar-right {
                    margin-left: 0;
                    width: 100%;
                    justify-content: flex-start;
                }
            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header -->
            <header class="header rs-nav">

                <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <div class="menu-logo">
                                <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-bs-toggle="collapse" data-bs-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span></span><span></span><span></span>
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
                                            <li><a href="postcontroller?pageforward=bloglist">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a></li>
                                            <li><a href="postcontroller?pageforward=blogdetail">Blog Details</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-dashboard"><a href="javascript:;">Dashboard <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="admin/index.jsp">Dashboard</a></li>
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
            </header>
            <!-- Header END -->

            <!-- Content -->
            <div class="page-content bg-white">
                <div class="page-banner">
                    <div class="container">
                        <h1>Question Management</h1>
                    </div>
                </div>
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="/home">Home</a></li>
                            <li>Question Form</li>
                        </ul>
                    </div>
                </div>

                <div class="container">
                    <div class="registration-card">
                        <h2>Question Information</h2>

                        <form action="questioncontroller?action=edit" method="post">
                            <input type="hidden" name="questionID" value="${question.questionID}">
                            <input type="hidden" name="dimensionID" value="${question.dimensionID}">

                            <%-- Hiển thị thông báo thành công từ session --%>
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${sessionScope.successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <c:remove var="successMessage" scope="session"/> <%-- Xóa thông báo khỏi session sau khi hiển thị --%>
                            </c:if>

                            <%-- Thông báo lỗi "Phải có ít nhất một đáp án đúng được chọn." (từ requestScope) --%>
                            <c:if test="${not empty requestScope.errorMessage}">
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    ${requestScope.errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <c:remove var="errorMessage" scope="request"/> <%-- Xóa thông báo khỏi request --%>
                            </c:if>    

                            <div class="form-group">
                                <label for="subject">Subject (Course):</label>
                                <select class="form-control" id="courseID" name="courseID" required>
                                    <c:forEach var="course" items="${courseList}">
                                        <option value="${course.courseID}"
                                                ${course.courseID == question.courseID ? 'selected' : ''}> 
                                            ${course.courseName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="subject">Dimensions:</label>
                                <select class="form-control" id="dimensionID" name="dimensionID" required>
                                    <c:forEach var="dimension" items="${dimensionList}">
                                        <option value="${dimension.dimensionID}"
                                                ${dimension.dimensionID == question.dimensionID ? 'selected' : ''}> 
                                            ${dimension.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="status">Status:</label>
                                <select name="status" id="status" class="form-select" required>
                                    <option value="Active" ${question.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${question.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="content">Question Content:</label>
                                <textarea class="form-control" id="content" name="content" rows="5" required>${question.content}</textarea>
                            </div>


                            <h4 class="form-section-title">Answer Options</h4>
                            <div id="answerOptionsContainer">
                                <c:if test="${not empty answers}">
                                    <c:forEach var="answer" items="${answers}" varStatus="loop">
                                        <div class="answer-option" id="answerOption_${loop.index}">
                                            <input type="text" class="form-control" name="answerOptionContent"
                                                   placeholder="Answer option ${loop.index + 1} content"
                                                   value="${answer.content}" required>
                                            <div class="form-check answer-key-checkbox">
                                                <input type="radio" class="form-check-input" name="correctAnswerIndex"
                                                       value="${loop.index}" id="correctAnswer_${loop.index}"
                                                       ${answer.isCorrect ? 'checked' : ''}>
                                                <label class="form-check-label" for="correctAnswer_${loop.index}">Correct Answer</label>
                                            </div>
                                            <button type="button" class="btn btn-danger btn-sm" onclick="removeAnswerOption(this)">Remove</button>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <button type="button" class="btn btn-secondary btn-sm add-answer-btn" onclick="addAnswerOption()">+ Add Option</button>


                            <h4 class="form-section-title">Explanation</h4>
                            <div class="form-group">
                                <label for="explanation">Explanation (optional):</label>
                                <textarea class="form-control" id="explanation" name="explanation" rows="3">${question.explanation}</textarea>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Save Question</button>
                                <a href="listQuestions.jsp" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
            <!-- Content END -->

            <!-- Footer -->
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
                                                <li><a href="admin/index.jsp">Dashboard</a></li>
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
            </footer>
            <!-- Footer END -->

            <button class="back-to-top fa fa-chevron-up"></button>
        </div>

        <!-- JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
                                // Khởi tạo biến đếm dựa trên số lượng câu trả lời hiện có từ database
                                let answerOptionCount = ${not empty answers ? fn:length(answers) : 0};

                                function addAnswerOption() {
                                    const container = document.getElementById('answerOptionsContainer');
                                    const newOptionDiv = document.createElement('div');
                                    newOptionDiv.classList.add('answer-option');
                                    newOptionDiv.id = `answerOption_${answerOptionCount}`;
                                    newOptionDiv.innerHTML = `
                <input type="text" class="form-control" name="answerOptionContent" 
                       placeholder="Answer option ${answerOptionCount + 1} content" required>
                <div class="form-check answer-key-checkbox">
                    <input type="radio" class="form-check-input" name="correctAnswerIndex" 
                           value="${answerOptionCount}" id="correctAnswer_${answerOptionCount}">
                    <label class="form-check-label" for="correctAnswer_${answerOptionCount}">Correct Answer</label>
                </div>
                <button type="button" class="btn btn-danger btn-sm" onclick="removeAnswerOption(this)">Remove</button>
            `;
                                    container.appendChild(newOptionDiv);
                                    answerOptionCount++;
                                    updateAnswerIndices();
                                }

                                function removeAnswerOption(button) {
                                    const optionDiv = button.closest('.answer-option');
                                    optionDiv.remove();
                                    updateAnswerIndices();
                                }

                                function updateAnswerIndices() {
                                    const options = document.querySelectorAll('.answer-option');
                                    options.forEach((option, index) => {
                                        option.id = `answerOption_${index}`;
                                        const contentInput = option.querySelector('input[type="text"]');
                                        if (contentInput) {
                                            contentInput.placeholder = `Answer option ${index + 1} content`;
                                        }

                                        const radioInput = option.querySelector('input[type="radio"]');
                                        if (radioInput) {
                                            radioInput.value = index;
                                            radioInput.id = `correctAnswer_${index}`;
                                            const label = option.querySelector(`label[for^="correctAnswer_"]`);
                                            if (label) {
                                                label.setAttribute('for', `correctAnswer_${index}`);
                                            }
                                        }
                                    });
                                    answerOptionCount = options.length;
                                }

                                document.addEventListener('DOMContentLoaded', updateAnswerIndices);


                                function previewMedia() {
                                    const mediaFileInput = document.getElementById('mediaFile');
                                    const newMediaPreviewDiv = document.getElementById('newMediaPreview');
                                    newMediaPreviewDiv.innerHTML = '';

                                    const file = mediaFileInput.files[0];
                                    if (file) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            let mediaElement;
                                            if (file.type.startsWith('image/')) {
                                                mediaElement = document.createElement('img');
                                                mediaElement.src = e.target.result;
                                                mediaElement.className = 'media-preview';
                                                mediaElement.alt = 'Image Preview';
                                            } else if (file.type.startsWith('audio/')) {
                                                mediaElement = document.createElement('audio');
                                                mediaElement.controls = true;
                                                mediaElement.className = 'media-preview';
                                                mediaElement.innerHTML = `<source src="${e.target.result}" type="${file.type}">Trình duyệt của bạn không hỗ trợ thẻ audio.`;
                                            } else if (file.type.startsWith('video/')) {
                                                mediaElement = document.createElement('video');
                                                mediaElement.controls = true;
                                                mediaElement.className = 'media-preview';
                                                mediaElement.innerHTML = `<source src="${e.target.result}" type="${file.type}">Trình duyệt của bạn không hỗ trợ thẻ video.`;
                                            }
                                            if (mediaElement) {
                                                newMediaPreviewDiv.appendChild(mediaElement);
                                            }
                                        };
                                        reader.readAsDataURL(file);
                                    }
                                }

                                function removeMedia() {
                                    if (confirm("Bạn có chắc chắn muốn xóa media hiện tại không?")) {
                                        const form = document.querySelector('form');
                                        const removeMediaInput = document.createElement('input');
                                        removeMediaInput.type = 'hidden';
                                        removeMediaInput.name = 'removeExistingMedia';
                                        removeMediaInput.value = 'true';
                                        form.appendChild(removeMediaInput);
                                        document.getElementById('mediaPreviewContainer').innerHTML = '';
                                    }
                                }
        </script>
    </body>
</html>