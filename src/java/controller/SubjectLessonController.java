package controller;

import dal.CourseDAO;
import dal.LessonDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Course;
import model.Lesson;

@WebServlet(name = "SubjectLessonController", urlPatterns = {"/subjectLesson"})
public class SubjectLessonController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("add")) {
            showAddLessonForm(request, response);
        } else if (action != null && (action.equals("deactivate") || action.equals("activate"))) {
            handleStatusChange(request, response);
        } else {
            showLessonList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action != null && action.equals("save")) {
            saveNewLesson(request, response);
        } else {
            showLessonList(request, response);
        }
    }

    private void showLessonList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId;
        try {
            courseId = Integer.parseInt(request.getParameter("courseId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
            return;
        }

        CourseDAO courseDAO = new CourseDAO();
        Course currentCourse = courseDAO.getCourseByIdd(courseId);

        if (currentCourse == null) {
            response.sendRedirect("home");
            return;
        }

        LessonDAO lessonDAO = LessonDAO.getInstance();

        String searchQuery = request.getParameter("search");
        String status = request.getParameter("status");
        String topicFilterIdRaw = request.getParameter("topicFilterId");
        String pageRaw = request.getParameter("page");

        Integer topicFilterId = null;
        if (topicFilterIdRaw != null && !topicFilterIdRaw.isEmpty() && !topicFilterIdRaw.equals("0")) {
            try {
                topicFilterId = Integer.parseInt(topicFilterIdRaw);
            } catch (NumberFormatException e) {
                topicFilterId = null;
            }
        }

        List<Lesson> topicList = lessonDAO.getAllSubjectTopicLesson(courseId);

        int pageIndex = 1;
        if (pageRaw != null && !pageRaw.isEmpty()) {
            try {
                pageIndex = Integer.parseInt(pageRaw);
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }
        int pageSize = 5;

        int totalLessons = lessonDAO.countLessonsByCourse(courseId, searchQuery, topicFilterId, status);
        int totalPages = (int) Math.ceil((double) totalLessons / pageSize);

        List<Lesson> lessonList = lessonDAO.getLessonsByCourse(courseId, searchQuery, topicFilterId, status, pageIndex, pageSize);

        request.setAttribute("course", currentCourse);
        request.setAttribute("lessonList", lessonList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("topicList", topicList);
        request.setAttribute("selectedTopicId", topicFilterId);

        // =============================================================
        // --- PHẦN ĐÃ SỬA: ĐỌC THÔNG BÁO TỪ SESSION ---
        // =============================================================
        HttpSession session = request.getSession();
        if (session.getAttribute("successMessage") != null) {
            request.setAttribute("successMessage", session.getAttribute("successMessage"));
            session.removeAttribute("successMessage");
        }
        // =============================================================

        request.getRequestDispatcher("manage-lessons.jsp").forward(request, response);
    }

    private void showAddLessonForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        LessonDAO lessonDAO = LessonDAO.getInstance();
        List<Lesson> topics = lessonDAO.getAllSubjectTopicLesson(courseId);

        request.setAttribute("courseId", courseId);
        request.setAttribute("topics", topics);
        request.setAttribute("action", "add");

        request.getRequestDispatcher("manage-lessons.jsp").forward(request, response);
    }

    private void saveNewLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId = 0;
        try {
            courseId = Integer.parseInt(request.getParameter("courseId"));
            String lessonName = request.getParameter("lessonName");
            String lessonType = request.getParameter("lessonType");
            int orderNum = Integer.parseInt(request.getParameter("orderNum"));
            String status = request.getParameter("status");
            int topicId = Integer.parseInt(request.getParameter("topicId"));
            String videoUrl = request.getParameter("videoUrl");
            String htmlContent = request.getParameter("htmlContent");
            int duration = Integer.parseInt(request.getParameter("duration"));

            LessonDAO lessonDAO = LessonDAO.getInstance();

            Course course = new Course();
            course.setCourseID(courseId);

            Lesson topic = null;
            if (topicId > 0) {
                topic = new Lesson();
                topic.setLessonID(topicId);
            }

            Lesson newLesson = new Lesson(0, course, topic, lessonName, lessonType, orderNum, status, videoUrl, htmlContent, duration);

            lessonDAO.addLesson(newLesson);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "New lesson '" + lessonName + "' has been added successfully!");
            
            response.sendRedirect("subjectLesson?courseId=" + courseId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding lesson: " + e.getMessage());

            request.setAttribute("courseId", courseId);
            LessonDAO lessonDAO = LessonDAO.getInstance();
            List<Lesson> topics = lessonDAO.getAllSubjectTopicLesson(courseId);
            request.setAttribute("topics", topics);
            request.setAttribute("action", "add");

            request.getRequestDispatcher("manage-lessons.jsp").forward(request, response);
        }
    }

    private void handleStatusChange(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String action = request.getParameter("action");

            String newStatus = action.equals("deactivate") ? "Inactive" : "Active";
            String successMessage = "Lesson status has been updated to '" + newStatus + "' successfully!";

            LessonDAO lessonDAO = LessonDAO.getInstance();
            lessonDAO.updateLessonStatus(lessonId, newStatus);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", successMessage);

            response.sendRedirect("subjectLesson?courseId=" + courseId);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}