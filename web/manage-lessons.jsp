<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
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
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />
    <title>${action == 'add' ? 'Add New Lesson' : 'Manage Lessons'}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 40px;
        }
        .table th {
            vertical-align: middle;
            background-color: #222222;
            color: #ffffff;
            text-align: center;
            font-weight: 600;
        }
        .table td {
            vertical-align: middle;
            text-align: center;
        }
        .table td:first-child + td {
            text-align: left;
        }
        .actions a {
            margin-right: 5px;
        }
        .btn-info {
            background-color: #17c1e8;
            border-color: #17c1e8;
            color: white;
        }
        .btn-info:hover {
            background-color: #0da9cd;
            border-color: #0da9cd;
        }
        .btn-danger {
            background-color: #f44336;
            border-color: #f44336;
            color: white;
        }
        .btn-danger:hover {
            background-color: #d32f2f;
            border-color: #d32f2f;
        }
        .form-control,
        .form-select {
            max-width: 220px;
            display: inline-block;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #1e88e5;
            border-color: #1e88e5;
            font-weight: 600;
            padding: 8px 16px;
        }
        .btn-primary:hover {
            background-color: #1565c0;
            border-color: #1565c0;
        }
        .badge-success {
            background-color: #4caf50;
            font-size: 0.9rem;
            padding: 6px 12px;
            border-radius: 12px;
        }
        .pagination {
            justify-content: center;
        }
        .page-item.active .page-link {
            background-color: #1e88e5;
            border-color: #1e88e5;
        }
        .page-link {
            color: #1e88e5;
        }
        .table-responsive {
            overflow-x: auto;
        }
        /* Adjust top bar spacing */
        .top-bar {
            padding: 5px 0;
        }
        .topbar-left,
        .topbar-right {
            margin: 0;
        }
        .topbar-right {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
        }
        .topbar-right ul {
            margin: 0;
            padding: 0;
        }
        .topbar-right li {
            display: inline-block;
            margin-left: 15px;
        }
        /* Adjust header spacing */
        .sticky-header {
            padding: 5px 0;
        }
        /* Ensure logo and menu are closer */
        .menu-bar {
            align-items: center;
        }
        .menu-logo {
            margin-right: 20px;
        }
    </style>
