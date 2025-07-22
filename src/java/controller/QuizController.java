/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDAO;
import dal.QuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Course;
import model.Quiz;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "QuizController", urlPatterns = {"/quizcontroller"})
public class QuizController extends HttpServlet {

    private static final CourseDAO courseDAO = new CourseDAO();
    private static final int QUIZZES_PER_PAGE = 5;

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    String search = request.getParameter("search");
                    String courseID_raw = request.getParameter("filterbysubject");
                    int courseID;
                    if (courseID_raw != null && !courseID_raw.isEmpty()) {
                        courseID = Integer.parseInt(courseID_raw);
                    } else {
                        courseID = -1;
                    }
                    String quizType = request.getParameter("quiztype");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int rowsPerPage = request.getParameter("rowsPerPage") != null ? Integer.parseInt(request.getParameter("rowsPerPage")) : QUIZZES_PER_PAGE;

                    // Column visibility parameters
                    boolean hideID = "true".equals(request.getParameter("hideID"));
                    boolean hideSubject = "true".equals(request.getParameter("hideSubject"));
                    boolean hideLevel = "true".equals(request.getParameter("hideLevel"));
                    boolean hideNOQ = "true".equals(request.getParameter("hideNOQ"));
                    boolean hideDuration = "true".equals(request.getParameter("hideDuration"));
                    boolean hidePassRate = "true".equals(request.getParameter("hidePassRate"));
                    boolean hideQuizType = "true".equals(request.getParameter("hideQuizType"));

                    List<Quiz> listAllQuiz = QuizDAO.getInstance().getFilteredQuizzes(search, courseID, quizType, page, rowsPerPage);
                    int totalQuiz = QuizDAO.getInstance().getTotalFilteredQuizzes(search, courseID, quizType);
                    int totalPages = (totalQuiz + rowsPerPage - 1) / rowsPerPage;
                    request.setAttribute("totalQuiz", totalQuiz);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("search", search);
                    request.setAttribute("filterbysubject", courseID_raw);
                    request.setAttribute("quiztype", quizType);
                    request.setAttribute("rowsPerPage", rowsPerPage);
                    request.setAttribute("totalPages", totalPages);
                    

                    request.setAttribute("hideID", hideID);
                    request.setAttribute("hideSubject",hideSubject);
                    request.setAttribute("hideLevel",hideLevel);
                    request.setAttribute("hideNOQ",hideNOQ);
                    request.setAttribute("hideDuration",hideDuration);
                    request.setAttribute("hidePassRate",hidePassRate);
                    request.setAttribute("hideQuizType",hideQuizType);

                    request.setAttribute("listAllQuiz", listAllQuiz);

                    List<Course> listCourse = courseDAO.getAllCoureByStatus("active");
                    request.setAttribute("listAllCourse", listCourse);

                    List<String> listQuizType = QuizDAO.getInstance().getAllQuizType();
                    request.setAttribute("listAllQuizType", listQuizType);

                    request.getRequestDispatcher("/admin/quizzeslist.jsp").forward(request, response);

                    break;
                default:
                    throw new AssertionError();
            }
        } catch (Exception e) {
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

}
