/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.DimensionResult;
import model.QuizLessonDTO;

/**
 *
 * @author ASUS
 */
public class QuizLessonDTO_DAO extends DBContext{

    private static QuizLessonDTO_DAO instance;

    private QuizLessonDTO_DAO() {
        super();
    }

    public static QuizLessonDTO_DAO getInstance() {
        if (instance == null) {
            synchronized (QuizLessonDTO_DAO.class) {
                if (instance == null) {
                    instance = new QuizLessonDTO_DAO();
                }
            }
        }
        return instance;
    }

    public List<DimensionResult> getDimensionResultByUserIdAndQuizId(int userID, int quizID) {
        List<DimensionResult> listAllDimensionResults = new ArrayList<>();

        try {
            String sql = """
                     SELECT  
                             sd.type AS dimensionType,
                             sd.name AS dimensionName,
                             COUNT(*) AS totalQuestions,
                             SUM(CASE WHEN uqa.isCorrect = 1 THEN 1 ELSE 0 END) AS correctCount
                         FROM UserQuizAnswer uqa
                         JOIN QuizQuestion qq ON uqa.questionID = qq.questionID AND uqa.quizID = qq.quizID
                         JOIN Question q ON qq.questionID = q.questionID
                         JOIN SubjectDimension sd ON q.dimensionID = sd.dimensionID
                         WHERE uqa.userID = ?
                         AND uqa.quizID =  ?
                         GROUP BY uqa.userID, uqa.quizID, sd.name, sd.type""";
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, quizID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                String dimensionType = rs.getString(1);
                String dimensionName = rs.getString(2);
                int totalQuestions = rs.getInt(3);
                int correctCount = rs.getInt(4);
                //Lấy entity
                DimensionResult dr = new DimensionResult(dimensionType, dimensionName, totalQuestions, correctCount);
                
                listAllDimensionResults.add(dr);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return listAllDimensionResults;
    }
    
    public QuizLessonDTO getQuizLessonDTOByUserIdAndQuizId(int userID, int quizID) {
        QuizLessonDTO quizLessonDTO = null;
        
        try {
            String sql = """
                         SELECT 
                             uqa.userID,
                             uqa.quizID,
                             uqa.startTime,
                             COUNT(*) AS totalQuestions,
                             SUM(CASE WHEN uqa.isCorrect = 1 THEN 1 ELSE 0 END) AS correctAnswers,
                             SUM(CASE WHEN uqa.selectedAnswerID IS NULL THEN 1 ELSE 0 END) AS unansweredQuestions,
                             DATEDIFF(SECOND, uqa.startTime, uqa.endTime) AS actualQuizTime,
                             CASE 
                                 WHEN SUM(CASE WHEN uqa.isCorrect = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) >= (SELECT passRate FROM Quiz WHERE quizID = uqa.quizID)
                                 THEN 'Pass'
                                 ELSE 'Fail'
                             END AS quizStatus
                         FROM UserQuizAnswer uqa
                         WHERE uqa.userID = ?
                         AND uqa.quizID = ?
                         GROUP BY uqa.userID, uqa.quizID, uqa.startTime, uqa.endTime;""";
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, quizID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                LocalDateTime startTime = rs.getTimestamp("startTime").toLocalDateTime();
                int actualQuizTime = rs.getInt("actualQuizTime");
                int correctAnswers = rs.getInt("correctAnswers");
                int unansweredQuestions = rs.getInt("unansweredQuestions");
                int totalQuestions = rs.getInt("totalQuestions");
                String quizStatus = rs.getString("quizStatus");
                List<DimensionResult> dr = this.getDimensionResultByUserIdAndQuizId(userID, quizID);
                
                //Lấy entity
                quizLessonDTO = new QuizLessonDTO(startTime, actualQuizTime, correctAnswers, unansweredQuestions, totalQuestions, dr, quizStatus);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return quizLessonDTO;
    }
    
    public static void main(String[] args) {
        System.out.println(QuizLessonDTO_DAO.getInstance().getQuizLessonDTOByUserIdAndQuizId(5, 4).getStartTime().getYear()
                + "-" + QuizLessonDTO_DAO.getInstance().getQuizLessonDTOByUserIdAndQuizId(5, 4).getStartTime().getMonthValue()
                + "-" + QuizLessonDTO_DAO.getInstance().getQuizLessonDTOByUserIdAndQuizId(5, 4).getStartTime().getHour());
    }
}
