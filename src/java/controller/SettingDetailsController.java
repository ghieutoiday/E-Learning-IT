package controller;

import dal.SettingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Setting;

@WebServlet(name="SettingDetailsController", urlPatterns={"/settingDetailsController"})
public class SettingDetailsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String idStr = request.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            SettingDAO dao = new SettingDAO();
            Setting setting = dao.getSettingById(id);
            
            // KIỂM TRA MỚI: Nếu không tìm thấy setting với ID này trong CSDL
            if (setting == null) {
                // Chuyển hướng về trang danh sách với thông báo lỗi
                response.sendRedirect("settingController?error=notFound");
                return; // Dừng thực thi để tránh lỗi
            }
            
            List<String> settingTypes = dao.getAllSettingTypes();
            
            request.setAttribute("setting", setting);
            request.setAttribute("settingTypes", settingTypes);
            
            request.getRequestDispatcher("setting-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Xử lý trường hợp ID không hợp lệ (ví dụ: không phải là số)
            response.sendRedirect("settingController?error=invalidId");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String type = request.getParameter("type");
            String settingKey = request.getParameter("settingKey");
            String value = request.getParameter("value");
            String description = request.getParameter("description");
            int orderNum = Integer.parseInt(request.getParameter("orderNum"));
            String status = request.getParameter("status");

            Setting updatedSetting = new Setting(id, type, settingKey, value, description, orderNum, status);
            SettingDAO dao = new SettingDAO();
            boolean success = dao.updateSetting(updatedSetting);
            
            if (success) {
                // Nếu thành công, chuyển hướng về trang danh sách với thông báo
                response.sendRedirect("settingController?updateSuccess=true");
            } else {
                // Nếu thất bại, quay lại trang chỉnh sửa và báo lỗi
                request.setAttribute("error", "Failed to update setting. The combination of Type and Setting Name might already exist.");
                request.setAttribute("setting", updatedSetting);
                // Gửi lại danh sách các type để hiển thị dropdown
                List<String> settingTypes = dao.getAllSettingTypes();
                request.setAttribute("settingTypes", settingTypes);
                request.getRequestDispatcher("setting-details.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("settingController?updateError=true");
        }
    }
}
