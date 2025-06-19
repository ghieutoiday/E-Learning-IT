/*
 * Click nbproject://nbproject/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbproject://nbproject/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Media;

/**
 *
 * @author ASUS
 */
public class MediaDAO extends DBContext {
    private static MediaDAO instance;

    private MediaDAO() {
        super();
    }

    public static MediaDAO getInstance() {
        if (instance == null) {
            synchronized (MediaDAO.class) {
                if (instance == null) {
                    instance = new MediaDAO();
                }
            }
        }
        return instance;
    }

    // 1. Lấy ra 1 đối tượng Media từ mediaID truyền vô
    public Media getMediaByMediaID(int mediaID) {
        Media media = null;
        String sql = "SELECT * FROM Media WHERE mediaID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, mediaID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int userLessonNotesID = rs.getInt("noteID");
                    String mediaType = rs.getString("mediaType");
                    String mediaUrl = rs.getString("mediaUrl");
                    String content = rs.getString("content");
                    media = new Media(mediaID, userLessonNotesID, mediaType, mediaUrl, content);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getMediaByMediaID: " + e.getMessage());
            e.printStackTrace();
        }
        return media;
    }

    // 2. Tạo 1 bản ghi Media
    public int addMedia(Media media) {
        String sql = "INSERT INTO Media (noteID, mediaType, mediaUrl, content) VALUES (?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            st.setInt(1, media.getNoteID());
            st.setString(2, media.getMediaType());
            st.setString(3, media.getMediaUrl());
            st.setString(4, media.getContent());
            st.executeUpdate();
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in addMedia: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // 3. Xóa Media thông qua noteID truyền vô
    public void deleteMediaByNote(int noteID) throws SQLException {
        String sql = "DELETE FROM Media WHERE noteID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, noteID);
            st.executeUpdate();
        }
    }

    // 4. Xóa Media thông qua mediaID
    public void deleteMediaById(int mediaID) throws SQLException {
        String sql = "DELETE FROM Media WHERE mediaID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, mediaID);
            st.executeUpdate();
        }
    }

    // 5. Lấy ra toàn bộ Media theo noteID
    public List<Media> getAllMediaByNote(int noteID) {
        List<Media> listMedia = new ArrayList<>();
        String sql = "SELECT * FROM Media WHERE noteID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, noteID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Media media = getMediaByMediaID(rs.getInt("mediaID"));
                    if (media != null) {
                        listMedia.add(media);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllMediaByNote: " + e.getMessage());
            e.printStackTrace();
        }
        return listMedia;
    }

    // 6. Cập nhật nội dung (content) của media
    public void updateMediaContent(int mediaID, String content) throws SQLException {
        String sql = "UPDATE Media SET content = ? WHERE mediaID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, content);
            st.setInt(2, mediaID);
            st.executeUpdate();
        }
    }

    public static void main(String[] args) {
        try {
            System.out.println(MediaDAO.getInstance().getAllMediaByNote(21).get(0).getMediaUrl());
            System.out.println("15");
            DBContext.getInstance().shutdown();
        } catch (SQLException e) {
            System.err.println("Error in main: " + e.getMessage());
            e.printStackTrace();
        }
    }
}