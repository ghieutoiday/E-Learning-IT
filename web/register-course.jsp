<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Registration</title>
        <style>
            /* Toàn bộ CSS để tạo giao diện */
            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                margin: 0;
                background-color: #f4f7f6;
            }
            .page-container {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 15px;
                width: 100%;
                box-sizing: border-box;
            }
            .form-content {
                background: white;
                padding: 20px 25px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                width: 100%;
                max-width: 650px;
            }
            .form-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-bottom: 15px;
            }
            .form-header h3 {
                margin: 0;
                font-size: 18px;
            }
            .close-button {
                font-size: 24px;
                cursor: pointer;
                color: #aaa;
            }
            .form-body {
                padding-top: 15px;
                border-top: 1px solid #f0f0f0;
            }
            .form-body h4 {
                margin-top: 0;
                margin-bottom: 15px;
                font-size: 16px;
            }
            .plan {
                border: 1px solid #ccc;
                border-radius: 6px;
                padding: 15px;
                margin-bottom: 10px;
                display: flex;
                align-items: flex-start;
                cursor: pointer;
                transition: border-color 0.2s, background-color 0.2s;
            }
            .plan.selected {
                border-color: #007bff;
                background-color: #f8f9fa;
            }
            .plan-details {
                flex-grow: 1;
                margin-left: 15px;
            }
            .plan-details strong {
                font-size: 16px;
            }
            .plan-details p {
                margin: 5px 0 0 0;
                font-size: 14px;
                color: #666;
            }
            .plan-details .original-price {
                text-decoration: line-through;
            }
            .plan-pricing {
                font-weight: bold;
                color: #007bff;
                font-size: 16px;
            }
            .info-section {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                border-top: 1px solid #f0f0f0;
                padding-top: 20px;
                margin-top: 20px;
            }
            .form-group label {
                margin-bottom: 5px;
                font-size: 14px;
                color: #555;
            }
            .form-group input, .form-group select {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }
            .form-footer {
                border-top: 1px solid #f0f0f0;
                padding-top: 20px;
                margin-top: 20px;
                display: flex;
                justify-content: flex-end;
                align-items: center;
            }
            .total-price {
                font-size: 20px;
                font-weight: bold;
                color: #d9534f;
                margin-right: auto;
            }
            .actions button {
                padding: 10px 25px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                font-size: 14px;
            }
            .actions .cancel-btn {
                background-color: #e9ecef;
            }
            .actions .accept-btn {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty requestScope.errorMessage}">
            <div style="padding: 15px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 5px; margin-bottom: 20px; text-align: center; font-weight: bold;">
                ${requestScope.errorMessage}
            </div>
        </c:if>
        <div class="page-container">
            <div class="form-content">
                <div class="form-header">
                    <h3>Course Register: ${course.courseName}</h3>
                    <span class="close-button" onclick="history.back()">&times;</span>
                </div>

                <form action="processRegistration?mode=${mode}" method="POST">
                    <c:if test="${not empty user}">
                        <input type="hidden" name="userId" value="${user.userID}">
                    </c:if>
                    <input type="hidden" name="courseId" value="${course.courseID}">

                    <div class="form-body">
                        <h4>Select a Plan</h4>
                        <c:if test="${not empty requestScope.errorMessage}">
                            <div style="padding: 15px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 5px; margin-bottom: 20px; text-align: center; font-weight: bold;">
                                ${requestScope.errorMessage}
                            </div>
                        </c:if>
                        <c:forEach var="pkg" items="${packages}" varStatus="loop">
                            <div id="plan-${pkg.pricePackageID}" class="plan ${loop.first ? 'selected' : ''}" onclick="selectPlan(${pkg.pricePackageID}, ${pkg.salePrice})">
                                <input type="radio" id="radio-${pkg.pricePackageID}" name="pricePackageId" value="${pkg.pricePackageID}" ${loop.first ? 'checked' : ''}>
                                <div class="plan-details">
                                    <strong>${pkg.name}</strong>
                                    <p>Access Duration: 
                                        <c:choose>
                                            <c:when test="${empty pkg.accessDuration}">Lifetime Access</c:when>
                                            <c:otherwise>${pkg.accessDuration} months</c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="original-price">
                                        Price: <fmt:formatNumber value="${pkg.listPrice}" type="currency" currencySymbol="$" maxFractionDigits="2"/>
                                    </p>
                                </div>
                                <div class="plan-pricing">
                                    <fmt:formatNumber value="${pkg.salePrice}" type="currency" currencySymbol="$" maxFractionDigits="2"/>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="info-section">
                            <h4>Your Information</h4>
                            <c:choose>
                                <c:when test="${not empty user}">
                                    <!-- Đã đăng nhập, hiển thị thông tin readonly -->
                                    <div class="form-group">
                                        <label>Full Name</label>
                                        <input type="text" value="${user.fullName}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="email" value="${user.email}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Mobile</label>
                                        <input type="tel" value="${user.mobile}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Gender</label>
                                        <input type="text" value="${user.gender}" readonly>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Chưa đăng nhập, yêu cầu nhập thông tin -->
                                    <div class="form-group">
                                        <label for="fullName">Your Name</label>
                                        <input type="text" id="fullName" name="fullName" value="${requestScope.input_fullName}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" name="email" value="${requestScope.input_email}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="mobile">Mobile</label>
                                        <input type="tel" id="mobile" name="mobile" value="${requestScope.input_mobile}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <select id="gender" name="gender" required>
                                            <option value="">Choose...</option>
                                            <option value="Male" ${requestScope.input_gender == 'Male' ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${requestScope.input_gender == 'Female' ? 'selected' : ''}>Female</option>
                                        </select>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="form-footer">
                        <div class="total-price">
                            Total: <span id="total-amount"></span>
                        </div>
                        <div class="actions">
                            <button type="button" class="cancel-btn" onclick="history.back()">Cancel</button>
                            <button type="submit" class="accept-btn">Accept</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function selectPlan(planId, price) {
                document.getElementById('radio-' + planId).checked = true;
                document.querySelectorAll('.plan').forEach(p => p.classList.remove('selected'));
                document.getElementById('plan-' + planId).classList.add('selected');

                const formattedPrice = new Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD'}).format(price);
                document.getElementById('total-amount').innerText = formattedPrice;
            }

            document.addEventListener('DOMContentLoaded', function () {
                const firstRadio = document.querySelector('input[name="pricePackageId"]:checked');
                if (firstRadio) {
                    firstRadio.parentElement.click();
                }
            });
        </script>
    </body>
</html>