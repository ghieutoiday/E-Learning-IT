/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.QuestionDTO;
import dto.QuizHandleDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.AnswerOption;
import model.DimensionResult;
import model.Question;

/**
 *
 * @author ASUS
 */
public class QuizHandleDTO_DAO extends DBContext {

    private static QuizHandleDTO_DAO instance;

    private QuizHandleDTO_DAO() {
        super();
    }

    public static QuizHandleDTO_DAO getInstance() {
        if (instance == null) {
            synchronized (QuizHandleDTO_DAO.class) {
                if (instance == null) {
                    instance = new QuizHandleDTO_DAO();
                }
            }
        }
        return instance;
    }

    //Lấy danh sách đáp án
    public List<AnswerOption> getAnswerOfAQuestion(int questionID) {
        List<AnswerOption> listAnswer = new ArrayList<>();
        try {
            String sql = "Select * from AnswerOption Where questionID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, questionID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int answerOptionID = rs.getInt(1);
                String content = rs.getString(3);
                int isCorrectInt = rs.getInt(4);
                boolean isCorrect = false;
                if (isCorrectInt == 1) {
                    isCorrect = true;
                }
                //Lấy entity
                AnswerOption ao = new AnswerOption(answerOptionID, questionID, content, isCorrect);

                listAnswer.add(ao);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return listAnswer;
    }
    
    //Lấy ra 1 câu hỏi có bao gồm đáp án
    public QuestionDTO getQuestionWithAnswerByQuestionID (int questionID) {
        Question question = QuestionDAO.getInstance().getQuestionByQuestionID(questionID);
        List<AnswerOption> listAnswer = QuizHandleDTO_DAO.getInstance().getAnswerOfAQuestion(questionID);
        QuestionDTO questionDTO = new QuestionDTO(question, listAnswer);
        
        return questionDTO;
    }
    
    //Lấy ra 1 list câu hỏi có đáp án trong 1 bài Quiz cụ thể
    public List<QuestionDTO> getAllQuestionInQuiz(int quizID) {
        List<QuestionDTO> listAllQuestionInQuiz = new ArrayList<>();
        try {
            String sql = """
                         SELECT q.questionID, q.content, q.media, q.explanation, q.level, q.status, q.createDate, q.updateDate
                         FROM Question q
                         INNER JOIN QuizQuestion qq ON q.questionID = qq.questionID
                         WHERE qq.quizID = ?
                         ORDER BY qq.quizQuestionID;""";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quizID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int questionID = rs.getInt(1);
                //Lấy entity
                QuestionDTO questionDTO  = this.getQuestionWithAnswerByQuestionID(questionID);

                listAllQuestionInQuiz.add(questionDTO);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return listAllQuestionInQuiz;
    }
    
    //Lấy ra 1 bài Quiz để hiển thị trên quiz-handle
    public QuizHandleDTO getQuizHandleDTO (int quizID) {
        List<QuestionDTO> listAllQuestionInQuiz = QuizHandleDTO_DAO.getInstance().getAllQuestionInQuiz(quizID);
        QuizHandleDTO quizHandleDTO = new QuizHandleDTO(quizID, listAllQuestionInQuiz);
        
        return quizHandleDTO;
    }
    
    
    public static void main(String[] args) {
        System.out.println(QuizHandleDTO_DAO.getInstance().getQuizHandleDTO(4).getListQuestionDTO().get(0).getQuestion().getQuestionID());
    }
}
