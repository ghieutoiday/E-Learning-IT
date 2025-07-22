<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Questions List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                background-color: #fff;
                padding: 2rem;
                border-radius: 0.5rem;
                box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Questions List</h3>
                <a href="#" class="btn btn-success">Import Questions</a>
            </div>

            <form action="questionList" method="get" class="p-3 border rounded bg-light mb-4">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Course</label>
                        <%-- Đã xóa onchange="this.form.submit()" --%>
                        <select name="courseId" class="form-select">
                            <option value="0">All Courses</option>
                            <c:forEach var="c" items="${allCourses}">
                                <option value="${c.courseID}" ${c.courseID == selectedCourseId ? 'selected' : ''}>${c.courseName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Dimension</label>
                        <select name="dimensionId" class="form-select">
                            <option value="0">All Dimensions</option>
                            <%-- Dropdown này cần được cập nhật bằng JS/AJAX nếu muốn nó phụ thuộc vào Course --%>
                            <%-- Hiện tại, nó hiển thị tất cả Dimension có thể có --%>
                            <c:forEach var="dim" items="${allDimensions}">
                                <option value="${dim.dimensionID}" ${dim.dimensionID == selectedDimensionId ? 'selected' : ''}>${dim.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Level</label>
                        <select name="level" class="form-select">
                            <option value="0">All Levels</option>
                            <c:forEach var="i" begin="1" end="5">
                                <option value="${i}" ${i == selectedLevel ? 'selected' : ''}>Level ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select">
                            <option value="">All</option>
                            <option value="Active" ${'Active' eq selectedStatus ? 'selected' : ''}>Active</option>
                            <option value="Inactive" ${'Inactive' eq selectedStatus ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Search by Content</label>
                        <input type="text" name="search" class="form-control" value="${searchValue}" placeholder="Enter content to search...">
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Apply Filter</button>
                    </div>
                </div>
            </form>

            <table class="table table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Content</th>
                        <th>Course</th>
                        <th>Dimension</th>
                        <th>Level</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${questions}">
                        <tr>
                            <td>${q.questionID}</td>
                            <td><c:out value="${q.content}" /></td>
                            <td>
                                <%-- Dùng vòng lặp lồng nhau để tìm tên Course --%>
                                <c:forEach var="course" items="${allCourses}">
                                    <c:if test="${q.courseID == course.courseID}">
                                        ${course.courseName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <%-- Dùng vòng lặp lồng nhau để tìm tên Dimension --%>
                                <c:forEach var="dimension" items="${allDimensions}">
                                    <c:if test="${q.dimensionID == dimension.dimensionID}">
                                        ${dimension.name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>${q.level}</td>
                            <td>
                                <span class="badge ${q.status == 'Active' ? 'bg-success' : 'bg-secondary'}">${q.status}</span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty questions}">
                        <tr><td colspan="6" class="text-center">No questions found.</td></tr>
                    </c:if>
                </tbody>
            </table>

            <nav>
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="questionList?page=${currentPage - 1}&courseId=${selectedCourseId}&dimensionId=${selectedDimensionId}&level=${selectedLevel}&status=${selectedStatus}&search=${searchValue}">Previous</a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="questionList?page=${i}&courseId=${selectedCourseId}&dimensionId=${selectedDimensionId}&level=${selectedLevel}&status=${selectedStatus}&search=${searchValue}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="questionList?page=${currentPage + 1}&courseId=${selectedCourseId}&dimensionId=${selectedDimensionId}&level=${selectedLevel}&status=${selectedStatus}&search=${searchValue}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </body>
</html>