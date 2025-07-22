/*
 * Click nb fs://nb fs/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nb fs://nb fs/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu

import model.AnswerOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Question;

/**
 *
 * @author gtrun
 */
public class AnswerOptionDAO extends DBContext {

    private static AnswerOptionDAO instance;

    public static AnswerOptionDAO getInstance() {
        if (instance == null) {
            instance = new AnswerOptionDAO();
        }
        return instance;
    }


    public AnswerOptionDAO() {
        super();
    }

     // Phương thức lấy các câu trả lời theo ID câu hỏi
    public List<AnswerOption> getAnswersByQuestionId(int questionID) {
        List<AnswerOption> answers = new ArrayList<>();
        String sql = "SELECT answerOptionID, questionID, content, isCorrect FROM AnswerOption WHERE questionID = ?";

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, questionID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AnswerOption answer = new AnswerOption();
                answer.setAnswerOptionID(rs.getInt("answerOptionID"));
                answer.setQuestionID(rs.getInt("questionID"));
                answer.setContent(rs.getString("content"));
                answer.setIsCorrect(rs.getBoolean("isCorrect")); // Sử dụng setCorrect()
                answers.add(answer);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy câu trả lời theo questionID: " + e.getMessage());
            e.printStackTrace();
        }
        return answers;
    }

    //Hàm lưu đáp án
    public void saveAnswerOption(AnswerOption option, Connection conn) throws SQLException {
        String sql = "INSERT INTO AnswerOption (questionID, content, isCorrect) VALUES (?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, option.getQuestionID());
            ps.setString(2, option.getContent());
            ps.setBoolean(3, option.isCorrect());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AnswerOptionDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    // Phương thức thêm một câu trả lời mới
    public int addAnswer(AnswerOption answer) {
        String sql = "INSERT INTO AnswerOption (questionID, content, isCorrect) VALUES (?, ?, ?)";
        String[] generatedColumns = {"answerOptionID"};

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, generatedColumns)) {
            ps.setInt(1, answer.getQuestionID());
            ps.setString(2, answer.getContent());
            ps.setBoolean(3, answer.isCorrect());
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }


    public boolean updateAnswer(AnswerOption answer) {
        String sql = "UPDATE AnswerOption SET content = ?, isCorrect = ? WHERE answerOptionID = ? AND questionID = ?";

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, answer.getContent());
            ps.setBoolean(2, answer.isCorrect());
            ps.setInt(3, answer.getAnswerOptionID());
            ps.setInt(4, answer.getQuestionID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean deleteAnswer(int answerOptionID) { 
        String sql = "DELETE FROM AnswerOption WHERE answerOptionID = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, answerOptionID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean deleteAnswersByQuestionId(int questionID) { 
        String sql = "DELETE FROM AnswerOption WHERE questionID = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, questionID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    
}
