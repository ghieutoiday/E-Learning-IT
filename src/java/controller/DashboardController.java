package controller;

import dal.DashboardDAO;
import dto.DashboardStatsDTO;

import java.io.IOException;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null || user.getRole() == null || user.getRole().getRoleID() != 2) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        //Kiểm tra hợp lệ của ngày nếu cả 2 đều được truyền vào
        if (startDateStr != null && endDateStr != null) {
            try {
                LocalDate startDate = LocalDate.parse(startDateStr);
                LocalDate endDate = LocalDate.parse(endDateStr);
                // Nếu ngày bắt đầu sau ngày kết thúc thì báo lỗi
                if (startDate.isAfter(endDate)) {
                    request.setAttribute("error", "Start date cannot be after end date.");
                    request.getRequestDispatcher("/admin/index-mkt.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format.");
                request.getRequestDispatcher("/admin/index-mkt.jsp").forward(request, response);
                return;
            }
        }
        // Xử lý ngày mặc định nếu không có giá trị
        LocalDate endDate = (endDateStr != null && !endDateStr.isEmpty()) ? LocalDate.parse(endDateStr) : LocalDate.now();
        LocalDate startDate = (startDateStr != null && !startDateStr.isEmpty()) ? LocalDate.parse(startDateStr) : endDate.minusMonths(1).plusDays(1);
        // Gọi DAO để lấy dữ liệu thống kê
        DashboardDAO dao = new DashboardDAO();
        DashboardStatsDTO stats = dao.getDashboardData(startDate, endDate);

        request.setAttribute("user", user);
        request.setAttribute("dashboardStats", stats);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.getRequestDispatcher("/admin/index-mkt.jsp").forward(request, response);
    }
}