</head>
<body id="bg">
<div class="page-wraper">
    <div id="loading-icon-bx"></div>
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
                            <li><a href="logout">Log out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="sticky-header navbar-expand-lg">
            <div class="menu-bar clearfix">
                <div class="container clearfix">
                    <div class="menu-logo">
                        <a href="coursecontroller"><img src="assets/images/logo.png" alt=""></a>
                    </div>
                    <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span></span>
                        <span></span>
                        <span></span>
                    </button>
                    <div class="secondary-menu">
                        <div class="secondary-inner">
                            <ul></ul>
                        </div>
                    </div>
                    <div class="nav-search-bar">
                        <form action="#"></form>
                        <span id="search-remove"><i class="ti-close"></i></span>
                    </div>
                    <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                        <div class="menu-logo">
                            <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                        </div>
                        <ul class="nav navbar-nav">
                            <li class="nav-dashboard"><a href="javascript:;">Dashboard <i class="fa fa-chevron-down"></i></a>
                                <ul class="sub-menu">
                                    <li><a href="coursecontroller">Dashboard</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="page-content bg-white">
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Subject Lesson</h1>
                </div>
            </div>
        </div>
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="#">Home</a></li>
                    <li>Subject Lesson</li>
                </ul>
            </div>
        </div>
        <div class="content-block">
            <div class="section-area section-sp1">
                <div class="container mt-4">
                    <c:choose>
                        <c:when test="${action == 'add'}">
                            <h3>Add New Lesson</h3>
                            <hr/>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            <form action="subjectLesson" method="post">
                                <input type="hidden" name="action" value="save">
                                <input type="hidden" name="courseId" value="${courseId}">

                                <div class="mb-3">
                                    <label for="lessonName" class="form-label">Lesson Name</label>
                                    <input type="text" class="form-control" id="lessonName" name="lessonName" required>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="topicId" class="form-label">Belongs to Topic (Chapter)</label>
                                        <select class="form-select" id="topicId" name="topicId">
                                            <option value="0">-- None (This is a main topic) --</option>
                                            <c:forEach var="topic" items="${topics}">
                                                <option value="${topic.getLessonID()}">${topic.getName()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="lessonType" class="form-label">Type</label>
                                        <select class="form-select" id="lessonType" name="lessonType">
                                            <option value="Subject Topic">Subject Topic (Chapter)</option>
                                            <option value="Lesson">Lesson</option>
                                            <option value="Quiz">Quiz</option>
                                            <option value="Video">Video</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="orderNum" class="form-label">Order</label>
                                        <input type="number" class="form-control" id="orderNum" name="orderNum" value="1" min="1" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="status" class="form-label">Status</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="Active">Active</option>
                                            <option value="Inactive">Inactive</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="videoUrl" class="form-label">Video URL (optional)</label>
                                    <input type="text" class="form-control" id="videoUrl" name="videoUrl">
                                </div>

                                <div class="mb-3">
                                    <label for="htmlContent" class="form-label">HTML Content (optional)</label>
                                    <textarea class="form-control" id="htmlContent" name="htmlContent" rows="5"></textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="duration" class="form-label">Duration (minutes)</label>
                                    <input type="number" class="form-control" id="duration" name="duration" value="0" min="0" required>
                                </div>

                                <button type="submit" class="btn btn-primary">Save Lesson</button>
                                <a href="subjectLesson?courseId=${courseId}" class="btn btn-secondary">Cancel</a>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item active" aria-current="page">${course.getCourseName()}</li>
                                </ol>
                            </nav>

                            <h3>Manage Lessons for Course: ${course.getCourseName()}</h3>
                            <hr/>

                            <form action="subjectLesson" method="get" class="row g-3 mb-3 align-items-center">
                                <input type="hidden" name="courseId" value="${course.getCourseID()}"/>

                                <div class="col-sm-4">
                                    <input type="text" name="search" class="form-control" placeholder="Type lesson name to search" value="${searchQuery}">
                                </div>

                                <div class="col-auto">
                                    <select name="topicFilterId" class="form-select">
                                        <option value="0">All Topics</option>
                                        <c:forEach var="topicItem" items="${topicList}">
                                            <option value="${topicItem.getLessonID()}" ${topicItem.getLessonID() == selectedTopicId ? 'selected' : ''}>
                                                ${topicItem.getName()}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-auto">
                                    <select name="status" class="form-select">
                                        <option value="">All statuses</option>
                                        <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Inactive" ${selectedStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>

                                <div class="col-auto">
                                    <button type="submit" class="btn btn-primary">Search</button>
                                </div>
                                <div class="col-auto ms-auto">
                                    <a href="subjectLesson?action=add&courseId=${course.getCourseID()}" class="btn btn-primary">Add Lesson</a>
                                </div>
                            </form>

                            <table class="table table-bordered table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>LESSON NAME</th>
                                        <th>ORDER</th>
                                        <th>TYPE</th>
                                        <th>STATUS</th>
                                        <th>ACTIONS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty lessonList}">
                                        <tr><td colspan="6" class="text-center">No lessons found.</td></tr>
                                    </c:if>
                                    <c:forEach var="lesson" items="${lessonList}">
                                        <tr>
                                            <td>${lesson.getLessonID()}</td>
                                            <td>${lesson.getName()}</td>
                                            <td>${lesson.getOrderNum()}</td>
                                            <td>${lesson.getType()}</td>
                                            <td>
                                                <span class="badge ${lesson.getStatus() == 'Active' ? 'bg-success' : 'bg-danger'}">
                                                    ${lesson.getStatus()}
                                                </span>
                                            </td>
                                            <td class="actions">
                                                <a href="lessonDetails?courseId=${course.getCourseID()}&lessonId=${lesson.getLessonID()}" class="btn btn-info btn-sm">Details</a>
                                                <c:choose>
                                                    <c:when test="${lesson.getStatus() == 'Active'}">
                                                        <a href="subjectLesson?action=deactivate&lessonId=${lesson.getLessonID()}&courseId=${course.getCourseID()}" 
                                                           class="btn btn-danger btn-sm"
                                                           onclick="return confirm('Are you sure you want to deactivate this lesson?');">
                                                            Deactivate
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="subjectLesson?action=activate&lessonId=${lesson.getLessonID()}&courseId=${course.getCourseID()}" 
                                                           class="btn btn-success btn-sm"
                                                           onclick="return confirm('Are you sure you want to activate this lesson?');">
                                                            Activate
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="subjectLesson?courseId=${course.getCourseID()}&page=${currentPage - 1}&status=${selectedStatus}&search=${searchQuery}&topicFilterId=${selectedTopicId}">Previous</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="subjectLesson?courseId=${course.getCourseID()}&page=${i}&status=${selectedStatus}&search=${searchQuery}&topicFilterId=${selectedTopicId}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="subjectLesson?courseId=${course.getCourseID()}&page=${currentPage + 1}&status=${selectedStatus}&search=${searchQuery}&topicFilterId=${selectedTopicId}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

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
                                <div class="ajax-message"></div>
                                <div class="input-group">
                                    <input name="email" required="required" class="form-control" placeholder="Your Email Address" type="email">
                                    <span class="input-group-btn">
                                        <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                    </span>
                                </div>
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
    <button class="back-to-top fa fa-chevron-up"></button>
</div>

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
</body>
</html>