<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lesson Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
        }
        .container { 
            max-width: 800px; 
            margin-top: 50px; 
            background-color: white; 
            padding: 30px; 
            border-radius: 8px; 
            box-shadow: 0 0 10px rgba(0,0,0,0.1); 
        }
        .form-label { 
            font-weight: bold; 
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="mb-4">Lesson Details</h2>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">
            ${errorMessage}
        </div>
    </c:if>

    <%-- Form sẽ gửi dữ liệu đến servlet tại URL "lessonDetails" --%>
    <form action="lessonDetails" method="post">
        
        <%-- Các trường ẩn để gửi ID cần thiết --%>
        <input type="hidden" name="lessonId" value="${lesson.lessonID}">
        <input type="hidden" name="courseId" value="${lesson.course.courseID}">

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="${lesson.name}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="type" class="form-label">Type</label>
                <select class="form-select" id="type" name="type">
                    <option value="Lesson" ${lesson.type == 'Lesson' ? 'selected' : ''}>Lesson</option>
                    <option value="Quiz" ${lesson.type == 'Quiz' ? 'selected' : ''}>Quiz</option>
                    <option value="Subject Topic" ${lesson.type == 'Subject Topic' ? 'selected' : ''}>Subject Topic</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="topic" class="form-label">Topic</label>
                <select class="form-select" id="topic" name="topicId">
                    <option value="">-- No Topic --</option>
                    <%-- Vòng lặp để hiển thị danh sách chủ đề --%>
                    <c:forEach var="topic" items="${topics}">
                        <option value="${topic.lessonID}" ${lesson.topic.lessonID == topic.lessonID ? 'selected' : ''}>
                            ${topic.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label for="order" class="form-label">Order</label>
                <input type="number" class="form-control" id="order" name="orderNum" value="${lesson.orderNum}" required>
            </div>
        </div>
        
        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" id="status" name="status">
                <option value="Active" ${lesson.status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${lesson.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="videoLink" class="form-label">Video link</label>
            <input type="text" class="form-control" id="videoLink" name="videoLink" value="${lesson.contentVideo}" placeholder="https://www.youtube.com/embed/...">
        </div>

        <div class="mb-3">
            <label for="htmlContent" class="form-label">HTML Content</label>
            <textarea class="form-control" id="htmlContent" name="htmlContent" rows="5">${lesson.contentHtml}</textarea>
        </div>

        <div class="d-flex justify-content-end">
            <%-- Nút Back, bạn hãy thay "lesson-list" bằng URL trang danh sách lesson của bạn --%>
            <a href="lesson-list?courseId=${lesson.course.courseID}" class="btn btn-secondary me-2">Back</a>
            <button type="submit" class="btn btn-primary">Submit</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>