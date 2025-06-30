<%-- verificationStatus.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trạng thái xác minh tài khoản</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }
            .container {
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                max-width: 500px;
                width: 90%;
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
            }
            p {
                color: #555;
                font-size: 1.1em;
                margin-bottom: 20px;
            }
            .success {
                color: green;
                font-weight: bold;
            }
            .error {
                color: red;
                font-weight: bold;
            }
            a {
                color: #007bff;
                text-decoration: none;
            }
            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Trạng thái xác minh tài khoản</h1>
            <p class="<%= (request.getAttribute("verificationMessage") != null && request.getAttribute("verificationMessage").toString().contains("thành công") ? "success" : "error") %>">
                <%= request.getAttribute("verificationMessage") != null ? request.getAttribute("verificationMessage") : "Có lỗi xảy ra." %>
            </p>
            <p>
                <a href="<%= request.getContextPath() %>/home">Quay lại trang chủ</a>
            </p>
        </div>
    </body>
</html>