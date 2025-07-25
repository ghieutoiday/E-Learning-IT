package controller;

import dal.CourseDAO;
import dal.PricePackageDAO;
import dal.RegistrationDAO;
import dal.UserDAO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.PricePackage;
import model.Registration;
import model.Role;
import model.User;
import utils.EmailService;

@WebServlet(name = "ProcessRegistrationServlet", urlPatterns = {"/processRegistration"})
public class ProcessRegistrationController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String mode = request.getParameter("mode");
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int pricePackageId = Integer.parseInt(request.getParameter("pricePackageId"));

        UserDAO userDAO = new UserDAO();
        RegistrationDAO regDAO = new RegistrationDAO();
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser"); // Lấy người dùng từ session

        int userIdToRegister = 0;
        User userToRegister = null;

        // =========================================================================
        // SỬA LỖI 1: LẤY USER ID TỪ SESSION NẾU ĐÃ ĐĂNG NHẬP
        // =========================================================================
        if ("loggedIn".equals(mode) && loggedInUser != null) {
            // Lấy ID và thông tin người dùng trực tiếp từ session, không qua request
            userIdToRegister = loggedInUser.getUserID();
            userToRegister = loggedInUser;
        } else {
            // Kịch bản 2: Khách đăng ký (giữ nguyên logic cũ của bạn)
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String gender = request.getParameter("gender");

            if (userDAO.emailExists(email)) {
                request.setAttribute("errorMessage", "This email (" + email + ") is already in use by another account.");
                forwardToRegistrationPage(request, response, courseId, 0, fullName, email, mobile, gender);
                return;
            }

            if (mobile != null && !mobile.trim().isEmpty() && userDAO.mobileExists(mobile)) {
                request.setAttribute("errorMessage", "This mobile number (" + mobile + ") is already in use by another account.");
                forwardToRegistrationPage(request, response, courseId, 0, fullName, email, mobile, gender);
                return;
            }

            Role customerRole = userDAO.getRoleByID(1);
            String defaultPassword = "123";
            User newUser = new User(0, fullName, email, defaultPassword, gender, mobile, "", customerRole, "", "Active");

            if (userDAO.addUser(newUser)) {
                userToRegister = userDAO.getUserByEmail(email);
                if (userToRegister != null) {
                    userIdToRegister = userToRegister.getUserID();
                } else {
                    request.setAttribute("errorMessage", "Critical Error: Could not retrieve the newly created user.");
                    forwardToRegistrationPage(request, response, courseId, 0, fullName, email, mobile, gender);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Error: Could not create a new user account.");
                forwardToRegistrationPage(request, response, courseId, 0, fullName, email, mobile, gender);
                return;
            }
        }

        PricePackageDAO ppDAO = new PricePackageDAO();
        PricePackage selectedPackage = ppDAO.getPricePackageById(pricePackageId);
        double totalCost = (selectedPackage != null) ? selectedPackage.getSalePrice() : 0;

        // Tìm kiếm đăng ký hiện có với User ID đã được xác thực
        Registration existingReg = regDAO.getRegistrationByUserAndCourse(userIdToRegister, courseId);

        boolean isSuccess = false;
        String successMessage = "";

        // =========================================================================
        // SỬA LỖI 2: TÁI CẤU TRÚC LOGIC CẬP NHẬT CHO RÕ RÀNG
        // =========================================================================
        if (existingReg != null) {
            // TRƯỜNG HỢP 1: Đã có đơn đăng ký -> Xử lý CẬP NHẬT

            if (pricePackageId == existingReg.getPricePackage().getPricePackageID()) {
                // Nếu chọn lại gói cũ -> Báo lỗi
                request.setAttribute("errorMessage", "You are already using this package. Please choose another one to update.");
                forwardToRegistrationPage(request, response, courseId, userIdToRegister, null, null, null, null);
                return;
            } else {
                // Nếu chọn gói mới -> Tiến hành cập nhật
                isSuccess = regDAO.updateRegistrationPackage(existingReg.getRegistrationID(), pricePackageId, totalCost);
                if (isSuccess) {
                    successMessage = "Your registration has been successfully updated with the new package!";
                }
            }

        } else {
            // TRƯỜNG HỢP 2: Chưa có đơn đăng ký -> TẠO MỚI
            if (userToRegister == null) {
                userToRegister = userDAO.getUserByID(userIdToRegister);
            }
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseByIdd(courseId);

            Registration newReg = new Registration(0, userToRegister, null, course, selectedPackage, totalCost, "Submitted", new java.util.Date(), null, null, null);
            isSuccess = regDAO.save(newReg);

            if (isSuccess) {
                if (!"loggedIn".equals(mode) && userToRegister != null && "123".equals(userToRegister.getPassword())) {
                    boolean emailSent = EmailService.sendNewUserPasswordEmail(userToRegister.getEmail(), userToRegister.getFullName(), userToRegister.getPassword());
                    successMessage = emailSent ? "Registration successful! A new account has been created and credentials have been sent to your email."
                            : "Registration successful! New account created, but failed to send password email.";
                } else {
                    successMessage = "Registration successful! The course has been added to your account.";
                }
            }
        }

        if (isSuccess) {
            session.setAttribute("successMessage", successMessage);
            response.sendRedirect("register-success.jsp");
        } else {
            // Nếu isSuccess vẫn là false (ví dụ: update thất bại nhưng không có lỗi cụ thể)
            if (request.getAttribute("errorMessage") == null) {
                request.setAttribute("errorMessage", "We could not process your request at this time. Please try again later.");
            }
            forwardToRegistrationPage(request, response, courseId, userIdToRegister, null, null, null, null);
        }
    }

    private void forwardToRegistrationPage(HttpServletRequest request, HttpServletResponse response, int courseId, int userId, String fullName, String email, String mobile, String gender) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO(); //
        CourseDAO courseDAO = new CourseDAO(); //
        PricePackageDAO ppDAO = new PricePackageDAO(); //

        request.setAttribute("course", courseDAO.getCourseByIdd(courseId)); //
        request.setAttribute("packages", ppDAO.getPricePackagesByCourseId(courseId)); //

        if (userId > 0) { //
            request.setAttribute("user", userDAO.getUserByID(userId)); //
        }

        request.setAttribute("input_fullName", fullName); //
        request.setAttribute("input_email", email); //
        request.setAttribute("input_mobile", mobile); //
        request.setAttribute("input_gender", gender); //

        request.getRequestDispatcher("register-course.jsp").forward(request, response); //
    }
}
