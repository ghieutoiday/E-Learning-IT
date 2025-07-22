/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.QuizHandleDTO_DAO;
import dto.QuizHandleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "QuizHandleController", urlPatterns = {"/quizHandleController"})
public class QuizHandleController extends HttpServlet {
    private static final QuizHandleDTO_DAO QUIZ_HANDLE_DTO_DAO = QuizHandleDTO_DAO.getInstance();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizHandleDTO quizHandleDTO = QUIZ_HANDLE_DTO_DAO.getQuizHandleDTO(4);
        request.setAttribute("quizHandleDTO", quizHandleDTO);
        
        if (request.getParameter("lessonID") == null) {
            response.sendRedirect("index.jsp");
        }
        
        request.setAttribute("lessonID", request.getParameter("lessonID"));
        request.setAttribute("courseID", request.getParameter("courseID"));
        
        request.getRequestDispatcher("quiz-handle.jsp").forward(request, response);
        
        
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
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
