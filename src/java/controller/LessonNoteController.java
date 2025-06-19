package controller;

import dal.LessonDAO;
import dal.MediaDAO;
import dal.UserDAO;
import dal.UserLessonNotesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Lesson;
import model.Media;
import model.User;
import model.UserLessonNotes;

@WebServlet(name = "LessonNoteController", urlPatterns = {"/lessonnotecontroller"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class LessonNoteController extends HttpServlet {

    private static final String UPLOAD_DIR = "D:\\Session_5\\SWP_Project\\E-Learning-IT\\web\\assets\\images\\note";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            String noteId = request.getParameter("noteId");
            String lessonID = request.getParameter("lessonId"); // Sử dụng lessonID
            Integer userId = 5; // Lấy từ session

            if (noteId == null || lessonID == null || userId == null) {
                request.setAttribute("errorMessage", "Thiếu thông tin cần thiết.");
                response.sendRedirect(request.getContextPath() + "/lessonviewcontroller");
                return;
            }

            try {
                UserLessonNotesDAO noteDAO = UserLessonNotesDAO.getInstance();
                UserLessonNotes editNote = noteDAO.getUserLessonNoteByULNID(Integer.parseInt(noteId));
                if (editNote == null || editNote.getUser().getUserID() != userId || editNote.getLesson().getLessonID() != Integer.parseInt(lessonID)) {
                    request.setAttribute("errorMessage", "Không tìm thấy ghi chú hoặc bạn không có quyền truy cập.");
                    response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
                    return;
                }

                MediaDAO mediaDAO = MediaDAO.getInstance();
                List<Media> mediaList = mediaDAO.getAllMediaByNote(editNote.getNoteID());
                editNote.setMedia(mediaList != null ? mediaList : new ArrayList<>());

                StringBuilder videoLinks = new StringBuilder();
                StringBuilder videoNotes = new StringBuilder();
                StringBuilder imageLinks = new StringBuilder();
                StringBuilder imageNotes = new StringBuilder();

                for (Media media : editNote.getMedia()) {
                    if ("video".equals(media.getMediaType()) && media.getMediaUrl() != null) {
                        if (videoLinks.length() > 0) {
                            videoLinks.append(",");
                            videoNotes.append(",");
                        }
                        videoLinks.append(media.getMediaUrl().replace("https://www.youtube.com/embed/", "https://www.youtube.com/watch?v="));
                        videoNotes.append(media.getContent() != null ? media.getContent() : "");
                    } else if ("image".equals(media.getMediaType()) && media.getMediaUrl() != null) {
                        if (imageLinks.length() > 0) {
                            imageLinks.append(",");
                            imageNotes.append(",");
                        }
                        imageLinks.append(media.getMediaUrl());
                        imageNotes.append(media.getContent() != null ? media.getContent() : "");
                    }
                }

                request.setAttribute("editNote", editNote);
                request.setAttribute("editVideoLinks", videoLinks.toString());
                request.setAttribute("editVideoNotes", videoNotes.toString());
                request.setAttribute("editImageLinks", imageLinks.toString());
                request.setAttribute("editImageNotes", imageNotes.toString());

                // Truyền lessonID trong URL khi forward
                request.getRequestDispatcher("/lessonviewcontroller?lessonID=" + lessonID).forward(request, response);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID không hợp lệ.");
                response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không được hỗ trợ.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String lessonID = request.getParameter("lessonId"); // Lưu ý: doPost dùng lessonId, cần đồng nhất
        String noteId = request.getParameter("noteId");
        Integer userId = 5;

        if (userId == null) {
            request.setAttribute("errorMessage", "Người dùng chưa đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
            return;
        }

        if ("delete".equals(action)) {
            try {
                UserLessonNotesDAO noteDAO = UserLessonNotesDAO.getInstance();
                noteDAO.deleteNote(Integer.parseInt(noteId), userId);
                response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
            } catch (SQLException | NumberFormatException e) {
                request.setAttribute("errorMessage", "Lỗi xóa ghi chú: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
            }
            return;
        }

        try {
            UserLessonNotesDAO noteDAO = UserLessonNotesDAO.getInstance();
            UserDAO userDAO = new UserDAO();
            LessonDAO lessonDAO = LessonDAO.getInstance();

            User user = userDAO.getUserByID(userId);
            int lessonIdInt = Integer.parseInt(lessonID);
            Lesson lesson = lessonDAO.getLessonByLessonID(lessonIdInt);

            String content = request.getParameter("content");
            String[] videoLinks;
            String rawLinks = request.getParameter("videoLinks");

            if (rawLinks != null) {
                videoLinks = rawLinks.split(",");
            } else {
                videoLinks = new String[]{};
            }

            String[] imageNotes = request.getParameterValues("imageNotes[]");
            String[] videoNotes = request.getParameterValues("videoNotes[]");
            String[] existingMedia = request.getParameterValues("existingMedia[]");

            UserLessonNotes note = new UserLessonNotes();
            note.setUser(user);
            note.setLesson(lesson);
            if (content != null && !content.trim().isEmpty()) {
                note.setContent(content);
            } else {
                note.setContent(null);
            }

            String uploadPath = UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            List<Part> imageParts = new ArrayList<>();
            for (Part part : request.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    imageParts.add(part);
                }
            }

            if (noteId != null && !noteId.isEmpty()) {
                noteDAO.updateNoteWithSelectiveMedia(Integer.parseInt(noteId), userId, note, imageParts, videoLinks, imageNotes, videoNotes, existingMedia, uploadPath);
            } else {
                noteDAO.addNoteWithMedia(note, imageParts, videoLinks, imageNotes, videoNotes, uploadPath);
            }

            response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/lessonviewcontroller?lessonID=" + lessonID);
        }
    }
}
