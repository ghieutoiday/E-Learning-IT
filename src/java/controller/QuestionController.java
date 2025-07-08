package controller;

import dal.QuestionDAO;
import model.Question;
import model.AnswerOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.BufferedReader;

@WebServlet("/questioncontroller")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class QuestionController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("download".equals(action)) {
            String templatePath = getServletContext().getRealPath("/sample_template_no_course_lesson.txt"); // Đã sửa tên file mẫu
            File file = new File(templatePath);
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File mẫu không tồn tại.");
                return;
            }
            response.setContentType("text/plain");
            response.setHeader("Content-Disposition", "attachment; filename=sample_template_no_course_lesson.txt"); // Đã sửa tên file

            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
            } catch (Exception ex) {
                Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải file mẫu.");
            }
        } else {
            // Forward tới JSP, các tham số courseId và lessonId đã có trong request
            request.getRequestDispatcher("/importQuestions.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("import".equals(action)) {
            Part filePart = request.getPart("file");
            QuestionDAO questionDAO = new QuestionDAO();
            List<String> errors = new ArrayList<>();
            int successCount = 0;

            // Lấy courseID và lessonID từ request (được gửi từ hidden input của JSP)
            String courseIdParam = request.getParameter("courseIdParam");
            String lessonIdParam = request.getParameter("lessonIdParam");

            int courseID = -1; // Giá trị mặc định hoặc lỗi
            int lessonID = -1; // Giá trị mặc định hoặc lỗi

            try {
                if (courseIdParam != null && !courseIdParam.isEmpty()) {
                    courseID = Integer.parseInt(courseIdParam);
                } else {
                    errors.add("Không tìm thấy courseID từ tham số URL.");
                }
                if (lessonIdParam != null && !lessonIdParam.isEmpty()) {
                    lessonID = Integer.parseInt(lessonIdParam);
                } else {
                    errors.add("Không tìm thấy lessonID từ tham số URL.");
                }
            } catch (NumberFormatException e) {
                errors.add("Định dạng courseID hoặc lessonID không hợp lệ trong URL.");
                Logger.getLogger(QuestionController.class.getName()).log(Level.WARNING, "Invalid courseIdParam or lessonIdParam format: " + e.getMessage());
            }

            // Nếu có lỗi với courseID/lessonID từ URL, không cần xử lý file
            if (!errors.isEmpty()) {
                request.setAttribute("successCount", successCount);
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/importQuestions.jsp").forward(request, response);
                return;
            }

            if (filePart == null || filePart.getSize() == 0) {
                errors.add("Vui lòng chọn file TXT hoặc CSV để import.");
            } else {
                String DELIMITER = "\\|";

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(filePart.getInputStream()))) {
                    String headerLine = reader.readLine(); // Đọc và bỏ qua hàng tiêu đề
                    if (headerLine == null) {
                         errors.add("Tệp rỗng hoặc không có tiêu đề.");
                         request.setAttribute("successCount", successCount);
                         request.setAttribute("errors", errors);
                         request.getRequestDispatcher("/importQuestions.jsp").forward(request, response);
                         return;
                    }

                    String lineContent;
                    while ((lineContent = reader.readLine()) != null) {
                        try {
                            String[] line = lineContent.split(DELIMITER);

                            // CHÚ Ý: Index của các cột đã thay đổi vì courseID và lessonID không còn trong file
                            // Cột 0: dimensionID
                            // Cột 1: typeQuestionID
                            // Cột 2: content
                            // ...
                            
                            // Kiểm tra xem có đủ cột cần thiết không (ít nhất 7 cột cơ bản: dimensionID, typeQuestionID, content, media, explanation, level, status)
                            // Số cột cơ bản trong file TXT mới là 7 (không có courseID, lessonID, questionID, createDate, updateDate)
                            if (line.length < 7) { 
                                errors.add("Dòng dữ liệu không đủ số cột (yêu cầu ít nhất 7 cột cơ bản, không bao gồm courseID và lessonID): " + lineContent);
                                continue;
                            }

                            int dimensionID = Integer.parseInt(line[0].trim());
                            int typeQuestionID = Integer.parseInt(line[1].trim());
                            String content = line[2].trim();
                            String media = line[3].trim().isEmpty() ? null : line[3].trim();
                            String explanation = line[4].trim().isEmpty() ? null : line[4].trim();
                            int level = Integer.parseInt(line[5].trim());
                            String status = line[6].trim();

                            // Validate khóa ngoại với courseID và lessonID lấy từ URL
                            if (!questionDAO.validateForeignKeys(courseID, lessonID, dimensionID, typeQuestionID)) {
                                errors.add("Khóa ngoại không hợp lệ cho câu hỏi: '" + content + "' (dimensionID: " + dimensionID + ", typeQuestionID: " + typeQuestionID + ", CourseID từ URL: " + courseID + ", LessonID từ URL: " + lessonID + ")");
                                continue;
                            }

                            if (!status.equals("Active") && !status.equals("Inactive")) {
                                errors.add("Trạng thái không hợp lệ cho câu hỏi: '" + content + "' (Dòng: '" + lineContent + "')");
                                continue;
                            }

                            // Tạo đối tượng Question với courseID và lessonID từ URL
                            Question question = new Question(courseID, lessonID, dimensionID, typeQuestionID, content,
                                    media, explanation, level, status);

                            List<AnswerOption> answerOptions = new ArrayList<>();
                            // Bắt đầu đọc đáp án từ cột thứ 7 (chỉ số 6)
                            for (int i = 7; i < line.length; i += 2) {
                                if (i + 1 < line.length) {
                                    String answerContent = line[i].trim();
                                    boolean isCorrect = line[i + 1].trim().equals("1");
                                    answerOptions.add(new AnswerOption(0, answerContent, isCorrect));
                                } else {
                                    errors.add("Dữ liệu đáp án không đầy đủ cho câu hỏi: '" + content + "' (Dòng: '" + lineContent + "'). Thiếu nội dung hoặc trạng thái đúng/sai của đáp án.");
                                    break;
                                }
                            }

                            if (answerOptions.stream().noneMatch(AnswerOption::isCorrect)) {
                                errors.add("Không có đáp án đúng nào được cung cấp cho câu hỏi: '" + content + "' (Dòng: '" + lineContent + "')");
                                continue;
                            }
                            
                            if (answerOptions.isEmpty()) {
                                errors.add("Không có đáp án nào được cung cấp cho câu hỏi: '" + content + "' (Dòng: '" + lineContent + "')");
                                continue;
                            }

                            questionDAO.saveQuestion(question, answerOptions);
                            successCount++;
                        } catch (NumberFormatException nfe) {
                            errors.add("Lỗi định dạng số cho câu hỏi: '" + lineContent + "' - " + nfe.getMessage());
                            Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, "Lỗi định dạng số khi xử lý dòng: " + lineContent, nfe);
                        } catch (ArrayIndexOutOfBoundsException aiobe) {
                             errors.add("Lỗi thiếu cột dữ liệu cho câu hỏi: '" + lineContent + "' - " + aiobe.getMessage());
                             Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, "Lỗi thiếu cột khi xử lý dòng: " + lineContent, aiobe);
                        }
                        catch (Exception ex) {
                            errors.add("Lỗi không xác định khi xử lý câu hỏi: '" + lineContent + "' - " + ex.getMessage());
                            Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, "Lỗi khi xử lý dòng: " + lineContent, ex);
                        }
                    }
                } catch (Exception ex) {
                    errors.add("Lỗi đọc file: " + ex.getMessage());
                    Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, "Lỗi khi đọc file TXT", ex);
                }
            }

            request.setAttribute("successCount", successCount);
            request.setAttribute("errors", errors);
            // Đảm bảo courseId và lessonId được gửi lại để hiển thị đúng khi có lỗi
            request.setAttribute("courseId", courseID);
            request.setAttribute("lessonId", lessonID);
            try {
                request.getRequestDispatcher("/importQuestions.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, "Lỗi khi chuyển hướng đến JSP", ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi chuyển hướng.");
            }
        }
    }
}