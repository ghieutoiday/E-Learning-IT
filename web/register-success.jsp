<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration Successful</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .success-container {
            text-align: center;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            max-width: 500px;
        }
        .success-container h1 {
            color: #28a745;
            font-size: 2.2em;
            margin-bottom: 15px;
        }
        .success-container p {
            font-size: 1.1em;
            color: #555;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .success-container a {
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            padding: 12px 30px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.2s;
        }
        .success-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <h1>Registration Successful!</h1>
        
        <%-- Hiển thị thông báo động từ session --%>
        <c:if test="${not empty sessionScope.successMessage}">
            <p>${sessionScope.successMessage}</p>
            <%-- Xóa message khỏi session để không hiển thị lại ở lần sau --%>
            <c:remove var="successMessage" scope="session" />
        </c:if>
        
        <a href="index.jsp">Back to Homepage</a>
    </div>
</body>
</html>