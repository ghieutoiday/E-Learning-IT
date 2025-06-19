package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.System.Logger;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.Course;
import model.CourseCategory;
import model.User;

@WebServlet(name = "CourseController", urlPatterns = {"/coursecontroller"})
public class CourseController extends HttpServlet {

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        CourseDAO courseDao = new CourseDAO();
//        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
//        HttpSession session = request.getSession();
//
//        String pageSubjectList = request.getParameter("pageSubjectList");
//        if (pageSubjectList == null) {
//            pageSubjectList = "1";
//        }
//        int indexPageSubjectList = Integer.parseInt(pageSubjectList);
//
//        String categoryParam = request.getParameter("category");
//        String statusParam = request.getParameter("status");
//        String action = request.getParameter("action");
//
//        if (action == null) {
//            action = "view"; // Mặc định là view nếu không có action
//        }
//
//        if (action.equals("view") || action.equals("filter")) {
//            // Nếu có tham số filter từ request, lưu vào session
//            if (categoryParam != null) {
//                session.setAttribute("currentCategory", categoryParam);
//            }
//            if (statusParam != null) {
//                session.setAttribute("currentStatus", statusParam);
//            }
//
//            // Lấy category và status từ session hoặc mặc định
//            String currentCategory = (String) session.getAttribute("currentCategory");
//            if (currentCategory == null) {
//                currentCategory = "allCategory"; // Giá trị mặc định
//            }
//
//            String currentStatus = (String) session.getAttribute("currentStatus");
//            if (currentStatus == null) {
//                currentStatus = "allStatus";
//            }
//
//            List<Course> courseList;
//            int totalCourse;
//
//            // lọc dựa trên currentCategory và currentStatus
//            if (currentCategory.equals("allCategory") && currentStatus.equals("allStatus")) {
//                totalCourse = courseDao.getAllCourse().size();
//                courseList = courseDao.pagingCourse(indexPageSubjectList);
//            } else if (currentCategory.equals("allCategory") && !currentStatus.equals("allStatus")) {
//                totalCourse = courseDao.getAllCoureByStatus(currentStatus).size();
//                courseList = courseDao.pagingCourseByStatus(indexPageSubjectList, currentStatus);
//            } else if (!currentCategory.equals("allCategory") && currentStatus.equals("allStatus")) {
//                CourseCategory courseCategory = courseCategoryDao.getCategoryByName(currentCategory);
//                int id = courseCategory.getCourseCategory();
//                totalCourse = courseDao.getAllCoureByCategory(id).size();
//                courseList = courseDao.pagingCourseByCategory(indexPageSubjectList, id);
//            } else {
//                CourseCategory courseCategory = courseCategoryDao.getCategoryByName(currentCategory);
//                int id = courseCategory.getCourseCategory();
//                totalCourse = courseDao.getAllCoureByCategoryAndStatus(id, currentStatus).size();
//                courseList = courseDao.pagingCourseByCategoryAndStatus(indexPageSubjectList, id, currentStatus);
//            }
//
//            int endPage = totalCourse / 5;
//            if (totalCourse % 5 != 0) {
//                endPage++;
//            }
//
//            session.setAttribute("endPage", endPage);
//            session.setAttribute("courseList", courseList);
//
//            List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
//            session.setAttribute("courseCategoryList", courseCategoryList);
//
//            request.getRequestDispatcher("subject-list.jsp").forward(request, response);
//        } else if (action.equals("detail")) {
//            String service = request.getParameter("service");
//            String id = request.getParameter("id");
//            Course courseDetail = courseDao.getCoureByCourseID(Integer.parseInt(id));
//
//            session.setAttribute("courseDetail", courseDetail);
//            List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
//            session.setAttribute("courseCategoryList", courseCategoryList);
//
//            if (service != null && service.equals("updatecourse")) {
//                // Lấy id và user
//                String idCourseRaw = request.getParameter("idCourse");
//                int idCourse = Integer.parseInt(idCourseRaw);
//                UserDAO userDao = new UserDAO();
//                User user = userDao.getUser(courseDetail.getOwner().getUserID());
//                // Tên subject
//                String subjectName = request.getParameter("subjectName");
//                // Tên category
//                String category = request.getParameter("category");
//                CourseCategory courseCategory = courseCategoryDao.getCategoryByName(category);
//                // Feature
//                int featuredSubject = 0;
//                String featuredSubjectRaw = request.getParameter("featuredSubject");
//                if( featuredSubjectRaw != null && featuredSubjectRaw.equals("1")){
//                    featuredSubject = 1;
//                }
//                // Số lượng bài học
//                String numberOfLessonsRaw = request.getParameter("numberOfLessons");
//                int numberOfLesson = Integer.parseInt(numberOfLessonsRaw);
//                // Trạng thái
//                String status = request.getParameter("status");
//                // Mô tả
//                String description = request.getParameter("description");
//                
//                Course courseUpdate = new Course(idCourse, subjectName, courseCategory, courseDetail.getThumbnail(), description, user, status, numberOfLesson, featuredSubject, courseDetail.getCreateDate());
//                
//                if( courseDao.updateCourse(courseUpdate) == 1){
//                    response.sendRedirect("coursecontroller?action=detail&id=" + idCourse + "&success=true");
//                    return; // Dừng việc thực thi mã sau khi chuyển hướng
//                } else {
//                    response.sendRedirect("coursecontroller?action=detail&id=" + idCourse + "&success=false");
//                    return;
//                }
//            }
//            request.getRequestDispatcher("subject-details.jsp").forward(request, response);
//        } else {
//            request.getRequestDispatcher("subject-list.jsp").forward(request, response);
//        }
//    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CourseDAO courseDao = new CourseDAO();
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
        HttpSession session = request.getSession();

