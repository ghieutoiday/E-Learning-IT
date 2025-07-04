/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu

import java.util.List;
import model.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CourseCategory;
import model.User;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gtrun
 */
public class CourseDAO extends DBContext {
    
    private static final Logger LOGGER = Logger.getLogger(CourseDAO.class.getName());

    public CourseDAO() {
        super();
    }

    // Hàm get course theo courseID
    public Course getCoureByCourseID(int courseID) {
        Course course = null;
        String sql = "SELECT c.courseID, "
                + "       c.courseName, "
                + "       c.courseCategoryID, "
                + "       c.description, "
                + "       c.ownerID, "
                + "       c.status, "
                + "       c.numberOfLesson, "
                + "       c.feature, "
                + "       c.createDate, "
                + "       i.thumbnail "
                + "FROM Course c "
                + "JOIN Image i ON c.courseID = i.courseID "
                + "WHERE c.courseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                String courseThumbnailLink = rs.getString("thumbnail");
                course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        courseThumbnailLink, //Truyền link ảnh vào đây
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getInt("feature"),
                        rs.getDate("createDate"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return course;
    }

    // Hàm get course theo getCoureByCourseIDAndPrice
    public Course getCoureByCourseIDAndPrice(int courseID) {
        Course course = null;
        String sql = "SELECT c.courseID, "
                + "       c.courseName, "
                + "       c.courseCategoryID, "
                + "       c.description, "
                + "       c.briefInfo, "
                + "       c.ownerID, "
                + "       c.status, "
                + "       c.numberOfLesson, "
                + "       c.feature, "
                + "       c.createDate, "
                + "       i.thumbnail, "
                + "       pp.[listPrice], "
                + "       pp.[salePrice] "
                + "FROM Course c "
                + "LEFT JOIN Image i ON c.courseID = i.courseID "
                + "OUTER APPLY ( "
                + "    SELECT TOP 1 listPrice, salePrice FROM [dbo].[PricePackage] pp "
                + "    WHERE pp.courseID = c.courseID "
                + "    ORDER BY pp.salePrice ASC "
                + ") pp "
                + "WHERE c.courseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                String courseThumbnailLink = rs.getString("thumbnail");
                Double listPrice = rs.getDouble("listPrice");
                Double salePrice = rs.getDouble("salePrice");
                course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        rs.getString("briefInfo"),
                        courseThumbnailLink, //Truyền link ảnh vào đây
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getInt("feature"),
                        rs.getDate("createDate"), rs.getDouble("listPrice"), rs.getDouble("salePrice"));
                course.setListPrice(listPrice);
                course.setSalePrice(salePrice);

            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return course;
    }

//    public List<Course> getAllCourse() {
//        List<Course> list = new ArrayList<>();
//        String sql = "SELECT [courseID]\n"
//                + "      ,[courseName]\n"
//                + "      ,[courseCategoryID]\n"
//                //                + "      ,[thumbnail]\n"
//                + "      ,[description]\n"
//                + "      ,[ownerID]\n"
//                + "      ,[status]\n"
//                + "      ,[numberOfLesson]\n"
//                + "      ,[createDate]\n"
//                + "  FROM [CourseManagementDB].[dbo].[Course]";
//
//        try {
//            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
//            UserDAO userDao = new UserDAO();
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
//                User user = userDao.getUser(rs.getInt("ownerID"));
//                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
//                list.add(course);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return list;
//    }
    public List<Course> getAllCourse() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.courseID, "
                + "       c.courseName, "
                + "       c.courseCategoryID, "
                + "       c.description, "
                + "       c.ownerID, "
                + "       c.status, "
                + "       c.numberOfLesson, "
                + "       c.feature, " // <-- Bao gồm cả feature
                + "       c.createDate, "
                + "       i.thumbnail " // <-- Bao gồm cả thumbnail từ bảng Image
                + "FROM [CourseManagementDB].[dbo].[Course] c "
                + "LEFT JOIN [CourseManagementDB].[dbo].[Image] i ON c.courseID = i.courseID";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));

                String thumbnail = rs.getString("thumbnail");
                int feature = rs.getInt("feature"); // <-- Lấy giá trị của feature

                // Tạo đối tượng Course với thumbnail và feature
                // Đảm bảo constructor của lớp Course có tham số String cho thumbnail và int cho feature
                Course course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        thumbnail, // Truyền thumbnail
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        feature, // Truyền feature
                        rs.getDate("createDate"));
                list.add(course);
            }
            // Đảm bảo đóng ResultSet và PreparedStatement để giải phóng tài nguyên
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy tất cả khóa học", ex);
        }
        return list;
    }

    //Thêm mới subject 
    public int addNewCourse(Course course) {
        String sql = "INSERT INTO Course (courseName, courseCategoryID, description, ownerID, status, feature) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, course.getCourseName());
            st.setInt(2, course.getCourseCategory().getCourseCategory());
            st.setString(3, course.getDescription());
            st.setInt(4, course.getOwner().getUserID());
            st.setString(5, course.getStatus());
            st.setInt(6, course.getFeature());

            // Gọi executeUpdate() trước khi getGeneratedKeys
            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // ID vừa tạo
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }

        return 0;
    }

