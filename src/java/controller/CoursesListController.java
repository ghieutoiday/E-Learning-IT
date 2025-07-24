package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import dal.PostDAO;
import dal.PricePackageDAO;
import dal.SliderDAO;
import dal.SubjectDimensionDAO;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.CourseCategory;
import model.PricePackage;
import model.User;

@WebServlet(name = "CoursesListController", urlPatterns = { "/courseslist" })
public class CoursesListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CourseDAO dao = new CourseDAO();
        

        String courseId_raw = request.getParameter("courseId");
        int courseId;
        if (courseId_raw != null && !courseId_raw.isBlank()) {
            try {
                courseId = Integer.parseInt(courseId_raw);
                //Lấy và tạo 1 attribute CourseDetail cụ thể để hiện thị trong trang Course Detail
                Course courseDetail = dao.getCoureByCourseIDAndPrice(courseId);
                request.setAttribute("courseDetail", courseDetail);

            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        String search = request.getParameter("search");
        String categoryIdStr = request.getParameter("categoryId");
        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            categoryId = Integer.parseInt(categoryIdStr);
        }
        
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
        List<Course> courseList = dao.getCoursePageCoursesList(page, search, categoryId);
        int totalCourses = dao.countCourseWithFilter(search, categoryId);
        int totalPages = (int) Math.ceil((double) totalCourses / 9);
        
        List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
        List<Course> courseListByFeature = dao.getCoursePageCoursesListByFeature(1);
        request.getSession().setAttribute("courseCategoryList", courseCategoryList);
        request.getSession().setAttribute("courseList", courseList);
        request.getSession().setAttribute("courseListByFeature", courseListByFeature);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("categoryId", categoryId);
        
        // Kiểm tra và xử lý khi nhấn "Registration"
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            courseId = Integer.parseInt(request.getParameter("courseId"));
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");
            if (user != null) {
                // Đã đăng nhập, chuyển trực tiếp đến trang đăng ký với thông tin
                response.sendRedirect(request.getContextPath() + "/showRegistration?courseId=" + courseId + "&mode=loggedIn");
            } else {
                // Chưa đăng nhập, chuyển đến trang đăng ký yêu cầu nhập thông tin
                response.sendRedirect(request.getContextPath() + "/showRegistration?courseId=" + courseId + "&mode=guest");
            }
            return;
        }
        
        //Lấy page để Chọn trang nào đc forward sang
        String pageforward = request.getParameter("pageforward");
        if (pageforward.equalsIgnoreCase("courselist")) {
            request.getRequestDispatcher("courses.jsp").forward(request, response);
        } else if (pageforward.equalsIgnoreCase("coursedetail")) {
            request.getRequestDispatcher("courses-details.jsp").forward(request, response);
        }
        
    }
}
