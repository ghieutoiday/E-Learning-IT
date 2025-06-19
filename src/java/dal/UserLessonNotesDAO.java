/*
 * Click nbproject://nbproject/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbproject://nbproject/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import model.UserLessonNotes;
import model.User;
import model.Lesson;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Media;

/**
 *
 * @author ASUS
 */
public class UserLessonNotesDAO extends DBContext {

    private static UserLessonNotesDAO instance;
    private UserDAO userDAO = new UserDAO();
    private MediaDAO mediaDAO;
    private LessonDAO lessonDAO;

    private UserLessonNotesDAO() {
        super();
    }

    public static UserLessonNotesDAO getInstance() {
        if (instance == null) {
            synchronized (UserLessonNotesDAO.class) {
                if (instance == null) {
                    instance = new UserLessonNotesDAO();
                }
            }
        }
        return instance;
    }

    private MediaDAO getMediaDAO() {
        if (mediaDAO == null) {
            synchronized (this) {
                if (mediaDAO == null) {
                    mediaDAO = MediaDAO.getInstance();
                }
            }
        }
        return mediaDAO;
    }

    private LessonDAO getLessonDAO() {
        if (lessonDAO == null) {
            synchronized (this) {
                if (lessonDAO == null) {
                    lessonDAO = LessonDAO.getInstance();
                }
            }
        }
        return lessonDAO;
    }