        String action = request.getParameter("action");
        String service = request.getParameter("service");
        String courseIdParam = request.getParameter("id");
        String pageSubjectList = request.getParameter("pageSubjectList");
        
        

        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "view":
            case "filter":
                handleSubjectList(request, response, session, courseDao, courseCategoryDao, pageSubjectList);
                break;

            case "detail":
                if (service != null && service.equals("updatecourse")) {
                    handleUpdateCourse(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                } else if (service != null && service.equals("updatedimension")) {
                    handleUpdateDimension(request, response, session);
                } else {
                    handleViewCourseDetail(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                }
                break;

            default:
                // Nếu action không xác định, chuyển về trang danh sách mặc định
                handleSubjectList(request, response, session, courseDao, courseCategoryDao, pageSubjectList);
                break;
        }
    }

    private void handleSubjectList(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, CourseDAO courseDao,
            CourseCategoryDAO courseCategoryDao, String pageSubjectList)
            throws ServletException, IOException {

        int indexPageSubjectList = (pageSubjectList == null) ? 1 : Integer.parseInt(pageSubjectList);

        String categoryParam = request.getParameter("category");
        String statusParam = request.getParameter("status");

        if (categoryParam != null) {
            session.setAttribute("currentCategory", categoryParam);
        }
        if (statusParam != null) {
            session.setAttribute("currentStatus", statusParam);
        }

        String currentCategory = (String) session.getAttribute("currentCategory");
        if (currentCategory == null) {
            currentCategory = "allCategory";
        }

        String currentStatus = (String) session.getAttribute("currentStatus");
        if (currentStatus == null) {
            currentStatus = "allStatus";
        }

        List<Course> courseList;
        int totalCourse;

        if (currentCategory.equals("allCategory") && currentStatus.equals("allStatus")) {
            totalCourse = courseDao.getAllCourse().size();
            courseList = courseDao.pagingCourse(indexPageSubjectList);
        } else if (currentCategory.equals("allCategory") && !currentStatus.equals("allStatus")) {
            totalCourse = courseDao.getAllCoureByStatus(currentStatus).size();
            courseList = courseDao.pagingCourseByStatus(indexPageSubjectList, currentStatus);
        } else if (!currentCategory.equals("allCategory") && currentStatus.equals("allStatus")) {
            CourseCategory courseCategory = courseCategoryDao.getCategoryByName(currentCategory);
            if (courseCategory == null) {
                totalCourse = 0;
                courseList = new java.util.ArrayList<>();
            } else {
                int id = courseCategory.getCourseCategory();
                totalCourse = courseDao.getAllCoureByCategory(id).size();
                courseList = courseDao.pagingCourseByCategory(indexPageSubjectList, id);
            }
        } else {
            CourseCategory courseCategory = courseCategoryDao.getCategoryByName(currentCategory);
            if (courseCategory == null) {
                totalCourse = 0;
                courseList = new java.util.ArrayList<>();
            } else {
                int id = courseCategory.getCourseCategory();
                totalCourse = courseDao.getAllCoureByCategoryAndStatus(id, currentStatus).size();
                courseList = courseDao.pagingCourseByCategoryAndStatus(indexPageSubjectList, id, currentStatus);
            }
        }

        int endPage = totalCourse / 5;
        if (totalCourse % 5 != 0) {
            endPage++;
        }

        session.setAttribute("endPage", endPage);
        session.setAttribute("courseList", courseList);

        List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
        session.setAttribute("courseCategoryList", courseCategoryList);

        request.getRequestDispatcher("subject-list.jsp").forward(request, response);
    }

