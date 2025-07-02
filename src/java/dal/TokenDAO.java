package dal;

import java.sql.*;
import java.time.LocalDateTime;
import model.TokenForgetPassword;
import model.User;

public class TokenDAO extends DBContext {

    public void saveToken(TokenForgetPassword token) {
        String sql = "INSERT INTO TokenForgetPassword (token, expiryTime, isUsed, userID) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token.getToken());
            ps.setTimestamp(2, Timestamp.valueOf(token.getExpiryTime()));
            ps.setBoolean(3, token.isIsUsed());
            ps.setInt(4, token.getUserID().getUserID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public TokenForgetPassword getToken(String tokenString) {
        String sql = "SELECT * FROM TokenForgetPassword WHERE token = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, tokenString);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TokenForgetPassword token = new TokenForgetPassword();
                token.setTokenID(rs.getInt("tokenID"));
                token.setToken(rs.getString("token"));
                token.setExpiryTime(rs.getTimestamp("expiryTime").toLocalDateTime());
                token.setIsUsed(rs.getBoolean("isUsed"));
                User user = new User();
                user.setUserID(rs.getInt("userID"));
                token.setUserID(user);
                return token;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void markTokenUsed(String tokenString) {
        String sql = "UPDATE TokenForgetPassword SET isUsed = 1 WHERE token = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, tokenString);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deleteToken(String tokenString) {
        String sql = "DELETE FROM TokenForgetPassword WHERE token = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, tokenString);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong deleteToken: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Lỗi chung trong deleteToken: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

}
