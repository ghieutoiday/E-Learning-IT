package controller;

import dal.SettingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Setting;
import model.User;

@WebServlet(name="SettingController", urlPatterns={"/settingController"})
public class SettingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User userr = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (userr == null || userr.getRole() == null || userr.getRole().getRoleID() !=5) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        SettingDAO settingDAO = new SettingDAO();

        if ("update-status".equals(action)) {
            handleUpdateStatus(request, response, settingDAO);
            return; 
        }
        
        if ("add".equals(action)) {
            request.setAttribute("showAddForm", true);
        }
        
        displaySettingsList(request, response, settingDAO);
    }
    
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response, SettingDAO dao) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            if ("Active".equals(status) || "Inactive".equals(status)) {
                dao.updateSettingStatus(id, status);
            }
        } catch (NumberFormatException e) {
            System.out.println("Lỗi: ID của setting không hợp lệ.");
        }
        response.sendRedirect("settingController");
    }

    private void displaySettingsList(HttpServletRequest request, HttpServletResponse response, SettingDAO dao) throws ServletException, IOException {
        handleNotifications(request);
        String keyword = request.getParameter("search"); 
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");
        
        int pageIndex = 1;
        int pageSize = 5;
        
        try { 
            if (pageStr != null) 
                pageIndex = Integer.parseInt(pageStr); 
        } catch (NumberFormatException e) {}
        
        try { 
            if (pageSizeStr != null) 
                pageSize = Integer.parseInt(pageSizeStr); 
        } catch (NumberFormatException e) {}
        
        List<String> settingTypes = dao.getAllSettingTypes();
        List<Setting> settingsList = dao.getListSetting(keyword, type, status, sortBy, sortOrder, pageIndex, pageSize);
        int totalRecords = dao.getTotalSettings(keyword, type, status);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        
        request.setAttribute("settingTypes", settingTypes);
        request.setAttribute("settingsList", settingsList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("currentSearch", keyword);
        request.setAttribute("currentType", type);
        request.setAttribute("currentStatus", status);
        request.setAttribute("currentSortBy", sortBy);
        
        // SỬA LỖI: Thêm dòng này để gửi lại trạng thái sắp xếp hiện tại cho JSP
        request.setAttribute("currentSortOrder", sortOrder);
        
        request.setAttribute("currentPSize", pageSize);

        request.getRequestDispatcher("settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String type = request.getParameter("type");
        String settingKey = request.getParameter("settingKey");
        String value = request.getParameter("value");
        String description = request.getParameter("description");
        String orderNumStr = request.getParameter("orderNum");
        String status = request.getParameter("status");
        HttpSession session = request.getSession(false);
        User userr = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (userr == null || userr.getRole() == null || userr.getRole().getRoleID() !=5) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        try {
            int orderNum = Integer.parseInt(orderNumStr);
            Setting newSetting = new Setting(0, type, settingKey, value, description, orderNum, status);
            SettingDAO settingDAO = new SettingDAO();
            if (settingDAO.addSetting(newSetting)) {
                response.sendRedirect("settingController?addSuccess=true");
            } else {
                request.setAttribute("error", "Failed to add. The combination of Type and Setting Name might already exist.");
                request.setAttribute("showAddForm", true);
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Order must be a valid number.");
            request.setAttribute("showAddForm", true);
            doGet(request, response);
        }
    }
    
    private void handleNotifications(HttpServletRequest request) {
        if ("true".equals(request.getParameter("addSuccess"))) request.setAttribute("success", "New setting added successfully!");
        if ("true".equals(request.getParameter("updateSuccess"))) request.setAttribute("success", "Setting updated successfully!");
        String error = request.getParameter("error");
        if (error != null) {
            switch (error) {
                case "invalidId": request.setAttribute("error", "Invalid setting ID specified."); break;
                case "notFound": request.setAttribute("error", "The requested setting could not be found."); break;
                case "updateError": request.setAttribute("error", "An error occurred during the update process."); break;
            }
        }
    }
}
