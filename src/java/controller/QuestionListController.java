package controller;

import dal.QuestionDAO;
import model.Course;
import model.Question;
import model.SubjectDimension;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "QuestionListController", urlPatterns = {"/questionList"})
public class QuestionListController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        QuestionDAO dao = new QuestionDAO();

        // 1. Lấy tham số
        String courseIdStr = request.getParameter("courseId");
        String dimensionIdStr = request.getParameter("dimensionId");
        String levelStr = request.getParameter("level");
        String pageStr = request.getParameter("page");
        String status = request.getParameter("status");
        String search = request.getParameter("search");

        // 2. Chuyển đổi kiểu dữ liệu
        int courseId = safeParseInt(courseIdStr, 0);
        int dimensionId = safeParseInt(dimensionIdStr, 0);
        int level = safeParseInt(levelStr, 0);
        int page = safeParseInt(pageStr, 1);

        // 3. Lấy dữ liệu
        List<Question> questions = dao.getFilteredQuestions(courseId, dimensionId, level, status, search, page, PAGE_SIZE);
        int totalQuestions = dao.getFilteredQuestionCount(courseId, dimensionId, level, status, search);
        int totalPages = (int) Math.ceil((double) totalQuestions / PAGE_SIZE);
        
        List<Course> allCourses = dao.getAllCourses();
        List<SubjectDimension> allDimensions = dao.getAllDimensions();

        // 4. Đặt thuộc tính vào request
        request.setAttribute("questions", questions);
        request.setAttribute("allCourses", allCourses);
        request.setAttribute("allDimensions", allDimensions);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        
        request.setAttribute("selectedCourseId", courseId);
        request.setAttribute("selectedDimensionId", dimensionId);
        request.setAttribute("selectedLevel", level);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("searchValue", search);
        
        // 5. Chuyển tiếp tới JSP
        request.getRequestDispatcher("question-list.jsp").forward(request, response);
    }

    private int safeParseInt(String str, int defaultValue) {
        if (str == null || str.isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    @Override
    public String getServletInfo() {
        return "Controller to display and filter questions.";
    }
}