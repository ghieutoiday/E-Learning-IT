<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${action == 'add' ? 'Add New Lesson' : 'Manage Lessons'}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <div class="page-banner ovbl-dark"
                     style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Subject Lesson</h1>
                        </div>
                    </div>
                </div>
   
        <style>
    /* Khoảng cách giữa nội dung và top */
    .container {
        margin-top: 40px;
    }

    /* Tiêu đề bảng */
    .table th {
        vertical-align: middle;
        background-color: #222222;
        color: #ffffff;
        text-align: center;
        font-weight: 600;
    }

    /* Nội dung bảng */
    .table td {
        vertical-align: middle;
        text-align: center;
    }

    /* Tên bài học canh trái cho dễ đọc */
    .table td:first-child + td {
        text-align: left;
    }

    /* Cột hành động */
    .actions a {
        margin-right: 5px;
    }

    /* Nút Details */
    .btn-info {
        background-color: #17c1e8;
        border-color: #17c1e8;
        color: white;
    }

    .btn-info:hover {
        background-color: #0da9cd;
        border-color: #0da9cd;
    }

    /* Nút Deactivate */
    .btn-danger {
        background-color: #f44336;
        border-color: #f44336;
        color: white;
    }

    .btn-danger:hover {
        background-color: #d32f2f;
        border-color: #d32f2f;
    }

    /* Filter inputs (dropdowns + search) */
    .form-control,
    .form-select {
        max-width: 220px;
        display: inline-block;
        margin-right: 10px;
    }

    /* Nút Search và Add Lesson */
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

    /* Status label */
    .badge-success {
        background-color: #4caf50;
        font-size: 0.9rem;
        padding: 6px 12px;
        border-radius: 12px;
    }

    /* Phân trang */
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

    /* Responsive table fix nếu cần */
    .table-responsive {
        overflow-x: auto;
    }
    
</style>

    </head>
    <body>
        <div class="container mt-4">

            <c:choose>
                <%-- KHI action LÀ 'add', HIỂN THỊ FORM THÊM MỚI --%>
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

                <%-- MẶC ĐỊNH, HIỂN THỊ DANH SÁCH BÀI HỌC --%>
                <c:otherwise>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item"><a href="courses">Courses</a></li>
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

                                <%-- Nút Previous --%>
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="subjectLesson?courseId=${course.getCourseID()}&page=${currentPage - 1}&status=${selectedStatus}&search=${searchQuery}&topicFilterId=${selectedTopicId}">Previous</a>
                                    </li>
                                </c:if>

                                <%-- Các số trang --%>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="subjectLesson?courseId=${course.getCourseID()}&page=${i}&status=${selectedStatus}&search=${searchQuery}&topicFilterId=${selectedTopicId}">${i}</a>
                                    </li>
                                </c:forEach>

                                <%-- Nút Next --%>
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
    </body>
</html>