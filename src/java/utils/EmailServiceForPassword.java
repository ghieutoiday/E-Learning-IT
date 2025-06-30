package utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailServiceForPassword {

    private static final String FROM_EMAIL = "g.trung.hieu.08@gmail.com"; // Gmail bạn
    private static final String PASSWORD = "juku dsmy pgrw cmqc"; // App Password

    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
    }

    public static boolean send(String toEmail, String subject, String body) {
        try {
            Message message = new MimeMessage(getSession());
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            //message.setText(body); //Gửi email dạng text
            message.setContent(body, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

     public static boolean sendForgetPasswordEmail(String toEmail, String name, String link) {
        String subject = "Reset Password";
        String body = "<p>Hi " + name + ",</p>"
             + "<p>You have requested to reset your password. Please click the button below:</p>"
             + "<a href=\"" + link + "\" "
             + "title=\"Click to reset your password\" "
             + "style=\"display:inline-block;padding:10px 15px;background-color:#007bff;"
             + "color:white;text-decoration:none;border-radius:5px\">"
             + "Reset Password</a>"
             + "<p>Link will expire in 10 minutes</p>"
             + "<p>Thank you,<br>System Support</p>";
        return send(toEmail, subject, body);
    }

}
