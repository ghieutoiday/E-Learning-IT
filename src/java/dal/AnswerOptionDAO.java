/*
 * Click nb fs://nb fs/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nb fs://nb fs/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu
import model.AnswerOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gtrun
 */
public class AnswerOptionDAO extends DBContext {

    public AnswerOptionDAO() {
        super();
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

    public static void main(String[] args) {
        AnswerOptionDAO dao = new AnswerOptionDAO();
        AnswerOption option = new AnswerOption(1, "Sample answer", true);
        try {
            // Test cần Connection, đây chỉ là demo
            System.out.println("Test saveAnswerOption requires a Connection object.");
        } catch (Exception ex) {
            Logger.getLogger(AnswerOptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}