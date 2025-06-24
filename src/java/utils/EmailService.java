package utils;

import java.util.Properties;
// THAY ĐỔI TẤT CẢ CÁC IMPORT TỪ JAVAX SANG JAKARTA
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

    /**
     * Gửi email chứa mật khẩu mặc định cho người dùng mới.
     * @param recipientEmail Email của người nhận.
     * @param recipientName Tên của người nhận.
     * @param generatedPassword Mật khẩu được tạo ra.
     * @return true nếu gửi thành công, false nếu thất bại.
     */
    public static boolean sendNewUserPasswordEmail(String recipientEmail, String recipientName, String generatedPassword) {

        final String fromEmail = "nguyenthehungas2711@gmail.com";   
        final String password = "xeoyocienojlnshr"; 

        // CẤU HÌNH MÁY CHỦ GỬI MAIL CỦA GMAIL
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587"); 
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable", "true"); 

        // Tạo một đối tượng Authenticator để xác thực tài khoản gửi mail
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage msg = new MimeMessage(session);
            
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail, false));
            msg.setSubject("Your New Account Credentials - EduLearning", "UTF-8");
            
            String emailContent = "<h1>Welcome to EduLearning, " + recipientName + "!</h1>"
                                + "<p>An administrator has created an account for you.</p>"
                                + "<p>You can now log in using the following credentials:</p>"
                                + "<ul>"
                                + "<li><strong>Email:</strong> " + recipientEmail + "</li>"
                                + "<li><strong>Password:</strong> " + generatedPassword + "</li>"
                                + "</ul>"
                                + "<p>For security reasons, please change your password after your first login.</p>"
                                + "<p>Best regards,<br>The EduLearning Team</p>";

            msg.setContent(emailContent, "text/html; charset=UTF-8");

            Transport.send(msg);
            
            System.out.println("Email sent successfully to " + recipientEmail);
            return true; 

        } catch (MessagingException e) {
            System.out.println("Lỗi khi gửi mail: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}