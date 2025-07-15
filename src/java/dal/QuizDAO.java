/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.Lesson;
import model.Quiz;

/**
 *
 * @author ASUS
 */
public class QuizDAO extends DBContext {

    private static QuizDAO instance;
    CourseDAO courseDAO = new CourseDAO();
    LessonDAO lessonDAO = new LessonDAO();

    private QuizDAO() {
        super();
    }

    public static QuizDAO getInstance() {
        if (instance == null) {
            synchronized (QuizDAO.class) {
                if (instance == null) {
                    instance = new QuizDAO();
                }
            }
        }
        return instance;
    }

    // Lấy 1 bài Quiz với ID cụ thể
    public Quiz getQuizByQuizID(int quizID) {
        Quiz quiz = null;
        try {
            String sql = "Select * from Quiz where quizID = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quizID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Lesson lesson = lessonDAO.getLessonByLessonID(rs.getInt(2));
                String name = rs.getString(3);
                Course course = courseDAO.getCoureByCourseID(rs.getInt(4));
                int level = rs.getInt(5);
                int numberQuestions = rs.getInt(6);
                int duration = rs.getInt(7);
                Double passRate = rs.getDouble(8);
                String quizType = rs.getString(9);
                String des = rs.getString(10);
                //Lấy entity
                quiz = new Quiz(quizID, lesson, name, course, level, numberQuestions, duration, passRate, quizType, des);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return quiz;
    }

    // Lấy 1 bài Quiz với LessonID cụ thể
    public Quiz getQuizByLessonID(int lessonID) {
        Quiz quiz = null;
        try {
            String sql = "Select * from Quiz where lessonID = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, lessonID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int quizID = rs.getInt(1);
                Lesson lesson = lessonDAO.getLessonByLessonID(lessonID);
                String name = rs.getString(3);
                Course course = courseDAO.getCoureByCourseID(rs.getInt(4));
                int level = rs.getInt(5);
                int numberQuestions = rs.getInt(6);
                int duration = rs.getInt(7);
                Double passRate = rs.getDouble(8);
                String quizType = rs.getString(9);
                String des = rs.getString(10);
                //Lấy entity
                quiz = new Quiz(quizID, lesson, name, course, level, numberQuestions, duration, passRate, quizType, des);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return quiz;
    }

    //Filter bài Quiz theo Subject
    public List<Quiz> getAllQuizBySubjectID(int subjectID) {
        List<Quiz> listQuiz = new ArrayList<>();
        String sql = "select * from Quiz where courseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subjectID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Quiz quiz = getQuizByQuizID(rs.getInt(1));
                listQuiz.add(quiz);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listQuiz;
    }

    //Filter bài Quiz theo QuizType
    public List<Quiz> getAllQuizByQuizType(String quizType) {
        List<Quiz> listQuiz = new ArrayList<>();
        String sql = "select * from Quiz where quizType = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, quizType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Quiz quiz = getQuizByQuizID(rs.getInt(1));
                listQuiz.add(quiz);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listQuiz;
    }

    //Lấy ra toàn bộ Quiz
    public List<Quiz> getAllQuiz() {
        List<Quiz> listQuiz = new ArrayList<>();
        String sql = "select * from Quiz";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Quiz quiz = getQuizByQuizID(rs.getInt(1));
                listQuiz.add(quiz);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listQuiz;
    }

    public List<String> getAllQuizType() {
        List<String> listQuizType = new ArrayList<>();
        String sql = "select DISTINCT quizType from Quiz";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                listQuizType.add(rs.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listQuizType;
    }

    // Truy vấn danh sách Quiz có phân trang, lọc theo từ khóa (search), subject, quizType
    public List<Quiz> getFilteredQuizzes(String search, int courseID, String quizType, int page, int rowsPerPage) {
        List<Quiz> listQuiz = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT * FROM [CourseManagementDB].[dbo].[Quiz] WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND [name] LIKE ?");
            params.add("%" + search + "%");
        }

        if (courseID != -1) {
            sql.append(" AND courseID = ? ");
            params.add(courseID);
        }

        if ((quizType != null && !quizType.equals("-1") && !quizType.isEmpty())) {
            sql.append(" AND quizType = ? ");
            params.add(quizType);
        }

        sql.append(" ORDER BY quizID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            stmt.setInt(params.size() + 1, (page - 1) * rowsPerPage);
            stmt.setInt(params.size() + 2, rowsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz(
                            rs.getInt("quizID"),
                            lessonDAO.getLessonByLessonID(rs.getInt("lessonID")),
                            rs.getString("name"),
                            courseDAO.getCourseByIdd(rs.getInt("courseID")),
                            rs.getInt("level"),
                            rs.getInt("numQuestions"),
                            rs.getInt("duration"),
                            rs.getDouble("passRate"),
                            rs.getString("quizType"),
                            rs.getString("description")
                    );
                    //Add list
                    listQuiz.add(quiz);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return listQuiz;
    }

    // Đếm tổng số Quiz theo điều kiện lọc
    public int getTotalFilteredQuizzes(String search, int courseID, String quizType) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM [CourseManagementDB].[dbo].[Quiz] WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND [name] LIKE ?");
            params.add("%" + search + "%");
        }

        if (courseID != -1) {
            sql.append(" AND courseID = ? ");
            params.add(courseID);
        }

        if (quizType != null && !quizType.equals("-1") && !quizType.isEmpty()) {
            sql.append(" AND quizType = ? ");
            params.add(quizType);
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }
    
    

    public static void main(String[] args) {
        QuizDAO quizDAO = QuizDAO.getInstance(); // <-- dùng Singleton
        System.out.println(quizDAO.getQuizByLessonID(15).getName());
    }

}