    private void handleViewCourseDetail(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, CourseDAO courseDao,
            CourseCategoryDAO courseCategoryDao, String courseIdParam)
            throws ServletException, IOException {

        if (courseIdParam == null || courseIdParam.isEmpty()) {
            //response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course ID is required to view details.");
            return;
        }

        int courseId = Integer.parseInt(courseIdParam);
        Course courseDetail = courseDao.getCoureByCourseID(courseId);

        if (courseDetail == null) {
            //response.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found.");
            return;
        }
       
        // gửi ra list dimension
        if (session.getAttribute("funtionList") == null) {
            String[] defaultFilters = {"id", "type", "dimension", "action"}; // Đảm bảo đủ các giá trị mặc định
            List<String> defaultFuntionList = Arrays.asList(defaultFilters);
            session.setAttribute("funtionList", defaultFuntionList);
        }

        session.setAttribute("courseDetail", courseDetail);
        List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
        session.setAttribute("courseCategoryList", courseCategoryList);

        request.getRequestDispatcher("subject-details.jsp").forward(request, response);

    }

    private void handleUpdateCourse(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, CourseDAO courseDao,
            CourseCategoryDAO courseCategoryDao, String courseIdParam)
            throws ServletException, IOException {

        if (courseIdParam == null || courseIdParam.isEmpty()) {
            //response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course ID is missing for update.");
            return;
        }

        int idCourse = Integer.parseInt(courseIdParam);

        Course courseDetail = courseDao.getCoureByCourseID(idCourse);
        if (courseDetail == null) {
            //response.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found for update.");
            return;
        }

        UserDAO userDao = new UserDAO();
        User user = userDao.getUser(courseDetail.getOwner().getUserID());

        String subjectName = request.getParameter("subjectName");
        String categoryName = request.getParameter("category");
        CourseCategory courseCategory = courseCategoryDao.getCategoryByName(categoryName);

        int featuredSubject = 0;
        String featuredSubjectRaw = request.getParameter("featuredSubject");
        if (featuredSubjectRaw != null && featuredSubjectRaw.equals("1")) {
            featuredSubject = 1;
        }

        String numberOfLessonsRaw = request.getParameter("numberOfLessons");
        int numberOfLesson = Integer.parseInt(numberOfLessonsRaw);

        String status = request.getParameter("status");
        String description = request.getParameter("description");

        Course courseUpdate = new Course(idCourse, subjectName, courseCategory,
                courseDetail.getThumbnail(), description, user,
                status, numberOfLesson, featuredSubject,
                courseDetail.getCreateDate());

        if (courseDao.updateCourse(courseUpdate) == 1) {
            response.sendRedirect("coursecontroller?action=detail&service=overview&id=" + idCourse + "&success=true");
        } else {
            response.sendRedirect("coursecontroller?action=detail&service=overview&id=" + idCourse + "&success=false");
        }
        return;
    }

    private void handleUpdateDimension(HttpServletRequest request, HttpServletResponse response,
            HttpSession session)
            throws ServletException, IOException {
        
        String[] filter = request.getParameterValues("filter");
        if(filter == null || filter.length == 0){
            filter = new String[] {"id","type","dimension"};
        }
        List<String> funtionList = Arrays.asList(filter);
        
        session.setAttribute("funtionList", funtionList);
        
        
        
        request.getRequestDispatcher("subject-details.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String search = request.getParameter("search");
        CourseDAO courseDao = new CourseDAO();
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();

        if (search != null && !search.trim().isEmpty()) {
            List<Course> courseList = courseDao.searchCourseByNameOrCategory(search);
            session.setAttribute("courseList", courseList);
            session.setAttribute("endPage", 0); // xóa phân trang
            session.removeAttribute("currentCategory");
            session.removeAttribute("currentStatus");
        } else {
            session.removeAttribute("courseList");
            session.removeAttribute("currentCategory");
            session.removeAttribute("currentStatus");

            // Chuyển hướng về doGet để tải lại trang với phân trang như ban đầu
            response.sendRedirect("coursecontroller?action=view");
            return; // Quan trọng để dừng việc thực thi sau khi chuyển hướng
        }
        request.getRequestDispatcher("subject-list.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Mô tả ngắn";
    }

}
