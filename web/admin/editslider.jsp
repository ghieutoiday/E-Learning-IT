<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>

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
        <title>EduChamp : Education HTML Template </title>

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



        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css"
              href="<%=request.getContextPath()%>/admin/assets/css/color/color-1.css">

        <style>
            .widget-box {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            .form-control {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
            }

            textarea.form-control {
                min-height: 100px;
                resize: vertical;
            }

            .btn {
                display: inline-block;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                text-decoration: none;
                color: white;
            }

            .btn-primary {
                background-color: #f8c61b;
                color:black;
                padding: 7px;
            }

            .btn-secondary {
                background-color: #f8c61b;
                color:black;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .preview-image {
                max-width: 200px;
                max-height: 200px;
                margin-top: 10px;
                border-radius: 4px;
            }
            .widget-box .wc-title{
                border-bottom: 0px solid rgba(0, 0, 0, 0.05);

            }
            .widget-box .widget-inner {
                margin-top: -56px;
            }
            .container-fluid {
                margin-top: -30px;
            }


        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header -->
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
                        <a href="index.jsp" class="ttr-logo">
                            <img alt="" class="ttr-logo-mobile" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img alt="" class="ttr-logo-desktop" src="assets/images/logo-white.png" width="160" height="27">
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
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK MENU <i class="fa fa-angle-down"></i></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="home">Our Posts List</a></li>
                                    <li><a href="event.jsp">New Event</a></li>
                                    <li><a href="membership.jsp">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
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
                                        <li>
                                            <span class="notification-icon dashbg-gray">
                                                <i class="fa fa-check"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 02:14</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-yellow">
                                                <i class="fa fa-shopping-cart"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Your order is placed</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 7 Min</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-red">
                                                <i class="fa fa-bullhorn"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Your item is shipped</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 2 May</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-green">
                                                <i class="fa fa-comments-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Sneha Jogi</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 14 July</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-primary">
                                                <i class="fa fa-file-word-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 15 Min</span>
                                            </span>
                                        </li>
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
                                <a href="#">
                                    <i class="fa fa-music"></i>
                                    <span>Musics</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-youtube-play"></i>
                                    <span>Videos</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-envelope"></i>
                                    <span>Emails</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-book"></i>
                                    <span>Reports</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-smile-o"></i>
                                    <span>Persons</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-picture-o"></i>
                                    <span>Pictures</span>
                                </a>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
                <!--header search panel start -->
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle">
                            <i class="ti-close"></i>
                        </span>
                    </form>
                </div>
                <!--header search panel end -->
            </div>
        </header>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="home"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
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
                            <a href="home" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashborad</span>
                            </a>
                        </li>
                        <li>
                            <a href="postcontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Posts List</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-email"></i></span>
                                <span class="ttr-label">Mailbox</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="mailbox.jsp" class="ttr-material-button"><span class="ttr-label">Mail Box</span></a>
                                </li>
                                <li>
                                    <a href="mailbox-compose.jsp" class="ttr-material-button"><span class="ttr-label">Compose</span></a>
                                </li>
                                <li>
                                    <a href="mailbox-read.jsp" class="ttr-material-button"><span class="ttr-label">Mail Read</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-calendar"></i></span>
                                <span class="ttr-label">Calendar</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="basic-calendar.jsp" class="ttr-material-button"><span class="ttr-label">Basic Calendar</span></a>
                                </li>
                                <li>
                                    <a href="list-view-calendar.jsp" class="ttr-material-button"><span class="ttr-label">List View</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="bookmark.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                                <span class="ttr-label">Bookmarks</span>
                            </a>
                        </li>
                        <li>
                            <a href="review.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Review</span>
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
                <!-- sidebar menu end -->
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
                                    <h4 class="breadcrumb-title" style="font-size: 24px;">Edit Slider</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                        <li>Edit Slider</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="widget-inner">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        ${error}
                                    </div>
                                </c:if>

                                <form action="slidercontroller" method="POST" class="edit-form" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="id" value="${slider.sliderID}">
                                    <input type="hidden" name="userID" value="${slider.userID}">

                                    <div class="form-group">
                                        <label for="title">Title</label>
                                        <input type="text" class="form-control" id="title" name="title" value="${oldTitle != null ? oldTitle : slider.title}" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="image">Slider Image</label>
                                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                        <small class="form-text text-muted">Upload a new image file (JPG, PNG, etc.) or leave empty to keep current image</small>
                                        <c:if test="${not empty slider.image}">
                                            <div class="mt-2">
                                                <p>Current image:</p>
                                                <img id="imagePreview" style="width:250px ;height: auto" src="assets/images/sliderlist/${slider.image}" alt="img" class="post-thumbnail">
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="form-group">
                                        <label for="backlink">Backlink</label>
                                        <input type="text" class="form-control" id="backlink" name="backlink" value="${oldBacklink != null ? oldBacklink : slider.backlink}" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <select class="form-control" id="status" name="status" required>
                                            <option value="Active" ${(oldStatus != null && oldStatus == 'Active') || (oldStatus == null && slider.status == 'Active') ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${(oldStatus != null && oldStatus == 'Inactive') || (oldStatus == null && slider.status == 'Inactive') ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="notes">Notes</label>
                                        <textarea class="form-control" id="notes" name="notes" rows="4">${oldNotes != null ? oldNotes : slider.notes}</textarea>
                                    </div>

                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                        <a href="slidercontroller" class="btn btn-secondary">Cancel</a>
                                    </div>
                                </form>
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
            // Preview image when URL changes
            document.getElementById('image').addEventListener('input', function () {
                var preview = document.getElementById('imagePreview');
                const file = this.files[0]; //Lấy tệp đầu tiên được người dùng chọn trong mục nhập tệp.
                preview.src = URL.createObjectURL(file);//Đặt thuộc tính src của bản xem trước <img> thành URL tạm thời
                preview.hidden = false;
            });

            document.getElementById("image").addEventListener("change", function () {
                const file = this.files[0];
                if (file && !file.type.startsWith("image/")) {
                    alert("Chỉ được chọn file ảnh (.jpg, .png, .gif, ...)!");
                    this.value = ""; // Đặt lại đầu vào tệp để xóa tệp không hợp lệ.
                    var preview = document.getElementById('imagePreview');
                    preview.hidden = true;
                }
            });
        </script> 

    </body>
</html> 