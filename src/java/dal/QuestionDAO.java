/*
 * Click nb fs://nb fs/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nb fs://nb fs/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu
import model.Question;
import model.AnswerOption;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gtrun
 */
public class QuestionDAO extends DBContext {

    private AnswerOptionDAO answerOptionDAO;

    public QuestionDAO() {
        super();
        answerOptionDAO = new AnswerOptionDAO();
    }

    //Hàm lưu câu hỏi và đáp án
    public int saveQuestion(Question question, List<AnswerOption> answerOptions) {
        String sql = "INSERT INTO Question (courseID, lessonID, dimensionID, typeQuestionID, content, media, explanation, level, status, createDate) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        int questionID = 0;

        try {
            connection.setAutoCommit(false);
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, question.getCourseID());
            ps.setInt(2, question.getLessonID());
            ps.setInt(3, question.getDimensionID());
            ps.setInt(4, question.getTypeQuestionID());
            ps.setString(5, question.getContent());
            ps.setString(6, question.getMedia());
            ps.setString(7, question.getExplanation());
            ps.setInt(8, question.getLevel());
            ps.setString(9, question.getStatus());
            ps.executeUpdate();

            // Lấy questionID vừa tạo
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                questionID = rs.getInt(1);
            }

            // Lưu các đáp án
            for (AnswerOption option : answerOptions) {
                option.setQuestionID(questionID);
                answerOptionDAO.saveAnswerOption(option, connection); // Sửa ở đây: truyền connection
            }

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return questionID;
    }

    //Hàm kiểm tra khóa ngoại
    public boolean validateForeignKeys(int courseID, int lessonID, int dimensionID, int typeQuestionID) {
        String sql = "SELECT 1 FROM Course WHERE courseID = ? " +
                "AND EXISTS (SELECT 1 FROM Lesson WHERE lessonID = ? AND courseID = ?) " +
                "AND EXISTS (SELECT 1 FROM SubjectDimension WHERE dimensionID = ? AND courseID = ?) " +
                "AND EXISTS (SELECT 1 FROM TypeQuestion WHERE typeQuestionId = ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ps.setInt(2, lessonID);
            ps.setInt(3, courseID);
            ps.setInt(4, dimensionID);
            ps.setInt(5, courseID);
            ps.setInt(6, typeQuestionID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        QuestionDAO qd = new QuestionDAO();
        // Test validateForeignKeys
        boolean valid = qd.validateForeignKeys(1, 1, 1, 1);
        System.out.println("Foreign keys valid: " + valid);
    }
}