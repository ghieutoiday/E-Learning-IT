/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import model.Lesson;
import model.User;
import model.UserLessonProgress;

/**
 *
 * @author ASUS
 */
public class UserLessonProgressDAO extends DBContext {

    private static UserLessonProgressDAO instance;

    public static UserLessonProgressDAO getInstance() {
        if (instance == null) {
            instance = new UserLessonProgressDAO();
        }
        return instance;
    }

    UserDAO userDAO = new UserDAO();
    LessonDAO lessonDAO = new LessonDAO();

    // Lấy 1 bài UserLessonProgress với ID cụ thể
    public UserLessonProgress getUserLessonProgressByUserLessonProgressID(int userLessonProgressID) {
        UserLessonProgress userLessonProgress = null;
        try {
            String sql = "Select * from UserLessonProgress where userLessonProgressID = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userLessonProgressID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  // Kiểm tra xem còn dữ liệu trong rs hay không
                User user = userDAO.getUserByID(rs.getInt(2));
                Lesson lesson = lessonDAO.getLessonByLessonID(rs.getInt(3));
                String status = rs.getString(4);
                Date completeDate = rs.getDate(5);
                Date createDate = rs.getDate(6);
                Date updateDate = rs.getDate(7);
                // Lấy entity
                userLessonProgress = new UserLessonProgress(userLessonProgressID, user, lesson, status, completeDate, createDate, updateDate);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return userLessonProgress;
    }

    // Kiểm tra xem bản ghi UserLessonProgress có tồn tại với userID và lessonID
    public UserLessonProgress getUserLessonProgressByUserAndLesson(int userID, int lessonID) {
        UserLessonProgress userLessonProgress = null;
        try {
            String sql = "SELECT * FROM UserLessonProgress WHERE userID = ? AND lessonID = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, lessonID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = userDAO.getUserByID(rs.getInt(2));
                Lesson lesson = lessonDAO.getLessonByLessonID(rs.getInt(3));
                String status = rs.getString(4);
                Date completeDate = rs.getDate(5);
                Date createDate = rs.getDate(6);
                Date updateDate = rs.getDate(7);
                userLessonProgress = new UserLessonProgress(rs.getInt(1), user, lesson, status, completeDate, createDate, updateDate);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return userLessonProgress;
    }

    // Tạo bản ghi UserLessonProgress mới
    public void createUserLessonProgress(int userID, int lessonID, String status) {
        try {
            String sql = "INSERT INTO UserLessonProgress (userID, lessonID, status, createDate, updateDate) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, lessonID);
            ps.setString(3, status);
            ps.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
            ps.setTimestamp(5, new java.sql.Timestamp(new Date().getTime()));
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Cập nhật trạng thái UserLessonProgress sang Completed
    public void updateUserLessonProgressToCompleted(int userID, int lessonID) {
        try {
            String sql = "UPDATE UserLessonProgress SET status = ?, completeDate = ?, updateDate = ? WHERE userID = ? AND lessonID = ? AND status = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "Completed");
            ps.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
            ps.setTimestamp(3, new java.sql.Timestamp(new Date().getTime()));
            ps.setInt(4, userID);
            ps.setInt(5, lessonID);
            ps.setString(6, "InProgress");
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        UserLessonProgressDAO dao = new UserLessonProgressDAO();
        System.out.println(dao.getUserLessonProgressByUserLessonProgressID(24).getUpdateDate());
    }
}