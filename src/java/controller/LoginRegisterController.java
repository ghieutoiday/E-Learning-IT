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
            String errorMessage = null; 


            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                errorMessage = "Email và mật khẩu không được để trống.";
            } else {
                User user = userDAO.getUserByEmailByLogin(email);
                if (user != null) {
                     String storedPassword = user.getPassword(); 

                    boolean passwordMatches = false;

                    // Kiểm tra xem mật khẩu trong DB có phải dạng BCrypt không
                    if (storedPassword != null && 
                        (storedPassword.startsWith("$2a$") || 
                         storedPassword.startsWith("$2b$") || 
                         storedPassword.startsWith("$2y$"))) {
                        
                        passwordMatches = BCrypt.checkpw(password, storedPassword);

                    } else {

                        passwordMatches = password.equals(storedPassword);
                    }
                    if (passwordMatches) {
                        // Đăng nhập THÀNH CÔNG
                        session.setAttribute("loggedInUser", user); 
                        response.sendRedirect(request.getContextPath() + "/home");
                        return; 
                    } else {
                        // Mật khẩu không đúng
                        errorMessage = "Mật khẩu không đúng. Vui lòng thử lại.";
                    }
                } else {
                    errorMessage = "Đã có lỗi xảy ra. Vui lòng kiểm tra lại.";
                }
            }

            request.setAttribute("loginError", errorMessage);
            request.setAttribute("prevEmail", email != null ? email : ""); 
            request.setAttribute("openLoginModalOnLoad", true); 
            request.getRequestDispatcher("/home").forward(request, response);

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
                //Mã hóa mật khẩu bằng BCrypt 
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

                User newUser = new User();
                newUser.setFullName(fullName);
                newUser.setGender(gender);
                newUser.setEmail(email);
                newUser.setMobile(mobile);
                newUser.setPassword(hashedPassword); 
                
                int newUserId  = userDAO.addNewUserRegister(newUser);

                if (newUserId  > 0) {
                    newUser.setUserID(newUserId); 
                    
                    //Tạo token xác minh
                    String verificationTokenString = UUID.randomUUID().toString();
                    LocalDateTime tokenExpiryTime = LocalDateTime.now().plusMinutes(10);

                    // Tạo đối tượng TokenForgetPassword và gán đối tượng User vào nó
                    TokenForgetPassword verificationTokenObj = new TokenForgetPassword();
                    verificationTokenObj.setToken(verificationTokenString);
                    verificationTokenObj.setExpiryTime(tokenExpiryTime);
                    verificationTokenObj.setIsUsed(false);
                    verificationTokenObj.setUserID(newUser); // Gán đối tượng User vào token
                    
                    try {
                        //Lưu token vào DB
                        tokenDAO.saveToken(verificationTokenObj); 
                        
                        //Tạo link xác minh
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
            request.getRequestDispatcher("/home").forward(request, response);
        }

    }

}
