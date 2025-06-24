package controller;

import dal.CourseDAO;
import dal.PricePackageDAO;
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
import model.User;

@WebServlet(name = "ShowRegistrationPopupServlet", urlPatterns = {"/showRegistration"})
public class ShowRegistrationPopupController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String mode = request.getParameter("mode");

        if ("loggedIn".equals(mode)) {
            // TRƯỜNG HỢP 1: Giả lập đã đăng nhập, fix cứng userId=1
            int currentUserId = 1;
            UserDAO userDAO = new UserDAO();
            User currentUser = userDAO.getUserByID(currentUserId);
            request.setAttribute("user", currentUser);
        }
        
        CourseDAO courseDAO = new CourseDAO();
        PricePackageDAO pricePackageDAO = new PricePackageDAO();
        Course course = courseDAO.getCourseByIdd(courseId);
        List<PricePackage> packages = pricePackageDAO.getPricePackagesByCourseId(courseId);

        request.setAttribute("course", course);
        request.setAttribute("packages", packages);
        request.setAttribute("mode", mode);

        request.getRequestDispatcher("register-course.jsp").forward(request, response);
    }
}