<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ page import="model.User" %>
    <%@ page import="model.Role" %>
    <%@ page import="model.Course" %>
    <%@ page import="model.Registration" %>
    <%@ page import="dal.RegistrationDAO" %>
    
    <%
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() == null || user.getRole().getRoleID() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy course từ request hoặc attribute
        Course course = (Course) request.getAttribute("choosenCourse");

        // Kiểm tra null để tránh lỗi
        if (course != null) {
            Registration regis = RegistrationDAO.getInstance()
                .getRegistrationByUserAndCourse(user.getUserID(), course.getCourseID());
            if (regis.getUser().getUserID() != user.getUserID()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
    %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>EduChamp : Education HTML Template</title>
    <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="admin/assets/images/favicon.png" />
    <link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">
    <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
    <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        .custom-exam-header {
            font-size: 1.1em;
            color: #fff;
            text-align: left !important;
        }
        .score-card, .exam-taken-card, .review-test-card, .redotest-card, .time-card {
            background-color: #ffffff;
            border: 1px solid #ccc;
        }
        .score-card .card-body {
            text-align: center;
        }
        .score-card .card-title {
            color: #333;
            margin-bottom: 0;
        }
        .score-card .card-text.score-percentage {
            font-size: 2.5em;
            color: #ff0000;
            font-weight: bold;
            margin-bottom: 0;
        }
        .score-card .card-text.correct {
            color: #000;
            margin-bottom: 0;
        }
        .score-card .card-text.failed {
            color: #ff0000;
            font-weight: bold;
            margin-bottom: 0;
        }
        .exam-taken-card .card-body {
            text-align: center;
        }
        .exam-taken-card .card-text {
            color: #333;
            margin-bottom: 0;
        }
        
        .exam-taken-card .card-text2 {
            color: #333;
            font-size: 0.8em;
            margin-bottom: 0;
        }
        .review-test-card .card-body, .redotest-card .card-body {
            text-align: center;
            padding: 0.25rem;
        }
        .review-test-card .card-text, .redotest-card .card-text {
            color: green;
            font-size: 0.9em;
            margin-bottom: 0;
        }
        .time-card {
            min-height: 80px;
            border-top: 2px solid #FFC107;
        }
        .time-card .card-body {
            text-align: center;
            padding: 0.25rem;
        }
        .time-card .card-text {
            color: #333;
            font-size: 0.8em;
            margin-bottom: 0;
        }
        .table {
            background-color: #ffffff;
        }
        .results-table-container {
            background-color: #ffffff;
            padding: 10px;
            margin: 0 auto;
            width: 100%;
        }
        
        .quiz-form1 {
            margin: 0 1%;
            padding: 20px;
            border: 2px solid #f0f0f0; /* Thêm khung với viền màu xám nhạt */
            background-color: #f0f0f0; /* Nền màu xám */
            border-radius: 5px;
        }

        .quiz-form1 > :first-child {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .quiz-form1 > :nth-child(2) {
            font-size: 1.3em;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .quiz-form1 .exam-description {
            background-color: #f0f0f0;
            padding: 15px;
            width: 80%;
            max-width: 600px;
            margin: 0 auto 20px auto;
            text-align: center;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quiz-form1 button[type="submit"] {
            background-color: #6d28d2;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            color: white;
        }

        .quiz-form1 button[type="submit"]:hover {
            background-color: #c0c0c0;
        }

        .ttr-sidebar-navi .ttr-label {
            white-space: normal;
            overflow-wrap: break-word;
            width: 100%;
            display: block;
        }
        .ttr-sidebar {
            overflow: visible;
            width: 30%;
        }
        .ttr-wrapper {
            margin-left: 30% !important;
        }
        .ttr-sidebar-navi a {
            line-height: unset;
        }
        body:not(.ttr-opened-sidebar) .ttr-sidebar {
            transform: translateX(-100%);
        }
        body:not(.ttr-opened-sidebar) .ttr-wrapper {
            margin-left: 0 !important;
            width: 100% !important;
        }
        .quiz-form2 {
            width: 100%; /* Đảm bảo form mở rộng toàn bộ chiều rộng */
            margin: 0; /* Loại bỏ margin cố định */
            padding: 20px; /* Giữ padding để không mất giao diện */
        }
        body:not(.ttr-opened-sidebar) .quiz-form2 {
            margin: 0 auto; /* Căn giữa khi sidebar đóng */
            max-width: 100%; /* Đảm bảo không vượt quá chiều rộng màn hình */
        }
        .ttr-wrapper .video-container {
            position: relative;
            padding-bottom: 56.25%;
            height: 0;
            overflow: hidden;
            margin-bottom: 20px;
            background-color: #000;
        }
        .ttr-wrapper .video-container #player,
        .ttr-wrapper .video-container .fallback-iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 5px;
            z-index: 1;
        }
        .ttr-wrapper .video-container .nav-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 123, 255, 0.8);
            color: white;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            text-decoration: none;
            font-size: 28px;
            z-index: 10;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .ttr-wrapper .video-container:hover .nav-button {
            opacity: 1;
        }
        .ttr-wrapper .video-container .nav-button:hover {
            background-color: rgba(0, 86, 179, 0.8);
        }
        .ttr-wrapper .video-container .nav-button.disabled {
            background-color: rgba(204, 204, 204, 0.8);
            pointer-events: none;
            opacity: 0.5;
        }
        .ttr-wrapper .video-container .prev-button {
            left: 10px;
        }
        .ttr-wrapper .video-container .next-button {
            right: 10px;
        }
        .nav-buttons-container {
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: space-between; /* Đặt nút ở hai bên */
            margin-bottom: 20px;
            max-width: 100%;
            min-height: 60px; /* Đảm bảo đủ chiều cao để căn giữa */
        }
        .nav-buttons-container .quiz-form1 {
            flex: 1; /* Để .quiz-form1 chiếm không gian giữa */
        }
        .nav-buttons-container .nav-button {
            background-color: rgba(0, 123, 255, 0.8);
            color: white;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            text-decoration: none;
            font-size: 28px;
        }
        .nav-buttons-container .nav-button:hover {
            background-color: rgba(0, 86, 179, 0.8);
        }
        .nav-buttons-container .nav-button.disabled {
            background-color: rgba(204, 204, 204, 0.8);
            pointer-events: none;
        }
        .media-preview {
            max-height: 200px;
            width: 100%;
            object-fit: contain;
            border-radius: 8px;
            transition: transform 0.2s ease;
        }
        .media-preview:hover {
            transform: scale(1.02);
        }
        .note-section {
            transition: all 0.3s ease;
            background-color: #ffffff;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #e5e7eb;
        }
        .note-section:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            background-color: #f9fafb;
        }
        #mediaNotes .media-preview, #mediaNotes iframe {
            display: block !important;
            max-height: 200px !important;
            width: 100% !important;
            margin: 8px 0;
            border-radius: 8px;
        }
        #mediaNotes .form-group {
            border: 1px solid #e2e8f0;
            padding: 12px;
            border-radius: 8px;
            background-color: #f7fafc;
            margin-bottom: 12px;
        }
        #errorMessage:not(.hidden) {
            display: block;
            padding: 12px;
            border: 1px solid #f87171;
            border-radius: 8px;
            background-color: #fef2f2;
            margin-bottom: 16px;
        }
        .ttr-sidebar-navi .duration-label {
            font-size: 0.8rem;
            color: #6b7280;
            margin-top: 4px;
            display: block;
        }
        @media (max-width: 1024px) {
            .ttr-sidebar {
                width: 10%;
            }
            .ttr-wrapper {
                margin-left: 10% !important;
            }
        }
        @media (max-width: 768px) {
            .ttr-sidebar {
                width: 100%;
                position: fixed;
                z-index: 1000;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            .ttr-opened-sidebar .ttr-sidebar {
                transform: translateX(0);
            }
            .ttr-wrapper {
                margin-left: 0;
            }
            .ttr-wrapper .video-container .nav-button {
                width: 30px;
                height: 30px;
                font-size: 20px;
            }
            .nav-buttons-container .nav-button {
                width: 30px;
                height: 30px;
                font-size: 20px;
            }
        }
        .delete-media-btn {
            background-color: #ef4444;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.875rem;
            transition: background-color 0.2s ease;
        }
        .delete-media-btn:hover {
            background-color: #dc2626;
        }
        .edit-media-btn {
            background-color: #3b82f6;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.875rem;
            transition: background-color 0.2s ease;
        }
        .edit-media-btn:hover {
            background-color: #2563eb;
        }
        .media-preview.error {
            border: 2px solid #f87171;
        }
        .media-preview.loading::before {
            content: '';
            display: block;
            width: 40px;
            height: 40px;
            margin: 0 auto;
            border: 4px solid #3498db;
            border-top: 4px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        #noteList {
            display: flex;
            flex-direction: column;
            gap: 16px;
            max-height: 600px;
            overflow-y: auto;
            padding-right: 8px;
            scrollbar-width: thin;
            scrollbar-color: #cbd5e1 #f1f5f9;
        }
        #noteList::-webkit-scrollbar {
            width: 8px;
        }
        #noteList::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 4px;
        }
        #noteList::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }
        #noteList .note-section {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        #noteList .note-content {
            font-size: 1rem;
            color: #1f2937;
            line-height: 1.5;
            word-break: break-word;
        }
        #noteList .media-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 12px;
            margin-top: 8px;
        }
        #noteList .media-item {
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            background-color: #f9fafb;
            padding: 8px;
        }
        #noteList .media-item iframe {
            border-radius: 8px;
            width: 100%;
            height: 150px;
        }
        #noteList .media-note {
            font-size: 0.875rem;
            color: #4b5563;
            margin-top: 8px;
            padding: 0 8px;
        }
        #noteList .note-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
            font-size: 0.75rem;
            color: #6b7280;
        }
        #noteList .note-actions {
            display: flex;
            gap: 8px;
        }
        #noteList .note-actions button {
            background: none;
            border: none;
            color: #ef4444;
            font-size: 0.875rem;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 4px;
            transition: background-color 0.2s ease;
        }
        #noteList .note-actions button.edit-btn {
            color: #3b82f6;
        }
        #noteList .note-actions button:hover {
            background-color: #fef2f2;
        }
        #noteList .note-actions button.edit-btn:hover {
            background-color: #eff6ff;
        }
        #noteList .note-date {
            font-style: italic;
        }
        @media (max-width: 768px) {
            #noteList .media-container {
                grid-template-columns: 1fr;
            }
            #noteList .media-item iframe {
                height: 120px;
            }
            .nav-buttons-container .nav-button {
                width: 30px;
                height: 30px;
                font-size: 20px;
            }
        }
        .error-message {
            color: #f87171;
            background-color: #fef2f2;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
            display: none;
            z-index: 5;
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">
    <c:set var="course" value="${requestScope.choosenCourse}"/>
    <header class="ttr-header">
        <div class="ttr-header-wrapper">
            <div class="ttr-toggle-sidebar ttr-material-button">
                <i class="ti-close ttr-open-icon"></i>
                <i class="ti-menu ttr-close-icon"></i>
            </div>
            <div class="ttr-logo-box">
                <a href="home" class="ttr-logo">
                    <img alt="" class="ttr-logo-mobile" src="assets/images/logowhite1.png" width="30" height="30">
                    <img alt="" class="ttr-logo-desktop" src="assets/images/logowhite1.png" width="130" height="20">
                </a>
            </div>
            <div class="ttr-header-menu">
                <ul class="ttr-header-navigation">
                    <li><a href="home" class="ttr-material-button ttr-submenu-toggle">HOME</a></li>
                    <li><a href="#" class="ttr-material-button ttr-submenu-toggle">${course.courseName}</a></li>
                </ul>
            </div>
            <div class="ttr-header-right ttr-with-seperator">
                <ul class="ttr-header-navigation">
                    <li><a href="#" class="ttr-material-button ttr-search-toggle"><i class="fas fa-tasks"></i> ${completedLessons}/${totalLessons} finished</a></li>
                </ul>
            </div>
        </div>
    </header>
    <div class="ttr-sidebar">
        <div class="ttr-sidebar-wrapper content-scroll">
            <div class="ttr-sidebar-logo">
                <a href="home"><img alt="" src="admin/assets/images/course-content.png" width="150" height="37"></a>
                <div class="ttr-sidebar-toggle-button"><i class="ti-arrow-left"></i></div>
            </div>
            <nav class="ttr-sidebar-navi">
                <!-- Khởi tạo biến một lần duy nhất để lấy index hiển thị-->
                <c:set var="c" value="1" scope="page"/> 
                <c:set var="d" value="1" scope="page"/>
                <ul>
                    <c:forEach items="${requestScope.subjectTopicLesson}" var="a">
                        <li>
                            <a class="ttr-material-button">
                                <span class="ttr-label">
                                    <span class="index">
                                        <h6><c:out value="${d}"/>. ${a.name}</h6>
                                    </span>
                                    <!--Tăng giá trị biến d sau mỗi vòng lặp-->
                                    <c:set var="d" value="${d + 1}" scope="page"/>
                                    <c:if test="${not empty a.duration}">
                                        <span class="duration-label">
                                            <c:set var="minutes" value="${a.duration div 60}" />
                                            <fmt:formatNumber var="formattedMinutes" value="${minutes}" minIntegerDigits="2" maxFractionDigits="0" />
                                            <c:set var="seconds" value="${a.duration mod 60}" />
                                            <fmt:formatNumber var="formattedSeconds" value="${seconds}" minIntegerDigits="2" maxFractionDigits="0" />
                                            &nbsp;&nbsp;&nbsp;${formattedMinutes}:${formattedSeconds}
                                        </span>
                                    </c:if>
                                    <c:if test="${empty a.duration}">
                                        <span class="duration-label">00:00</span>
                                    </c:if>
                                </span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <c:forEach items="${subLessonsMap[a.lessonID]}" var="subLesson">
                                    <li>
                                        <a href="lessonviewcontroller?lessonID=${subLesson.lessonID}&courseID=${course.courseID}" class="ttr-material-button lesson-link" data-lesson-id="${subLesson.lessonID}">
                                            <span class="ttr-label">
                                                <span class="index"><c:out value="${c}"/>.</span>
                                                <!--Tăng giá trị biến c sau khi xong 1 subLesson-->
                                                <c:set var="c" value="${c + 1}" scope="page"/>
                                                ${subLesson.name}
                                                <c:if test="${not empty subLesson.duration}">
                                                    <span class="duration-label">
                                                        <c:if test="${subLesson.type == 'Lesson'}">
                                                            <i class="fas fa-desktop"></i>
                                                        </c:if>
                                                        <c:if test="${subLesson.type == 'Quiz'}">
                                                            <i class="fas fa-clipboard-list"></i>
                                                        </c:if>
                                                        <c:set var="minutes" value="${subLesson.duration div 60}" />
                                                        <fmt:formatNumber var="formattedMinutes" value="${minutes}" minIntegerDigits="2" maxFractionDigits="0" />
                                                        <c:set var="seconds" value="${subLesson.duration mod 60}" />
                                                        <fmt:formatNumber var="formattedSeconds" value="${seconds}" minIntegerDigits="2" maxFractionDigits="0" />
                                                        &nbsp;&nbsp;&nbsp;${formattedMinutes}:${formattedSeconds}
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty subLesson.duration}">
                                                    <span class="duration-label">00:00</span>
                                                </c:if>
                                            </span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:forEach>
                    <li class="ttr-seperate"></li>
                </ul>
            </nav>
        </div>
    </div>
    <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="wc-title"><h4>Course Content</h4></div>
                        <div class="widget-inner">
                            <c:if test="${not empty requestScope.errorMessage}">
                                <!--<div id="errorMessage" class="text-red-500 mb-4">${requestScope.errorMessage}</div>-->
                            </c:if>
                            <c:set var="b" value="${requestScope.chooseLesson}"/>
                            <c:choose>
                                <c:when test="${b eq null}">
                                    <p>Please select a lesson from the sidebar.</p>
                                </c:when>
                                <c:otherwise>
                                    
                                    <!--Test xem nếu Lesson type = lesson thì hiển thị video hoặc HTML-->
                                    <c:if test="${b.type eq 'Lesson'}">
                                        
                                        <!--Nếu có link video thì hiển thị-->
                                        <c:if test="${not empty b.contentVideo}">
                                            <div class="video-container">
                                                <div id="player"></div>
                                                <iframe class="fallback-iframe" src="${b.contentVideo}" frameborder="0" allowfullscreen></iframe>
                                                <div id="video-error" class="error-message"></div>
                                                <c:if test="${prevLessonID > 0}">
                                                    <a href="lessonviewcontroller?lessonID=${prevLessonID}&courseID=${course.courseID}" class="nav-button prev-button"><i class="fas fa-chevron-left"></i></a>
                                                </c:if>
                                                <c:if test="${nextLessonID > 0 && isLessonCompleted}">
                                                    <a href="lessonviewcontroller?lessonID=${nextLessonID}&courseID=${course.courseID}" class="nav-button next-button"><i class="fas fa-chevron-right"></i></a>
                                                </c:if>
                                                <c:if test="${nextLessonID > 0 && !isLessonCompleted}">
                                                    <span class="nav-button next-button disabled"><i class="fas fa-chevron-right"></i></span>
                                                </c:if>
                                            </div>
                                        </c:if>
                                        
                                        <!--Nếu có HTML thì hiển thị-->
                                        <c:if test="${not empty b.contentHtml}">
                                            <div class="content-html">${b.contentHtml}</div>
                                        </c:if>
                                    </c:if>
                                    
                                    <!--Nếu type = Quiz thì hiển thị bài Quiz Lesson-->
                                    <c:if test="${b.type eq 'Quiz'}">
                                        <div class="nav-buttons-container">
                                            
                                            <c:if test="${prevLessonID > 0}">
                                                <a href="lessonviewcontroller?lessonID=${prevLessonID}&courseID=${course.courseID}" class="nav-button"><i class="fas fa-chevron-left"></i></a>
                                            </c:if>
                                <!-----------------------------Form 1-->  
                                            <c:if test="${form eq null}">
                                      
                                                <div class="quiz-form1">
                                                    <c:set var="d" value="${requestScope.quizChoose}"/>
                                                            <h3>${b.name}</h3>
                                                            <h5 style="font-weight: normal;">${d.name}&nbsp;&nbsp;|&nbsp;&nbsp;${d.numberQuestions}&nbsp;questions</h5>
                                                            <br/>
                                                            <div class="exam-description">
                                                                <i>${d.description}</i>
                                                            </div>
                                                    <br/>
                                                    <form action="quizHandleController" method="get">
                                                        <button type="submit">Start Test</button>
                                                        <input type="hidden" value="${b.lessonID}" name="lessonID" />
                                                        <input type="hidden" value="${b.course.courseID}" name="courseID" />
                                                    </form>

                                                </div>        
                                            </c:if>
                                    <!-----------------------------Form 2-->  

                                            <c:if test="${form ne null}">
                                                <div class="quiz-form2">
                                                <c:set var="e" value="${requestScope.quizLessonDTO}"/>
                                                <div class="bg-light p-3 rounded">
                                                    <div class="bg-secondary bg-opacity-25 p-2 mb-3 custom-exam-header">
                                                        <c:if test="${not empty e and not empty e.startTime}">
                                                            Exam | 
                                                            ${e.startTime.getDayOfMonth() < 10 ? '0' : ''}${e.startTime.getDayOfMonth()}/${e.startTime.getMonthValue() < 10 ? '0' : ''}${e.startTime.getMonthValue()}/${e.startTime.getYear()} | 
                                                            ${e.startTime.getHour() < 10 ? '0' : ''}${e.startTime.getHour()}: 
                                                            ${e.startTime.getMinute() < 10 ? '0' : ''}${e.startTime.getMinute()} | 
                                                            ${e.numberQuestions} Questions
                                                        </c:if>
                                                    </div>

                                                    <div class="row g-3">
                                                        <div class="col-12 col-md-3">
                                                            <div class="row g-2">
                                                                <div class="col-12">
                                                                    <div class="card score-card">
                                                                        <div class="card-body">
                                                                            <h5 class="card-title">SCORE</h5>
                                                                            <br/>
                                                                            <c:if test="${e.quizStatus eq 'Pass'}">
                                                                                <p style="color: green" class="card-text score-percentage">
                                                                                    <fmt:formatNumber value="${(e.correctAnswers * 100) div e.numberQuestions}" type="number" maxFractionDigits="0" />%
                                                                                </p>
                                                                            </c:if>
                                                                            <c:if test="${e.quizStatus eq 'Fail'}">
                                                                                <p style="color: red" class="card-text score-percentage">
                                                                                    <fmt:formatNumber value="${(e.correctAnswers * 100) div e.numberQuestions}" type="number" maxFractionDigits="0" />%
                                                                                </p>
                                                                            </c:if>


                                                                            <p class="card-text correct">Correct: ${e.correctAnswers}/${e.numberQuestions}</p>

                                                                            <c:if test="${e.quizStatus eq 'Pass'}">
                                                                                <p style="color: green" class="card-text failed">${e.quizStatus}</p>
                                                                            </c:if>
                                                                            <c:if test="${e.quizStatus eq 'Fail'}">
                                                                                <p style="color: red" class="card-text failed">${e.quizStatus}</p>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-12 mt-2">
                                                                    <div class="card exam-taken-card">
                                                                        <div class="card-body">
                                                                            <p class="card-text">EXAM</p>
                                                                            <p class="card-text2">
                                                                                TAKEN
                                                                                ${e.startTime.getDayOfMonth() < 10 ? '0' : ''}${e.startTime.getDayOfMonth()}/${e.startTime.getMonthValue() < 10 ? '0' : ''}${e.startTime.getMonthValue()}/${e.startTime.getYear()}
                                                                            </p>
                                                                            <p class="card-text">
                                                                                ${e.startTime.getHour() < 10 ? '0' : ''}${e.startTime.getHour()} : 
                                                                                ${e.startTime.getMinute() < 10 ? '0' : ''}${e.startTime.getMinute()}
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-12 col-md-9">
                                                            <div class="results-table-container">
                                                                <c:set var="f" value="${e.dimensionResults}"/>
                                                                <table class="table table-bordered">
                                                                    <thead>
                                                                        <tr class="table-secondary">
                                                                            <th>${f[0].dimensionType}</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach var="g" items="${f}">
                                                                            <tr>
                                                                                <td>
                                                                                    ${g.dimensionName} : 
                                                                                    <fmt:formatNumber value="${(g.correctCount * 100) div g.totalQuestions}" type="number" maxFractionDigits="0" />%
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>

                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row g-3 mt-3">
                                                        <div class="col-12 col-md-3">
                                                            <div class="row g-2">
                                                                <div class="col-12">
                                                                    <div class="card review-test-card">
                                                                        <div class="card-body">
                                                                            <a href="">
                                                                                <p class="card-text">REVIEW TEST</p>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-12 mt-2">
                                                                    <div class="card redotest-card">
                                                                        <div class="card-body">
                                                                            <a href="quizHandleController?lessonID=${b.lessonID}&courseID=${b.course.courseID}">
                                                                                <p class="card-text">REDO TEST</p>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-12 col-md-9">
                                                            <div class="row g-2">
                                                                <div class="col-4">
                                                                    <div class="card time-card">
                                                                        <div class="card-body">
                                                                            <p class="card-text">AVERAGE TIME TO QUESTION</p>
                                                                            <p class="card-text">
                                                                                <fmt:formatNumber value="${e.actualQuizTime  div e.numberQuestions}" type="number" maxFractionDigits="0" /> sec
                                                                            </p>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-4">
                                                                    <div class="card time-card">
                                                                        <div class="card-body">
                                                                            <p class="card-text">TOTAL TIMES</p>
                                                                            <p class="card-text">
                                                                                ${e.actualQuizTime} sec
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-4">
                                                                    <div class="card time-card">
                                                                        <div class="card-body">
                                                                            <p class="card-text">UN-ANSWER QUESTION</p>
                                                                            <p class="card-text">
                                                                                ${e.unAnswers} question
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                </div>
                                            </c:if>
                                            
                                                <c:if test="${nextLessonID > 0 && isLessonCompleted}">
                                                    <a href="lessonviewcontroller?lessonID=${nextLessonID}&courseID=${course.courseID}" class="nav-button next-button"><i class="fas fa-chevron-right"></i></a>
                                                </c:if>
                                                <c:if test="${nextLessonID > 0 && !isLessonCompleted}">
                                                    <span class="nav-button next-button disabled"><i class="fas fa-chevron-right"></i></span>
                                                </c:if>
                                        </div>
                                    </c:if>

                                    <!--Phần ghi chú-->
                                    <div class="section-area section-sp1">
                                        <div class="container">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <h2 class="text-xl font-semibold text-gray-800 mb-1 font-weight-bold">Notes</h2>
                                                    <c:if test="${not empty requestScope.errorMessage}">
                                                        <div id="errorMessage" class="text-red-500 mb-4">${requestScope.errorMessage}</div>
                                                    </c:if>
                                                    <!--Form ghi chú-->
                                                    <form id="noteForm" action="${pageContext.request.contextPath}/lessonnotecontroller?courseID=${course.courseID}" method="post" enctype="multipart/form-data">
                                                        <input type="hidden" name="lessonId" value="${b.lessonID}">
                                                        <input type="hidden" name="userID" value="${sessionScope.userID}">
                                                        <input type="hidden" name="noteId" value="${editNote.noteID}">
                                                        <input type="hidden" name="editImageLinks" value="${editImageLinks}">
                                                        <input type="hidden" name="editImageNotes" value="${editImageNotes}">
                                                        <input type="hidden" name="editVideoNotes" value="${editVideoNotes}">
                                                        <div class="form-group">
                                                            <label class="block text-gray-700 mb-1 font-weight-bold">General Note:</label>
                                                            <textarea name="content" rows="5" class="form-control w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter general note for the lesson...">${editNote.content}</textarea>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="block text-gray-700 mb-1 font-weight-bold">Add Images:</label>
                                                            <input type="file" name="images" multiple accept="image/*" class="form-control w-full p-2 border border-gray-300 rounded-md">
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="block text-gray-700 mb-1 font-weight-bold">Add Video Links:</label>
                                                            <input type="text" name="videoLinks" class="form-control w-full p-2 border border-gray-300 rounded-md" placeholder="Paste video links (YouTube, etc.), separated by commas" value="${editVideoLinks}">
                                                        </div>
                                                        <div id="mediaNotes" class="space-y-4 mb-4"></div>
                                                        <button type="submit" class="btn btn-primary bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 transition">Save Note</button>
                                                    </form>
                                                    <!--Danh sách ghi chú-->
                                                    <div id="noteList" class="space-y-3 max-h-96 overflow-y-auto mt-4">
                                                        <c:if test="${empty requestScope.listNotes}">
                                                            <p class="text-gray-500">No notes yet.</p>
                                                        </c:if>
                                                        <c:forEach var="note" items="${requestScope.listNotes}">
                                                            <div class="note-section">
                                                                <c:if test="${not empty note.content}">
                                                                    <p class="note-content">${note.content}</p>
                                                                    <p class="note-content text-gray-500 text-sm">${note.noteID}</p>
                                                                </c:if>
                                                                <div class="media-container">
                                                                    <c:forEach var="media" items="${note.media}">
                                                                        <div class="media-item">
                                                                            <c:choose>
                                                                                <c:when test="${media.mediaType == 'image'}">
                                                                                    <img src="${pageContext.request.contextPath}/${media.mediaUrl}?t=${System.currentTimeMillis()}" alt="Note image" class="media-preview loading" data-media-url="${pageContext.request.contextPath}/${media.mediaUrl}">
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <iframe src="${media.mediaUrl}" frameborder="0" allowfullscreen></iframe>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <c:if test="${not empty media.content}">
                                                                                <p class="media-note">${media.content}</p>
                                                                            </c:if>
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
                                                                <div class="note-meta">
                                                                    <span class="note-date">${note.createDate}</span>
                                                                    <div class="note-actions">
                                                                        <form action="${pageContext.request.contextPath}/lessonnotecontroller" method="get" style="display: inline;">
                                                                            <input type="hidden" name="courseID" value="${course.courseID}">
                                                                            <input type="hidden" name="action" value="edit">
                                                                            <input type="hidden" name="noteId" value="${note.noteID}">
                                                                            <input type="hidden" name="lessonId" value="${b.lessonID}">
                                                                            <input type="hidden" name="userID" value="${sessionScope.userID}">
                                                                            <button type="submit" class="edit-btn">Edit</button>
                                                                        </form>
                                                                        <form action="${pageContext.request.contextPath}/lessonnotecontroller" method="post" style="display: inline;">
                                                                            <input type="hidden" name="courseID" value="${course.courseID}">
                                                                            <input type="hidden" name="action" value="delete">
                                                                            <input type="hidden" name="noteId" value="${note.noteID}">
                                                                            <input type="hidden" name="lessonId" value="${b.lessonID}">
                                                                            <input type="hidden" name="userID" value="${sessionScope.userID}">
                                                                            <button type="submit" onclick="return confirm('Are you sure you want to delete this note?')">Delete</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <div class="ttr-overlay"></div>
    <script src="admin/assets/js/jquery.min.js"></script>
    <script src="admin/assets/vendors/bootstrap/js/popper.min.js"></script>
    <script src="admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
    <script src="admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
    <script src="admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
    <script src="admin/assets/vendors/counter/waypoints.min.js"></script>
    <script src="admin/assets/vendors/counter/counterup.min.js"></script>
    <script src="admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
    <script src="admin/assets/vendors/masonry/masonry.js"></script>
    <script src="admin/assets/vendors/masonry/filter.js"></script>
    <script src="admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
    <script src="admin/assets/vendors/scroll/scrollbar.min.js"></script>
    <script src="admin/assets/js/functions.js"></script>
    <script src="admin/assets/vendors/chart/chart.min.js"></script>
    <script src="admin/assets/js/admin.js"></script>
    <script src='admin/assets/vendors/switcher/switcher.js'></script>
    <script src="https://www.youtube.com/iframe_api"></script>
    <script>
        (function ($) {
            try {
                console.log('Khởi tạo script tại', new Date().toLocaleString());
                // Selector cho các phần tử
                const $imageInput = $('input[name="images"]');
                const $videoInput = $('input[name="videoLinks"]');
                const $mediaNotesDiv = $('#mediaNotes');
                const $noteForm = $('#noteForm');
                const $videoContainer = $('.video-container');
                
                // Lưu trữ danh sách file đã chọn và media hiện có
                let selectedFiles = [];
                let existingMedia = [];
                let hideButtonsTimeout;

                // Xử lý hiển thị/ẩn nút điều hướng
                function showNavButtons() {
                    clearTimeout(hideButtonsTimeout);
                    $videoContainer.find('.nav-button').css('opacity', 1);
                    hideButtonsTimeout = setTimeout(() => {
                        $videoContainer.find('.nav-button').css('opacity', 0);
                    }, 3000); // Ẩn sau 3 giây không di chuyển chuột
                }

                // Sự kiện mousemove trên video container
                $videoContainer.on('mousemove', showNavButtons);
                
                // Xử lý URL YouTube
                function getYouTubeEmbedUrl(url) {
                    console.log('Xử lý URL video:', url);
                    let videoId = extractYouTubeVideoId(url);
                    return videoId ? 'https://www.youtube.com/embed/' + videoId : url;
                }

                // Thêm preview cho media
                function addMediaNoteField(type, value, previewSrc, noteContent = '') {
                    console.log('Thêm preview cho ' + type + ':', value);
                    let preview = '';
                    let displayValue = value.length > 30 ? value.substring(0, 27) + '...' : value;
                    if (type === 'image' && previewSrc) {
                        preview = '<img src="' + previewSrc + '" alt="Preview: ' + value + '" class="media-preview" style="max-height: 200px; width: 100%; object-fit: contain;">';
                    } else if (type === 'video') {
                        var embedUrl = getYouTubeEmbedUrl(value);
                        preview = embedUrl ? '<iframe src="' + embedUrl + '" width="100%" height="200" frameborder="0" allowfullscreen style="display: block;"></iframe>' :
                            '<p class="text-red-500">Invalid video link: ' + value + '</p>';
                    }
                    var html = [
                        '<div class="form-group" data-media-value="' + value + '" data-media-type="' + type + '">',
                        '<label class="block text-gray-700 mb-1 font-weight-bold">Note for ' + type + ': ' + displayValue + '</label>',
                        preview,
                        '<textarea name="' + type + 'Notes[]" class="form-control w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" rows="2" placeholder="Enter note for this ' + type + '...">' + (noteContent || '') + '</textarea>',
                        '<input type="hidden" name="' + type + 'Values[]" value="' + value + '">',
                        '<input type="hidden" name="existingMediaLinks[]" value="' + (type === 'video' ? getYouTubeEmbedUrl(value) : value) + '">',
                        '<button type="button" class="delete-media-btn">Delete</button>',
                        '</div>'
                    ].join('');
                    $mediaNotesDiv.append(html);
                    if (type === 'video') {
                        existingMedia.push(getYouTubeEmbedUrl(value));
                    } else {
                        existingMedia.push(value);
                    }
                }
                
                // Cập nhật FileList của input ảnh
                function updateImageInput() {
                    let dataTransfer = new DataTransfer();
                    selectedFiles.forEach(file => dataTransfer.items.add(file));
                    $imageInput[0].files = dataTransfer.files;
                    console.log('Đã cập nhật file input ảnh:', $imageInput[0].files.length);
                }

                // Cập nhật preview media
                function updateMediaNotes() {
                    console.log('Cập nhật ghi chú media');
                    // Lấy danh sách link video hiện tại
                    let currentVideos = $videoInput.val().split(',').map(v => v.trim()).filter(v => v);
                    
                    // Lưu ghi chú hiện tại
                    let currentMediaNotes = {};
                    $mediaNotesDiv.find('.form-group').each(function() {
                        let $group = $(this);
                        let value = $group.find('input[name$="Values[]"]').val();
                        let type = $group.data('media-type');
                        let noteContent = $group.find('textarea').val();
                        currentMediaNotes[type + '-' + value] = noteContent;
                    });
                    console.log('Ghi chú media hiện tại:', currentMediaNotes);
                    
                    // Xóa tất cả form-group để tránh trùng lặp
                    $mediaNotesDiv.empty();
                    existingMedia = [];
                    
                    // Thêm lại preview cho các ảnh
                    if (selectedFiles.length > 0) {
                        console.log('Ảnh đã chọn:', selectedFiles.length);
                        $.each(selectedFiles, function(i, file) {
                            console.log('Xử lý ảnh:', file.name);
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                let noteContent = currentMediaNotes['image-' + file.name] || '';
                                addMediaNoteField('image', file.name, e.target.result, noteContent);
                            };
                            reader.onerror = function(e) {
                                console.error('Lỗi FileReader cho', file.name, ':', e);
                                alert('Error reading image file: ' + file.name);
                            };
                            reader.readAsDataURL(file);
                        });
                    }
                    
                    // Thêm lại preview cho các video
                    if (currentVideos.length > 0) {
                        console.log('Video đã nhập:', currentVideos);
                        $.each(currentVideos, function(i, video) {
                            let noteContent = currentMediaNotes['video-' + video] || '';
                            addMediaNoteField('video', video, null, noteContent);
                        });
                    }
                }

                // Xử lý sự kiện click nút xóa
                $mediaNotesDiv.on('click', '.delete-media-btn', function() {
                    let $group = $(this).closest('.form-group');
                    let value = $group.data('media-value');
                    let type = $group.data('media-type');
                    console.log('Xóa ' + type + ':', value);
                    if (type === 'image') {
                        selectedFiles = selectedFiles.filter(file => file.name !== value);
                        updateImageInput();
                    } else if (type === 'video') {
                        let videos = $videoInput.val().split(',').map(v => v.trim()).filter(v => v);
                        videos = videos.filter(v => v !== value);
                        $videoInput.val(videos.join(','));
                        console.log('Đã cập nhật input video:', $videoInput.val());
                    }
                    $group.remove();
                    updateMediaNotes();
                });

                // Sự kiện thay đổi input ảnh
                $imageInput.on('change', function(e) {
                    console.log('Input ảnh thay đổi, số file:', e.target.files.length);
                    if (e.target.files.length > 0) {
                        let newFiles = Array.from(e.target.files);
                        if (selectedFiles.length + newFiles.length > 5) {
                            alert('Maximum 5 images can be uploaded.');
                            return;
                        }
                        for (let i = 0; i < newFiles.length; i++) {
                            if (!newFiles[i].type.startsWith('image/')) {
                                alert('File ' + newFiles[i].name + ' is not an image.');
                                return;
                            }
                            if (newFiles[i].size > 10 * 1024 * 1024) {
                                alert('File ' + newFiles[i].name + ' is too large (maximum 10MB).');
                                return;
                            }
                            if (selectedFiles.some(file => file.name === newFiles[i].name)) {
                                alert('File ' + newFiles[i].name + ' has already been selected.');
                                return;
                            }
                        }
                        selectedFiles = selectedFiles.concat(newFiles);
                        updateImageInput();
                        updateMediaNotes();
                    }
                });

                // Sự kiện thay đổi input video
                $videoInput.on('input', function(e) {
                    console.log('Input video thay đổi:', e.target.value);
                    var videos = e.target.value.split(',').map(v => v.trim()).filter(v => v);
                    for (var video of videos) {
                        if (!video.includes('youtube.com') && !video.includes('youtu.be')) {
                            alert('Invalid video link: ' + video);
                            return;
                        }
                    }
                    updateMediaNotes();
                });

                // Sự kiện submit form
                $noteForm.on('submit', function(e) {
                    console.log('Form đang submit, selectedFiles:', selectedFiles.length);
                    console.log('File input ảnh:', $imageInput[0].files.length);
                    if (selectedFiles.length > 0) {
                        updateImageInput();
                    }
                    if ($imageInput[0].files.length === 0 && selectedFiles.length > 0) {
                        console.warn('FileList rỗng, buộc cập nhật');
                        updateImageInput();
                    }
                });

                // Kiểm tra và tải lại ảnh trong danh sách ghi chú
                function checkImages(maxRetries = 3, retryDelay = 1000) {
                    console.log('Kiểm tra ảnh trong danh sách ghi chú');
                    $('#noteList img.media-preview').each(function() {
                        let $img = $(this);
                        let src = $img.data('media-url');
                        let retries = 0;
                        function tryLoadImage() {
                            console.log('Thử tải ảnh:', src, 'Lần thử:', retries);
                            $img.attr('src', src + '?t=' + new Date().getTime());
                            $img.addClass('loading');
                            $img.on('load', function() {
                                console.log('Tải ảnh thành công:', src);
                                $img.removeClass('loading error');
                                $img.off('load error');
                            });
                            $img.on('error', function() {
                                console.error('Tải ảnh thất bại:', src, 'Lần thử:', retries);
                                $img.addClass('error');
                                if (retries < maxRetries) {
                                    retries++;
                                    setTimeout(tryLoadImage, retryDelay);
                                } else {
                                    console.error('Đã đạt tối đa số lần thử cho ảnh:', src);
                                    $img.removeClass('loading');
                                    $img.off('load error');
                                }
                            });
                        }
                        tryLoadImage();
                    });
                }

                // Tải ghi chú media hiện có khi chỉnh sửa
                $(document).ready(function() {
                    console.log('editVideoLinks:', $('[name="videoLinks"]').val());
                    console.log('editVideoNotes:', $('[name="editVideoNotes"]').val());
                    console.log('editImageLinks:', $('[name="editImageLinks"]').val());
                    console.log('editImageNotes:', $('[name="editImageNotes"]').val());
                    checkImages();
                    // Tải ghi chú video hiện có nếu ở chế độ chỉnh sửa
                    if ($('[name="videoLinks"]').val()) {
                        let videoLinks = $('[name="videoLinks"]').val().split(',').map(v => v.trim()).filter(v => v);
                        let videoNotes = $('[name="editVideoNotes"]').val() ? $('[name="editVideoNotes"]').val().split(',').map(v => v.trim()) : [];
                        $.each(videoLinks, function(i, video) {
                            let noteContent = videoNotes[i] || '';
                            addMediaNoteField('video', video, null, noteContent);
                        });
                    }
                    // Tải ghi chú ảnh hiện có nếu ở chế độ chỉnh sửa
                    if ($('[name="editImageLinks"]').val()) {
                        let imageLinks = $('[name="editImageLinks"]').val().split(',').map(v => v.trim()).filter(v => v);
                        let imageNotes = $('[name="editImageNotes"]').val() ? $('[name="editImageNotes"]').val().split(',').map(v => v.trim()) : [];
                        $.each(imageLinks, function(i, image) {
                            let noteContent = imageNotes[i] || '';
                            addMediaNoteField('image', image, '${pageContext.request.contextPath}/' + image, noteContent);
                        });
                    }
                });
                var player;
                var lessonId = ${b.lessonID != null ? b.lessonID : 0};
                var courseId = ${b.course.courseID != null ? b.course.courseID : 0};
                var lessonDuration = ${b.duration != null ? b.duration : 0};
                var threshold = lessonDuration * 0.05;
                var hasStarted = false;
                var hasCompleted = false;
                var contentVideo = "${b.contentVideo != null ? b.contentVideo : ''}";
                var $videoError = $('#video-error');
                var $fallbackIframe = $('.fallback-iframe');
                var nextLessonID = ${nextLessonID != null ? nextLessonID : -1};
                var totalLessons = ${totalLessons != null ? totalLessons : 0};

                function onYouTubeIframeAPIReady() {
                    console.log('YouTube IFrame API ready');
                    var videoId = extractYouTubeVideoId(contentVideo);
                    if (!videoId) {
                        console.error('Invalid YouTube video ID for URL:', contentVideo);
                        $videoError.text('Cannot load video: Invalid YouTube URL').show();
                        $fallbackIframe.css('display', 'block');
                        return;
                    }
                    try {
                        player = new YT.Player('player', {
                            height: '100%',
                            width: '100%',
                            videoId: videoId,
                            playerVars: {
                                'autoplay': 0,
                                'controls': 1,
                                'rel': 0
                            },
                            events: {
                                'onReady': onPlayerReady,
                                'onStateChange': onPlayerStateChange
                            }
                        });
                        $fallbackIframe.css('display', 'none');
                    } catch (e) {
                        console.error('Error creating YouTube player:', e);
                        $videoError.text('Error loading YouTube player').show();
                        $fallbackIframe.css('display', 'block');
                    }
                }

                function extractYouTubeVideoId(url) {
                    console.log('Extracting video ID from:', url);
                    if (!url || typeof url !== 'string') {
                        console.warn('Invalid or empty URL');
                        return '';
                    }
                    let videoId = '';
                    if (url.includes('youtube.com/embed/')) {
                        videoId = url.split('embed/')[1]?.split('?')[0]?.split('&')[0]?.trim();
                    } else if (url.includes('youtube.com/watch?v=')) {
                        videoId = url.split('watch?v=')[1]?.split('&')[0]?.trim();
                    } else if (url.includes('youtu.be/')) {
                        videoId = url.split('youtu.be/')[1]?.split('?')[0]?.split('&')[0]?.trim();
                    }
                    console.log('Extracted video ID:', videoId);
                    return videoId || '';
                }

                function onPlayerReady(event) {
                    console.log('Player ready for video ID:', extractYouTubeVideoId(contentVideo));
                    setInterval(checkProgress, 1000);
                }

                //Khi video bắt đầu chạy thì tạo 1 bản ghi UserLessonProgress mới
                //với status = InProgress
                function onPlayerStateChange(event) {
                    console.log('Player state changed:', event.data);
                    if (event.data === YT.PlayerState.PLAYING && !hasStarted) {
                        hasStarted = true;
                        console.log('Video started, sending AJAX for lessonId:', lessonId);
                        $.ajax({
                            url: 'lessonviewcontroller',
                            type: 'POST',
                            data: {
                                action: 'startVideo',
                                lessonID: lessonId
                            },
                            success: function(response) {
                                console.log('Start video AJAX success:', response);
                            },
                            error: function(xhr, status, error) {
                                console.error('Start video AJAX error:', error);
                            }
                        });
                    }
                }
                
                //Cho phép nút Next available
                function updateNextButton(isLessonCompleted) {
                    if (isLessonCompleted && nextLessonID > 0) {
                        $('.video-container .next-button').replaceWith(
                            '<a href="lessonviewcontroller?lessonID=' + encodeURIComponent(nextLessonID) + '" class="nav-button next-button"><i class="fas fa-chevron-right"></i></a>'
                        );
                        $('.nav-buttons-container .nav-button.disabled').filter(function() {
                            return $(this).find('i.fas.fa-chevron-right').length > 0;
                        }).replaceWith(
                            '<a href="lessonviewcontroller?lessonID=' + encodeURIComponent(nextLessonID) + '" class="nav-button"><i class="fas fa-chevron-right"></i></a>'
                        );
                    }
                }
                
                //Cập nhật tiến độ UserLessonProgress sang Completed
                function updateCompletedLessons(completedLessons) {
                    let $completedDisplay = $('.ttr-header-right .ttr-header-navigation li a i.fas.fa-tasks').parent();
                    $completedDisplay.html('<i class="fas fa-tasks"></i> ' + completedLessons + '/' + totalLessons + ' finished');
                }

                //Kiểm tra tiến độ video (checkProgress) để gửi AJAX khi xem 5% (completedVideo).
                function checkProgress() {
                    if (player && player.getCurrentTime && !hasCompleted) {
                        var currentTime = player.getCurrentTime();
                        console.log('Current video time:', currentTime, '/', threshold);
                        if (currentTime >= threshold) {
                            hasCompleted = true;
                            console.log('Video watched past 5% threshold, sending AJAX for lessonId:', lessonId);
                            $.ajax({
                                url: 'lessonviewcontroller',
                                type: 'POST',
                                data: {
                                    action: 'completedVideo',
                                    lessonID: lessonId
                                },
                                success: function(response) {
                                    console.log('Complete video AJAX success:', response);
                                    // Gọi checkProgress để lấy trạng thái mới
                                    $.ajax({
                                        url: 'lessonviewcontroller',
                                        type: 'POST',
                                        data: {
                                            action: 'checkProgress',
                                            lessonID: lessonId,
                                            courseID: courseId
                                        },
                                        success: function(response) {
                                            console.log('Check progress AJAX success:', response);
                                            if (!response.startsWith('Error') && response.includes(':')) {
                                                let parts = response.split(':');
                                                if (parts.length === 2) {
                                                    let isLessonCompleted = parts[0] === 'true';
                                                    let completedLessons = parseInt(parts[1], 10);
                                                    if (!isNaN(completedLessons)) {
                                                        if (isLessonCompleted) {
                                                            updateNextButton(true);
                                                        }
                                                        updateCompletedLessons(completedLessons);
                                                    } else {
                                                        console.error('Invalid completedLessons:', parts[1]);
                                                    }
                                                } else {
                                                    console.error('Invalid response format:', response);
                                                }
                                            } else {
                                                console.error('Check progress error:', response);
                                            }
                                        },
                                        error: function(xhr, error) {
                                            console.error('Check progress AJAX error:', error);
                                        }
                                    });
                                },
                                error: function(xhr, error) {
                                    console.error('Complete video AJAX error:', error);
                                }
                            });
                        }
                    }
                }

                $(document).ready(function() {
                    console.log('Document ready, contentVideo:', contentVideo, 'lessonId:', lessonId, 'duration:', lessonDuration);
                    if (contentVideo && lessonId > 0) {
                        $fallbackIframe.css('display', 'block');
                        if (typeof YT === 'undefined' || !YT.Player) {
                            console.warn('YouTube API not loaded, waiting...');
                            setTimeout(function() {
                                if (typeof YT !== 'undefined' && YT.Player) {
                                    onYouTubeIframeAPIReady();
                                } else {
                                    console.error('YouTube API failed to load');
                                    $videoError.text('Cannot load video: YouTube API unavailable').show();
                                    $fallbackIframe.css('display', 'block');
                                }
                            }, 2000);
                        } else {
                            onYouTubeIframeAPIReady();
                        }
                    } else {
                        console.error('Invalid lesson data: contentVideo or lessonId missing');
                        $videoError.text('Cannot load video: Invalid lesson data').show();
                        $fallbackIframe.css('display', 'block');
                    }
                });
            } catch (error) {
                console.error('Script error:', error);
                $('#video-error').text('Error loading video: ' + error.message).show();
                $('.fallback-iframe').css('display', 'block');
            }
        })(jQuery);
    </script>
</body>
</html>