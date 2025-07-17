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
import model.Lesson;

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

    public String getGeminiResponseWithCourseInfo(String userMessage, String pageforward) {
        StringBuilder courseContext = new StringBuilder();
        List<Course> foundCourses = null;
        String prompt;
        
        // Logic cho trang Course Details
        if ("coursedetail".equalsIgnoreCase(pageforward)) {
            // Tìm khóa học theo ID
            Integer extractedCourseId = extractCourseIdFromMessage(userMessage);
            if (extractedCourseId != null) {
                Course specificCourseById = courseDAO.getCoureByCourseIDAndPrice(extractedCourseId);
                if (specificCourseById != null) {
                    foundCourses = List.of(specificCourseById);
                }
            }
            // Tìm khóa học theo categoryName
            if (foundCourses == null || foundCourses.isEmpty()) {
                String extractedCategoryName = extractCategoryNameFromMessage(userMessage);
                if (extractedCategoryName != null && !extractedCategoryName.isEmpty()) {
                    foundCourses = courseDAO.searchCoursesByCategoryName(extractedCategoryName);
                }
            }
            // Tìm khóa học theo courseName
            if (foundCourses == null || foundCourses.isEmpty()) {
                String extractedCourseName = extractCourseNameFromMessage(userMessage);
                if (extractedCourseName != null && !extractedCourseName.isEmpty()) {
                    foundCourses = courseDAO.searchCoursesByName(extractedCourseName);
                }
            }
            // Tạo context cho Course Details
            if (foundCourses != null && !foundCourses.isEmpty()) {
                courseContext.append("Thông tin chi tiết về các khóa học được tìm thấy:\n");
                for (Course course : foundCourses) {
                    courseContext.append("--- Khóa học ID: ").append(course.getCourseID()).append(" ---\n");
                    courseContext.append(course.toPromptString()).append("\n");
                }
            } else {
                courseContext.append("Không tìm thấy thông tin chi tiết cho khóa học hoặc thể loại này trong cơ sở dữ liệu. Vui lòng cung cấp mã khóa học chính xác, tên khóa học đầy đủ hoặc tên thể loại.");
            }
            // Prompt cho trang Course Details
            prompt = String.format(
                    "Bạn là một trợ lý ảo chuyên nghiệp tư vấn về các khóa học và gói giá. "
                    + "Dưới đây là thông tin chi tiết về khóa học (hoặc danh sách các khóa học) được yêu cầu:\n\n"
                    + "=== Dữ liệu Khóa học ===\n%s\n\n"
                    + "Người dùng hỏi: \"%s\"\n\n"
                    + "Vui lòng trả lời câu hỏi của người dùng dựa trên thông tin Dữ liệu Khóa học đã cung cấp. "
                    + "Nếu thông tin khóa học không có sẵn hoặc không đủ để trả lời câu hỏi, hãy thông báo rằng bạn không tìm thấy thông tin phù hợp hoặc đề nghị người dùng cung cấp thêm chi tiết. "
                    + "Trả lời ngắn gọn, súc tích và tập trung vào chi tiết của khóa học cụ thể.",
                    courseContext.toString(), userMessage
            );
        } 
        // Logic cho trang Courses List by khuong
        else if ("courselist".equalsIgnoreCase(pageforward)) {
            LOGGER.info("Xử lý câu hỏi: " + userMessage);
            
            // Xử lý câu hỏi về khóa học nổi bật
            if (userMessage.toLowerCase().contains("nổi bật") || userMessage.toLowerCase().contains("featured")) {
                LOGGER.info("Tìm kiếm khóa học nổi bật...");
                foundCourses = courseDAO.getTopFeaturedCourses(5); // Lấy 5 khóa học nổi bật nhất
                LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
            } else {
                LOGGER.info("Không phải câu hỏi về khóa học nổi bật");
            }
            
            // Xử lý câu hỏi về khóa học có nhiều lượt đăng ký
            if (foundCourses == null && (userMessage.toLowerCase().contains("nhiều lượt đăng ký") || userMessage.toLowerCase().contains("nhiều lượt đăng kí") || 
                userMessage.toLowerCase().contains("đăng ký") || userMessage.toLowerCase().contains("đăng kí") || 
                userMessage.toLowerCase().contains("popular") || userMessage.toLowerCase().contains("registration"))) {
                LOGGER.info("Tìm kiếm khóa học có nhiều lượt đăng ký...");
                foundCourses = courseDAO.getCoursesWithMostRegistrations(5); // Lấy 5 khóa học có nhiều đăng ký nhất
                LOGGER.info("Kết quả tìm kiếm khóa học có nhiều lượt đăng ký: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
            } else if (foundCourses != null) {
                LOGGER.info("Bỏ qua tìm kiếm khóa học có nhiều đăng ký vì đã tìm thấy kết quả trước đó");
            } else {
                LOGGER.info("Không phải câu hỏi về khóa học có nhiều đăng ký");
            }
            
            // Xử lý câu hỏi về khóa học miễn phí
            if (foundCourses == null && (userMessage.toLowerCase().contains("miễn phí") || userMessage.toLowerCase().contains("free"))) {
                LOGGER.info("Tìm kiếm khóa học miễn phí...");
                foundCourses = courseDAO.getFreeCourses();
                LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
            }
            
            // Xử lý câu hỏi về khóa học trả phí
            if (foundCourses == null && (userMessage.toLowerCase().contains("trả phí") || userMessage.toLowerCase().contains("paid") || 
                userMessage.toLowerCase().contains("có phí"))) {
                LOGGER.info("Tìm kiếm khóa học trả phí...");
                foundCourses = courseDAO.getPaidCourses();
                LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
            }
            
            // Xử lý câu hỏi về khóa học mới nhất
            if (foundCourses == null && (userMessage.toLowerCase().contains("mới nhất") || userMessage.toLowerCase().contains("latest") || 
                userMessage.toLowerCase().contains("recent"))) {
                LOGGER.info("Tìm kiếm khóa học mới nhất...");
                foundCourses = courseDAO.getLatestCourses(5); // Lấy 5 khóa học mới nhất
                LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
            }
            
            // Xử lý câu hỏi về khóa học cho người mới bắt đầu
            if (foundCourses == null && (userMessage.toLowerCase().contains("mới bắt đầu") || userMessage.toLowerCase().contains("beginner") || 
                userMessage.toLowerCase().contains("cơ bản") || userMessage.toLowerCase().contains("basic"))) {
                LOGGER.info("Tìm kiếm khóa học cho người mới bắt đầu...");
                foundCourses = courseDAO.getBeginnerCourses();
                LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
            }
            
            // Xử lý câu hỏi về khóa học theo ngôn ngữ lập trình cụ thể
            if (foundCourses == null && (userMessage.toLowerCase().contains("java") || userMessage.toLowerCase().contains("python") || 
                userMessage.toLowerCase().contains("javascript") || userMessage.toLowerCase().contains("c++") ||
                userMessage.toLowerCase().contains("c#") || userMessage.toLowerCase().contains("php"))) {
                LOGGER.info("Tìm kiếm khóa học theo ngôn ngữ lập trình...");
                String programmingLanguage = extractProgrammingLanguageFromMessage(userMessage);
                if (programmingLanguage != null && !programmingLanguage.isEmpty()) {
                    foundCourses = courseDAO.searchCoursesByProgrammingLanguage(programmingLanguage);
                    LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học cho " + programmingLanguage);
                }
            }
            
            // Xử lý câu hỏi về khóa học theo giá
            if (foundCourses == null && (userMessage.toLowerCase().contains("giá") || userMessage.toLowerCase().contains("price") || 
                userMessage.toLowerCase().contains("cost"))) {
                LOGGER.info("Tìm kiếm khóa học theo giá...");
                Double priceRange = extractPriceRangeFromMessage(userMessage);
                if (priceRange != null) {
                    foundCourses = courseDAO.getCoursesByPriceRange(priceRange);
                    LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học với giá <= " + priceRange);
                }
            }
            
            // Tìm khóa học theo ID (chỉ khi chưa tìm thấy)
            if (foundCourses == null) {
                Integer extractedCourseId = extractCourseIdFromMessage(userMessage);
                if (extractedCourseId != null) {
                    LOGGER.info("Tìm kiếm khóa học theo ID: " + extractedCourseId);
                    Course specificCourseById = courseDAO.getCoureByCourseIDAndPrice(extractedCourseId);
                    if (specificCourseById != null) {
                        foundCourses = List.of(specificCourseById);
                        LOGGER.info("Tìm thấy khóa học theo ID");
                    }
                }
            }
            
            // Tìm khóa học theo categoryName (chỉ khi chưa tìm thấy và không phải câu hỏi đặc biệt)
            if (foundCourses == null && !isSpecialQuestion(userMessage)) {
                String extractedCategoryName = extractCategoryNameFromMessage(userMessage);
                if (extractedCategoryName != null && !extractedCategoryName.isEmpty()) {
                    LOGGER.info("Tìm kiếm khóa học theo category: " + extractedCategoryName);
                    foundCourses = courseDAO.searchCoursesByCategoryName(extractedCategoryName);
                    LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
                }
            }

            // Tìm khóa học theo courseName (chỉ khi chưa tìm thấy và không phải câu hỏi đặc biệt)
            if (foundCourses == null && !isSpecialQuestion(userMessage)) {
                String extractedCourseName = extractCourseNameFromMessage(userMessage);
                if (extractedCourseName != null && !extractedCourseName.isEmpty()) {
                    LOGGER.info("Tìm kiếm khóa học theo tên: " + extractedCourseName);
                    foundCourses = courseDAO.searchCoursesByName(extractedCourseName);
                    LOGGER.info("Kết quả tìm kiếm: " + (foundCourses != null ? foundCourses.size() : 0) + " khóa học");
                }
            }

            // Tạo context cho Courses List
            if (foundCourses != null && !foundCourses.isEmpty()) {
                LOGGER.info("Tạo context cho " + foundCourses.size() + " khóa học được tìm thấy");
                courseContext.append("Thông tin chi tiết về các khóa học được tìm thấy:\n");
                for (Course course : foundCourses) {
                    courseContext.append("--- Khóa học ID: ").append(course.getCourseID()).append(" ---\n");
                    courseContext.append(course.toPromptString()).append("\n");
                }
            } else {
                LOGGER.info("Không tìm thấy khóa học phù hợp, lấy tất cả khóa học active làm fallback");
                // Fallback: lấy tất cả khóa học active
                foundCourses = courseDAO.getAllCourse();
                LOGGER.info("Fallback - Số khóa học lấy được: " + (foundCourses != null ? foundCourses.size() : 0));
                if (foundCourses != null && !foundCourses.isEmpty()) {
                    courseContext.append("Dưới đây là danh sách tất cả các khóa học hiện có:\n");
                    for (Course course : foundCourses) {
                        courseContext.append("--- Khóa học ID: ").append(course.getCourseID()).append(" ---\n");
                        courseContext.append(course.toPromptString()).append("\n");
                    }
                } else {
                    LOGGER.warning("Fallback cũng không tìm thấy khóa học nào!");
                    courseContext.append("Không tìm thấy khóa học phù hợp trong cơ sở dữ liệu. Vui lòng cung cấp tên khóa học hoặc danh mục cụ thể.");
                }
            }

            // Lấy danh sách danh mục khóa học
            List<CourseCategory> categories = courseCategoryDao.getAllCategory();
            if (!categories.isEmpty()) {
                courseContext.append("\nDanh sách danh mục khóa học hiện có:\n");
                for (CourseCategory category : categories) {
                    courseContext.append("- ").append(category.getCourseCategoryName()).append(" (ID: ").append(category.getCourseCategory()).append(")\n");
                }
            }

            // Prompt cho trang Courses List
            prompt = String.format(
                    "Bạn là một trợ lý ảo chuyên tư vấn về các khóa học trực tuyến. Dưới đây là thông tin về các khóa học và danh mục hiện có:\n\n"
                    + "=== Danh sách Khóa học ===\n%s\n\n"
                    + "Câu hỏi từ người dùng: \"%s\"\n\n"
                    + "Hãy trả lời câu hỏi của người dùng một cách ngắn gọn, chính xác, dựa trên thông tin khóa học và danh mục được cung cấp. "
                    + "Tập trung vào việc liệt kê hoặc gợi ý các khóa học phù hợp, bao gồm tên khóa học, danh mục, hoặc giá nếu được hỏi. "
                    + "Nếu không tìm thấy thông tin phù hợp, hãy thông báo một cách lịch sự và đề xuất người dùng cung cấp thêm chi tiết như tên khóa học, danh mục, hoặc khoảng giá. "
                    + "Trả lời thân thiện, dễ hiểu, và ưu tiên các khóa học nổi bật hoặc phù hợp nhất với yêu cầu.",
                    courseContext.toString(), userMessage
            );
        } else {
            return "Lỗi: Không xác định được loại trang (pageforward).";
        }

        String apiUrl = GEMINI_API_URL + geminiApiKey;

        // Gửi yêu cầu đến AI
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

            // Gửi request và nhận response
            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                HttpEntity responseEntity = response.getEntity();
                if (responseEntity != null) {
                    String responseBody = EntityUtils.toString(responseEntity);
                    JsonNode root = objectMapper.readTree(responseBody);

                    // Kiểm tra lỗi
                    if (root.has("error")) {
                        return "Lỗi: " + root.path("error").path("message").asText();
                    }

                    // Trích xuất nội dung trả lời từ Gemini
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
    // Trích xuất tên khóa học từ tin nhắn
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
    // Trích xuất ID khóa học từ tin nhắn (ví dụ: "ID 123")
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
    
    private String extractProgrammingLanguageFromMessage(String message) {
        String lowerMessage = message.toLowerCase();
        if (lowerMessage.contains("java")) return "Java";
        if (lowerMessage.contains("python")) return "Python";
        if (lowerMessage.contains("javascript")) return "JavaScript";
        if (lowerMessage.contains("c++")) return "C++";
        if (lowerMessage.contains("c#")) return "C#";
        if (lowerMessage.contains("php")) return "PHP";
        if (lowerMessage.contains("html")) return "HTML";
        if (lowerMessage.contains("css")) return "CSS";
        if (lowerMessage.contains("sql")) return "SQL";
        if (lowerMessage.contains("react")) return "React";
        if (lowerMessage.contains("angular")) return "Angular";
        if (lowerMessage.contains("vue")) return "Vue";
        if (lowerMessage.contains("node.js")) return "Node.js";
        if (lowerMessage.contains("spring")) return "Spring";
        if (lowerMessage.contains("django")) return "Django";
        if (lowerMessage.contains("flask")) return "Flask";
        if (lowerMessage.contains("unity")) return "Unity";
        if (lowerMessage.contains("git")) return "Git";
        return null;
    }
    
    private Double extractPriceRangeFromMessage(String message) {
        String lowerMessage = message.toLowerCase();
        
        // Tìm số tiền cụ thể (ví dụ: "dưới 100", "trên 50", "100-200")
        Pattern pricePattern = Pattern.compile("(\\d+)\\s*[-~]\\s*(\\d+)");
        Matcher matcher = pricePattern.matcher(lowerMessage);
        if (matcher.find()) {
            double min = Double.parseDouble(matcher.group(1));
            double max = Double.parseDouble(matcher.group(2));
            return (min + max) / 2; // Trả về giá trị trung bình
        }
        
        // Tìm "dưới X" hoặc "trên X"
        Pattern underPattern = Pattern.compile("dưới\\s*(\\d+)");
        matcher = underPattern.matcher(lowerMessage);
        if (matcher.find()) {
            return Double.parseDouble(matcher.group(1)) * 0.5; // Trả về 50% của giá trị
        }
        
        Pattern overPattern = Pattern.compile("trên\\s*(\\d+)");
        matcher = overPattern.matcher(lowerMessage);
        if (matcher.find()) {
            return Double.parseDouble(matcher.group(1)) * 1.5; // Trả về 150% của giá trị
        }
        
        // Tìm số đơn lẻ
        Pattern singlePricePattern = Pattern.compile("\\b(\\d+)\\b");
        matcher = singlePricePattern.matcher(lowerMessage);
        if (matcher.find()) {
            return Double.parseDouble(matcher.group(1));
        }
        
        return null;
    }

    private boolean isSpecialQuestion(String message) {
        String lowerMessage = message.toLowerCase();
        boolean isSpecial = lowerMessage.contains("nổi bật") || lowerMessage.contains("featured") ||
               lowerMessage.contains("nhiều lượt đăng ký") || lowerMessage.contains("nhiều lượt đăng kí") ||
               lowerMessage.contains("đăng ký") || lowerMessage.contains("đăng kí") ||
               lowerMessage.contains("popular") || lowerMessage.contains("registration") ||
               lowerMessage.contains("miễn phí") || lowerMessage.contains("free") ||
               lowerMessage.contains("trả phí") || lowerMessage.contains("paid") ||
               lowerMessage.contains("có phí") || lowerMessage.contains("mới nhất") ||
               lowerMessage.contains("latest") || lowerMessage.contains("recent") ||
               lowerMessage.contains("mới bắt đầu") || lowerMessage.contains("beginner") ||
               lowerMessage.contains("cơ bản") || lowerMessage.contains("basic") ||
               lowerMessage.contains("java") || lowerMessage.contains("python") ||
               lowerMessage.contains("javascript") || lowerMessage.contains("c++") ||
               lowerMessage.contains("c#") || lowerMessage.contains("php") ||
               lowerMessage.contains("giá") || lowerMessage.contains("price") ||
               lowerMessage.contains("cost");
        
        LOGGER.info("isSpecialQuestion('" + message + "') = " + isSpecial);
        return isSpecial;
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


    
    
}
