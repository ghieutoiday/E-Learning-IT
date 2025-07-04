/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Course;
import model.PricePackage;
import model.Registration;
import model.User;

/**
 *
 * @author ASUS
 */
public class RegistrationDAO extends DBContext {

    private static RegistrationDAO instance;

    public static RegistrationDAO getInstance() {

        if (instance == null) {
            instance = new RegistrationDAO();
        }

        return instance;
    }

    UserDAO userDAO = new UserDAO();
    CourseDAO courseDAO = new CourseDAO();
    PricePackageDAO pricePackageDAO = new PricePackageDAO();

    public RegistrationDAO() {
        super();
    }

    public Registration getRegistrationByRegistrationID(int registrationID) {
        Registration registration = null;
        try {
            String sql = "Select * from Registration where registrationID = " + registrationID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không

                User user = userDAO.getUserByID(rs.getInt(2));
                User lastUpdateBy = userDAO.getUserByID(rs.getInt(3));
                Course course = courseDAO.getCoureByCourseID(rs.getInt(4));
                PricePackage pricePackage = pricePackageDAO.getPricePackageByPricePackageID(rs.getInt(5));
                double totalCost = rs.getDouble(6);
                String status = rs.getString(7);
                Date registrationTime = rs.getDate(8);
                Date validFrom = rs.getDate(9);
                Date validTo = rs.getDate(10);
                String note = rs.getString(11);

                //Lấy entity
                registration = new Registration(registrationID, user, lastUpdateBy, course, pricePackage, totalCost, status, registrationTime, validFrom, validTo, note);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return registration;
    }

    public List<Registration> getAllRegistration() {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy ra hết Registration theo courseID
    //để từ đó thực hiện chức năng lấy Registration theo courseCategoryID
    public List<Registration> getAllRegistrationByCourseID(int courseID) {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration where courseID =" + courseID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    //Hàm của thịnh
    public List<Registration> getRegistrationsByAllFilters(String emailSearch, String courseName, String name, String status, String sortBy, String sortOrder) {
        List<Registration> list = new ArrayList<>();

        try {
            StringBuilder sql = new StringBuilder
                     ("SELECT * FROM Registration r "
                    + "JOIN [User] u ON r.userID = u.userID "
                    + "JOIN Course c ON r.courseID = c.courseID "
                    + "JOIN PricePackage p ON r.pricePackageID = p.pricePackageID "
                    + "LEFT JOIN [User] lu ON r.lastUpdateBy = lu.userID " // lấy tất cả các bản ghi từ bên trái là registration phù hợp với bản ghi bên phải là user
                    + "WHERE 1=1 "); // để có thể thêm các điều kiện khác ( AND )
            // Danh sách các giá trị tham số sẽ truyền vào câu SQL
            List<Object> params = new ArrayList<>();
            
            // Lọc theo email người dùng nếu có
            if (emailSearch != null && !emailSearch.trim().isEmpty()) {
                sql.append("AND LOWER(u.email) LIKE ? ");
                params.add("%" + emailSearch.toLowerCase() + "%");
            }
            // Lọc theo tên khóa học nếu có
            if (courseName != null && !courseName.trim().isEmpty()) {
                sql.append("AND c.courseName = ? ");
                params.add(courseName);
            }
            // Lọc theo tên gói học phí nếu có
            if (name != null && !name.trim().isEmpty()) {
                sql.append("AND p.name = ? ");
                params.add(name);
            }
            // Lọc theo trạng thái nếu có
            if (status != null && !status.trim().isEmpty()) {
                sql.append("AND r.status = ? ");
                params.add(status);
            }

            // Handle sorting
            // kiểm tra xem có yêu cầu sắp xếp không
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                //Dựa vào giá trị sortBy, xác định cột thực tế trong SQL cần dùng để sắp xếp
                String orderColumn;
                switch (sortBy) {
                    case "registrationID":
                        orderColumn = "r.registrationID";
                        break;
                    case "email":
                        orderColumn = "u.email";
                        break;
                    case "registrationTime":
                        orderColumn = "r.registrationTime";
                        break;
                    case "courseName":
                        orderColumn = "c.courseName";
                        break;
                    case "name":
                        orderColumn = "p.name";
                        break;
                    case "totalCost":
                        orderColumn = "r.totalCost";
                        break;
                    case "status":
                        orderColumn = "r.status";
                        break;
                    case "validFrom":
                        orderColumn = "r.validFrom";
                        break;
                    case "validTo":
                        orderColumn = "r.validTo";
                        break;
                    case "fullName":
                        orderColumn = "lu.fullName";
                        break;
                    default:
                        orderColumn = "r.registrationID";
                }

                sql.append(" ORDER BY ").append(orderColumn).append(" ")  //  sắp xếp kết quả truy vấn theo yêu cầu của người dùng
                        .append("desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");
            }
            // chuyển đối tượng StringBuilder thành chuỗi hoàn chỉnh.
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            //gán từng giá trị trong danh sách params vào các dấu ? trong câu SQL tương ứng.
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int registrationID = rs.getInt("registrationID");
                Registration registration = getRegistrationByRegistrationID(registrationID); //  lấy chi tiết thông tin Registration dựa vào registrationID từ hàm getRegistrationByRegistrationID() .
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println("Error in getRegistrationsByAllFilters: " + e.getMessage());
        }

        return list;
    }
    
    

    //Lọc và lấy Registration theo courseCategoryID
    public List<Registration> getAllRegistrationByCourseCategory(int courseCategoryID) {
        List<Registration> list = new ArrayList();
        List<Course> listCourse = courseDAO.getAllCoureByCategory(courseCategoryID);
        try {
            String sql = "Select * from Registration";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Registration> getAllRegistrationOfUserByUserID(int userID) {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration where userID =" + userID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy Registration theo courseCategoryID
    public List<Registration> getAllRegistrationByCourseCategoryOfUser(int userID, int courseCategoryID) {
        List<Registration> list = new ArrayList();
        List<Course> listCourse = new ArrayList<>();
        if (courseCategoryID == 0) {
            listCourse = courseDAO.getAllCourse();
        } else {
            listCourse = courseDAO.getAllCoureByCategory(courseCategoryID);
        }
        try {
            for (Course course : listCourse) {
                String sql = "Select * from Registration where userID = ? AND courseID = ?";

                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, course.getCourseID());
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                    int id = rs.getInt(1);

                    //Lấy entity
                    Registration registration = getRegistrationByRegistrationID(id);
                    list.add(registration);
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy Registration theo mà có tên course ứng với tên course 
    //được input trong thanh search ở trang my-registration.jsp
    public List<Registration> getAllRegistrationByListCourseOfUser(int userID, List<Course> listCourse) {
        List<Registration> list = new ArrayList();
        try {
            for (Course course : listCourse) {
                String sql = "Select * from Registration where userID = ? AND courseID = ?";

                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, course.getCourseID());
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                    int id = rs.getInt(1);

                    //Lấy entity
                    Registration registration = getRegistrationByRegistrationID(id);
                    list.add(registration);
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    //Lấy ra những registration của user mà có status = paid
    public List<Registration> getAllRegistrationOfUserHavePaidStatus(int userID) {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration where userID = ? AND status = 'Paid'";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    // hàm update registration
    public boolean updateRegistration(Registration registration) {
        String sql = "UPDATE Registration SET "
                + "[courseID] = ?, "
                + "[status] = ?, "
                + "[validFrom] = ?, "
                + "[validTo] = ? ,"
                + "[note] = ? "
                + "WHERE [registrationID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, registration.getCourse().getCourseID());
            st.setString(2, registration.getStatus());
            st.setDate(3, new java.sql.Date(registration.getValidFrom().getTime()));
            st.setDate(4, new java.sql.Date(registration.getValidTo().getTime()));
            st.setString(5, registration.getNote());
            st.setInt(6, registration.getRegistrationID());

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0; // trả về true nếu có ít nhất 1 dòng được cập nhật
        } catch (SQLException e) {
            System.out.println("Error in updateRegistration: " + e.getMessage());
            return false;
        }
    }

    //Thêm mới registration 
    public int addRegistration(Registration reg) {
        String sql = "INSERT INTO Registration (userID, courseID, pricePackageID, validFrom, validTo, status, totalCost, lastUpdateBy, note) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int generatedId = -1;
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            if (reg.getUser() != null) {
                ps.setInt(1, reg.getUser().getUserID());
            } else {
                throw new IllegalArgumentException("❌ Thiếu user khi thêm registration.");
            }
            ps.setInt(2, reg.getCourse().getCourseID());
            ps.setInt(3, reg.getPricePackage().getPricePackageID());
            ps.setDate(4, new java.sql.Date(reg.getValidFrom().getTime()));
            ps.setDate(5, new java.sql.Date(reg.getValidTo().getTime()));
            ps.setString(6, reg.getStatus());
            ps.setDouble(7, reg.getTotalCost());
            // saler
            ps.setInt(8, 24);
            ps.setString(9, reg.getNote());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    public boolean updateRegistrationStatus(int registrationID, String newStatus, int lastUpdateBy) {
        String sql = "UPDATE Registration SET status = ?, lastUpdateBy = ? WHERE registrationID = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, lastUpdateBy);
            ps.setInt(3, registrationID);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean save(Registration registration) {
        String sql = "INSERT INTO Registration (userID, courseID, pricePackageID, totalCost, status, registrationTime) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Lấy ID từ đối tượng User - ĐÚNG
            ps.setInt(1, registration.getUser().getUserID());
            // Lấy ID từ đối tượng Course - ĐÚNG
            ps.setInt(2, registration.getCourse().getCourseID());
            // Lấy ID từ đối tượng PricePackage - ĐÚNG
            ps.setInt(3, registration.getPricePackage().getPricePackageID());
            ps.setDouble(4, registration.getTotalCost());
            ps.setString(5, registration.getStatus());
            ps.setTimestamp(6, new java.sql.Timestamp(registration.getRegistrationTime().getTime()));

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in RegistrationDAO.save: " + e.getMessage());
            return false;
        }
    }

    /**
     * Kiểm tra xem một người dùng đã có đơn đăng ký (chưa bị hủy) cho một khóa
     * học cụ thể hay chưa.
     *
     * @param userId ID của người dùng.
     * @param courseId ID của khóa học.
     * @return true nếu đã tồn tại, false nếu chưa có.
     */
    public boolean hasExistingRegistration(int userId, int courseId) {
        String sql = "SELECT COUNT(*) FROM Registration WHERE userID = ? AND courseID = ? AND status != 'Cancelled'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            if (ps.executeQuery().next()) {
                return ps.executeQuery().getInt(1) > 0;
            }

        } catch (SQLException e) {
            // Sửa lại System.out
            System.out.println("Lỗi trong hasExistingRegistration: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    //Lấy đơn đăng kí của user cho 1 course
    public Registration getRegistrationByUserAndCourse(int userId, int courseId) {
        String sql = "SELECT * FROM Registration WHERE userID = ? AND courseID = ? AND status != 'Cancelled'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Tận dụng lại hàm đã có để không phải viết lại code mapping
                    return getRegistrationByRegistrationID(rs.getInt("registrationID"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi trong getRegistrationByUserAndCourse: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    //Update gói 
    public boolean updateRegistrationPackage(int registrationId, int newPricePackageId, double newTotalCost) {
        // Cập nhật gói cước, chi phí, và reset trạng thái về 'Submitted' để chờ xử lý lại.
        // Cập nhật cả registrationTime để ghi nhận thời điểm thay đổi.
        String sql = "UPDATE Registration SET pricePackageID = ?, totalCost = ?, status = 'Submitted', registrationTime = GETDATE() WHERE registrationID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newPricePackageId);
            ps.setDouble(2, newTotalCost);
            ps.setInt(3, registrationId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi trong updateRegistrationPackage: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        RegistrationDAO d = new RegistrationDAO();
        List<Registration> list = d.getAllRegistrationOfUserHavePaidStatus(5);
        for (Registration x : list) {
            System.out.println(x.getTotalLesson());
        }
    }

}
