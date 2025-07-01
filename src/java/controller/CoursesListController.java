package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import dal.PostDAO;
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

@WebServlet(name = "CoursesListController", urlPatterns = { "/courseslist" })
public class CoursesListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        CourseDAO dao = new CourseDAO();
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
        request.getRequestDispatcher("courses.jsp").forward(request, response);
    }
}