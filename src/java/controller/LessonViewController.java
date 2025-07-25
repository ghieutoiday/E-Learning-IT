/*
 * Click NBS://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click https://youtu.be/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDAO;
import dal.LessonDAO;
import dal.QuizDAO;
import dal.QuizLessonDTO_DAO;
import dal.UserLessonNotesDAO;
import dal.UserLessonProgressDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;
import model.Course;
import model.Lesson;
import model.Quiz;
import dto.QuizLessonDTO;
import model.User;
import model.UserLessonNotes;
import model.UserLessonProgress;

@WebServlet(name = "LessonViewController", urlPatterns = {"/lessonviewcontroller"})
public class LessonViewController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LessonViewController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền truy cập
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null || user.getRole() == null || user.getRole().getRoleID() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int userID = user.getUserID();

        //Lấy courseID
        String courseID_raw = request.getParameter("courseID");
        int courseID = -1;

        try {
            courseID = Integer.parseInt(courseID_raw);
            //Lấy course đưa sang JSP để mỗi lần chuyển bài học
            //nó vẫn còn courseID ở đó
            Course course = new CourseDAO().getCoureByCourseID(courseID);
            request.setAttribute("choosenCourse", course);
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }

        String form = request.getParameter("form");
        if (form != null && "form".equals(form)) {
            request.setAttribute("form", "form");
        }

        //Lấy 2 tham số này để hiển thị trên tranh tiến độ
        int completedLessons = LessonDAO.getInstance().getTotalNumberOfCompletedLessonInCourse(userID, courseID);
        int totalLessons = LessonDAO.getInstance().getAllSubLessonsByCourseIDOrdered(courseID).size();
        request.setAttribute("completedLessons", completedLessons);
        request.setAttribute("totalLessons", totalLessons);

        //List danh sách các bài học cha
        List<Lesson> listLessonTypeSubjectTopic = LessonDAO.getInstance().getAllSubjectTopicLesson(courseID);
        request.setAttribute("subjectTopicLesson", listLessonTypeSubjectTopic);

        //Danh sách các bài học con tương ứng, dùng MAP với key là các bài học
        //cha để truy vấn bên kia
        Map<Integer, List<Lesson>> subLessonsMap = new HashMap<>();
        for (Lesson topic : listLessonTypeSubjectTopic) {
            List<Lesson> subLessons = LessonDAO.getInstance().getAllLessonBySubjectTopicLesson(topic.getLessonID());
            subLessonsMap.put(topic.getLessonID(), subLessons);
        }
        request.setAttribute("subLessonsMap", subLessonsMap);

        //Lấy 1 lesson chi tiết mà người dùng chọn bên kia thông qua thanh siderbar
        String lessonID_raw = request.getParameter("lessonID");
        if (lessonID_raw == null || lessonID_raw.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Lesson ID is required");
            request.getRequestDispatcher("lesson-view.jsp").forward(request, response);
            return;
        }

        try {
            int lessonID = Integer.parseInt(lessonID_raw);
            Lesson lesson = LessonDAO.getInstance().getLessonByLessonID(lessonID);
            if (lesson == null) {
                request.setAttribute("errorMessage", "Lesson not found");
                request.getRequestDispatcher("lesson-view.jsp").forward(request, response);
                return;
            } else if (lesson.getType().equalsIgnoreCase("Lesson")) {
                request.setAttribute("chooseLesson", lesson);
            } else if (lesson.getType().equalsIgnoreCase("Quiz")) {
                //Lấy thông tin bài Quiz để in ra QuizLesson Form 1
                Quiz quizChoose = QuizDAO.getInstance().getQuizByLessonID(lessonID);
                request.setAttribute("chooseLesson", lesson);
                request.setAttribute("quizChoose", quizChoose);

                //Lấy thông tin bài Quiz để in ra QuizLesson Form 2
                QuizLessonDTO quizLessonDTO = QuizLessonDTO_DAO.getInstance().getQuizLessonDTOByUserIdAndQuizId(userID, quizChoose.getQuizID());
                request.setAttribute("quizLessonDTO", quizLessonDTO);
            }

            UserLessonProgress progress = UserLessonProgressDAO.getInstance().getUserLessonProgressByUserAndLesson(userID, lessonID);
            boolean isLessonCompleted = (progress != null && "Completed".equals(progress.getStatus()));
            request.setAttribute("isLessonCompleted", isLessonCompleted);

            List<Lesson> allLessons = LessonDAO.getInstance().getAllSubLessonsByCourseIDOrdered(courseID);
            int currentIndex = -1;
            for (int i = 0; i < allLessons.size(); i++) {
                if (allLessons.get(i).getLessonID() == lessonID) {
                    currentIndex = i;
                    break;
                }
            }

            int prevLessonID = -1;
            int nextLessonID = -1;
            if (currentIndex > 0) {
                prevLessonID = allLessons.get(currentIndex - 1).getLessonID();
            }
            if (currentIndex >= 0 && currentIndex < allLessons.size() - 1) {
                nextLessonID = allLessons.get(currentIndex + 1).getLessonID();
            }

            request.setAttribute("prevLessonID", prevLessonID);
            request.setAttribute("nextLessonID", nextLessonID);

            List<UserLessonNotes> notes = UserLessonNotesDAO.getInstance().getAllNoteByLessonIdAndUserID(lessonID, userID);
            if (notes != null && !notes.isEmpty()) {
                request.setAttribute("listNotes", notes);
            }

            String editNote = request.getParameter("editNote");
            if (editNote != null) {
                request.setAttribute("editNote", editNote);
                request.setAttribute("editVideoLinks", request.getParameter("editVideoLinks"));
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lessonID format: " + lessonID_raw, e);
            request.setAttribute("errorMessage", "Invalid lesson ID");
            request.getRequestDispatcher("lesson-view.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("lesson-view.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null || user.getRole() == null || user.getRole().getRoleID() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int userId = user.getUserID();
        try {
            if ("startVideo".equals(action)) {
                handleStartVideoRequest(request, response);
            } else if ("completedVideo".equals(action)) {
                handleCompleteVideoRequest(request, response);
            } else if ("checkProgress".equals(action)) {
                handleCheckProgressRequest(request, response);
            } else {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Invalid action");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing POST request", e);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Error: Internal server error");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void handleStartVideoRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String lessonID_raw = request.getParameter("lessonID");
        if (lessonID_raw == null || lessonID_raw.trim().isEmpty()) {
            response.getWriter().write("Error: Lesson ID is required");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null || user.getRole() == null || user.getRole().getRoleID() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int userID = user.getUserID();
        try {

            int lessonID = Integer.parseInt(lessonID_raw);
            Lesson lesson = LessonDAO.getInstance().getLessonByLessonID(lessonID);

            if (lesson == null || !"Lesson".equals(lesson.getType()) || lesson.getContentVideo() == null) {
                response.getWriter().write("Error: Invalid lesson or no video content");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            UserLessonProgressDAO progressDAO = UserLessonProgressDAO.getInstance();
            UserLessonProgress progress = progressDAO.getUserLessonProgressByUserAndLesson(userID, lessonID);

            if (progress == null) {
                progressDAO.createUserLessonProgress(userID, lessonID, "InProgress");
                response.getWriter().write("Progress created");
            } else if (!"InProgress".equals(progress.getStatus()) && !"Completed".equals(progress.getStatus())) {
                response.getWriter().write("Progress exists with different status");
            } else {
                response.getWriter().write("Progress already exists");
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lessonID format: " + lessonID_raw, e);
            response.getWriter().write("Error: Invalid lesson ID");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error handling start video request", e);
            response.getWriter().write("Error: Internal server error");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void handleCompleteVideoRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String lessonID_raw = request.getParameter("lessonID");
        if (lessonID_raw == null || lessonID_raw.trim().isEmpty()) {
            response.getWriter().write("Error: Lesson ID is required");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
            if (user == null || user.getRole() == null || user.getRole().getRoleID() != 1) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            int userID = user.getUserID();

            int lessonID = Integer.parseInt(lessonID_raw);
            Lesson lesson = LessonDAO.getInstance().getLessonByLessonID(lessonID);

            if (lesson == null || !"Lesson".equals(lesson.getType()) || lesson.getContentVideo() == null) {
                response.getWriter().write("Error: Invalid lesson or no video content");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            UserLessonProgressDAO progressDAO = UserLessonProgressDAO.getInstance();
            UserLessonProgress progress = progressDAO.getUserLessonProgressByUserAndLesson(userID, lessonID);

            if (progress != null && "InProgress".equals(progress.getStatus())) {
                progressDAO.updateUserLessonProgressToCompleted(userID, lessonID);
                response.getWriter().write("Progress updated to Completed");
            } else if (progress != null && "Completed".equals(progress.getStatus())) {
                response.getWriter().write("Progress already Completed");
            } else {
                response.getWriter().write("Error: No valid progress to update");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lessonID format: " + lessonID_raw, e);
            response.getWriter().write("Error: Invalid lesson ID");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error handling complete video request", e);
            response.getWriter().write("Error: Internal server error");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void handleCheckProgressRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String lessonID_raw = request.getParameter("lessonID");
        String courseID_raw = request.getParameter("courseID");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null || user.getRole() == null || user.getRole().getRoleID() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int userID = user.getUserID();

        try {
            int courseID = Integer.parseInt(courseID_raw);
            int lessonID = Integer.parseInt(lessonID_raw);
            UserLessonProgress progress = UserLessonProgressDAO.getInstance().getUserLessonProgressByUserAndLesson(userID, lessonID);
            boolean isLessonCompleted = (progress != null && "Completed".equals(progress.getStatus()));
            int completedLessons = LessonDAO.getInstance().getTotalNumberOfCompletedLessonInCourse(userID, courseID);

            // Trả về chuỗi dạng "isLessonCompleted:completedLessons"
            response.getWriter().write(isLessonCompleted + ":" + completedLessons);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lessonID format: " + lessonID_raw, e);
            response.getWriter().write("Error:Invalid lesson ID");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error checking progress", e);
            response.getWriter().write("Error:Internal server error");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles lesson view and progress tracking";
    }
}
