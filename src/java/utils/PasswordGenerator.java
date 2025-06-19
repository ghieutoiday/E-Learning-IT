/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author admin
 */
import java.security.SecureRandom;
import java.util.Base64;
public class PasswordGenerator {
    private static final SecureRandom secureRandom = new SecureRandom();
    private static final Base64.Encoder base64Encoder = Base64.getUrlEncoder();

    // Sinh mật khẩu ngẫu nhiên với độ dài cho trước
    public static String generateRandomPassword(int length) {
        byte[] randomBytes = new byte[length];
        secureRandom.nextBytes(randomBytes);
        // Mã hóa sang Base64 để có chuỗi ký tự an toàn cho mật khẩu
        String password = base64Encoder.encodeToString(randomBytes);
        // Cắt bớt nếu quá dài hoặc thêm các ký tự đặc biệt để tăng độ mạnh
        return password.substring(0, Math.min(password.length(), length));
    }

    public static String hashPassword(String rawPassword) {
        return "hashed_" + rawPassword; 
    }
}
