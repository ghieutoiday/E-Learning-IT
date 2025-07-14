package controller;

import dal.AdminNoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.stream.Collectors;
import model.AdminLessonNote;

@WebServlet(name = "AdminNoteController", urlPatterns = {"/adminNote"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AdminNoteController extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads/admin_notes";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String action = request.getParameter("action");
            int adminId = 27;

            if ("add_note".equals(action)) {
                String noteContent = request.getParameter("noteContent");
                String[] videoLinks = request.getParameterValues("videoLinks");
                Collection<Part> imageParts = request.getParts().stream()
                        .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                        .collect(Collectors.toList());
                
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                
                AdminLessonNote note = new AdminLessonNote(0, lessonId, noteContent, adminId, null, null);
                
                AdminNoteDAO.getInstance().addNoteWithMedia(note, imageParts, videoLinks, uploadPath);
            } 
            else if ("delete_note".equals(action)) {
                int noteId = Integer.parseInt(request.getParameter("noteId"));
                AdminNoteDAO.getInstance().deleteNote(noteId);
            }

            response.sendRedirect("lessonDetails?lessonId=" + lessonId + "&courseId=" + courseId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}