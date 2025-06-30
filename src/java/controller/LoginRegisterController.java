/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.TokenDAO;
import dal.UserDAO;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import model.Course;
import model.TokenForgetPassword;
import model.User;

import org.mindrot.jbcrypt.BCrypt;
import utils.EmailUtil;

/**
 *
 * @author admin
 */
@WebServlet(name = "LoginRegisterController", urlPatterns = {"/loginregistercontroller"})
public class LoginRegisterController extends HttpServlet {

    private UserDAO userDAO;
    private TokenDAO tokenDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        tokenDAO = new TokenDAO();

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
                     String storedPassword = user.getPassword(); // Mật khẩu từ DB

                    boolean passwordMatches = false;

                    // 1. Kiểm tra xem mật khẩu trong DB có phải dạng BCrypt không
                    if (storedPassword != null && 
                        (storedPassword.startsWith("$2a$") || 
                         storedPassword.startsWith("$2b$") || 
                         storedPassword.startsWith("$2y$"))) {
                        
                        // Đây là mật khẩu BCrypt (dành cho tài khoản mới hoặc đã được chuyển đổi từ trước)
                        passwordMatches = BCrypt.checkpw(password, storedPassword);

                    } else {

                        passwordMatches = password.equals(storedPassword);
                    }
                    if (passwordMatches) {
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
                // MỚI: Băm mật khẩu bằng BCrypt trước khi lưu vào DB (CHỈ DÀNH CHO NGƯỜI DÙNG MỚI)
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

                User newUser = new User();
                // Gán dữ liệu cho từng thuộc tính của newUser
                newUser.setFullName(fullName);
                newUser.setGender(gender);
                newUser.setEmail(email);
                newUser.setMobile(mobile);
                newUser.setPassword(hashedPassword); // LƯU MẬT KHẨU ĐÃ BĂM BCrypt
                
                int newUserId  = userDAO.addNewUserRegister(newUser);

                if (newUserId  > 0) {
                    // MỚI: Cập nhật đối tượng newUser với userID vừa lấy được từ DB
                    newUser.setUserID(newUserId); 

                    String verificationTokenString = UUID.randomUUID().toString();
                    LocalDateTime tokenExpiryTime = LocalDateTime.now().plusMinutes(10);

                    // Tạo đối tượng TokenForgetPassword và gán đối tượng User vào nó
                    TokenForgetPassword verificationTokenObj = new TokenForgetPassword();
                    verificationTokenObj.setToken(verificationTokenString);
                    verificationTokenObj.setExpiryTime(tokenExpiryTime);
                    verificationTokenObj.setIsUsed(false);
                    verificationTokenObj.setUserID(newUser); // Gán đối tượng User vào token
                    
                    try {
                        tokenDAO.saveToken(verificationTokenObj); 

                        String verificationLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                + request.getContextPath() + "/verifycontroller?token=" + verificationTokenString;

                        String emailSubject = "Verify Your Account - E-Learning System"; 
                        System.out.println("DEBUG: Verification Link generated: " + verificationLink);
                        String emailBodyHtml = "<html><body style=\"font-family: Arial, sans-serif; line-height: 1.6; color: #333;\">"
                                + "<div style=\"max-width: 600px; margin: 20px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; background-color: #f9f9f9;\">"
                                + "<h2 style=\"color: #007bff; text-align: center;\">Account Verification</h2>"
                                + "<p>Dear " + fullName + ",</p>"
                                + "<p>Thank you for registering with our E-Learning System.</p>"
                                + "<p>Please click the link below to verify your email address:</p>"
                                + "<p style=\"text-align: center; margin: 30px 0;\">"
                                + "<a href=\"" + verificationLink + "\" style=\"display: inline-block; padding: 12px 25px; background-color: #28a745; color: #ffffff; text-decoration: none; border-radius: 5px; font-weight: bold;\">Verify My Account</a>"
                                + "</p>"
                                + "<p>This link will expire in <strong>10 minutes</strong>.</p>" // Thông báo 10 phút
                                + "<p>If you did not register, please ignore this email.</p>"
                                + "<p>Regards,<br/>E-Learning System Team</p>"
                                + "<hr style=\"border: 0; border-top: 1px solid #eee; margin-top: 20px;\">"
                                + "<p style=\"font-size: 0.8em; color: #777; text-align: center;\">This is an automated email. Please do not reply.</p>"
                                + "</div></body></html>";

                        try {
                            EmailUtil.sendEmail(email, emailSubject, emailBodyHtml);
                            request.setAttribute("signupSuccessMessage", "Đăng ký thành công! Vui lòng kiểm tra email để xác minh tài khoản của bạn.");
                            response.sendRedirect(request.getContextPath() + "/home");
                            return;
                        } catch (MessagingException e) {
                            e.printStackTrace();
                            signupErrorMessage = "Đăng ký thành công nhưng không gửi được email xác minh. Vui lòng thử lại sau hoặc liên hệ hỗ trợ.";
                        }
                    } catch (Exception e) {
                         e.printStackTrace();
                         signupErrorMessage = "Có lỗi xảy ra khi lưu token xác minh. Vui lòng thử lại.";
                    }
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
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

}
