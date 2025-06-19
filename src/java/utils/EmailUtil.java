/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author admin
 */
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    // THAY THẾ CÁC THÔNG TIN NÀY BẰNG CỦA BẠN
    private static final String SENDER_EMAIL = "buitrongthinh24@gmail.com"; // VD: your.email.fpt@fpt.edu.vn
    private static final String SENDER_PASSWORD = "ffbw mrju itlz ofbu"; // Mật khẩu ứng dụng nếu dùng Gmail, hoặc mật khẩu email thông thường
    private static final String SMTP_HOST = "smtp.gmail.com"; // Hoặc smtp.office365.com, smtp.mail.yahoo.com... tùy email bạn dùng
    private static final String SMTP_PORT = "587"; // Thường là 587 cho TLS (STARTTLS), hoặc 465 cho SSL

    public static void sendEmail(String recipientEmail, String subject, String content) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // bảo vệ thông tin của máy khách về máy chủ smtp

        // Tạo Session với Authenticator
        Session session = Session.getInstance(props, new Authenticator() { 
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

        try {
            // Tạo đối tượng Message
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL)); // Người gửi
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail)); // Người nhận
            message.setSubject(subject, "UTF-8"); // Tiêu đề email, đặt UTF-8 để hỗ trợ tiếng Việt
            message.setHeader("Content-Type", "text/html; charset=UTF-8");
            message.setContent(content, "text/html; charset=UTF-8"); // Nội dung email dạng HTML, đặt UTF-8 để hỗ trợ tiếng Việt

            // Gửi email
            Transport.send(message);
            System.out.println("Email sent successfully to: " + recipientEmail);
        } catch (MessagingException e) {
            System.err.println("Error sending email to " + recipientEmail + ": " + e.getMessage());
            e.printStackTrace(); // In stack trace để debug chi tiết hơn
            throw e; // Ném lại lỗi để Controller có thể bắt và xử lý
        }
    }
}
