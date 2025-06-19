/*
 * Click https://netbeans/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click https://netbeans/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.Lesson;

/**
 *
 * @author ASUS
 */
public class LessonDAO extends DBContext {

    private static LessonDAO instance;

    public static LessonDAO getInstance() {
        if (instance == null) {
            instance = new LessonDAO();
        }
        return instance;
    }

    CourseDAO courseDAO = new CourseDAO();

    // Lấy 1 bài Lesson với ID cụ thể
    public Lesson getLessonByLessonID(int lessonId) {
        Lesson lesson = null;
        try {
            String sql = "Select * from Lesson where status = 'Active' AND lessonId = " + lessonId;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Course course = courseDAO.getCoureByCourseID(rs.getInt(2));
                Lesson topic = this.getLessonByLessonID(rs.getInt(3));
                String name = rs.getString(4);
                String type = rs.getString(5);
                int orderNum = rs.getInt(6);
                String status = rs.getString(7);
                String contentVideo = rs.getString(8);
                String contentHtml = rs.getString(9);
                int duration = rs.getInt(10);
                //Lấy entity
                lesson = new Lesson(lessonId, course, topic, name, type, orderNum, status, contentVideo, contentHtml, duration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return lesson;
    }

    // Lấy số Lesson trong 1 khóa học mà có trạng thái là Active
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

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    // Lấy số Lesson trong 1 khóa học mà có trạng thái là Active
    // và người dùng đã hoàn thành
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

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    // Lấy danh sách Lesson có type = subject topic (module)
    public List<Lesson> getAllSubjectTopicLesson(int courseID) {
        List<Lesson> listLesson = new ArrayList<>();
        String sql = "select * from Lesson where courseID = ? AND type = 'Subject Topic' AND status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Lesson lesson = getLessonByLessonID(rs.getInt(1));
                listLesson.add(lesson);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listLesson;
    }

    // Lấy danh sách Lesson có của 1 Lesson type = subject topic (module)
    // ko cần courseID nữa vì topicID nó ko lặp lại
    public List<Lesson> getAllLessonBySubjectTopicLesson(int topicID) {
        List<Lesson> listLesson = new ArrayList<>();
        String sql = "select * from Lesson where topicID = ? AND status = 'Active'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, topicID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Lesson lesson = getLessonByLessonID(rs.getInt(1));
                listLesson.add(lesson);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listLesson;
    }

    // Lấy danh sách tất cả sub lesson trong courseID theo thứ tự tăng
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