package controller;

import dal.LessonDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Course;
import model.Lesson;

@WebServlet(name = "LessonDetailControllers", urlPatterns = {"/lessonDetails"})
public class LessonDetailControllers extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lessonIdStr = request.getParameter("lessonId");
        String courseIdStr = request.getParameter("courseId");

        try {
        int courseId = Integer.parseInt(courseIdStr);
        LessonDAO lessonDAO = LessonDAO.getInstance();

        List<Lesson> topics = lessonDAO.getAllSubjectTopicLesson(courseId);
        request.setAttribute("topics", topics);
        request.setAttribute("courseId", courseId);

        Lesson lesson = new Lesson();
        
        if (lessonIdStr != null && !lessonIdStr.isEmpty()) {
            int lessonId = Integer.parseInt(lessonIdStr);
            lesson = lessonDAO.getLessonById(lessonId);
            if (lesson == null || lesson.getCourse().getCourseID() != courseId) {
                response.sendRedirect("errorPage.jsp?msg=Invalid-lesson-for-course");
                return; 
            }
        } else {
            Course currentCourse = new Course();
            currentCourse.setCourseID(courseId);
            lesson.setCourse(currentCourse);
        }

        request.setAttribute("lesson", lesson);
        request.getRequestDispatcher("lesson-details.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        response.getWriter().println("Invalid ID format.");
        e.printStackTrace();
    }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String lessonIdStr = request.getParameter("lessonId");
        String courseIdStr = request.getParameter("courseId");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String topicIdStr = request.getParameter("topicId");
        String orderNumStr = request.getParameter("orderNum");
        String videoLink = request.getParameter("videoLink");
        String htmlContent = request.getParameter("htmlContent");
        String status = request.getParameter("status");

        try {
            LessonDAO lessonDAO = LessonDAO.getInstance();
            Lesson lesson = new Lesson();

            int courseId = Integer.parseInt(courseIdStr);
            Course currentCourse = new Course();
            currentCourse.setCourseID(courseId);
            lesson.setCourse(currentCourse);

            lesson.setName(name);
            lesson.setType(type);
            lesson.setOrderNum(Integer.parseInt(orderNumStr));
            lesson.setContentVideo(videoLink);
            lesson.setContentHtml(htmlContent);
            lesson.setStatus(status != null ? status : "Active");
            lesson.setDuration(0);

            if (topicIdStr != null && !topicIdStr.isEmpty()) {
                Lesson topic = new Lesson();
                topic.setLessonID(Integer.parseInt(topicIdStr));
                lesson.setTopic(topic);
            } else {
                lesson.setTopic(null);
            }

            if (lessonIdStr != null && !lessonIdStr.trim().isEmpty() && !lessonIdStr.equals("0")) {
                lesson.setLessonID(Integer.parseInt(lessonIdStr));
                lessonDAO.updateLesson(lesson);
            } else {
                lessonDAO.addLesson(lesson);
            }


            response.sendRedirect("lesson-list?courseId=" + courseId);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            doGet(request, response);
        }
    }
}
