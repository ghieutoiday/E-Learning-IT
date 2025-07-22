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
import model.Course;
import model.SubjectDimension;

public class QuestionDAO extends DBContext {
    
    private static QuestionDAO instance;

    public static QuestionDAO getInstance() {

        if (instance == null) {
            instance = new QuestionDAO();
        }

        return instance;
    }

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
    
    public Question getQuestionByQuestionID(int questionID) {
        Question question = null;
        try {
            String sql = "Select * from Question where questionID = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
             ps.setInt(1, questionID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                
            int courseID = rs.getInt("courseID");
            int dimensionID = rs.getInt("dimensionID");
            int typeQuestionID = rs.getInt("typeQuestionID");
            String content = rs.getString("content");
            String media = rs.getString("media");
            String explanation = rs.getString("explanation");
            int level = rs.getInt("level");
            String status = rs.getString("status");
 
                //Lấy entity
                question = new Question(questionID, courseID, dimensionID, typeQuestionID, content, media, explanation, level, status);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return question;
    }
    
    // hàm update question
    public void updateQuestion(Question question) {
        String sql = "UPDATE Question SET "
                + "[courseID] = ?, "
                + "[dimensionID] = ?, "
                + "[content] = ?, "
                + "[explanation] = ?, "
                + "[status] = ? "
                + "WHERE [questionID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, question.getCourseID());
            st.setInt(2, question.getDimensionID());
            st.setString(3, question.getContent());
            st.setString(4, question.getExplanation());
            st.setString(5, question.getStatus());
            st.setInt(6, question.getQuestionID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updateQuestion: " + e.getMessage());
        }
    }
    
    //Hàm kiểm tra khóa ngoại
    public boolean validateForeignKeys(int courseID, int lessonID, int dimensionID, int typeQuestionID) {
        String sql = "SELECT 1 FROM Course WHERE courseID = ? "
                + "AND EXISTS (SELECT 1 FROM Lesson WHERE lessonID = ? AND courseID = ?) "
                + "AND EXISTS (SELECT 1 FROM SubjectDimension WHERE dimensionID = ? AND courseID = ?) "
                + "AND EXISTS (SELECT 1 FROM TypeQuestion WHERE typeQuestionId = ?)";

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
    /**
     * Lấy danh sách tất cả các khóa học để hiển thị trong bộ lọc.
     * @return Danh sách các đối tượng Course.
     */
//    public List<Course> getAllCourses() {
//        List<Course> list = new ArrayList<>();
//        String sql = "SELECT courseID, courseName FROM Course";
//        try (PreparedStatement st = connection.prepareStatement(sql);
//             ResultSet rs = st.executeQuery()) {
//            while (rs.next()) {
//                Course c = new Course();
//                c.setCourseID(rs.getInt("courseID"));
//                c.setCourseName(rs.getString("courseName"));
//                list.add(c);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return list;
//    }
    
    /**
     * Lấy danh sách tất cả các chiều hướng (dimension) để tra cứu.
     * @return Danh sách các đối tượng SubjectDimension.
     */
    public List<SubjectDimension> getAllDimensions() {
        List<SubjectDimension> list = new ArrayList<>();
        String sql = "SELECT dimensionID, name FROM SubjectDimension";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                SubjectDimension sd = new SubjectDimension();
                sd.setDimensionID(rs.getInt("dimensionID"));
                sd.setName(rs.getString("name"));
                list.add(sd);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     * Lấy danh sách câu hỏi đã được lọc và phân trang.
     * @param courseId ID của khóa học để lọc.
     * @param dimensionId ID của chiều hướng để lọc.
     * @param level Cấp độ để lọc.
     * @param status Trạng thái để lọc ('Active' hoặc 'Inactive').
     * @param search Từ khóa tìm kiếm trong nội dung câu hỏi.
     * @param page Trang hiện tại.
     * @param pageSize Số lượng câu hỏi trên mỗi trang.
     * @return Danh sách các đối tượng Question thỏa mãn điều kiện.
     */
    public List<Question> getFilteredQuestions(int courseId, int dimensionId, int level, String status, String search, int page, int pageSize) {
        List<Question> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Question WHERE 1=1 ");

        if (courseId > 0) sql.append("AND courseID = ? ");
        if (dimensionId > 0) sql.append("AND dimensionID = ? ");
        if (level > 0) sql.append("AND level = ? ");
        if (status != null && !status.isEmpty()) sql.append("AND status = ? ");
        if (search != null && !search.isEmpty()) sql.append("AND content LIKE ? ");
        
        sql.append("ORDER BY questionID ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            if (courseId > 0) st.setInt(paramIndex++, courseId);
            if (dimensionId > 0) st.setInt(paramIndex++, dimensionId);
            if (level > 0) st.setInt(paramIndex++, level);
            if (status != null && !status.isEmpty()) st.setString(paramIndex++, status);
            if (search != null && !search.isEmpty()) st.setString(paramIndex++, "%" + search + "%");
            
            st.setInt(paramIndex++, (page - 1) * pageSize);
            st.setInt(paramIndex++, pageSize);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Question q = new Question();
                q.setQuestionID(rs.getInt("questionID"));
                q.setCourseID(rs.getInt("courseID"));
                q.setDimensionID(rs.getInt("dimensionID"));
                q.setContent(rs.getString("content"));
                q.setLevel(rs.getInt("level"));
                q.setStatus(rs.getString("status"));
                list.add(q);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    

    /**
     * Đếm tổng số câu hỏi thỏa mãn điều kiện lọc để tính toán phân trang.
     * @param courseId ID của khóa học.
     * @param dimensionId ID của chiều hướng.
     * @param level Cấp độ.
     * @param status Trạng thái.
     * @param search Từ khóa tìm kiếm.
     * @return Tổng số câu hỏi.
     */
    
    public int getFilteredQuestionCount(int courseId, int dimensionId, int level, String status, String search) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Question WHERE 1=1 ");
        
        if (courseId > 0) sql.append("AND courseID = ? ");
        if (dimensionId > 0) sql.append("AND dimensionID = ? ");
        if (level > 0) sql.append("AND level = ? ");
        if (status != null && !status.isEmpty()) sql.append("AND status = ? ");
        if (search != null && !search.isEmpty()) sql.append("AND content LIKE ? ");

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            if (courseId > 0) st.setInt(paramIndex++, courseId);
            if (dimensionId > 0) st.setInt(paramIndex++, dimensionId);
            if (level > 0) st.setInt(paramIndex++, level);
            if (status != null && !status.isEmpty()) st.setString(paramIndex++, status);
            if (search != null && !search.isEmpty()) st.setString(paramIndex++, "%" + search + "%");
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
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