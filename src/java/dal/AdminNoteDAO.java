package dal;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import model.AdminLessonNote;
import model.AdminNoteMedia;

public class AdminNoteDAO extends DBContext {

    private static AdminNoteDAO instance;
    public static AdminNoteDAO getInstance() {
        if (instance == null) instance = new AdminNoteDAO();
        return instance;
    }

    public List<AdminLessonNote> getNotesByLessonId(int lessonId) {
        List<AdminLessonNote> notes = new ArrayList<>();
        String sql = "SELECT * FROM AdminLessonNote WHERE LessonID = ? ORDER BY CreatedDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AdminLessonNote note = new AdminLessonNote();
                    note.setNoteID(rs.getInt("NoteID"));
                    note.setLessonID(rs.getInt("LessonID"));
                    note.setNoteContent(rs.getString("NoteContent"));
                    note.setCreatedByUserID(rs.getInt("CreatedByUserID"));
                    note.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    note.setMedia(getMediaByNoteId(note.getNoteID())); // Lấy media đính kèm
                    notes.add(note);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notes;
    }

    public List<AdminNoteMedia> getMediaByNoteId(int noteId) {
        List<AdminNoteMedia> mediaList = new ArrayList<>();
        String sql = "SELECT * FROM AdminNoteMedia WHERE NoteID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, noteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AdminNoteMedia media = new AdminNoteMedia();
                    media.setMediaID(rs.getInt("MediaID"));
                    media.setNoteID(rs.getInt("NoteID"));
                    media.setMediaType(rs.getString("MediaType"));
                    media.setMediaURL(rs.getString("MediaURL"));
                    media.setContent(rs.getString("Content"));
                    mediaList.add(media);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mediaList;
    }

    public void addNoteWithMedia(AdminLessonNote note, Collection<Part> imageParts, String[] videoLinks, String uploadPath) throws SQLException, IOException {
        // Thêm ghi chú chính và lấy lại ID
        int newNoteId = addNoteAndGetId(note);
        if (newNoteId == -1) {
            throw new SQLException("Failed to add note, no ID obtained.");
        }

        // Xử lý và lưu các link video
        if (videoLinks != null) {
            for (String link : videoLinks) {
                String trimmedLink = link.trim();
                if (!trimmedLink.isEmpty()) {
                    String embedUrl = getYouTubeEmbedUrl(trimmedLink);
                    if (!embedUrl.isEmpty()) {
                         addMedia(new AdminNoteMedia(0, newNoteId, "video", embedUrl, null));
                    }
                }
            }
        }

        // Xử lý và lưu các file ảnh
        if (imageParts != null) {
             File fileSaveDir = new File(uploadPath);
             if (!fileSaveDir.exists()) fileSaveDir.mkdirs();

            for (Part part : imageParts) {
                String fileName = getSubmittedFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    part.write(uploadPath + File.separator + fileName);
                    String dbPath = "uploads/admin_notes/" + fileName; // Đường dẫn lưu trong DB
                    addMedia(new AdminNoteMedia(0, newNoteId, "image", dbPath, null));
                }
            }
        }
    }
    
    private int addNoteAndGetId(AdminLessonNote note) throws SQLException {
        String sql = "INSERT INTO AdminLessonNote (LessonID, NoteContent, CreatedByUserID) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, note.getLessonID());
            ps.setString(2, note.getNoteContent());
            ps.setInt(3, note.getCreatedByUserID());
            ps.executeUpdate();
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) return generatedKeys.getInt(1);
            }
        }
        return -1;
    }
    
    private void addMedia(AdminNoteMedia media) throws SQLException {
        String sql = "INSERT INTO AdminNoteMedia (NoteID, MediaType, MediaURL, Content) VALUES (?, ?, ?, ?)";
        try(PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, media.getNoteID());
            ps.setString(2, media.getMediaType());
            ps.setString(3, media.getMediaURL());
            ps.setString(4, media.getContent());
            ps.executeUpdate();
        }
    }

    public void deleteNote(int noteId) {
        String sql = "DELETE FROM AdminLessonNote WHERE NoteID = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, noteId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // --- CÁC HÀM TRỢ GIÚP ---
    private String getYouTubeEmbedUrl(String url) {
        String videoId = null;
        if (url.contains("watch?v=")) {
            videoId = url.split("watch\\?v=")[1].split("&")[0];
        } else if (url.contains("youtu.be/")) {
            videoId = url.split("youtu.be/")[1].split("\\?")[0];
        } else if (url.contains("/embed/")) {
             videoId = url.split("/embed/")[1].split("\\?")[0];
        }
        return (videoId != null) ? "https://www.youtube.com/embed/" + videoId : "";
    }
    
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}