<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <title>EduChamp : Education HTML Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <style>
            input[type="text"], input[type="number"], textarea, select {
                width: 100%;
                font-size: inherit;
                font-family: inherit;
                border: 1px solid #ccc;
                padding: 8px;
                margin: 0;
                color: inherit;
                line-height: inherit;
                vertical-align: baseline;
                resize: none;
            }
            textarea {
                min-height: 100px;
            }
            input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus {
                outline: none;
                border-color: #007bff;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group.checkbox-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 20px;
                flex-wrap: wrap;
            }
            .form-group.checkbox-group label {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .form-group.checkbox-group input[type="number"] {
                max-width: 100px;
                margin-left: auto;
            }
            .form-group.owner-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .form-group.owner-group label {
                margin: 0;
            }
            .form-group.owner-group input[type="text"] {
                border: none;
                background: transparent;
                padding: 0;
                flex: 1;
            }
            .tabs {
                display: flex;
                border-bottom: 2px solid #ccc;
                margin-bottom: 20px;
            }
            .tab {
                padding: 10px 20px;
                cursor: pointer;
                background: #f1f1f1;
                margin-right: 5px;
                border-radius: 5px 5px 0 0;
            }
            .tab.active {
                background: #007bff;
                color: white;
            }
            .tab-content {
                display: none;
            }
            .tab-content.active {
                display: block;
            }
            .overview-section {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .overview-left {
                width: 48%;
            }
            .overview-right {
                width: 48%;
            }
            .overview-right img {
                width: 100%;
                height: auto;
            }
            .description-section {
                margin-bottom: 20px;
            }
            .save-btn {
                background: #007bff;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .add-new-btn {
                background: #28a745;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                float: right;
                margin-bottom: 15px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            th {
                background: #007bff;
                color: white;
            }
            .filter-section {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 15px;
                flex-wrap: wrap;
            }
            .filter-section label {
                margin-right: 15px;
                display: flex;
                align-items: center;
                gap: 5px;
            }
            .filter-section input[type="number"] {
                max-width: 100px;
            }
            .apply-btn {
                background: #007bff;
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .pagination {
                text-align: center;
                margin-top: 20px;
            }
            .pagination a {
                padding: 8px 12px;
                margin: 0 5px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .pagination a.active {
                background-color: #007bff;
                color: #fff;
                border: none;
            }
            .pagination a:hover {
                background-color: #e9ecef;
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
                                    <li>
                                    </li>
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
                                    <ul>

                                    </ul>
                                </div>
                            </div>
                            <div class="nav-search-bar">
                                <form action="#">

                                </form>
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
            </header>
            <div class="page-content bg-white">
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Subject / Course Details</h1>
                        </div>
                    </div>
                </div>
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Courses Details</li>
                        </ul>
                    </div>
                </div>
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="tabs">
                                <div class="tab ${sessionScope.serviceActiveTab == 'overview' ? 'active' : ''}" data-tab="overview">
                                    <a href="coursecontroller?action=detail&service=overview&id=${sessionScope.courseDetail.courseID}">Overview</a>
                                </div>
                                <div class="tab ${sessionScope.serviceActiveTab == 'dimension' ? 'active' : ''}" data-tab="dimension">
                                    <a href="coursecontroller?action=detail&service=dimension&id=${sessionScope.courseDetail.courseID}">Dimension</a>
                                </div>
                                <div class="tab ${sessionScope.serviceActiveTab == 'pricepackage' ? 'active' : ''}" data-tab="pricepackage">
                                    <a href="coursecontroller?action=detail&service=pricepackage&id=${sessionScope.courseDetail.courseID}">Price Package</a>
                                </div>
                            </div>

                            <c:if test="${sessionScope.serviceActiveTab == 'overview'}">
                                <div id="overview" class="tab-content active">
                                    <form action="coursecontroller" method="get">
                                        <input type="hidden" name="service" value="updatecourse">
                                        <input type="hidden" name="action" value="detail">
                                        <input type="hidden" name="id" value="${sessionScope.courseDetail.courseID}">
                                        <div class="overview-section">
                                            <div class="overview-left">
                                                <div class="form-group">
                                                    <label>Subject Name</label>
                                                    <input type="text" name="subjectName" placeholder="Subject Name" value="${sessionScope.courseDetail.courseName}">
                                                </div>
                                                <div class="form-group">
                                                    <label>Category Name</label>
                                                    <select name="category">
                                                        <c:forEach var="i" items="${sessionScope.courseCategoryList}">
                                                            <option value="${i.courseCategoryName}"
                                                                    <c:if test="${sessionScope.courseDetail.courseCategory == i.courseCategoryName}">selected</c:if> >
                                                                ${i.courseCategoryName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group checkbox-group">
                                                    <label>
                                                        Featured Subject <input type="checkbox" name="featuredSubject" value="1" <c:if test="${sessionScope.courseDetail.feature == 1}">checked</c:if>>
                                                        </label>
                                                        <label>
                                                            <a href="subjectLesson?courseId=${sessionScope.courseDetail.courseID}"> View Details Lesson</a>
                                                            <input type="number" name="numberOfLessons" min="1" value="${sessionScope.courseDetail.numberOfLesson}" readonly>
                                                            
                                                    </label>
                                                </div>
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <select name="status">
                                                        <option value="Active" <c:if test="${sessionScope.courseDetail.status == 'Active'}">selected</c:if>>Active</option>
                                                        <option value="Inactive" <c:if test="${sessionScope.courseDetail.status == 'Inactive'}">selected</c:if>>Inactive</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group owner-group">
                                                        <label>Owner</label>
                                                        <input type="text" name="owner" value="${sessionScope.courseDetail.owner}" readonly>
                                                </div>
                                            </div>
                                            <div class="overview-right">
                                                <img src="${sessionScope.courseDetail.thumbnail}" alt="Course Thumbnail">
                                                <div class="form-group">
                                                    <label>Thumbnail URL</label>
                                                    <input type="text" name="thumbnailUrl" placeholder="Enter image URL" value="${sessionScope.courseDetail.thumbnail}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="description-section">
                                            <div class="form-group">
                                                <label>Description</label>
                                                <textarea name="description" rows="5" placeholder="Enter course description...">${sessionScope.courseDetail.description}</textarea>
                                            </div>
                                        </div>
                                        <button type="submit" class="save-btn">Save</button>
                                    </form>
                                </div>
                            </c:if>

                            <%-- Dimension Tab Content --%>
                            <c:if test="${sessionScope.serviceActiveTab == 'dimension'}">
                                <div id="dimension" class="tab-content active">
                                    <%-- Form Add New --%>
                                    <form method="get" action="subjectdimensioncontroller">
                                        <input type="hidden" name="service" value="updatedimension">
                                        <input type="hidden" name="action" value="detail">
                                        <input type="hidden" name="id" value="${sessionScope.courseDetail.courseID}">
                                        <a href="subjectdimensioncontroller?action=add&courseID=${sessionScope.courseDetail.courseID}" class="add-new-btn">Add New</a>
                                    </form>


                                    <form id="filterDimensionForm" method="get" action="coursecontroller">
                                        <input type="hidden" name="service" value="dimension">
                                        <input type="hidden" name="action" value="detail">
                                        <input type="hidden" name="id" value="${sessionScope.courseIdOfDimension}"> 

                                        <div class="filter-section">
                                            <label><input type="checkbox" name="filter" class="dimension-filter" value="Id" <c:if test="${requestScope.idSubjectDimension != null}">checked</c:if>> ID</label>
                                            <label><input type="checkbox" name="filter" class="dimension-filter" value="Type" <c:if test="${requestScope.typeSubjectDimension != null}">checked</c:if>> Type</label>
                                            <label><input type="checkbox" name="filter" class="dimension-filter" value="Name" <c:if test="${requestScope.nameSubjectDimension != null}">checked</c:if>> Name</label>
                                            <label><input type="checkbox" name="filter" class="dimension-filter" value="Description" <c:if test="${requestScope.descriptionSubjectDimension != null}">checked</c:if>> Description</label>
                                            <label><input type="checkbox" name="filter" class="dimension-filter" value="Action" <c:if test="${requestScope.actionSubjectDimension != null}">checked</c:if>> Action</label>
                                            <label>Row Display: <input type="number" name="rowDisplay" min="1" max="${sessionScope.totalDimension}" value="${sessionScope.currentRowDisplayDimension != null ? sessionScope.currentRowDisplayDimension : 2}"></label>
                                            <button class="apply-btn" type="submit">Apply</button>
                                        </div>
                                    </form>


                                    <table id="dimension-table">
                                        <thead>
                                            <tr>
                                                <c:forEach var="i" items="${sessionScope.funtionList}">
                                                    <th class="col-type">${i}</th>
                                                    </c:forEach>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="i" items="${sessionScope.listSubjectDimension}">
                                                <tr>
                                                    <c:if test="${requestScope.idSubjectDimension != null}">
                                                        <td class="col-type">${i.dimensionID}</td>
                                                    </c:if>
                                                    <c:if test="${requestScope.typeSubjectDimension != null}">
                                                        <td class="col-type">${i.type}</td>
                                                    </c:if>
                                                    <c:if test="${requestScope.nameSubjectDimension != null}">
                                                        <td class="col-type">${i.name}</td>
                                                    </c:if>
                                                    <c:if test="${requestScope.descriptionSubjectDimension != null}">
                                                        <td class="col-type">${i.description}</td>
                                                    </c:if>
                                                    <c:if test="${requestScope.actionSubjectDimension != null}">
                                                        <td class="col-type">
                                                            <a href="subjectdimensioncontroller?action=edit&dimensionId=${i.dimensionID}">Edit</a>/
                                                            <a href="subjectdimensioncontroller?action=delete&courseId=${sessionScope.courseDetail.courseID}&dimensionId=${i.dimensionID}">Delete</a>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <%-- Phân trang --%>
                                    <div class="pagination">
                                        <c:forEach begin="1" end="${sessionScope.endPageDimension}" var="i">

                                            <c:set var="filterParams" value=""/>
                                            <c:forEach var="filterVal" items="${paramValues.filter}">
                                                <c:set var="filterParams" value="${filterParams}&filter=${filterVal}"/>
                                            </c:forEach>

                                            <c:set var="rowDisplayParam" value=""/>
                                            <c:if test="${param.rowDisplay != null}">
                                                <c:set var="rowDisplayParam" value="&rowDisplay=${param.rowDisplay}"/>
                                            </c:if>

                                            <a href="coursecontroller?action=detail&service=dimension&id=${sessionScope.courseIdOfDimension}&pageDimension=${i}${filterParams}${rowDisplayParam}"
                                               class="${sessionScope.currentIndexPageDimension == i ? 'active' : ''}">${i}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                            <%-- Price Package Tab Content --%>
                            <c:if test="${sessionScope.serviceActiveTab == 'pricepackage'}">
                                <div id="price-package" class="tab-content active">
                                    <a href="pricepackagecontroller?action=add&courseId=${sessionScope.courseDetail.courseID}" class="add-new-btn">Add New</a>
                                    <table id="price-table">
                                        <thead>
                                            <tr>
                                                <th class="col-id">ID</th>
                                                <th class="col-package">Package</th>
                                                <th class="col-duration">Duration</th>
                                                <th class="col-list-price">List Price</th>
                                                <th class="col-sale-price">Sale Price</th>
                                                <th class="col-sale-price">Status</th>
                                                <th class="col-action">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="i" items="${sessionScope.listPricePackage}"> 
                                                <tr>
                                                    <td class="col-id">${i.pricePackageID}</td>
                                                    <td class="col-package">${i.name}</td>
                                                    <td class="col-duration">${i.accessDuration}</td>
                                                    <td class="col-list-price">${i.listPrice}</td>
                                                    <td class="col-sale-price">${i.salePrice}</td>
                                                    <td class="col-action">${i.status}</td>
                                                    <td class="col-action">
                                                        <a href="pricepackagecontroller?action=edit&courseId=${sessionScope.courseDetail.courseID}&pricepackageId=${i.pricePackageID}"">Edit</a>/
                                                        <a href="pricepackagecontroller?action=delete&courseId=${sessionScope.courseDetail.courseID}&pricepackageId=${i.pricePackageID}">Delete</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="pagination">
                                        <c:forEach begin="1" end="${sessionScope.endPagePrice}" var="i">
                                            <a href="coursecontroller?action=detail&service=pricepackage&id=${sessionScope.courseIdOfPricePackage}&pagePricePackage=${i}" >${i}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
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