package dal;

import dto.DashboardStatsDTO;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

public class DashboardDAO extends DBContext {

    public DashboardStatsDTO getDashboardData(LocalDate start, LocalDate end) {
        DashboardStatsDTO data = new DashboardStatsDTO();
        try (Connection conn = connection) {
            // a. Số lượng subject mới
            PreparedStatement ps1 = conn.prepareStatement("SELECT COUNT(*) FROM Course WHERE createDate BETWEEN ? AND ?");
            ps1.setDate(1, Date.valueOf(start));
            ps1.setDate(2, Date.valueOf(end));
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                data.setNewSubject(rs1.getInt(1));
            }

            // b. Tổng subject
            PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM Course");
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                data.setAllSubject(rs2.getInt(1));
            }

            // c. Số lượng đăng ký
            PreparedStatement ps3 = conn.prepareStatement(
                    "SELECT "
                    + "SUM(CASE WHEN status = 'Paid' THEN 1 ELSE 0 END) AS paid, "
                    + "SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled, "
                    + "SUM(CASE WHEN status = 'Submitted' THEN 1 ELSE 0 END) AS submitted "
                    + "FROM Registration WHERE registrationTime BETWEEN ? AND ?"
            );
            ps3.setDate(1, Date.valueOf(start));
            ps3.setDate(2, Date.valueOf(end));
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                data.setSuccessfulRegistration(rs3.getInt("paid"));
                data.setCancelledRegistration(rs3.getInt("cancelled"));
                data.setSubmittedRegistration(rs3.getInt("submitted"));
            }

            // d. Tổng doanh thu
            PreparedStatement ps6 = conn.prepareStatement(
                    "SELECT SUM(totalCost) FROM Registration WHERE status = 'Paid' AND registrationTime BETWEEN ? AND ?"
            );
            ps6.setDate(1, Date.valueOf(start));
            ps6.setDate(2, Date.valueOf(end));
            ResultSet rs6 = ps6.executeQuery();
            if (rs6.next()) {
                data.setTotalRevenue(rs6.getInt(1));
            }

            // e. Doanh thu theo category - chuyển từ Map sang List
            PreparedStatement ps7 = conn.prepareStatement(
                    "SELECT cc.courseCategoryName, SUM(r.totalCost) AS revenue "
                    + "FROM Registration r "
                    + "JOIN Course c ON r.courseID = c.courseID "
                    + "JOIN CourseCategory cc ON c.courseCategoryID = cc.courseCategoryID "
                    + "WHERE r.status = 'Paid' AND r.registrationTime BETWEEN ? AND ? "
                    + "GROUP BY cc.courseCategoryName "
                    + "ORDER BY revenue DESC"
            );
            ps7.setDate(1, Date.valueOf(start));
            ps7.setDate(2, Date.valueOf(end));
            ResultSet rs7 = ps7.executeQuery();
            List<String> categoryNames = new ArrayList<>();
            List<Integer> categoryRevenues = new ArrayList<>();
            while (rs7.next()) {
                categoryNames.add(rs7.getString(1));
                categoryRevenues.add(rs7.getInt(2));
            }
            data.setCategoryNames(categoryNames);
            data.setCategoryRevenues(categoryRevenues);

            // f. Số lượng tài khoản mới tạo
            PreparedStatement ps4 = conn.prepareStatement(
                    "SELECT COUNT(*) FROM [User] WHERE createDate BETWEEN ? AND ?"
            );
            ps4.setDate(1, Date.valueOf(start));
            ps4.setDate(2, Date.valueOf(end));
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) {
                data.setNewCustomer(rs4.getInt(1));
            }

            // g. Số lượng user đã đăng ký khóa học trả phí thành công (newBought)
            PreparedStatement ps5 = conn.prepareStatement(
                    "SELECT COUNT(DISTINCT userID) FROM Registration WHERE status = 'Paid' AND registrationTime BETWEEN ? AND ?"
            );
            ps5.setDate(1, Date.valueOf(start));
            ps5.setDate(2, Date.valueOf(end));
            ResultSet rs5 = ps5.executeQuery();
            if (rs5.next()) {
                data.setNewBought(rs5.getInt(1));
            }

            // h. Order trend (biểu đồ)
            PreparedStatement ps8 = conn.prepareStatement(
                    "SELECT CONVERT(VARCHAR, registrationTime, 23) AS day, "
                    + "COUNT(*) AS totalOrders, "
                    + "SUM(CASE WHEN status = 'Paid' THEN 1 ELSE 0 END) AS paidOrders "
                    + "FROM Registration "
                    + "WHERE registrationTime BETWEEN ? AND ? "
                    + "GROUP BY CONVERT(VARCHAR, registrationTime, 23) "
                    + "ORDER BY day"
            );
            ps8.setDate(1, Date.valueOf(start));
            ps8.setDate(2, Date.valueOf(end));
            ResultSet rs8 = ps8.executeQuery();
            List<String> orderLabels = new ArrayList<>();
            List<Integer> orderCounts = new ArrayList<>();
            List<Integer> successfulOrderCounts = new ArrayList<>();
            while (rs8.next()) {
                String day = rs8.getString("day");
                String[] parts = day.split("-");
                String label = parts[1] + "-" + parts[2]; // MM-dd
                orderLabels.add(label);
                orderCounts.add(rs8.getInt("totalOrders"));
                successfulOrderCounts.add(rs8.getInt("paidOrders"));
            }
            data.setOrderLabels(orderLabels);
            data.setOrderCounts(orderCounts);
            data.setSuccessfulOrderCounts(successfulOrderCounts);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
}
