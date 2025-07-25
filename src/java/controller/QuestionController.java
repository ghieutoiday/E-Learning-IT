package controller;

import dal.AnswerOptionDAO;
import dal.CourseDAO;
import dal.QuestionDAO;
import dal.SubjectDimensionDAO;
import model.Question;
import model.AnswerOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

@WebServlet("/questioncontroller")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Kích thước file tối đa 10MB
public class QuestionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(QuestionController.class.getName());

    private CourseDAO courseDAO;
    private SubjectDimensionDAO subjectDimensionDAO;
    private AnswerOptionDAO answerOptionDAO;
    private QuestionDAO questionDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        subjectDimensionDAO = new SubjectDimensionDAO();
        answerOptionDAO = new AnswerOptionDAO();
        questionDAO = new QuestionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("loggedInUser");

        // Kiểm tra quyền Expert
        if (currentUser == null || currentUser.getRole().getRoleID() != 4) {
            request.setAttribute("errorMessage", "Bạn không có quyền thực hiện hành động này.");
            response.sendRedirect("home");
            return;
        }
        if ("edit".equalsIgnoreCase(action)) {
            String questionIDParam = request.getParameter("questionID");
            int questionID = Integer.parseInt(questionIDParam);
            Question question = questionDAO.getQuestionByQuestionID(questionID);
            request.setAttribute("question", question);
            request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
            request.setAttribute("dimensionList", subjectDimensionDAO.getAllDistinctDimensionByName());
            request.setAttribute("answers", answerOptionDAO.getAnswersByQuestionId(questionID));
            request.getRequestDispatcher("Question-Detail.jsp").forward(request, response);
        } else {
            // Mặc định forward về questionList.jsp thay vì questionList.jsp
            request.getRequestDispatcher("/questionList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("loggedInUser");

        // Kiểm tra quyền Expert
        if (currentUser == null || currentUser.getRole().getRoleID() != 4) {
            response.sendRedirect("home");
            return;
        }

        if ("import".equals(action)) {
            Part filePart = request.getPart("file");
            List<String> errors = new ArrayList<>();
            int successCount = 0;

            String courseIdParam = request.getParameter("courseIdParam");
            String lessonIdParam = request.getParameter("lessonIdParam");

            int courseID = -1;

            try {
                if (courseIdParam != null && !courseIdParam.isEmpty()) {
                    courseID = Integer.parseInt(courseIdParam);
                } else {
                    errors.add("Không tìm thấy courseID.");
                }
            } catch (NumberFormatException e) {
                errors.add("Định dạng courseID không hợp lệ.");
                LOGGER.log(Level.WARNING, "Định dạng courseIdParam không hợp lệ: " + e.getMessage());
            }

            if (!errors.isEmpty()) {
                response.sendRedirect("questionList");
                return;
            }

            if (filePart == null || filePart.getSize() == 0) {
                errors.add("Vui lòng chọn file TXT hoặc CSV để import.");
            } else {
                String DELIMITER = "\\|";

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(filePart.getInputStream()))) {
                    String headerLine = reader.readLine();
                    if (headerLine == null) {
                        errors.add("Tệp rỗng hoặc không có tiêu đề.");
                    } else {
                        String lineContent;
                        while ((lineContent = reader.readLine()) != null) {
                            try {
                                String[] line = lineContent.split(DELIMITER);

                                if (line.length < 7) {
                                    errors.add("Dòng dữ liệu không đủ số cột: " + lineContent);
                                    continue;
                                }

                                int dimensionID = Integer.parseInt(line[0].trim());
                                int typeQuestionID = Integer.parseInt(line[1].trim());
                                String content = line[2].trim();
                                String media = line[3].trim().isEmpty() ? null : line[3].trim();
                                String explanation = line[4].trim().isEmpty() ? null : line[4].trim();
                                int level = Integer.parseInt(line[5].trim());
                                String status = line[6].trim();

                                if (!questionDAO.validateForeignKeys(courseID, dimensionID, typeQuestionID)) {
                                    errors.add("Khóa ngoại không hợp lệ cho câu hỏi: '" + content + "' (dimensionID: " + dimensionID + ", typeQuestionID: " + typeQuestionID + ", CourseID: " + courseID + ").");
                                    continue;
                                }

                                if (!status.equals("Active") && !status.equals("Inactive")) {
                                    errors.add("Trạng thái không hợp lệ cho câu hỏi: '" + content + "'. Trạng thái phải là 'Active' hoặc 'Inactive'.");
                                    continue;
                                }

                                Question question = new Question(0, courseID, dimensionID, typeQuestionID, content,
                                        media, explanation, level, status);

                                List<AnswerOption> answerOptions = new ArrayList<>();
                                for (int i = 7; i < line.length; i += 2) {
                                    if (i + 1 < line.length) {
                                        String answerContent = line[i].trim();
                                        boolean isCorrect = line[i + 1].trim().equals("1");
                                        answerOptions.add(new AnswerOption(0, answerContent, isCorrect));
                                    } else {
                                        errors.add("Dữ liệu đáp án không đầy đủ cho câu hỏi: '" + content + "'.");
                                        break;
                                    }
                                }

                                if (answerOptions.isEmpty()) {
                                    errors.add("Không có đáp án nào được cung cấp cho câu hỏi: '" + content + "'.");
                                    continue;
                                }

                                if (answerOptions.stream().noneMatch(AnswerOption::isCorrect)) {
                                    errors.add("Không có đáp án đúng nào được cung cấp cho câu hỏi: '" + content + "'.");
                                    continue;
                                }

                                int savedQuestionId = questionDAO.saveQuestion(question, answerOptions);
                                if (savedQuestionId > 0) {
                                    successCount++;
                                } else {
                                    errors.add("Lỗi không xác định khi lưu câu hỏi: '" + content + "'.");
                                }

                            } catch (NumberFormatException nfe) {
                                errors.add("Lỗi định dạng số cho câu hỏi: '" + lineContent + "' - " + nfe.getMessage());
                                LOGGER.log(Level.SEVERE, "Lỗi định dạng số khi xử lý dòng: " + lineContent, nfe);
                            } catch (ArrayIndexOutOfBoundsException aiobe) {
                                errors.add("Lỗi thiếu cột dữ liệu cho câu hỏi: '" + lineContent + "' - " + aiobe.getMessage());
                                LOGGER.log(Level.SEVERE, "Lỗi thiếu cột khi xử lý dòng: " + lineContent, aiobe);
                            } catch (Exception ex) {
                                errors.add("Lỗi không xác định khi xử lý câu hỏi: '" + lineContent + "' - " + ex.getMessage());
                                LOGGER.log(Level.SEVERE, "Lỗi khi xử lý dòng: " + lineContent, ex);
                            }
                        }
                    }
                } catch (IOException ex) {
                    errors.add("Lỗi đọc file: " + ex.getMessage());
                    LOGGER.log(Level.SEVERE, "Lỗi khi đọc file TXT", ex);
                }
            }

            // Redirect về questionList bất kể thành công hay lỗi
            response.sendRedirect("questionList");
        } else if ("edit".equalsIgnoreCase(action)) {
            String questionIDStr = request.getParameter("questionID");
            String courseIDStr = request.getParameter("courseID");
            String dimensionIDStr = request.getParameter("dimensionID");
            String status = request.getParameter("status");
            String content = request.getParameter("content");
            String explanation = request.getParameter("explanation");

            int questionID = Integer.parseInt(questionIDStr);

            Question question = new Question();
            question.setQuestionID(questionID);
            question.setCourseID(Integer.parseInt(courseIDStr));
            question.setDimensionID(Integer.parseInt(dimensionIDStr));
            question.setStatus(status);
            question.setContent(content);
            question.setExplanation(explanation != null && !explanation.trim().isEmpty() ? explanation.trim() : null);

            questionDAO.updateQuestion(question);
            answerOptionDAO.deleteAnswersByQuestionId(questionID);
            
            // --- Lấy danh sách đáp án mới từ form
            String[] answerContents = request.getParameterValues("answerOptionContent");
            String correctAnswerIndexStr = request.getParameter("correctAnswerIndex");

            boolean hasCorrectAnswer = false;
            
            // --- Duyệt tất cả đáp án người dùng nhập
            if (answerContents != null) {
                for (int i = 0; i < answerContents.length; i++) {
                    String answerContent = answerContents[i];
                    boolean isCorrect = String.valueOf(i).equals(correctAnswerIndexStr);

                    if (answerContent != null && !answerContent.trim().isEmpty()) {
                        AnswerOption answer = new AnswerOption();
                        answer.setQuestionID(question.getQuestionID());
                        answer.setContent(answerContent.trim());
                        answer.setCorrect(isCorrect);

                        int newAnswerID = answerOptionDAO.addAnswer(answer);
                    }

                    if (isCorrect) {
                        hasCorrectAnswer = true;
                    }
                }
            }

            if (!hasCorrectAnswer && answerContents != null && answerContents.length > 0) {
                request.setAttribute("errorMessage", "Phải có ít nhất một đáp án đúng được chọn.");
                response.sendRedirect("questioncontroller?action=edit&questionID=" + questionIDStr);
                return;
            }

            request.setAttribute("successMessage", "Question updated successfully!");
            response.sendRedirect("questioncontroller?action=edit&questionID=" + questionIDStr);
        }
    }
}