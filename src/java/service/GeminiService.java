package service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import dal.CourseDAO;
import dal.CourseCategoryDAO;
import dal.LessonDAO;
import model.Course;
import model.CourseCategory;
import model.Lesson;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GeminiService {

    private static final Logger LOGGER = Logger.getLogger(GeminiService.class.getName());
    private final String geminiApiKey;
    private final ObjectMapper objectMapper;
    private final CourseDAO courseDAO;
    private final CourseCategoryDAO courseCategoryDao;
    private final LessonDAO lessonDAO;
    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=";

    public GeminiService(String geminiApiKey) {
        this.geminiApiKey = geminiApiKey;
        this.objectMapper = new ObjectMapper();
        this.courseDAO = new CourseDAO();
        this.courseCategoryDao = new CourseCategoryDAO();
        this.lessonDAO = LessonDAO.getInstance();
    }

    public String getGeminiResponseWithCourseInfo(String userMessage) {
        StringBuilder courseContext = new StringBuilder();
        List<Course> foundCourses = null;

        Integer extractedCourseId = extractCourseIdFromMessage(userMessage);
        if (extractedCourseId != null) {
            Course specificCourseById = courseDAO.getCoureByCourseIDAndPrice(extractedCourseId);
            if (specificCourseById != null) {
                foundCourses = List.of(specificCourseById);
            }
        }

        if (foundCourses == null || foundCourses.isEmpty()) {
            String extractedCategoryName = extractCategoryNameFromMessage(userMessage);
            if (extractedCategoryName != null && !extractedCategoryName.isEmpty()) {
                foundCourses = courseDAO.searchCoursesByCategoryName(extractedCategoryName);
            }
        }

        if (foundCourses == null || foundCourses.isEmpty()) {
            String extractedCourseName = extractCourseNameFromMessage(userMessage);
            if (extractedCourseName != null && !extractedCourseName.isEmpty()) {
                foundCourses = courseDAO.searchCoursesByName(extractedCourseName);
            }
        }

        if (foundCourses != null && !foundCourses.isEmpty()) {
            courseContext.append("Thông tin chi tiết về các khóa học được tìm thấy:\n");
            for (Course course : foundCourses) {
                courseContext.append("--- Khóa học ID: ").append(course.getCourseID()).append(" ---\n");
                courseContext.append(course.toPromptString()).append("\n");
            }
        } else {
            courseContext.append("Không tìm thấy thông tin chi tiết cho khóa học hoặc thể loại này trong cơ sở dữ liệu. Vui lòng cung cấp mã khóa học chính xác, tên khóa học đầy đủ hoặc tên thể loại.");
        }

        String prompt = String.format(
                "Bạn là một trợ lý ảo chuyên nghiệp tư vấn về các khóa học và gói giá. " +
                        "Dưới đây là thông tin chi tiết về khóa học (hoặc danh sách các khóa học) được yêu cầu:\n\n" +
                        "=== Dữ liệu Khóa học ===\n%s\n\n" +
                        "Người dùng hỏi: \"%s\"\n\n" +
                        "Vui lòng trả lời câu hỏi của người dùng dựa trên thông tin Dữ liệu Khóa học đã cung cấp. " +
                        "Nếu thông tin khóa học không có sẵn hoặc không đủ để trả lời câu hỏi, hãy thông báo rằng bạn không tìm thấy thông tin phù hợp hoặc đề nghị người dùng cung cấp thêm chi tiết. " +
                        "Tránh suy đoán hoặc tạo ra thông tin không có trong dữ liệu.",
                courseContext.toString(), userMessage
        );

        return sendPromptToGemini(prompt);
    }

    public String generateQuizQuestions(int courseId, int numQuestions, String type) {
        List<Lesson> lessons = lessonDAO.getLessonsByCourseIdForAI(courseId);

        if (lessons.isEmpty()) {
            return "Không tìm thấy bài học nào cho khóa học ID = " + courseId;
        }

        StringBuilder lessonContext = new StringBuilder();
        for (Lesson lesson : lessons) {
            lessonContext.append("Bài: ").append(lesson.getName()).append("\n");
            lessonContext.append(lesson.getContentHtml()).append("\n\n");
        }

        String instruction = switch (type.toLowerCase()) {
            case "multiple-choice" -> "Hãy tạo các câu hỏi trắc nghiệm (4 lựa chọn, 1 đáp án đúng).";
            case "true-false" -> "Hãy tạo các câu hỏi đúng/sai (True/False).";
            default -> "Hãy tạo câu hỏi hỗn hợp giữa trắc nghiệm và đúng/sai.";
        };

        String prompt = String.format("""
                Bạn là một AI tạo đề thi thông minh.
                Dưới đây là nội dung của một số bài học từ khóa học có ID = %d:

                %s

                %s
                Hãy tạo ra %d câu hỏi từ nội dung trên.
                Trình bày mỗi câu hỏi rõ ràng: số thứ tự, nội dung, lựa chọn (nếu có), và đáp án đúng.
                **Vui lòng trả lời bằng tiếng Việt.**
                """, courseId, lessonContext.toString(), instruction, numQuestions);

        return sendPromptToGemini(prompt);
    }

    private String sendPromptToGemini(String prompt) {
        String apiUrl = GEMINI_API_URL + geminiApiKey;

        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(apiUrl);
            httpPost.setHeader("Content-Type", "application/json");

            ObjectNode rootNode = objectMapper.createObjectNode();
            ArrayNode contentsArray = rootNode.putArray("contents");
            ObjectNode contentNode = contentsArray.addObject();
            ArrayNode partsArray = contentNode.putArray("parts");
            partsArray.addObject().put("text", prompt);

            httpPost.setEntity(new StringEntity(objectMapper.writeValueAsString(rootNode), "UTF-8"));

            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                HttpEntity responseEntity = response.getEntity();
                if (responseEntity != null) {
                    String responseBody = EntityUtils.toString(responseEntity);
                    JsonNode root = objectMapper.readTree(responseBody);

                    if (root.has("error")) {
                        return "Lỗi: " + root.path("error").path("message").asText();
                    }

                    JsonNode part = root.path("candidates").path(0).path("content").path("parts").path(0);
                    if (part.has("text")) {
                        return part.path("text").asText();
                    }
                }
                return "Không có phản hồi từ Gemini API.";
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Lỗi IO khi gọi Gemini API", e);
            return "Không thể kết nối với dịch vụ AI.";
        }
    }

    private String extractCourseNameFromMessage(String message) {
        String[] keywords = message.toLowerCase().split("\\s+");
        StringBuilder courseName = new StringBuilder();
        for (String keyword : keywords) {
            if (!keyword.matches("id|category|price|giá|loại|khoá|học|course|danh|mục.*")) {
                courseName.append(keyword).append(" ");
            }
        }
        return courseName.toString().trim();
    }

    private Integer extractCourseIdFromMessage(String message) {
        Matcher matcher = Pattern.compile("id\\s*[:=\\s]*(\\d+)").matcher(message.toLowerCase());
        if (matcher.find()) {
            return Integer.parseInt(matcher.group(1));
        }
        return null;
    }

    private String extractCategoryNameFromMessage(String message) {
        String[] keywords = message.toLowerCase().split("\\s+");
        StringBuilder categoryName = new StringBuilder();
        for (String keyword : keywords) {
            if (!keyword.matches("id|course|price|giá|khoá|học|danh|mục.*")) {
                categoryName.append(keyword).append(" ");
            }
        }
        return categoryName.toString().trim();
    }
} 
