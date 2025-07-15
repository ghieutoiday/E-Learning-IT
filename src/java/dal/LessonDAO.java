package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.Lesson;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class LessonDAO extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(LessonDAO.class.getName());
    private static LessonDAO instance;

    public static LessonDAO getInstance() {
        if (instance == null) {
            instance = new LessonDAO();
        }
        return instance;
    }

    CourseDAO courseDAO = new CourseDAO();

    // Fetch lessons by courseID for Gemini AI (simplified fields)
    public List<Lesson> getLessonsByCourseIdForAI(int courseId) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT TOP (1000) [lessonID], [courseID], [topicID], [name], [contentHtml] " +
                    "FROM [CourseManagementDB].[dbo].[Lesson] WHERE courseID = ? AND status = 'Active'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonID(rs.getInt("lessonID"));
                lesson.setCourse(new Course(rs.getInt("courseID"))); // Minimal Course object
                lesson.setTopic(rs.getInt("topicID") != 0 ? new Lesson(rs.getInt("topicID")) : null); // Minimal Lesson for topic
                lesson.setName(rs.getString("name"));
                lesson.setContentHtml(rs.getString("contentHtml"));
                lessons.add(lesson);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching lessons for courseID: " + courseId, e);
        }
        return lessons;
    }

    // Fetch a specific lesson by courseID and lessonID for Gemini AI (simplified fields)
    public Lesson getLessonByIdForAI(int courseId, int lessonId) {
        String sql = "SELECT [lessonID], [courseID], [topicID], [name], [contentHtml] " +
                    "FROM [CourseManagementDB].[dbo].[Lesson] WHERE courseID = ? AND lessonID = ? AND status = 'Active'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setInt(2, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonID(rs.getInt("lessonID"));
                lesson.setCourse(new Course(rs.getInt("courseID"))); // Minimal Course object
                lesson.setTopic(rs.getInt("topicID") != 0 ? new Lesson(rs.getInt("topicID")) : null); // Minimal Lesson for topic
                lesson.setName(rs.getString("name"));
                lesson.setContentHtml(rs.getString("contentHtml"));
                return lesson;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching lesson for courseID: " + courseId + ", lessonID: " + lessonId, e);
        }
        return null;
    }

    // Existing methods (unchanged)
    public Lesson getLessonByLessonID(int lessonId) {
        Lesson lesson = null;
        try {
            String sql = "Select * from Lesson where status = 'Active' AND lessonId = " + lessonId;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course course = courseDAO.getCoureByCourseID(rs.getInt(2));
                Lesson topic = this.getLessonByLessonID(rs.getInt(3));
                String name = rs.getString(4);
                String type = rs.getString(5);
                int orderNum = rs.getInt(6);
                String status = rs.getString(7);
                String contentVideo = rs.getString(8);
                String contentHtml = rs.getString(9);
                int duration = rs.getInt(10);
                lesson = new Lesson(lessonId, course, topic, name, type, orderNum, status, contentVideo, contentHtml, duration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return lesson;
    }

    public int getTotalNumberOfLessonInCourse(int courseID) {
        int total = -1;
        try {
            String sql = """
                         SELECT COUNT(*) AS totalActiveLessons
                         FROM Lesson l
                         WHERE l.courseID = ?
                         AND l.status = 'Active';""";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    public int getTotalNumberOfCompletedLessonInCourse(int userID, int courseID) {
        int total = -1;
        try {
            String sql = """
                          SELECT COUNT(*) AS lessonsCompleted
                          FROM UserLessonProgress ulp
                          JOIN Lesson l ON ulp.lessonID = l.lessonID
                          JOIN Registration r ON r.userID = ulp.userID AND r.courseID = l.courseID
                          WHERE ulp.userID = ?
                          AND l.courseID = ?
                          AND ulp.status = 'Completed'
                          AND l.status = 'Active'
                          AND r.status IN ('Submitted', 'Paid');
                          """;

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    public List<Lesson> getAllSubjectTopicLesson(int courseID) {
        List<Lesson> listLesson = new ArrayList<>();
        String sql = "select * from Lesson where courseID = ? AND type = 'Subject Topic' AND status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = getLessonByLessonID(rs.getInt(1));
                listLesson.add(lesson);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listLesson;
    }

    public List<Lesson> getAllLessonBySubjectTopicLesson(int topicID) {
        List<Lesson> listLesson = new ArrayList<>();
        String sql = "select * from Lesson where topicID = ? AND status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, topicID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = getLessonByLessonID(rs.getInt(1));
                listLesson.add(lesson);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listLesson;
    }

    public List<Lesson> getAllSubLessonsByCourseIDOrdered(int courseID) {
        List<Lesson> listLesson = new ArrayList<>();
        String sql = "SELECT * FROM Lesson WHERE courseID = ? AND type NOT LIKE 'Subject Topic' AND status = 'Active' ORDER BY lessonID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int lessonId = rs.getInt(1);
                Course course = courseDAO.getCoureByCourseID(rs.getInt(2));
                Lesson topic = this.getLessonByLessonID(rs.getInt(3));
                String name = rs.getString(4);
                String type = rs.getString(5);
                int orderNum = rs.getInt(6);
                String status = rs.getString(7);
                String contentVideo = rs.getString(8);
                String contentHtml = rs.getString(9);
                int duration = rs.getInt(10);
                Lesson lesson = new Lesson(lessonId, course, topic, name, type, orderNum, status, contentVideo, contentHtml, duration);
                listLesson.add(lesson);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listLesson;
    }
    public List<Lesson> getLessonsByCourse(int courseId, String searchQuery, Integer topicId, String status, int pageIndex, int pageSize) {
        List<Lesson> lessons = new ArrayList<>();

        try {
            // Xây dựng câu lệnh SQL động để linh hoạt trong việc lọc
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT l.*, c.courseName FROM Lesson l ");
            sql.append("JOIN Course c ON l.courseID = c.courseID ");
            sql.append("WHERE l.courseID = ? ");

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql.append("AND l.name LIKE ? ");
            }
            if (topicId != null) {
                // Chức năng này chưa được triển khai ở Servlet, nhưng DAO đã sẵn sàng
                sql.append("AND l.topicID = ? ");
            }
            if (status != null && !status.trim().isEmpty() && !status.equals("All")) {
                sql.append("AND l.status = ? ");
            }

            // Sắp xếp theo orderNum và thêm phân trang
            sql.append("ORDER BY l.lessonID ASC ");
            sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

            PreparedStatement ps = connection.prepareStatement(sql.toString());

            // Gán các tham số vào câu lệnh
            int paramIndex = 1;
            ps.setInt(paramIndex++, courseId);

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchQuery + "%");
            }
            if (topicId != null) {
                ps.setInt(paramIndex++, topicId);
            }
            if (status != null && !status.trim().isEmpty() && !status.equals("All")) {
                ps.setString(paramIndex++, status);
            }

            ps.setInt(paramIndex++, (pageIndex - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonID(rs.getInt("lessonID"));
                lesson.setName(rs.getString("name"));
                lesson.setOrderNum(rs.getInt("orderNum"));
                lesson.setType(rs.getString("type"));
                lesson.setStatus(rs.getString("status"));
                lesson.setContentVideo(rs.getString("contentVideo"));
                lesson.setContentHtml(rs.getString("contentHtml"));
                lesson.setDuration(rs.getInt("duration"));

                // Tạo đối tượng Course đơn giản để chứa thông tin cơ bản
                Course course = new Course();
                course.setCourseID(rs.getInt("courseID"));
                course.setCourseName(rs.getString("courseName"));
                lesson.setCourse(course);

                // Xử lý topicID
                int tId = rs.getInt("topicID");
                if (!rs.wasNull()) {
                    Lesson topic = new Lesson();
                    topic.setLessonID(tId);
                    lesson.setTopic(topic);
                }

                lessons.add(lesson);
            }
        } catch (SQLException e) {
            System.out.println("getLessonsByCourse: " + e.getMessage());
        }
        return lessons;
    }

    /**
     * Đếm tổng số bài học thỏa mãn điều kiện lọc để phục vụ việc phân trang.
     *
     * @param courseId ID của khóa học.
     * @param searchQuery Từ khóa tìm kiếm.
     * @param topicId ID của chủ đề.
     * @param status Trạng thái.
     * @return Tổng số bài học.
     */
    public int countLessonsByCourse(int courseId, String searchQuery, Integer topicId, String status) {
        try {
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Lesson WHERE courseID = ? ");
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql.append("AND name LIKE ? ");
            }
            if (topicId != null) {
                sql.append("AND topicID = ? ");
            }
            if (status != null && !status.trim().isEmpty() && !status.equals("All")) {
                sql.append("AND status = ? ");
            }

            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            ps.setInt(paramIndex++, courseId);

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchQuery + "%");
            }
            if (topicId != null) {
                ps.setInt(paramIndex++, topicId);
            }
            if (status != null && !status.trim().isEmpty() && !status.equals("All")) {
                ps.setString(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("countLessonsByCourse: " + e.getMessage());
        }
        return 0;
    }

    //Thêm bài học 
    public void addLesson(Lesson lesson) {
        String sql = "INSERT INTO Lesson (courseID, topicID, name, type, orderNum, status, contentVideo, contentHtml, duration) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, lesson.getCourse().getCourseID());

            // Topic có thể là null
            if (lesson.getTopic() != null) {
                ps.setInt(2, lesson.getTopic().getLessonID());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }

            ps.setString(3, lesson.getName());
            ps.setString(4, lesson.getType());
            ps.setInt(5, lesson.getOrderNum());
            ps.setString(6, lesson.getStatus());
            ps.setString(7, lesson.getContentVideo());
            ps.setString(8, lesson.getContentHtml());
            ps.setInt(9, lesson.getDuration());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding lesson: " + e.getMessage());
        }
    }

    /**
     * Cập nhật trạng thái của một bài học dựa vào lessonId.
     *
     * @param lessonId ID của bài học cần cập nhật.
     * @param newStatus Trạng thái mới ('Active' hoặc 'Inactive').
     */
    public void updateLessonStatus(int lessonId, String newStatus) {
        String sql = "UPDATE Lesson SET status = ? WHERE lessonID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, lessonId);
            ps.executeUpdate(); // Thực thi lệnh cập nhật
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error updating lesson status: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    
/**
 * Lấy toàn bộ thông tin của một bài học dựa vào ID.
 * Phương thức này không giống getLessonByLessonID cũ vì nó không join,
 * và lấy tất cả các thuộc tính.
 * @param lessonId ID của bài học.
 * @return Đối tượng Lesson hoặc null nếu không tìm thấy.
 */
public Lesson getLessonById(int lessonId) {
    String sql = "SELECT * FROM Lesson WHERE lessonID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, lessonId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Lesson lesson = new Lesson();
            lesson.setLessonID(rs.getInt("lessonID"));
            
            Course course = new Course();
            course.setCourseID(rs.getInt("courseID"));
            lesson.setCourse(course);

            int topicId = rs.getInt("topicID");
            if (!rs.wasNull()) {
                Lesson topic = new Lesson();
                topic.setLessonID(topicId);
                lesson.setTopic(topic);
            }
            
            lesson.setName(rs.getString("name"));
            lesson.setType(rs.getString("type"));
            lesson.setOrderNum(rs.getInt("orderNum"));
            lesson.setStatus(rs.getString("status"));
            lesson.setContentVideo(rs.getString("contentVideo"));
            lesson.setContentHtml(rs.getString("contentHtml"));
            lesson.setDuration(rs.getInt("duration"));
            return lesson;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

/**
 * Cập nhật thông tin của một bài học hiện có trong database.
 * @param lesson Đối tượng Lesson chứa thông tin mới.
 */
public void updateLesson(Lesson lesson) {
    String sql = "UPDATE Lesson SET "
               + "name = ?, "
               + "type = ?, "
               + "topicID = ?, "
               + "orderNum = ?, "
               + "status = ?, "
               + "contentVideo = ?, "
               + "contentHtml = ?, "
               + "duration = ? "
               + "WHERE lessonID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, lesson.getName());
        ps.setString(2, lesson.getType());
        
        if (lesson.getTopic() != null && lesson.getTopic().getLessonID() > 0) {
            ps.setInt(3, lesson.getTopic().getLessonID());
        } else {
            ps.setNull(3, java.sql.Types.INTEGER);
        }
        
        ps.setInt(4, lesson.getOrderNum());
        ps.setString(5, lesson.getStatus());
        ps.setString(6, lesson.getContentVideo());
        ps.setString(7, lesson.getContentHtml());
        ps.setInt(8, lesson.getDuration());
        ps.setInt(9, lesson.getLessonID()); // lessonID cho mệnh đề WHERE

        ps.executeUpdate();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    public static void main(String[] args) {
        System.out.println(LessonDAO.getInstance().getTotalNumberOfLessonInCourse(4));
    }
}