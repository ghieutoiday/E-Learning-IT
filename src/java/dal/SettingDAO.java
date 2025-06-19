package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Setting;

public class SettingDAO extends DBContext {

    public SettingDAO() {
        super();
    }

    /**
     * Thêm một cài đặt mới vào cơ sở dữ liệu.
     * @param setting Đối tượng Setting chứa thông tin cần thêm.
     * @return true nếu thêm thành công, false nếu thất bại.
     */
    public boolean addSetting(Setting setting) {
        String sql = "INSERT INTO [dbo].[Setting] ([type], [settingKey], [value], [description], [orderNum], [status]) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, setting.getType());
            ps.setString(2, setting.getSettingKey());
            ps.setString(3, setting.getValue());
            ps.setString(4, setting.getDescription());
            ps.setInt(5, setting.getOrderNum());
            ps.setString(6, setting.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi tại addSetting: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Cập nhật thông tin của một setting.
     * @param Đối tượng Setting chứa thông tin đã được chỉnh sửa.
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateSetting(Setting setting) {
        String sql = "UPDATE [dbo].[Setting] SET [type] = ?, [settingKey] = ?, [value] = ?, [description] = ?, [orderNum] = ?, [status] = ? WHERE [settingID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, setting.getType());
            ps.setString(2, setting.getSettingKey());
            ps.setString(3, setting.getValue());
            ps.setString(4, setting.getDescription());
            ps.setInt(5, setting.getOrderNum());
            ps.setString(6, setting.getStatus());
            ps.setInt(7, setting.getSettingID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi tại updateSetting: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Lấy thông tin chi tiết của một setting dựa vào ID.
     * @param ID của setting cần tìm.
     * @return một đối tượng Setting nếu tìm thấy, ngược lại trả về null.
     */
    public Setting getSettingById(int id) {
        String sql = "SELECT * FROM [Setting] WHERE settingID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Setting(
                        rs.getInt("settingID"), rs.getString("type"), rs.getString("settingKey"),
                        rs.getString("value"), rs.getString("description"), rs.getInt("orderNum"), rs.getString("status")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi tại getSettingById: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Cập nhật trạng thái của một setting.
     * @param settingId ID của setting cần cập nhật.
     * @param newStatus Trạng thái mới ('Active' hoặc 'Inactive').
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateSettingStatus(int settingId, String newStatus) {
        String sql = "UPDATE [dbo].[Setting] SET [status] = ? WHERE [settingID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, settingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi tại updateSettingStatus: " + e.getMessage());
            return false;
        }
    }

    /**
     * Lấy tất cả các 'type' (nhóm cài đặt) duy nhất để đổ vào dropdown.
     * @return Danh sách các chuỗi là tên của các type.
     */
    public List<String> getAllSettingTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT type FROM [Setting] ORDER BY type";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                types.add(rs.getString("type"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi tại getAllSettingTypes: " + e.getMessage());
        }
        return types;
    }

    /**
     * Lấy danh sách setting để hiển thị, có hỗ trợ tìm kiếm, lọc, sắp xếp và phân trang.
     * @return Danh sách các đối tượng Setting.
     */
    public List<Setting> getListSetting(String keyword, String type, String status, String sortBy, String sortOrder, int page, int pageSize) {
    List<Setting> list = new ArrayList<>();
    
    try {
        int offset = (page - 1) * pageSize;
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM [Setting] WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sqlBuilder.append(" AND (settingKey LIKE ? OR value LIKE ?)");
        }
        if (type != null && !type.trim().isEmpty() && !type.equalsIgnoreCase("all")) {
            sqlBuilder.append(" AND type = ?");
        }
        if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("all")) {
            sqlBuilder.append(" AND status = ?");
        }

        String orderColumn = "settingID";
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            if (sortBy.equalsIgnoreCase("type")) {
                 sortBy = "settingKey"; 
            }
            switch (sortBy.toLowerCase()) {
                case "settingkey": orderColumn = "settingKey"; break;
                case "value":      orderColumn = "value";      break;
                case "ordernum":   orderColumn = "orderNum";   break;
                case "status":     orderColumn = "status";     break;
            }
        }
        
        sqlBuilder.append(" ORDER BY ").append(orderColumn);
        
        if (sortOrder != null && sortOrder.equalsIgnoreCase("desc")) {
            sqlBuilder.append(" DESC");
        } else {
            sqlBuilder.append(" ASC");
        }

        sqlBuilder.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        PreparedStatement ps = connection.prepareStatement(sqlBuilder.toString());
        int index = 1;

        if (keyword != null && !keyword.trim().isEmpty()) {
            String likeKeyword = "%" + keyword.trim() + "%";
            ps.setString(index++, likeKeyword);
            ps.setString(index++, likeKeyword);
        }
        if (type != null && !type.trim().isEmpty() && !type.equalsIgnoreCase("all")) {
            ps.setString(index++, type);
        }
        if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("all")) {
            ps.setString(index++, status);
        }
        
        ps.setInt(index++, offset);
        ps.setInt(index++, pageSize);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Setting setting = new Setting(
                rs.getInt("settingID"), 
                rs.getString("type"), 
                rs.getString("settingKey"), 
                rs.getString("value"), 
                rs.getString("description"), 
                rs.getInt("orderNum"), 
                rs.getString("status")
            );
            list.add(setting);
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return list;
}

    /**
     * Lấy tổng số setting để phân trang.
     * @return Tổng số setting thỏa mãn điều kiện lọc.
     */
    public int getTotalSettings(String keyword, String type, String status) {
        int total = 0;
        try {
            StringBuilder sqlBuilder = new StringBuilder("SELECT COUNT(*) FROM [Setting] WHERE 1=1");
            if (keyword != null && !keyword.trim().isEmpty()) sqlBuilder.append(" AND (settingKey LIKE ? OR value LIKE ?)");
            if (type != null && !type.trim().isEmpty() && !type.equalsIgnoreCase("all")) sqlBuilder.append(" AND type = ?");
            if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("all")) sqlBuilder.append(" AND status = ?");
            PreparedStatement ps = connection.prepareStatement(sqlBuilder.toString());
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword.trim() + "%";
                ps.setString(index++, likeKeyword);
                ps.setString(index++, likeKeyword);
            }
            if (type != null && !type.trim().isEmpty() && !type.equalsIgnoreCase("all")) ps.setString(index++, type);
            if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("all")) ps.setString(index++, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
