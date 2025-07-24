package controller;

import dal.CourseDAO;
import dal.PricePackageDAO;
import dal.RegistrationDAO;
import dal.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import model.PricePackage;
import model.Registration;
import model.User;

@WebServlet(name = "ShowRegistrationPopupServlet", urlPatterns = {"/showRegistration"})
public class ShowRegistrationPopupController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int courseId = Integer.parseInt(request.getParameter("courseId"));

        RegistrationDAO regDAO = new RegistrationDAO();
        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (user != null) {
            request.setAttribute("mode", "loggedIn");
            int currentUserId = user.getUserID();
            UserDAO userDAO = new UserDAO();
            User currentUser = userDAO.getUserByID(currentUserId);
            request.setAttribute("user", currentUser);

            try {
                Registration existingReg = regDAO.getRegistrationByUserAndCourse(currentUserId, courseId);
                if (existingReg != null) {
                    request.setAttribute("existingRegistration", existingReg);
                } else {
                    System.out.println("No existing registration for userId=" + currentUserId + " and courseId=" + courseId);
                    // Không cần set lỗi nếu không tìm thấy, vì đây là trường hợp hợp lệ
                }
            } catch (Exception e) {
                System.err.println("Error fetching existing registration: " + e.getMessage());
                request.setAttribute("errorMessage", "An error occurred while checking registration. Please try again.");
            }
        } else {
            request.setAttribute("mode", "guest");
        }

        CourseDAO courseDAO = new CourseDAO();
        PricePackageDAO pricePackageDAO = new PricePackageDAO();
        Course course = courseDAO.getCourseByIdd(courseId);
        List<PricePackage> packages = pricePackageDAO.getPricePackagesByCourseId(courseId);

        request.setAttribute("course", course);
        request.setAttribute("packages", packages);
        request.getRequestDispatcher("register-course.jsp").forward(request, response);
    }
}
