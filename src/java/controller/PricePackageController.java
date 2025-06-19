/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDAO;
import dal.PricePackageDAO;
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
import model.PricePackage;

/**
 *
 * @author gtrun
 */
@WebServlet(name = "PricePackageController", urlPatterns = {"/pricepackagecontroller"})
public class PricePackageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        PricePackageDAO pDao = new PricePackageDAO();
        if( action == null){
            action = "view";
        }
        
        switch (action){
            case "view":
            case "add":
                handleAddPricePackage(request,response,session, pDao);
                break;
            case "edit":
                handleUpdatePricePackage(request,response,session, pDao);
                break;
            case "delete":
                handleDeletePricePackage(request,response,session, pDao);
                break;
                
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void handleAddPricePackage(HttpServletRequest request, HttpServletResponse response, HttpSession session, PricePackageDAO pDao) throws ServletException, IOException {
        String courseIdParam = request.getParameter("courseId");
        int courseId = Integer.parseInt(courseIdParam);
        session.setAttribute("courseId", courseId);
        //lấy các giá trị 
        String addPricePackage = request.getParameter("addPricePackage");
        if( addPricePackage != null){
        String name = request.getParameter("name");
        String accessDurationParam = request.getParameter("accessDuration");
        int accessDuration = Integer.parseInt(accessDurationParam);
        String listPriceParam = request.getParameter("listPrice");
        String salePriceParam = request.getParameter("salePrice");
        double listPrice = Double.parseDouble(listPriceParam);
        double salePrice = Double.parseDouble(salePriceParam);
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        CourseDAO courseDao = new CourseDAO();
        Course course = courseDao.getCoureByCourseID(courseId);
        PricePackage pricePackage = new PricePackage(course, name, accessDuration, listPrice, salePrice, description, status);
        if( pDao.insertPricePackage(pricePackage) > 0){
            response.sendRedirect("coursecontroller?action=detail&service=pricepackage&id=" + courseId);
            return;
        }
        }
        request.setAttribute("currentAction", "add");
        request.getRequestDispatcher("update-pricepackage.jsp").forward(request, response);
        return;
    }

    private void handleDeletePricePackage(HttpServletRequest request, HttpServletResponse response, HttpSession session, PricePackageDAO pDao) throws ServletException, IOException {
        String courseIdParam = request.getParameter("courseId");
        int courseId = Integer.parseInt(courseIdParam);
        session.setAttribute("courseId", courseId);
        String pricepackageId = request.getParameter("pricepackageId");
        if( pDao.deletePricePackage(Integer.parseInt(pricepackageId)) > 0){
            response.sendRedirect("coursecontroller?action=detail&service=pricepackage&id=" + courseId + "&succes=true");
            return;
        }
        //response.sendRedirect("coursecontroller?action=detail&service=pricepackage&id=" + courseId);
    }
    
    private void handleUpdatePricePackage(HttpServletRequest request, HttpServletResponse response, HttpSession session, PricePackageDAO pDao) throws ServletException, IOException {
    // Lấy courseId và pricepackageId từ request.
    // Lần submit form, chúng sẽ có giá trị từ input hidden trong JSP.
    String courseIdParam = request.getParameter("courseId");
    int courseId = Integer.parseInt(courseIdParam); // Giả định luôn là số hợp lệ

    // Đặt vào session để JSP có thể hiển thị dữ liệu ban đầu hoặc khi load lại
    session.setAttribute("courseId", courseId);

    String pricepackageIdParam = request.getParameter("pricepackageId");
    int pricepackageId = Integer.parseInt(pricepackageIdParam); // Giả định luôn là số hợp lệ

    // Lấy PricePackage từ DAO và đặt vào session để JSP hiển thị thông tin
    PricePackage pp = pDao.getPricePackageByPricePackageID(pricepackageId);
    session.setAttribute("pp", pp);

    // Kiểm tra xem đây có phải là yêu cầu submit form cập nhật hay không
    String updatePricePackage = request.getParameter("updatePricePackage");
    if (updatePricePackage != null) {
        // Lấy các tham số từ form
        String PricePackageID = request.getParameter("PricePackageID");
        String name = request.getParameter("name");
        String accessDurationParam = request.getParameter("accessDuration");
        String listPriceParam = request.getParameter("listPrice");
        String salePriceParam = request.getParameter("salePrice");
        String description = request.getParameter("description");
        String status = request.getParameter("status");


        int accessDuration = Integer.parseInt(accessDurationParam);
        double listPrice = Double.parseDouble(listPriceParam);
        double salePrice = Double.parseDouble(salePriceParam);

        // Lấy thông tin Course để tạo đối tượng PricePackage
        CourseDAO courseDao = new CourseDAO();
        Course course = courseDao.getCoureByCourseID(courseId);
        PricePackage pricePackage = new PricePackage(Integer.parseInt(PricePackageID), course, name, accessDuration, listPrice, salePrice, description, status);

        // Cập nhật vào cơ sở dữ liệu
        if (pDao.updatePricePackage(pricePackage) > 0) {
            // Chuyển hướng về lại trang chỉnh sửa với ID của khóa học và gói giá vừa cập nhật
            response.sendRedirect("pricepackagecontroller?action=edit&courseId=" + courseId + "&pricepackageId=" + pricepackageId);
            return; 
        }
    }
    // Nếu không phải submit form cập nhật (lần đầu vào trang) hoặc cập nhật không thành công,
    // thì forward đến trang JSP để hiển thị form
    request.setAttribute("currentAction", "edit");
    request.getRequestDispatcher("update-pricepackage.jsp").forward(request, response);
    return;
}

}
