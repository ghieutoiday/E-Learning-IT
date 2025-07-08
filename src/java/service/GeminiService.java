package service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import dal.CourseDAO;
import model.Course;
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
    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=";

    public GeminiService(String geminiApiKey) {
        this.geminiApiKey = geminiApiKey;
        this.objectMapper = new ObjectMapper();
        this.courseDAO = new CourseDAO();
    }

    public String getGeminiResponseWithCourseInfo(String userMessage) {
        StringBuilder courseContext = new StringBuilder();
        List<Course> foundCourses = null;

        // tìm khóa học theo ID
        Integer extractedCourseId = extractCourseIdFromMessage(userMessage);
        if (extractedCourseId != null) {
            Course specificCourseById = courseDAO.getCoureByCourseIDAndPrice(extractedCourseId);
            if (specificCourseById != null) {
                foundCourses = List.of(specificCourseById);
            }
        }

        // tìm khóa học theo categoryName
        if (foundCourses == null || foundCourses.isEmpty()) {
            String extractedCategoryName = extractCategoryNameFromMessage(userMessage);
            if (extractedCategoryName != null && !extractedCategoryName.isEmpty()) {
                foundCourses = courseDAO.searchCourseByNameOrCategory(extractedCategoryName);
            }
        }

        // tìm khóa học theo courseName
        if (foundCourses == null || foundCourses.isEmpty()) {
            String extractedCourseName = extractCourseNameFromMessage(userMessage);
            if (extractedCourseName != null && !extractedCourseName.isEmpty()) {
                foundCourses = courseDAO.searchCoursesByName(extractedCourseName);
            }
        }

        // context từ các khóa học tìm được
        if (foundCourses != null && !foundCourses.isEmpty()) {
            courseContext.append("Thông tin chi tiết về các khóa học được tìm thấy:\n");
            for (Course course : foundCourses) {
                courseContext.append("--- Khóa học ID: ").append(course.getCourseID()).append(" ---\n");
                courseContext.append(course.toPromptString()).append("\n");
            }
        } else {
            courseContext.append("Không tìm thấy thông tin chi tiết cho khóa học hoặc thể loại này trong cơ sở dữ liệu. Vui lòng cung cấp mã khóa học chính xác, tên khóa học đầy đủ hoặc tên thể loại.");
        }

        //Tạo prompt gửi đến Gemin
        String prompt = String.format(
                "Bạn là một trợ lý ảo chuyên nghiệp tư vấn về các khóa học và gói giá. "
                + "Dưới đây là thông tin chi tiết về khóa học (hoặc danh sách các khóa học) được yêu cầu:\n\n"
                + "=== Dữ liệu Khóa học ===\n%s\n\n"
                + "Người dùng hỏi: \"%s\"\n\n"
                + "Vui lòng trả lời câu hỏi của người dùng dựa trên thông tin Dữ liệu Khóa học đã cung cấp. "
                + "Nếu thông tin khóa học không có sẵn hoặc không đủ để trả lời câu hỏi, hãy thông báo rằng bạn không tìm thấy thông tin phù hợp hoặc đề nghị người dùng cung cấp thêm chi tiết. "
                + "Tránh suy đoán hoặc tạo ra thông tin không có trong dữ liệu. ",
                //            "**Vui lòng trả lời bằng tiếng Anh.**",
                courseContext.toString(), userMessage
        );

        String apiUrl = GEMINI_API_URL + geminiApiKey;

        // gửi yêu cầu đến AI
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(apiUrl);
            httpPost.setHeader("Content-Type", "application/json");

            // Tạo body JSON gửi cho Gemini
            ObjectNode rootNode = objectMapper.createObjectNode();
            ArrayNode contentsArray = rootNode.putArray("contents");
            ObjectNode contentNode = contentsArray.addObject();
            ArrayNode partsArray = contentNode.putArray("parts");
            partsArray.addObject().put("text", prompt);

            httpPost.setEntity(new StringEntity(objectMapper.writeValueAsString(rootNode), "UTF-8"));

            //Gửi request và nhận response
            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                HttpEntity responseEntity = response.getEntity();
                if (responseEntity != null) {
                    String responseBody = EntityUtils.toString(responseEntity); // Đọc response body
                    JsonNode root 
                            = objectMapper.readTree(responseBody); // Chuyển response về dạng JsonNode
                    
                    //Kiểm tra xem response có lỗi không
                    if (root.has("error")) {
                        return "Lỗi: " + root.path("error").path("message").asText();
                    }
                    
                    //Trích nội dung trả lời từ Gemini
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
        return message;
    }

    private Integer extractCourseIdFromMessage(String message) {
        Matcher matcher = Pattern.compile("id\\s*[:=\\s]*(\\d+)").matcher(message.toLowerCase());
        if (matcher.find()) {
            return Integer.parseInt(matcher.group(1));
        }
        return null;
    }

    private String extractCategoryNameFromMessage(String message) {
        return message;
    }
}