    // 1. Lấy ra UserLessonNote từ ID
    public UserLessonNotes getUserLessonNoteByULNID(int noteID) {
        UserLessonNotes userLessonNotes = null;
        String sql = "SELECT * FROM UserLessonNotes WHERE noteID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, noteID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = userDAO.getUserByID(rs.getInt("userID"));
                    Lesson lesson = getLessonDAO().getLessonByLessonID(rs.getInt("lessonID"));
                    String content = rs.getString("content");
                    Date createDate = rs.getDate("createDate");
                    Date updateDate = rs.getDate("updateDate");
                    userLessonNotes = new UserLessonNotes(noteID, user, lesson, content, createDate, updateDate);
                    userLessonNotes.setMedia(getMediaDAO().getAllMediaByNote(noteID));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getUserLessonNoteByULNID: " + e.getMessage());
            e.printStackTrace();
        }
        return userLessonNotes;
    }

    // 2. Tạo 1 bản ghi UserLessonNote
    public int addNote(UserLessonNotes note) {
        String sql = "INSERT INTO UserLessonNotes (userID, lessonID, content, createDate, updateDate) "
                + "VALUES (?, ?, ?, GETDATE(), GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            st.setInt(1, note.getUser().getUserID());
            st.setInt(2, note.getLesson().getLessonID());
            st.setString(3, note.getContent());
            st.executeUpdate();
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in addNote: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // 3. Thêm một ghi chú mới cùng với media (ảnh, video) và nội dung media vào cơ sở dữ liệu
    public void addNoteWithMedia(UserLessonNotes note, List<Part> imageParts, String[] videoLinks, String[] imageNotes, String[] videoNotes, String uploadPath) throws SQLException {
        int noteId = addNote(note);
        saveMedia(noteId, imageParts, videoLinks, imageNotes, videoNotes, uploadPath);
    }

    // 4. Cập nhật nội dung ghi chú hiện có, xóa media không còn trong danh sách, và thêm media mới
    public void updateNoteWithSelectiveMedia(int noteId, int userId, UserLessonNotes note, List<Part> imageParts, String[] videoLinks, String[] imageNotes, String[] videoNotes, String[] existingMedia, String uploadPath) throws SQLException {
        // Cập nhật nội dung ghi chú
        String sql = "UPDATE UserLessonNotes SET content = ?, updateDate = GETDATE() WHERE noteID = ? AND userID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, note.getContent());
            pstmt.setInt(2, noteId);
            pstmt.setInt(3, userId);
            int rows = pstmt.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Không tìm thấy ghi chú hoặc bạn không có quyền cập nhật.");
            }
        }

        // Lấy danh sách media hiện tại
        List<Media> currentMedia = getMediaDAO().getAllMediaByNote(noteId);
        List<String> mediaToKeep = new ArrayList<>();
        if (existingMedia != null) {
            for (String mediaUrl : existingMedia) {
                mediaToKeep.add(mediaUrl.trim());
            }
        }

        // Xóa media không còn trong danh sách existingMedia
        for (Media media : currentMedia) {
            if (!mediaToKeep.contains(media.getMediaUrl())) {
                getMediaDAO().deleteMediaById(media.getMediaID());
                // Xóa file ảnh khỏi server nếu là ảnh
                if ("image".equals(media.getMediaType())) {
                    File file = new File(uploadPath + File.separator + media.getMediaUrl().substring("assets/images/note/".length()));
                    if (file.exists()) {
                        file.delete();
                    }
                }
            }
        }

        // Cập nhật nội dung (content) cho media cũ và thêm media mới
        int imageNoteIndex = 0;
        int videoNoteIndex = 0;
        List<String> processedMedia = new ArrayList<>();

        // Xử lý media cũ (chỉ cập nhật content)
        for (Media media : currentMedia) {
            if (mediaToKeep.contains(media.getMediaUrl())) {
                String noteContent = null;
                if ("image".equals(media.getMediaType()) && imageNoteIndex < imageNotes.length) {
                    noteContent = imageNotes[imageNoteIndex] != null && !imageNotes[imageNoteIndex].isEmpty() ? imageNotes[imageNoteIndex] : null;
                    imageNoteIndex++;
                } else if ("video".equals(media.getMediaType()) && videoNoteIndex < videoNotes.length) {
                    noteContent = videoNotes[videoNoteIndex] != null && !videoNotes[videoNoteIndex].isEmpty() ? videoNotes[videoNoteIndex] : null;
                    videoNoteIndex++;
                }
                getMediaDAO().updateMediaContent(media.getMediaID(), noteContent);
                processedMedia.add(media.getMediaUrl());
            }
        }

        // Thêm media mới
        if (imageParts != null) {
            for (Part part : imageParts) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    if (!part.getContentType().startsWith("image/")) {
                        throw new SQLException("Chỉ chấp nhận file ảnh.");
                    }
                    String originalFileName = extractFileName(part);
                    String fileName = System.currentTimeMillis() + "_" + originalFileName;
                    String filePath = uploadPath + File.separator + fileName;
                    try {
                        part.write(filePath);
                    } catch (IOException e) {
                        throw new SQLException("Không thể lưu ảnh: " + e.getMessage());
                    }
                    Media media = new Media();
                    media.setNoteID(noteId);
                    media.setMediaType("image");
                    media.setMediaUrl("assets/images/note/" + fileName);
                    media.setContent(imageNotes != null && imageNoteIndex < imageNotes.length && imageNotes[imageNoteIndex] != null && !imageNotes[imageNoteIndex].isEmpty() ? imageNotes[imageNoteIndex] : null);
                    getMediaDAO().addMedia(media);
                    imageNoteIndex++;
                    processedMedia.add(media.getMediaUrl());
                }
            }
        }

        if (videoLinks != null) {
            for (String video : videoLinks) {
                if (video.trim().isEmpty() || processedMedia.contains(video)) {
                    continue;
                }
                String embedUrl = getYouTubeEmbedUrl(video.trim());
                if (embedUrl.isEmpty()) {
                    throw new SQLException("Link video không hợp lệ: " + video);
                }
                Media media = new Media();
                media.setNoteID(noteId);
                media.setMediaType("video");
                media.setMediaUrl(embedUrl);
                media.setContent(videoNotes != null && videoNoteIndex < videoNotes.length && videoNotes[videoNoteIndex] != null && !videoNotes[videoNoteIndex].isEmpty() ? videoNotes[videoNoteIndex] : null);
                getMediaDAO().addMedia(media);
                videoNoteIndex++;
                processedMedia.add(embedUrl);
            }
        }
    }

    // 5. Xóa một ghi chú dựa trên noteId và kiểm tra quyền của userId
    public void deleteNote(int noteId, int userId) throws SQLException {
        String sql = "DELETE FROM UserLessonNotes WHERE noteID = ? AND userID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, noteId);
            pstmt.setInt(2, userId);
            int rows = pstmt.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Không tìm thấy ghi chú hoặc bạn không có quyền xóa.");
            }
        }
    }

    // 6. Lấy ra toàn bộ note theo LessonID và UserID
    public List<UserLessonNotes> getAllNoteByLessonIdAndUserID(int lessonId, int userId) {
        List<UserLessonNotes> listNote = new ArrayList<>();
        String sql = "SELECT * FROM UserLessonNotes WHERE lessonID = ? AND userID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserLessonNotes userLessonNotes = getUserLessonNoteByULNID(rs.getInt("noteID"));
                    if (userLessonNotes != null) {
                        listNote.add(userLessonNotes);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllNoteByLessonIdAndUserID: " + e.getMessage());
        }
        return listNote;
    }

    // 7. Lưu các file ảnh và link video (media) cùng với nội dung media vào cơ sở dữ liệu và server
    private void saveMedia(int noteId, List<Part> imageParts, String[] videoLinks, String[] imageNotes, String[] videoNotes, String uploadPath) throws SQLException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        int imageNoteIndex = 0;
        if (imageParts != null) {
            for (Part part : imageParts) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    if (!part.getContentType().startsWith("image/")) {
                        throw new SQLException("Chỉ chấp nhận file ảnh.");
                    }
                    String originalFileName = extractFileName(part);
                    String fileName = System.currentTimeMillis() + "_" + originalFileName;
                    String filePath = uploadPath + File.separator + fileName;
                    try {
                        part.write(filePath);
                    } catch (IOException e) {
                        throw new SQLException("Không thể lưu ảnh: " + e.getMessage());
                    }
                    Media media = new Media();
                    media.setNoteID(noteId);
                    media.setMediaType("image");
                    media.setMediaUrl("assets/images/note/" + fileName);
                    media.setContent(imageNotes != null && imageNoteIndex < imageNotes.length && imageNotes[imageNoteIndex] != null && !imageNotes[imageNoteIndex].isEmpty() ? imageNotes[imageNoteIndex] : null);
                    getMediaDAO().addMedia(media);
                    imageNoteIndex++;
                }
            }
        }
        int videoNoteIndex = 0;
        if (videoLinks != null) {
            for (String video : videoLinks) {
                if (video.trim().isEmpty()) {
                    continue;
                }
                String embedUrl = getYouTubeEmbedUrl(video.trim());
                if (embedUrl.isEmpty()) {
                    throw new SQLException("Link video không hợp lệ: " + video);
                }
                Media media = new Media();
                media.setNoteID(noteId);
                media.setMediaType("video");
                media.setMediaUrl(embedUrl);
                media.setContent(videoNotes != null && videoNoteIndex < videoNotes.length && videoNotes[videoNoteIndex] != null && !videoNotes[videoNoteIndex].isEmpty() ? videoNotes[videoNoteIndex] : null);
                getMediaDAO().addMedia(media);
                videoNoteIndex++;
            }
        }
    }

    // 8. Chuyển đổi link YouTube (dạng watch?v= hoặc youtu.be) thành embed URL để lưu vào cơ sở dữ liệu
    private String getYouTubeEmbedUrl(String url) {
        String videoId = "";
        if (url.contains("youtube.com/watch?v=")) {
            videoId = url.split("watch\\?v=")[1].split("&")[0];
        } else if (url.contains("youtu.be/")) {
            videoId = url.split("youtu.be/")[1].split("\\?")[0].split("&")[0];
        }
        return videoId.isEmpty() ? "" : "https://www.youtube.com/embed/" + videoId;
    }

    // 9. Lấy tên file gốc từ header content-disposition của một Part (file upload từ form)
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String s : contentDisposition.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public static void main(String[] args) {
        UserLessonNotesDAO dao = UserLessonNotesDAO.getInstance();
        List<UserLessonNotes> notes = dao.getAllNoteByLessonIdAndUserID(13, 5);
        System.out.println(notes.get(0).getMedia().get(0).getNoteID());
    }
}