package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import dal.PricePackageDAO;
import dal.SubjectDimensionDAO;
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
import model.PricePackage;
import model.SubjectDimension;
import model.User;

@WebServlet(name = "CourseController", urlPatterns = {"/coursecontroller"})
public class CourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CourseDAO courseDao = new CourseDAO();
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
        SubjectDimensionDAO subjectDimensionDAO = new SubjectDimensionDAO();
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

            case "detail": // là trang detail
                if (service != null) { // các service trong details
                    switch (service) {
                        case "overview":
                            session.setAttribute("serviceActiveTab", "overview");
                            handleViewCourseDetail(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                            break;
                        case "updatecourse":
                            session.setAttribute("serviceActiveTab", "overview");
                            handleUpdateCourse(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                            break;
                        case "dimension":
                            session.setAttribute("serviceActiveTab", "dimension");
                            handleViewDimensionDetail(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                            break;
                        case "updatedimension":
                            session.setAttribute("serviceActiveTab", "dimension");
                            handleUpdateDimension(request, response, session, subjectDimensionDAO);
                            break;
                        case "pricepackage":
                            session.setAttribute("serviceActiveTab", "pricepackage");
                            handleViewPricePackage(request, response, session, courseDao);
                            break;
                        default:
                            session.setAttribute("serviceActiveTab", "overview");
                            handleViewCourseDetail(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                            break;
                    }
                } else {
                    // If no service parameter, default to overview tab for detail view
                    session.setAttribute("serviceActiveTab", "overview");
                    handleViewCourseDetail(request, response, session, courseDao, courseCategoryDao, courseIdParam);
                }
                break;

            default:
                // If action is unrecognized, redirect to default subject list page
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
        
        String thumbnailUrl = request.getParameter("thumbnailUrl");

        Course courseUpdate = new Course(idCourse, subjectName, courseCategory,
                thumbnailUrl, description, user,
                status, numberOfLesson, featuredSubject,
                courseDetail.getCreateDate());

        if (courseDao.updateCourse(courseUpdate) == 1) {
            response.sendRedirect("coursecontroller?action=detail&service=overview&id=" + idCourse + "&success=true");
            //request.getRequestDispatcher("coursecontroller?action=detail&service=overview&id=" + idCourse + "&success=true").forward(request, response);
        } else {
            response.sendRedirect("coursecontroller?action=detail&service=overview&id=" + idCourse + "&success=false");
        }
        return;
    }

    private void handleUpdateDimension(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, SubjectDimensionDAO subjectDimensionDAO)
            throws ServletException, IOException {

        String[] filter = request.getParameterValues("filter");
        if (filter == null || filter.length == 0) {
            filter = new String[]{"Id", "Type", "Name", "Description", "Action"};
            String currentID = request.getParameter("id");
            session.setAttribute("currentID", currentID); // set id hiện tại nếu filter = null;
        }

        List<String> funtionList = Arrays.asList(filter);
        for (String string : funtionList) {
            if (string.equals("Id")) {
                request.setAttribute("idSubjectDimension", "id");
            }
            if (string.equals("Type")) {
                request.setAttribute("typeSubjectDimension", "type");
            }
            if (string.equals("Name")) {
                request.setAttribute("nameSubjectDimension", "name");
            }
            if (string.equals("Description")) {
                request.setAttribute("descriptionSubjectDimension", "description");
            }
            if (string.equals("Action")) {
                request.setAttribute("actionSubjectDimension", "action");
            }
        }

        session.setAttribute("funtionList", funtionList);
        String id = request.getParameter("id");
        List<SubjectDimension> listSubjectDimension = subjectDimensionDAO.getAllSubjectDimensionsByCourseID(Integer.parseInt(id));
        session.setAttribute("listSubjectDimension", listSubjectDimension);

        session.removeAttribute("currentID");

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

    private void handleViewPricePackage(HttpServletRequest request, HttpServletResponse response, HttpSession session, CourseDAO courseDao) throws ServletException, IOException {
        PricePackageDAO pDao = new PricePackageDAO();
        List<PricePackage> listPricePackage;
        String courseIdParam = request.getParameter("id");
        int courseId = Integer.parseInt(courseIdParam);
        session.setAttribute("courseIdOfPricePackage", courseId);
        int totalPricePackage = pDao.getTotalPricePackageByCourseID(courseId);
        String pagePricePackage = request.getParameter("pagePricePackage");
        int indexPagePricePackage = (pagePricePackage == null) ? 1 : Integer.parseInt(pagePricePackage);
        //String a = "coursecontroller?action=detail&service=pricepackage&id=1";
        //session.setAttribute("id", courseId);
        listPricePackage = pDao.pagingPricePackage(courseId, indexPagePricePackage);

        int endPagePrice = totalPricePackage / 3;
        if (totalPricePackage % 3 != 0) {
            endPagePrice++;
        }
        session.setAttribute("endPagePrice", endPagePrice);
        session.setAttribute("listPricePackage", listPricePackage);
        request.getRequestDispatcher("subject-details.jsp").forward(request, response);
        return;
    }

    private void handleViewDimensionDetail(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, CourseDAO courseDao,
            CourseCategoryDAO courseCategoryDao, String courseIdParam)
            throws ServletException, IOException {
        
        if (courseIdParam == null || courseIdParam.isEmpty()) {
            return;
        }
        int courseId = Integer.parseInt(courseIdParam);
        session.setAttribute("courseIdOfDimension", courseId);

        Course courseDetail = courseDao.getCoureByCourseID(courseId);
        if (courseDetail == null) {
            return;
        }

        // Lấy các filter đã chọn từ request.getParameterValues("filter")
        String[] selectedFilters = request.getParameterValues("filter");
        List<String> currentFuntionList = new ArrayList<>();

        // Đặt các thuộc tính requestScope dựa trên các filter đã chọn
        if (selectedFilters != null) {
            for (String filter : selectedFilters) {
                currentFuntionList.add(filter); // Thêm vào list để hiển thị header
                switch (filter) {
                    case "Id":
                        request.setAttribute("idSubjectDimension", "id");
                        break;
                    case "Type":
                        request.setAttribute("typeSubjectDimension", "type");
                        break;
                    case "Name":
                        request.setAttribute("nameSubjectDimension", "name");
                        break;
                    case "Description":
                        request.setAttribute("descriptionSubjectDimension", "description");
                        break;
                    case "Action":
                        request.setAttribute("actionSubjectDimension", "action");
                        break;
                }
            }
        } else {
            // Nếu không có filter nào được chọn (lần đầu tải trang hoặc tất cả bị bỏ chọn),
            // Để giữ mặc định ban đầu:
            String[] defaultFilters = {"Id", "Type", "Name", "Description", "Action"};
            for (String filter : defaultFilters) {
                currentFuntionList.add(filter);
                switch (filter) {
                    case "Id":
                        request.setAttribute("idSubjectDimension", "id");
                        break;
                    case "Type":
                        request.setAttribute("typeSubjectDimension", "type");
                        break;
                    case "Name":
                        request.setAttribute("nameSubjectDimension", "name");
                        break;
                    case "Description":
                        request.setAttribute("descriptionSubjectDimension", "description");
                        break;
                    case "Action":
                        request.setAttribute("actionSubjectDimension", "action");
                        break;
                }
            }
        }
        session.setAttribute("funtionList", currentFuntionList); // Sử dụng currentFuntionList cho header

        SubjectDimensionDAO subjectDimensionDAO = new SubjectDimensionDAO();

        String rowDisplayParam = request.getParameter("rowDisplay");
        int rowDisplay = 2; // Giá trị mặc định = 2
        if (rowDisplayParam != null && !rowDisplayParam.isEmpty()) {
            try {
                rowDisplay = Integer.parseInt(rowDisplayParam);
                if (rowDisplay < 1) {
                    rowDisplay = 2; // Đảm bảo rowDisplay không âm hoặc 0
                }
            } catch (NumberFormatException e) {
                rowDisplay = 2; // Quay về mặc định nếu input không hợp lệ
            }
        }
        session.setAttribute("currentRowDisplayDimension", rowDisplay); // Lưu rowDisplay vào session để dùng lại

        int totalDimension = subjectDimensionDAO.getTotalSubjectDimensionByCourseID(courseId);
        String pageDimension = request.getParameter("pageDimension");
        int indexPageDimension = (pageDimension == null || pageDimension.isEmpty()) ? 1 : Integer.parseInt(pageDimension);

        List<SubjectDimension> listSubjectDimension = subjectDimensionDAO.pagingSubjectDimension(courseId, indexPageDimension, rowDisplay);
        session.setAttribute("listSubjectDimension", listSubjectDimension);

        int endPageDimension = totalDimension / rowDisplay;
        if( endPageDimension % 2 != 0){
                endPageDimension = endPageDimension + 1;
        }
        session.setAttribute("totalDimension", totalDimension);
        if (endPageDimension == 0 && totalDimension > 0) {
            endPageDimension = 1;
        }
        session.setAttribute("endPageDimension", endPageDimension);
        session.setAttribute("currentIndexPageDimension", indexPageDimension); // Lưu trang hiện tại vào session

        request.getRequestDispatcher("subject-details.jsp").forward(request, response);
    }

}
