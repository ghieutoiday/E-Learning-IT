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

    public static void main(String[] args) {
        System.out.println(LessonDAO.getInstance().getTotalNumberOfLessonInCourse(4));
    }
}