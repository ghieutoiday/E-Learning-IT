<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>${not empty lesson.lessonID ? 'Edit Lesson Details' : 'Add New Lesson'}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Font tổng thể */
            body {
                background-color: #f1f3f5;
                font-family: 'Inter', sans-serif;
                color: #212529;
            }

            /* Khung chính */
            .container {
                max-width: 850px;
                background-color: #ffffff;
                border-radius: 10px;
                padding: 40px;
                margin-top: 60px;
                margin-bottom: 60px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.08);
            }

            /* Tiêu đề */
            h2, h4 {
                font-weight: 600;
                color: #343a40;
            }

            /* Label */
            .form-label {
                font-weight: 500;
                color: #495057;
                font-size: 0.95rem;
            }

            /* Input & Select */
            .form-control,
            .form-select {
                border-radius: 6px;
                font-size: 0.95rem;
                transition: border-color 0.3s;
            }
            .form-control:focus,
            .form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
            }

            /* Nút */
            .btn {
                font-weight: 500;
                font-size: 0.95rem;
            }
            .btn-primary {
                background-color: #0d6efd;
                border-color: #0d6efd;
                padding: 8px 20px;
            }
            .btn-primary:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            .btn-secondary {
                padding: 8px 20px;
            }

            /* Alert */
            .alert {
                border-radius: 6px;
                font-size: 0.92rem;
            }

            /* Admin Notes */
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }
            .card-header {
                font-weight: 600;
                background-color: #f8f9fa;
                font-size: 1rem;
            }

            /* Ghi chú */
            #noteList .card-body p {
                margin-bottom: 0.5rem;
                white-space: pre-wrap;
            }

            /* Hình ảnh trong ghi chú */
            #noteList img {
                border: 1px solid #dee2e6;
                padding: 3px;
                background-color: #f8f9fa;
            }

            /* Video */
            #noteList .ratio {
                border: 1px solid #dee2e6;
                border-radius: 6px;
                overflow: hidden;
            }

            /* Nhỏ hơn */
            small.text-muted {
                font-size: 0.85rem;
            }

            /* Responsive */
            @media (max-width: 576px) {
                .container {
                    padding: 20px;
                }
                .d-flex.justify-content-end {
                    flex-direction: column;
                    gap: 10px;
                }
            }

        </style>
    </head>
    <body>

        <div class="container">
            <h2 class="mb-4">${not empty lesson.lessonID ? 'Edit Lesson Details' : 'Add New Lesson'}</h2>

            <%-- Hiển thị thông báo thành công hoặc lỗi --%>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>

            <%-- Form chính để sửa thông tin Lesson --%>
            <form action="lessonDetails" method="post">

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
                            <option value="0">-- No Topic --</option>
                            <c:forEach var="topicItem" items="${topics}">
                                <option value="${topicItem.lessonID}" ${lesson.topic.lessonID == topicItem.lessonID ? 'selected' : ''}>
                                    ${topicItem.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="order" class="form-label">Order</label>
                        <input type="number" class="form-control" id="order" name="orderNum" value="${lesson.orderNum > 0 ? lesson.orderNum : 1}" required>
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
                    <a href="subjectLesson?courseId=${lesson.course.courseID}" class="btn btn-secondary me-2">Back</a>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>

            <%-- ============================================================== --%>
            <%--    BẮT ĐẦU KHU VỰC NOTES DÀNH CHO ADMIN (Giao diện nâng cấp)    --%>
            <%-- ============================================================== --%>
            <hr class="mt-5">
            <h4 class="mb-3">Admin Notes</h4>
            <p class="text-muted small">These notes are for internal use by Admins/Experts only.</p>
            <%-- Hiển thị danh sách các ghi chú đã có --%>
            <div id="noteList" class="mb-4">
                <c:if test="${empty notes}">
                    <p class="text-muted">No admin notes yet for this lesson.</p>
                </c:if>
                <c:forEach var="note" items="${notes}">
                    <div class="card mb-3">
                        <div class="card-body">
                            <p style="white-space: pre-wrap;">${note.getNoteContent()}</p>

                            <%-- Hiển thị media đính kèm --%>
                            <c:if test="${not empty note.media}">
                                <div class="row g-2 mt-2">
                                    <c:forEach var="mediaItem" items="${note.media}">
                                        <div class="col-md-6 col-lg-4">
                                            <c:if test="${mediaItem.getMediaType() == 'image'}">
                                                <img src="${pageContext.request.contextPath}/${mediaItem.getMediaURL()}" class="img-fluid rounded border" alt="Note Image">
                                            </c:if>
                                            <c:if test="${mediaItem.getMediaType() == 'video'}">
                                                <div class="ratio ratio-16x9">
                                                    <iframe src="${mediaItem.getMediaURL()}" title="YouTube video" allowfullscreen></iframe>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>

                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <small class="text-muted">Created: <fmt:formatDate value="${note.getCreatedDate()}" pattern="yyyy-MM-dd HH:mm"/></small>
                                <form action="adminNote" method="post" onsubmit="return confirm('Are you sure you want to delete this note?');">
                                    <input type="hidden" name="action" value="delete_note">
                                    <input type="hidden" name="noteId" value="${note.getNoteID()}">
                                    <input type="hidden" name="lessonId" value="${lesson.getLessonID()}">
                                    <input type="hidden" name="courseId" value="${courseId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="card">
                <div class="card-header">Add New Admin Note</div>
                <div class="card-body">
                    <form action="adminNote" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add_note">
                        <input type="hidden" name="lessonId" value="${lesson.getLessonID()}">
                        <input type="hidden" name="courseId" value="${courseId}">

                        <div class="mb-3">
                            <label class="form-label">General Note:</label>
                            <textarea name="noteContent" class="form-control" rows="3" placeholder="Enter general note for the lesson..."></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Add Images (can select multiple):</label>
                            <input type="file" name="images" class="form-control" multiple accept="image/*">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Add Video Links:</label>
                            <textarea name="videoLinks" class="form-control" rows="2" placeholder="Paste video links (YouTube, etc.), separated by commas"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Note</button>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>