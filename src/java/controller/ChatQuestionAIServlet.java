package controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import service.GeminiService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/chat-question-ai")
public class ChatQuestionAIServlet extends HttpServlet {

    private GeminiService geminiService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void init() {
        String apiKey = System.getenv("GEMINI_API_KEY");
        if (apiKey == null || apiKey.isEmpty()) {
            apiKey = "AIzaSyCTCU-gJ-6GJFDV1DdH2_kbDiAtzE8YWp0"; // Key test
            System.out.println("[WARN] Không tìm thấy GEMINI_API_KEY. Đang dùng key mặc định.");
        }
        geminiService = new GeminiService(apiKey);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");

        // 1. Đọc JSON từ client
        BufferedReader reader = request.getReader();
        JsonNode jsonNode = objectMapper.readTree(reader);

        String message = jsonNode.path("message").asText();
        int courseId = jsonNode.path("courseId").asInt();

        System.out.println("==> Nhận message: " + message);
        System.out.println("==> courseId = " + courseId);

        // 2. Parse số lượng câu hỏi và loại quiz
        int numQuestions = 3; // mặc định
        String type = "multiple-choice"; // mặc định

        String lowerMsg = message.toLowerCase();
        if (lowerMsg.contains("true") || lowerMsg.contains("false") || lowerMsg.contains("đúng") || lowerMsg.contains("sai")) {
            type = "true-false";
        }

        Matcher matcher = Pattern.compile("(\\d+)").matcher(message);
        if (matcher.find()) {
            numQuestions = Integer.parseInt(matcher.group(1));
        }

        // 3. Gọi AI để sinh câu hỏi quiz
        String result;
        try {
            result = geminiService.generateQuizQuestions(courseId, numQuestions, type);
        } catch (Exception e) {
            e.printStackTrace();
            result = "Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này.";
        }

        // 4. Trả JSON về cho client
        ObjectNode jsonResponse = objectMapper.createObjectNode();
        jsonResponse.put("response", result);
        PrintWriter out = response.getWriter();
        out.print(objectMapper.writeValueAsString(jsonResponse));
        out.flush();
    }
}
