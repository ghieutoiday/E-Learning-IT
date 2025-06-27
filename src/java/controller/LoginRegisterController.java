/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Course;
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "LoginRegisterController", urlPatterns = {"/loginregistercontroller"})
public class LoginRegisterController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/home");

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("login".equalsIgnoreCase(action)) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String errorMessage = null; // Khởi tạo là null thay vì rỗng để dễ kiểm tra

            // 1. Kiểm tra dữ liệu đầu vào cơ bản
            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                errorMessage = "Email và mật khẩu không được để trống.";
            } else {
                // 2. Tìm kiếm người dùng và xác thực mật khẩu
                User user = userDAO.getUserByEmail(email);
                if (user != null) {
                    if (password.equals(user.getPassword())) {
                        // Đăng nhập THÀNH CÔNG
                        session.setAttribute("loggedInUser", user); 
                        response.sendRedirect(request.getContextPath() + "/home");
                        return; // RẤT QUAN TRỌNG: Dừng xử lý tại đây khi thành công
                    } else {
                        // Mật khẩu không đúng
                        errorMessage = "Mật khẩu không đúng. Vui lòng thử lại.";
                    }
                } else {
                    // Email không tồn tại
                    errorMessage = "Email không tồn tại. Vui lòng kiểm tra lại.";
                }
            }

            // --- Xử lý khi Đăng nhập THẤT BẠI ---
            // Phần này được đặt NGOÀI khối if/else của logic xác thực thành công/thất bại
            // để đảm bảo nó luôn được thực thi nếu không có lệnh `return` nào xảy ra (tức là đăng nhập thất bại).
            request.setAttribute("loginError", errorMessage); // Gửi thông báo lỗi
            request.setAttribute("prevEmail", email != null ? email : ""); // Giữ lại email đã nhập
            request.setAttribute("openLoginModalOnLoad", true); // Cờ báo cho JS mở lại modal

            // Chuyển tiếp (forward) về lại index.jsp để hiển thị modal với lỗi
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } else if ("signup".equalsIgnoreCase(action)) {
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String password = request.getParameter("password");
            String signupErrorMessage = null;

            if (fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || password == null || password.trim().isEmpty()) {
                signupErrorMessage = "Vui lòng điền đầy đủ Họ tên, Email và Mật khẩu.";
            } else if (userDAO.getUserByEmail(email) != null) {
                signupErrorMessage = "Email này đã được đăng ký. Vui lòng sử dụng email khác.";
            } else {
                User newUser = new User();
                // Gán dữ liệu cho từng thuộc tính của newUser
                newUser.setFullName(fullName);
                newUser.setGender(gender);
                newUser.setEmail(email);
                newUser.setMobile(mobile);
                newUser.setPassword(password);
                
                int success = userDAO.addNewUser(newUser);

                if (success > 0) {
                     response.sendRedirect(request.getContextPath() + "/home");
                    return;
                } else {
                    signupErrorMessage = "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại.";
                }
            }

            request.setAttribute("signupError", signupErrorMessage);
            request.setAttribute("prevFullName", fullName != null ? fullName : "");
            request.setAttribute("prevEmail", email != null ? email : "");
            request.setAttribute("prevMobile", mobile != null ? mobile : "");
            request.setAttribute("prevGender", gender != null ? gender : "");
            request.setAttribute("openSignupModalOnLoad", true);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }

    }

}
