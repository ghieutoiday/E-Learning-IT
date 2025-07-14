package controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import service.GeminiService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ChatServlet.class.getName());

    private GeminiService geminiService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void init() {
        String geminiApiKey = System.getenv("GEMINI_API_KEY");
        if (geminiApiKey == null || geminiApiKey.isEmpty()) {
            geminiApiKey = "AIzaSyBDJZqEe_uSDDIF02AG27QOR3Q-VR_cAMc"; // Thay bằng API key thực tế hoặc để trong biến môi trường
            LOGGER.warning("Không tìm thấy biến môi trường GEMINI_API_KEY. Đang dùng API key hardcoded.");
        }
        geminiService = new GeminiService(geminiApiKey);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        StringBuilder sb = new StringBuilder();
        // Đọc dữ liệu JSON từ request body
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
        }

        // Parse JSON và lấy trường "message" và "pageforward"
        JsonNode jsonNode = objectMapper.readTree(sb.toString());
        String userMessage = jsonNode.path("message").asText();
        String pageforward = jsonNode.path("pageforward").asText("courselist"); // Mặc định là courselist nếu không có pageforward

        String geminiResponse;
        try {
            // Gọi GeminiService với pageforward
            geminiResponse = geminiService.getGeminiResponseWithCourseInfo(userMessage, pageforward);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi gọi GeminiService", e);
            geminiResponse = "Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này.";
        }

        // Tạo đối tượng JSON để gửi phản hồi về client
        ObjectNode jsonResponse = objectMapper.createObjectNode();
        jsonResponse.put("response", geminiResponse);
        try (PrintWriter out = response.getWriter()) {
            out.print(objectMapper.writeValueAsString(jsonResponse));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body>");
            out.println("<h1>Chào mừng đến với Chatbot!</h1>");
            out.println("<p>Gửi yêu cầu POST đến /chat với nội dung JSON: {\"message\": \"tin nhắn của bạn\", \"pageforward\": \"courselist hoặc coursedetail\"}</p>");
            out.println("</body></html>");
        }
    }
}