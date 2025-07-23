<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Setting Details - #${setting.settingID}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                background-color: #f4f7f9;
                font-family: 'Inter', sans-serif;
                color: #333;
            }
            .card {
                border: 1px solid #e0e0e0;
                border-radius: 12px;
                box-shadow: 0 4px_12px rgba(0,0,0,0.05);
                transition: all 0.3s ease-in-out;
            }
            .card:hover {
                box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            }
            .card-header {
                background: linear-gradient(135deg, #0d6efd, #0d5dd1);
                color: white;
                font-weight: 600;
                border-bottom: 0;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
                padding: 1.25rem 1.5rem;
            }
            .card-header h3 {
                margin: 0;
                font-size: 1.5rem;
            }
            .card-body {
                padding: 2rem;
            }
            .form-label {
                font-weight: 600;
                color: #555;
                margin-bottom: 0.5rem;
            }
            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid #ced4da;
                padding: 0.75rem 1rem;
                transition: border-color 0.2s ease, box-shadow 0.2s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
            }
            .btn {
                border-radius: 8px;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                transition: all 0.2s ease;
                letter-spacing: 0.5px;
            }
            .btn-primary {
                background-color: #0d6efd;
                border-color: #0d6efd;
            }
            .btn-primary:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
                transform: translateY(-2px);
            }
            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }
            .btn-secondary:hover {
                background-color: #5c636a;
                border-color: #565e64;
                transform: translateY(-2px);
            }
            .card-footer-actions {
                background-color: #f8f9fa;
                border-top: 1px solid #e0e0e0;
                padding: 1.5rem 2rem;
                border-bottom-left-radius: 12px;
                border-bottom-right-radius: 12px;
            }
        </style>
    </head>
    <body>
        <%@ page import="model.User" %>

        <%@ page import="model.Role" %>

        <%

            User user = (User) session.getAttribute("loggedInUser");

            if (user == null || user.getRole() == null || user.getRole().getRoleID() != 5) {

                response.sendRedirect(request.getContextPath() + "/home");

                return;

            }

        %>
        <div class="container mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="card">
                        <div class="card-header">
                            <h3>Setting Details (ID: ${setting.settingID})</h3>
                        </div>
                        <form action="settingDetailsController" method="post">
                            <div class="card-body">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">${error}</div>
                                </c:if>

                                <input type="hidden" name="id" value="${setting.settingID}">

                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="type" class="form-label">Type (Group)</label>
                                        <input list="setting-types" class="form-control" id="type" name="type" value="${setting.type}" required>
                                        <datalist id="setting-types">
                                            <c:forEach var="t" items="${settingTypes}"><option value="${t}"></option></c:forEach>
                                            </datalist>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <label for="settingKey" class="form-label">Setting Name (Key)</label>
                                            <input type="text" class="form-control" id="settingKey" name="settingKey" value="${setting.settingKey}" required>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="value" class="form-label">Value</label>
                                    <input type="text" class="form-control" id="value" name="value" value="${setting.value}">
                                </div>

                                <div class="mb-4">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3">${setting.description}</textarea>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="orderNum" class="form-label">Order</label>
                                        <input type="number" class="form-control" id="orderNum" name="orderNum" value="${setting.orderNum}" required>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label for="status" class="form-label">Status</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="Active" ${setting.status == 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${setting.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer-actions d-flex justify-content-end">
                                <a href="settingController" class="btn btn-secondary me-2">Back to List</a>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
