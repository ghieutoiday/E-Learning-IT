/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDAO;
import dal.SubjectDimensionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.SubjectDimension;

/**
 *
 * @author gtrun
 */
@WebServlet(name = "SubjectDimensionController", urlPatterns = {"/subjectdimensioncontroller"})
public class SubjectDimensionController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        SubjectDimensionDAO sdDao = new SubjectDimensionDAO();
        if( action == null){
            action = "view";
        }
        
        switch (action){
            case "view":
            case "add":
                handleAddSubjectDimension(request,response,session, sdDao);
                break;
            case "edit":
                handleUpdateSubjectDimension(request,response,session, sdDao);
                break;
            case "delete":
                handleDeleteSubjectDimension(request,response,session, sdDao);
                break;
                
        }
    }
    
    
    private void handleUpdateSubjectDimension(HttpServletRequest request, HttpServletResponse response, HttpSession session, SubjectDimensionDAO sdDao) throws ServletException, IOException {
        String idSdParam = request.getParameter("dimensionId");
        int idSd = Integer.parseInt(idSdParam);
        SubjectDimension sd = sdDao.getSubjectDimensionByID(idSd);
        session.setAttribute("sd", sd); //gửi sd detail sang update
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        CourseDAO courseDao = new CourseDAO();
        Course course = courseDao.getCoureByCourseID(sd.getCourse().getCourseID());
        SubjectDimension sdUpdate = new SubjectDimension(idSd, course, type, name, description);
        int idCourse = sdDao.getCourseIDBySubjectDimensionID(idSd);
        request.setAttribute("idCourse", idCourse);
        if( sdDao.updateSubjectDimension(sdUpdate) > 0){
//            int idCourse = sdDao.getCourseIDBySubjectDimensionID(idSd);
//            request.setAttribute("idCourse", idCourse);
            response.sendRedirect("subjectdimensioncontroller?action=edit&dimensionId="+ idSd +"&success=true");
            return;
        }else{
            //request.getRequestDispatcher("update-dimension.jsp").forward(request, response);
        }
        
        request.setAttribute("currentAction", "edit");
        
        request.getRequestDispatcher("update-dimension.jsp").forward(request, response);
        return;
    }
    
    private void handleAddSubjectDimension(HttpServletRequest request, HttpServletResponse response, HttpSession session, SubjectDimensionDAO sdDao) throws ServletException, IOException {
        String courseIDParam = request.getParameter("courseID");
        int courseID = Integer.parseInt(courseIDParam);
        SubjectDimension sd = sdDao.getSubjectDimensionByID(courseID);
        session.setAttribute("courseID", courseID); //gửi sd detail sang update
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        CourseDAO courseDao = new CourseDAO();
        Course course = courseDao.getCoureByCourseID(sd.getCourse().getCourseID());
        SubjectDimension sdUpdate = new SubjectDimension(course, type, name, description);
        
        if( sdDao.createSubjectDimension(sdUpdate) > 0){
//            int idCourse = sdDao.getCourseIDBySubjectDimensionID(idSd);
//            request.setAttribute("idCourse", idCourse);
            response.sendRedirect("coursecontroller?action=detail&service=dimension&id=" + courseID); 
            return;
        }else{
            //request.getRequestDispatcher("update-dimension.jsp").forward(request, response);
        }
        
        
        request.setAttribute("currentAction", "add");
        request.getRequestDispatcher("update-dimension.jsp").forward(request, response);
        return;
    }
    
    private void handleDeleteSubjectDimension(HttpServletRequest request, HttpServletResponse response, HttpSession session, SubjectDimensionDAO sdDao) throws ServletException, IOException {
        String idSdParam = request.getParameter("dimensionId");
        int idSd = Integer.parseInt(idSdParam);
        String idCourse = request.getParameter("courseId");
        
        if( sdDao.deleteSubjectDimension(idSd) > 0){
            response.sendRedirect("coursecontroller?action=detail&service=dimension&id=" + idCourse); 
            return;
        } 
        response.sendRedirect("coursecontroller?action=detail&service=dimension&id=" + idCourse); 
        return;
    }
    
    


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