//    public boolean linkCourseImage(int courseID, int imageId) {
//        String sql = "INSERT INTO Hotel_has_image (hotel_ID, image_ID) VALUES (?, ?)";
//        System.out.println("Linking hotel " + hotelId + " with image " + imageId);
//
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, hotelId);
//            st.setInt(2, imageId);
//            int result = st.executeUpdate();
//            System.out.println("Link result: " + result);
//            return result > 0;
//        } catch (SQLException e) {
//            System.out.println("Error in linkHotelImage: " + e.getMessage());
//            e.printStackTrace();
//            return false;
//        }
//    }
    public int insertLink(String imageName, String thumbnail, int courseID) {
        String sql = "INSERT INTO Image (imageName, thumbnail, courseID) VALUES (?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, imageName);
            st.setString(2, thumbnail);
            st.setInt(3, courseID);

            int affectedRows = st.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating image failed, no rows affected.");
            }

            try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    System.out.println("Successfully inserted image with ID: " + id);
                    return id;
                } else {
                    throw new SQLException("Creating image failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in insertImage: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public List<Course> getAllDistinctCourseByName() {
        List<Course> list = new ArrayList<>();

        try {
            //  lọc ra các bản ghi Course với tên name duy nhất (không trùng nhau).
            // Mỗi name chỉ lấy 1 bản ghi đại diện (bản ghi có pricePackageID nhỏ nhất).
            String sql = "SELECT * FROM Course WHERE courseID IN ( "
                    + "SELECT MIN(courseID) FROM Course GROUP BY courseName )";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("courseID");
                Course course = getCoureByCourseID(id);
                list.add(course);
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return list;
    }

    //Hàm filter by categoryID
    public List<Course> getAllCoureByCategoryAndStatus(int categoryId, String status) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseCategoryID] = ? and [status] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm get all course theo status
    public List<Course> getAllCoureByStatus(String status) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where[status] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm lấy tất cả các course có courseName ứng với 1 phần hoặc toàn bộ courseName sau khi search
    //hàm này lấy để dùng trong 
    public List<Course> getAllCoureByCourseName(String courseName) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where LOWER(courseName) LIKE LOWER(?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + courseName + "%");
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Hàm get all course theo categoryID
    public List<Course> getAllCoureByCategory(int categoryId) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseCategoryID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Hàm get 5 courselist dùng để phân trang
    public List<Course> pagingCourse(int index) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //Hàm phân trang theo status
    public List<Course> pagingCourseByStatus(int index, String status) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  where status = ?\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //Hàm phân trang theo Category
    public List<Course> pagingCourseByCategory(int index, int categoryId) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  where courseCategoryID = ?\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setInt(2, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm phân trang theo Category
    public List<Course> pagingCourseByCategoryAndStatus(int index, int categoryId, String status) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                //                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  where courseCategoryID = ? and status = ?\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setString(2, status);
            ps.setInt(3, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm search By Part of Name of CategoryName
    public List<Course> searchCourseByNameOrCategory(String searchKey) {
        List<Course> list = new ArrayList<>();
        Course course = null;

        String sql = "SELECT c.[courseID], c.[courseName], c.[courseCategoryID], "
                + "c.[description], c.[ownerID], c.[status], c.[numberOfLesson], c.[createDate], "
                + "cc.[courseCategoryName] "
                + "FROM [dbo].[Course] c "
                + "JOIN [dbo].[CourseCategory] cc ON c.[courseCategoryID] = cc.[courseCategoryID] "
                + "WHERE c.[courseName] LIKE ? OR cc.[courseCategoryName] LIKE ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            String searchKeyTerm = "%" + searchKey + "%"; // Sửa dấu grave accent
            ps.setString(1, searchKeyTerm);
            ps.setString(2, searchKeyTerm);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"),
                        rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hầm update course
    public int updateCourse(Course course) {
        int rowsAffected = 0;
        String sql = "UPDATE [dbo].[Course] SET "
                + "[courseName] = ?, "
                + "[courseCategoryID] = ?, "
                + "[description] = ?, "
                + "[status] = ?, "
                + "[numberOfLesson] = ?, "
                + "[feature] = ? "
                + "WHERE [courseID] = ?";

        String sql2 = "UPDATE [dbo].[Image] SET [thumbnail] = ? WHERE [courseID] = ?";

        try {

            PreparedStatement ps1 = connection.prepareStatement(sql);
            ps1.setString(1, course.getCourseName());
            ps1.setInt(2, course.getCourseCategory().getCourseCategory());
            ps1.setString(3, course.getDescription());
            ps1.setString(4, course.getStatus());
            ps1.setInt(5, course.getNumberOfLesson());
            ps1.setInt(6, course.getFeature());
            ps1.setInt(7, course.getCourseID());
            rowsAffected += ps1.executeUpdate();

            PreparedStatement ps2 = connection.prepareStatement(sql2);
            ps2.setString(1, course.getThumbnail());
            ps2.setInt(2, course.getCourseID());
            rowsAffected += ps2.executeUpdate();


        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowsAffected;
    }

    // Lấy danh sách các khóa học nổi bật (feature = 1) và đang hoạt động (status = 'Active')by Khuong
    public List<Course> getCoursePageHome() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.[courseID]\n"
                + "      ,c.[courseName]\n"
                + "      ,c.[courseCategoryID]\n"
                + "      ,c.[description]\n"
                + "      ,c.[ownerID]\n"
                + "      ,c.[status]\n"
                + "      ,c.[numberOfLesson]\n"
                + "      ,c.[createDate]\n"
                + "      ,i.[thumbnail]\n"
                + "  FROM [dbo].[Course] c\n"
                + "  LEFT JOIN [dbo].[Image] i ON c.courseID = i.courseID\n"
                + "   WHERE c.[status] = 'Active' AND c.[feature] = 1 \n "
                + "  order by c.[courseID]";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                String thumbnail = rs.getString("thumbnail");
                Course course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        thumbnail,
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    // Lấy danh sách khóa học có phân trang, kèm tìm kiếm và lọc theo danh mục by Khuong
    public List<Course> getCoursePageCoursesList(int index, String search, Integer categoryId) {
        List<Course> list = new ArrayList<>();
        String sql
                = "SELECT c.[courseID], "
                + "       c.[courseName], "
                + "       c.[courseCategoryID], "
                + "       c.[description], "
                + "       c.[ownerID], "
                + "       c.[status], "
                + "       c.[numberOfLesson], "
                + "       c.[createDate], "
                + "       i.[thumbnail], "
                + "       pp.[listPrice], "
                + "       pp.[salePrice] "
                + "FROM [dbo].[Course] c "
                + "LEFT JOIN [dbo].[Image] i ON c.courseID = i.courseID "
                + "OUTER APPLY ( "
                + "    SELECT TOP 1 listPrice, salePrice FROM [dbo].[PricePackage] pp "
                + "    WHERE pp.courseID = c.courseID "
                + "    ORDER BY pp.salePrice ASC "
                + ") pp "
                + "WHERE c.[status] = 'Active' ";

        if (search != null && !search.isEmpty()) {
            sql += " AND c.courseName LIKE ? ";
        }
        if (categoryId != null) {
            sql += " AND c.courseCategoryID = ? ";
        }

        sql += " ORDER BY c.[updateDate] DESC "
                + " OFFSET " + ((index - 1) * 9) + " ROWS FETCH NEXT 9 ROWS ONLY;";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIdx = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIdx++, "%" + search + "%");
            }
            if (categoryId != null) {
                ps.setInt(paramIdx++, categoryId);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                String thumbnail = rs.getString("thumbnail");
                double listPrice = rs.getDouble("listPrice");
                double salePrice = rs.getDouble("salePrice");

                Course course = new Course(
                        rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        thumbnail,
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getDate("createDate")
                );

                course.setListPrice(listPrice);
                course.setSalePrice(salePrice);
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //Lấy danh sách khóa học nổi bật (feature = 1) có phân trang by Khuong
    public List<Course> getCoursePageCoursesListByFeature(int index) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.[courseID]\n"
                + "      ,c.[courseName]\n"
                + "      ,c.[courseCategoryID]\n"
                + "      ,c.[description]\n"
                + "      ,c.[ownerID]\n"
                + "      ,c.[status]\n"
                + "      ,c.[numberOfLesson]\n"
                + "      ,c.[createDate]\n"
                + "      ,i.[thumbnail]\n"
                + "      ,pp.[listPrice]\n"
                + "      ,pp.[salePrice]\n"
                + "  FROM [dbo].[Course] c\n"
                + "  LEFT JOIN [dbo].[Image] i ON c.courseID = i.courseID\n"
                + "  OUTER APPLY (\n"
                + "      SELECT TOP 1 listPrice, salePrice FROM [dbo].[PricePackage] pp\n"
                + "      WHERE pp.courseID = c.courseID \n"
                + "      ORDER BY pp.salePrice ASC\n"
                + "  ) pp\n"
                + "   WHERE c.[status] = 'Active' AND c.[feature] = 1\n "
                + "  order by c.[courseID]"
                + "  offset " + ((index - 1) * 15) + " rows fetch next 15 rows only;";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                String thumbnail = rs.getString("thumbnail");
                double listPrice = rs.getDouble("listPrice");
                double salePrice = rs.getDouble("salePrice");
                Course course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        thumbnail,
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getDate("createDate"));
                course.setListPrice(listPrice);
                course.setSalePrice(salePrice);
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //Đếm số lượng khóa học thỏa mãn điều kiện tìm kiếm và lọc danh mục by Khuong
    public int countCourseWithFilter(String search, Integer categoryId) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM [dbo].[Course] c WHERE c.[status] = 'Active'");
        if (search != null && !search.isEmpty()) {
            sql.append(" AND c.courseName LIKE ? ");
        }
        if (categoryId != null) {
            sql.append(" AND c.courseCategoryID = ? ");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIdx = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIdx++, "%" + search + "%");
            }
            if (categoryId != null) {
                ps.setInt(paramIdx++, categoryId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Course getCourseByIdd(int courseId) {
        String sql = "SELECT * FROM Course WHERE courseID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Course c = new Course();
                    c.setCourseID(rs.getInt("courseID"));
                    c.setCourseName(rs.getString("courseName"));

                    // Lấy các đối tượng liên quan
                    CourseCategoryDAO catDAO = new CourseCategoryDAO();
                    UserDAO userDAO = new UserDAO();

                    c.setCourseCategory(catDAO.getCategoryById(rs.getInt("courseCategoryID")));
                    c.setOwner(userDAO.getUserByID(rs.getInt("ownerID")));
                    c.setDescription(rs.getString("description"));
                    c.setStatus(rs.getString("status"));
                    // Thêm các trường khác nếu cần
                    return c;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getCourseById: " + e.getMessage());
        }
        return null;
    }

    public Course getCoureByCourseIDD(int courseID) {
        Course course = null;
        String sql = "SELECT c.courseID, "
                + "       c.courseName, "
                + "       c.courseCategoryID, "
                + "       c.description, "
                + "       c.ownerID, "
                + "       c.status, "
                + "       c.numberOfLesson, "
                + "       c.feature, "
                + "       c.createDate, "
                + "       i.thumbnail "
                + "FROM Course c "
                + "JOIN Image i ON c.courseID = i.courseID "
                + "WHERE c.courseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                String courseThumbnailLink = rs.getString("thumbnail");
                course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        courseThumbnailLink, //Truyền link ảnh vào đây
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getInt("feature"),
                        rs.getDate("createDate"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return course;
    }

    // Hàm searchCoursesByName by thịnh
    public List<Course> searchCoursesByName(String userInput) {
        List<Course> list = new ArrayList<>();

        // Tách các từ khóa từ user input
        String[] keywords = userInput.toLowerCase().split("\\s+");

        // Xây dựng phần WHERE với nhiều điều kiện LIKE
        StringBuilder whereClause = new StringBuilder("WHERE ");
        for (int i = 0; i < keywords.length; i++) {
            whereClause.append("LOWER(c.courseName) LIKE ?");
            if (i < keywords.length - 1) {
                whereClause.append(" OR ");
            }
        }

        String sql = "SELECT c.courseID,\n"
                + "       c.courseName,\n"
                + "       c.courseCategoryID,\n"
                + "       c.briefInfo,\n"
                + "       c.description,\n"
                + "       c.ownerID,\n"
                + "       c.status,\n"
                + "       c.numberOfLesson,\n"
                + "       c.feature,\n"
                + "       c.createDate,\n"
                + "       pp.listPrice,\n"
                + "       pp.salePrice\n"
                + "FROM Course c\n"
                + "OUTER APPLY (\n"
                + "    SELECT TOP 1 listPrice, salePrice\n"
                + "    FROM PricePackage pp\n"
                + "    WHERE pp.courseID = c.courseID\n"
                + "    ORDER BY pp.salePrice ASC\n"
                + ") pp\n"
                + whereClause.toString();

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Truyền giá trị cho từng điều kiện LIKE
            for (int i = 0; i < keywords.length; i++) {
                ps.setString(i + 1, "%" + keywords[i] + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
                UserDAO userDao = new UserDAO();

                while (rs.next()) {
                    CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                    User user = userDao.getUserByID(rs.getInt("ownerID"));

                    Course course = new Course(
                            rs.getInt("courseID"),
                            rs.getString("courseName"),
                            courseCategory,
                            rs.getString("briefInfo"),
                            null,
                            rs.getString("description"),
                            user,
                            rs.getString("status"),
                            rs.getInt("numberOfLesson"),
                            rs.getInt("feature"),
                            rs.getDate("createDate"),
                            rs.getDouble("listPrice"),
                            rs.getDouble("salePrice")
                    );
                    list.add(course);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm kiếm khóa học theo tên: " + userInput, ex);
        }

        return list;
    }

    // Hàm searchCoursesByCategoryName by thịnh
    public List<Course> searchCoursesByCategoryName(String categoryName) {
        List<Course> list = new ArrayList<>();

        // Tách input thành các từ khóa
        String[] keywords = categoryName.toLowerCase().split("\\s+");

        // Tạo điều kiện WHERE gồm nhiều LIKE nối bằng OR
        StringBuilder whereClause = new StringBuilder("WHERE ");
        for (int i = 0; i < keywords.length; i++) {
            whereClause.append("LOWER(cc.courseCategoryName) LIKE ?");
            if (i < keywords.length - 1) {
                whereClause.append(" OR ");
            }
        }

        String sql = "SELECT c.courseID,\n"
                + "       c.courseName,\n"
                + "       c.courseCategoryID,\n"
                + "       c.briefInfo,\n"
                + "       c.description,\n"
                + "       c.ownerID,\n"
                + "       c.status,\n"
                + "       c.numberOfLesson,\n"
                + "       c.feature,\n"
                + "       c.createDate,\n"
                + "       pp.listPrice,\n"
                + "       pp.salePrice\n"
                + "FROM Course c\n"
                + "JOIN CourseCategory cc ON c.courseCategoryID = cc.courseCategoryID\n"
                + "OUTER APPLY (\n"
                + "    SELECT TOP 1 listPrice, salePrice\n"
                + "    FROM PricePackage pp\n"
                + "    WHERE pp.courseID = c.courseID\n"
                + "    ORDER BY pp.salePrice ASC\n"
                + ") pp\n"
                + "WHERE LOWER(cc.courseCategoryName) LIKE LOWER(?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + categoryName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
                UserDAO userDao = new UserDAO();
                while (rs.next()) {
                    CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                    User user = userDao.getUserByID(rs.getInt("ownerID"));

                    // Gọi constructor đầy đủ nhất
                    Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                            rs.getString("briefInfo"),
                            null, // Lấy thumbnail
                            rs.getString("description"), user, rs.getString("status"),
                            rs.getInt("numberOfLesson"),
                            rs.getInt("feature"),
                            rs.getDate("createDate"),
                            rs.getDouble("listPrice"),
                            rs.getDouble("salePrice"));
                    list.add(course);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm kiếm khóa học theo thể loại: " + categoryName, ex);
        }
        return list;
    }

    // Phương thức getCourseByName (để lấy 1 Course duy nhất)
    public Course getCourseByName(String courseName) {
        List<Course> courses = searchCoursesByName(courseName);
        if (courses != null && !courses.isEmpty()) {
            return courses.get(0); // Trả về khóa học đầu tiên tìm thấy
        }
        return null;
    }

}
