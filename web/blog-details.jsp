<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="icon" href="assets/images/favicon3.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon3.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>E-Learning IT: Education HTML Template</title>

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
                                        <c:if test="${sessionScope.loggedInUser eq null}">
                                            <a><button id="openLoginModal" ">Login</button></a>
                                        </c:if>
                                        <c:if test="${sessionScope.loggedInUser eq null}">
                                            <button id="openSignupModal" >Sign Up</button>
                                        </c:if>
                                        <c:if test="${sessionScope.loggedInUser ne null}">
                                            <a href="logout">Logout</a>
                                        </c:if>
                                    </li>
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
                                <a href="home"><img src="assets/images/logoblack1.png" alt=""></a>
                            </div>
                            <!-- Mobile Nav Button ==== -->
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button"
                                    data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown"
                                    aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <!-- Author Nav ==== -->
                            <div class="secondary-menu">
                                <div class="secondary-inner">
                                    <ul>

                                        <c:if test="${sessionScope.loggedInUser ne null}">
                                            &nbsp;&nbsp;
                                            <li>||</li>

                                            <!--My Course / My Registration-->
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <li><a href="mycoursecontroller" class="btn-link customer-course">
                                                    <p>My Courses</p>
                                                </a>
                                            </li>
                                            &nbsp;&nbsp;&nbsp;
                                            <li><a href="registrationcontroller" class="btn-link customer-registration">
                                                    <p>My Registrations</p>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                            <!-- Search Box ==== -->
                            <div class="nav-search-bar">
                                <form action="#">
                                    <input name="search" value="" type="text" class="form-control"
                                           placeholder="Type to search">
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
                                            <li><a href="contact-1.jsp">Contact Us<i></i></a>

                                            </li>
                                            <li><a href="portfolio.jsp">Portfolio</a></li>
                                            <li><a href="profile.jsp">Profile</a></li>
                                            <li><a href="membership.jsp">Membership</a></li>
                                            <li><a href="error-404.jsp">404 Page</a></li>
                                        </ul>
                                    </li>
                                    <li class="add-mega-menu"><a href="javascript:;">Our Courses <i
                                                class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu add-menu">
                                            <li class="add-menu-left">
                                                <h5 class="menu-adv-title">Our Courses</h5>
                                                <ul>
                                                    <li><a href="courseslist?pageforward=courselist">Courses </a></li>

                                                    <li><a href="profile.jsp">Instructor Profile</a></li>
                                                    <li><a href="event.jsp">Upcoming Event</a></li>
                                                    <li><a href="membership.jsp">Membership</a></li>
                                                </ul>
                                            </li>
                                            <li class="add-menu-right">
                                                <img src="assets/images/adv/adv.jpg" alt="" />
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Blog <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="blog-classic-grid.jsp">Blog Classic</a></li>
                                            <li><a href="blog-classic-sidebar.jsp">Blog Classic Sidebar</a></li>
                                            <li><a href="blogcontroller?pageforward=bloglist">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a></li>

                                        </ul>
                                    </li>
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
            </header>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Blog Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Blog Details</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <c:set var="c" value="${requestScope.postDetail}"/>
                                <!-- Left part start -->
                                <div class="col-lg-8 col-xl-8">
                                    <!-- blog start -->
                                    <div class="recent-news blog-lg">
                                        <div class="action-box blog-lg">
                                            <td><img src="assets/images/post/${c.thumbnail}" alt="Thumbnail"></td>
                                        </div>
                                        <div class="info-bx">
                                            <ul class="media-post">
                                                <li><a href="#"><i class="fa fa-user-md"></i>${c.owner.fullName}</a></li>
                                                &nbsp;&nbsp;&nbsp;
                                                <li><a href="#"><i class="fa fa-calendar"></i>${c.createDate}</a></li>
                                                &nbsp;&nbsp;&nbsp;
                                                <li><a href="#"><i class="fa fa-tags"></i>${c.postCategory.postCategoryName}</a></li>
                                            </ul>
                                            <h5 class="post-title"><a href="#">${c.title}</a></h5>
                                            <p>${c.description}</p>
                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>

                                        </div>
                                    </div>

                                    <!-- blog END -->
                                </div>
                                <!-- Left part END -->
                                <!-- Side bar start -->
                                <div class="col-lg-4 col-xl-4">
                                    <aside  class="side-bar sticky-top">
                                        <div class="widget">
                                            <h6 class="widget-title">Search</h6>
                                            <div class="search-bx style-1">
                                                <form role="search" action="blogcontroller" method="get">
                                                    <input type="hidden" name="pageforward" value="bloglist" />
                                                    <div class="input-group">
                                                        <input name="titleSearch" class="form-control" placeholder="Enter your keywords..." type="text">
                                                        <span class="input-group-btn">
                                                            <button type="submit" class="fa fa-search text-primary"></button>
                                                        </span> 
                                                    </div>
                                                </form>

                                            </div>
                                        </div>

                                        <div class = "widge post-category">
                                            <h6 class="widget-title post-category">Post Category</h6>

                                            <!--L?y ra list Post Category, sau khi click v?o t?n th? chuy?n sang blogcontroller-->
                                            <c:forEach items="${requestScope.listPostCategory}" var="a">
                                                <p><a href="blogcontroller?postCategoryID=${a.postCategoryID}&pageforward=bloglist">${a.postCategoryName}</a></p>
                                                </c:forEach>    
                                            </h6>
                                        </div>
                                        <hr style="border: none; height: 2px; background-color: gray;">

                                        <div class="widget recent-posts-entry">
                                            <h6 class="widget-title">Recent Posts</h6>
                                            <div class="widget-post-bx">
                                                <c:forEach items="${requestScope.listRecentPost}" var="b">
                                                    <div class="widget-post clearfix">
                                                        <div class="ttr-post-media"><td><img src="assets/images/post/${b.thumbnail}" alt="Thumbnail" style="width: 200px; height: 65px; object-fit: cover; display: block;"></td> </div>
                                                        <div class="ttr-post-info">
                                                            <div class="ttr-post-header">
                                                                <h6 class="post-title"><a href="blogcontroller?postID=${b.postID}&pageforward=blogdetail">${b.title}</a></h6>
                                                            </div>
                                                            <ul class="media-post">
                                                                <li><a href="#"><i class="fa fa-calendar"></i>${b.updateDate}</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                            </div>
                                        </div>

                                    </aside>
                                </div>
                                <!-- Side bar END -->
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
                                        <a href="home"><img style="width:50%" src="assets/images/logowhite1.png" alt="" /></a>
                                    </div>
                                    <div class="pt-social-link">
                                        <ul class="list-inline m-a0">

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

                </footer>
                <!-- Footer END ==== -->
            <!-- scroll top button -->
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
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>

        <%@ include file="login-register-modal.jsp" %>
    </body>

</html>