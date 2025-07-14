package dal;

import model.Question;
import model.AnswerOption;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class QuestionDAO extends DBContext {

    private AnswerOptionDAO answerOptionDAO;

    public QuestionDAO() {
        super();
        answerOptionDAO = new AnswerOptionDAO();
    }

    /**
     * Lưu một câu hỏi và các tùy chọn trả lời liên quan vào cơ sở dữ liệu.
     * Thao tác này được thực hiện trong một giao dịch để đảm bảo tính nguyên tử.
     *
     * @param question Đối tượng Question cần lưu.
     * @param answerOptions Danh sách các đối tượng AnswerOption liên quan đến câu hỏi.
     * @return questionID được tạo nếu thành công, 0 nếu không.
     */
    public int saveQuestion(Question question, List<AnswerOption> answerOptions) {
        String sql = "INSERT INTO Question (courseID, dimensionID, typeQuestionID, content, media, explanation, level, status, createDate) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        int questionID = 0;

        try {
            connection.setAutoCommit(false); // Bắt đầu giao dịch
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, question.getCourseID());
            // Đã loại bỏ ps.setInt(2, question.getLessonID()); vì lessonID không còn trong mô hình Question
            ps.setInt(2, question.getDimensionID());
            ps.setInt(3, question.getTypeQuestionID());
            ps.setString(4, question.getContent());
            ps.setString(5, question.getMedia());
            ps.setString(6, question.getExplanation());
            ps.setInt(7, question.getLevel());
            ps.setString(8, question.getStatus());
            ps.executeUpdate();

            // Lấy questionID tự động tạo
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                questionID = rs.getInt(1);
            }

            // Lưu các tùy chọn trả lời, liên kết chúng với questionID vừa tạo
            for (AnswerOption option : answerOptions) {
                option.setQuestionID(questionID);
                answerOptionDAO.saveAnswerOption(option, connection); // Truyền kết nối hiện tại cho giao dịch
            }

            connection.commit(); // Hoàn tất giao dịch
        } catch (SQLException ex) {
            try {
                connection.rollback(); // Hoàn tác khi có lỗi
            } catch (SQLException rollbackEx) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi trong quá trình rollback cho saveQuestion", rollbackEx);
            }
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lưu câu hỏi và các tùy chọn trả lời", ex);
        } finally {
            try {
                connection.setAutoCommit(true); // Khôi phục chế độ tự động commit
            } catch (SQLException ex) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi đặt lại tự động commit cho saveQuestion", ex);
            }
        }
        return questionID;
    }

    /**
     * Xác thực xem các khóa ngoại đã cung cấp (courseID, dimensionID, typeQuestionID) có tồn tại
     * và nhất quán trong cơ sở dữ liệu hay không.
     * Lưu ý: Việc kiểm tra lessonID đã được loại bỏ vì nó không còn là một phần của mô hình Question.
     *
     * @param courseID ID của khóa học.
     * @param dimensionID ID của chiều (dimension).
     * @param typeQuestionID ID của loại câu hỏi.
     * @return true nếu tất cả các khóa ngoại hợp lệ, ngược lại là false.
     */
    public boolean validateForeignKeys(int courseID, int dimensionID, int typeQuestionID) {
        String sql = "SELECT 1 FROM Course WHERE courseID = ? " +
                "AND EXISTS (SELECT 1 FROM SubjectDimension WHERE dimensionID = ? AND courseID = ?) " +
                "AND EXISTS (SELECT 1 FROM TypeQuestion WHERE typeQuestionId = ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ps.setInt(2, dimensionID);
            ps.setInt(3, courseID);
            ps.setInt(4, typeQuestionID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi xác thực khóa ngoại", ex);
        }
        return false;
    }

    public static void main(String[] args) {
        QuestionDAO qd = new QuestionDAO();
        // Kiểm tra validateForeignKeys
        // Lưu ý: Vì lessonID đã bị loại bỏ, hãy điều chỉnh dữ liệu kiểm tra cho phù hợp.
        // Kiểm tra này giả định courseID=1, dimensionID=1, typeQuestionID=1 tồn tại và hợp lệ.
        boolean valid = qd.validateForeignKeys(1, 1, 1);
        System.out.println("Các khóa ngoại hợp lệ: " + valid);

        // Ví dụ về cách sử dụng saveQuestion (bạn sẽ cần tạo các đối tượng Question và AnswerOption giả)
        /*
        try {
            Question newQuestion = new Question();
            newQuestion.setCourseID(1);
            newQuestion.setDimensionID(1);
            newQuestion.setTypeQuestionID(1);
            newQuestion.setContent("2 cộng 2 bằng mấy?");
            newQuestion.setMedia(null);
            newQuestion.setExplanation("Phép tính cơ bản");
            newQuestion.setLevel(1);
            newQuestion.setStatus("Active");

            List<AnswerOption> options = new ArrayList<>();
            options.add(new AnswerOption(0, 0, "3", false)); // questionID sẽ được đặt bởi saveQuestion
            options.add(new AnswerOption(0, 0, "4", true));
            options.add(new AnswerOption(0, 0, "5", false));

            int savedQuestionID = qd.saveQuestion(newQuestion, options);
            if (savedQuestionID > 0) {
                System.out.println("Câu hỏi đã được lưu thành công với ID: " + savedQuestionID);
            } else {
                System.out.println("Không thể lưu câu hỏi.");
            }
        } catch (Exception e) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi trong quá trình kiểm tra main", e);
        }
        */
    }
}