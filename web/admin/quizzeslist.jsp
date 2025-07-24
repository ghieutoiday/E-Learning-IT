<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META -->
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

        <!-- FAVICONS ICON -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE -->
        <title>Quizzes List</title>

        <!-- MOBILE SPECIFIC -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            .container-fluid {
                padding: 20px;
            }

            .ttr-wrapper {
                max-width: 90%; 
                margin: 0 auto; 
            }

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
                padding-top: 0;
            }

            .search-input {
                flex: 1;
                min-width: 300px; 
                padding: 12px 16px; 
                font-size: 16px; 
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .btn-warning {
                white-space: nowrap;
                padding: 8px 16px;
                font-size: 14px;
                background-color: #f8c61b;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .btn-warning:hover {
                background-color: #e0b017;
            }

            .sort-select {
                width: auto;
                padding: 8px 12px;
                font-size: 14px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #fff;
                cursor: pointer;
                color: #555;
                text-align: center;
            }

            .filters {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: center;
                margin-bottom: 20px;
            }

            .filters select {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #fff;
                cursor: pointer;
                font-size: 14px;
                color: #555;
                min-width: 150px;
            }

            .filters select option {
                text-align: left;
            }

            .filters .form-control {
                padding: 6px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .filters label {
                margin-left: 10px;
                font-size: 14px;
                font-weight: normal;
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
                background-color: #d9eaff;
                font-weight: bold;
                color: #555;
            }

            table td {
                vertical-align: middle;
            }

            .action-buttons a {
                text-decoration: none;
                color: #007bff;
                font-size: 14px;
                margin: 0 5px;
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

            .pagination {
                display: flex;
                justify-content: center; 
                padding: 0;
                margin: 0;
            }

            .pagination li {
                list-style: none;
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

            .pagination a:hover {
                background-color: #f0f0f0;
            }

            .pagination .active a, .pagination span {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .top-bar {
                    flex-wrap: wrap;
                }
                .search-input {
                    min-width: 100%;
                }
                .filters {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .filters select, .filters input {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Content -->
            <div class="page-content bg-white">
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="coursecontroller">Subject List</a></li>
                            <li>Quizzes List</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- Contact area -->
                <main class="ttr-wrapper">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12 m-b30">
                                <div class="widget-box">
                                    <div class="wc-title">
                                        <form action="quizcontroller" method="GET" class="d-flex flex-wrap align-items-center" style="color: black;">
                                            <input type="hidden" name="action" value="list" />
                                            <div class="top-bar" style="width: 80%; display: flex; align-items: center; justify-content: flex-start; gap: 10px; flex-wrap: nowrap; margin-bottom: 15px; padding-top: 0px;">
                                                <input type="text" name="search" value="${param.search}" placeholder="Search by quiz name" class="search-input flex-grow-1" />
                                                <button type="submit" class="btn btn-warning search">Search</button>
                                                <select name="filterbysubject" class="sort-select">
                                                    <option value="-1" ${param.filterbysubject eq '-1' ? 'selected' : ''}>All Subject</option>
                                                    <c:forEach var="b" items="${requestScope.listAllCourse}">
                                                        <option value="${b.courseID}" ${param.filterbysubject == b.courseID ? 'selected' : ''}>${b.courseName}</option>
                                                    </c:forEach>
                                                </select>
                                                <select name="quiztype" class="sort-select">
                                                    <option value="-1" ${param.quiztype eq '-1' ? 'selected' : ''}>All Quiz Type</option>
                                                    <c:forEach var="c" items="${requestScope.listAllQuizType}">
                                                        <option value="${c}" ${param.quiztype == c ? 'selected' : ''}>${c}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="filters" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center; margin-bottom: 20px; width: 100%;">
                                                <div class="d-flex align-items-center">
                                                    <span>Records per page:</span>
                                                    <input type="number" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 5}" min="1" class="form-control" style="height: 32px; width: 75px; margin-left: 10px; padding: 6px;" />
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <span>Choose column to hide: </span>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hideID" value="true" ${param.hideID == 'true' ? 'checked' : ''}> ID</label>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hideSubject" value="true" ${param.hideSubject == 'true' ? 'checked' : ''}> Subject</label>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hideLevel" value="true" ${param.hideLevel == 'true' ? 'checked' : ''}> Level</label>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hideNOQ" value="true" ${param.hideNOQ == 'true' ? 'checked' : ''}> Number of Question</label>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hideDuration" value="true" ${param.hideDuration == 'true' ? 'checked' : ''}> Duration</label>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hidePassRate" value="true" ${param.hidePassRate == 'true' ? 'checked' : ''}> Pass Rate</label>
                                                    <label style="margin-left: 15px; margin-top: 13px; font-weight: normal"><input type="checkbox" name="hideQuizType" value="true" ${param.hideQuizType == 'true' ? 'checked' : ''}> Quiz Type</label>
                                                </div>
                                                <input type="hidden" name="page" value="1" />
                                                <button type="submit" class="btn btn-warning">Apply Filters</button>
                                                <a href="quizcontroller" class="btn btn-warning reset">Reset Filters</a>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="widget-inner">
                                        <div class="card-courses-list admin-courses">
                                            <table border="1">
                                                <thead>
                                                    <tr>
                                                        <c:if test="${param.hideID != 'true'}"><th>ID</th></c:if>
                                                            <th>Quiz Name</th>
                                                        <c:if test="${param.hideSubject != 'true'}"><th>Subject</th></c:if>
                                                        <c:if test="${param.hideLevel != 'true'}"><th>Level</th></c:if>
                                                        <c:if test="${param.hideNOQ != 'true'}"><th>Number of Question</th></c:if>
                                                        <c:if test="${param.hideDuration != 'true'}"><th>Duration</th></c:if>
                                                        <c:if test="${param.hidePassRate != 'true'}"><th>Pass Rate</th></c:if>
                                                        <c:if test="${param.hideQuizType != 'true'}"><th>Quiz Type</th></c:if>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="a" items="${listAllQuiz}" varStatus="loop">
                                                        <tr>
                                                            <c:if test="${param.hideID != 'true'}"><td>${a.quizID}</td></c:if>
                                                            <td>${a.name}</td>
                                                            <c:if test="${param.hideSubject != 'true'}"><td>${a.course.courseName}</td></c:if>
                                                            <c:if test="${param.hideLevel != 'true'}"><td>${a.level}</td></c:if>
                                                            <c:if test="${param.hideNOQ != 'true'}"><td>${a.numberQuestions}</td></c:if>
                                                            <c:if test="${param.hideDuration != 'true'}"><td>${a.duration}</td></c:if>
                                                            <c:if test="${param.hidePassRate != 'true'}"><td>${a.passRate}</td></c:if>
                                                            <c:if test="${param.hideQuizType != 'true'}"><td>${a.quizType}</td></c:if>
                                                                <td class="action-buttons">
                                                                    <a href="#">Edit</a>
                                                                    <a href="#">Delete</a>
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
                                                <c:if test="${not empty param.filterbysubject}"><c:set var="baseQuery" value="${baseQuery}&filterbysubject=${param.filterbysubject}" /></c:if>
                                                <c:if test="${not empty param.quiztype}"><c:set var="baseQuery" value="${baseQuery}&quiztype=${param.quiztype}" /></c:if>
                                                <c:if test="${not empty param.rowsPerPage}"><c:set var="baseQuery" value="${baseQuery}&rowsPerPage=${param.rowsPerPage}" /></c:if>
                                                <c:if test="${param.hideID == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideID=true" /></c:if>
                                                <c:if test="${param.hideSubject == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideSubject=true" /></c:if>
                                                <c:if test="${param.hideLevel == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideLevel=true" /></c:if>
                                                <c:if test="${param.hideNOQ == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideNOQ=true" /></c:if>
                                                <c:if test="${param.hideDuration == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideDuration=true" /></c:if>
                                                <c:if test="${param.hidePassRate == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hidePassRate=true" /></c:if>
                                                <c:if test="${param.hideQuizType == 'true'}"><c:set var="baseQuery" value="${baseQuery}&hideQuizType=true" /></c:if>
                                                <c:if test="${currentPage > 1}">
                                                    <li class="previous">
                                                        <a href="quizcontroller?${baseQuery}&page=${currentPage - 1}">
                                                            <i class="ti-arrow-left"></i> Prev
                                                        </a>
                                                    </li>
                                                </c:if>
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="${currentPage == i ? 'active' : ''}">
                                                        <a href="quizcontroller?${baseQuery}&page=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="next">
                                                        <a href="quizcontroller?${baseQuery}&page=${currentPage + 1}">
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
                    </div>
                </main>
                <!-- Contact area END -->
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
    </body>
</html>