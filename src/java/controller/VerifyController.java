package controller;

import dal.UserDAO;
import dal.TokenDAO;
import model.User;
import model.TokenForgetPassword;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.Duration;

@WebServlet(name = "VerifyController", urlPatterns = {"/verifycontroller"}) 
public class VerifyController extends HttpServlet {

    private UserDAO userDAO;
    private TokenDAO tokenDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        tokenDAO = new TokenDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tokenString = request.getParameter("token");
        String verificationMessage = "";

        if (tokenString == null || tokenString.isEmpty()) {
            verificationMessage = "Liên kết xác minh không hợp lệ.";
        } else {
            try {
                TokenForgetPassword verToken = tokenDAO.getToken(tokenString);

                if (verToken == null) {
                    verificationMessage = "Liên kết xác minh không tồn tại.";
                } else if (verToken.isIsUsed()) {
                    verificationMessage = "Liên kết xác minh đã được sử dụng.";
                    // Dòng này được BÌNH LUẬN (OPTIONAL) theo các thảo luận trước đó, 
                    // nhưng nếu bỏ bình luận thì nó sẽ xóa token đã sử dụng.
                    // tokenDAO.deleteToken(tokenString); 
                } else if (verToken.getExpiryTime().isBefore(LocalDateTime.now())) { // Kiểm tra token hết hạn
                    verificationMessage = "Liên kết xác minh đã hết hạn. Vui lòng đăng ký lại hoặc yêu cầu gửi lại email.";
                    tokenDAO.markTokenUsed(tokenString); 
                    // DÒNG SỬ DỤNG HÀM DELETE: Xóa token sau khi hết hạn
                    tokenDAO.deleteToken(tokenString); 
                } else {
                    // Token hợp lệ, chưa sử dụng, chưa hết hạn
                    User user = userDAO.getUserByID(verToken.getUserID().getUserID()); 

                    if (user == null) {
                        verificationMessage = "Không tìm thấy tài khoản người dùng cho liên kết này.";
                        tokenDAO.markTokenUsed(tokenString); 
                        // DÒNG SỬ DỤNG HÀM DELETE: Xóa token nếu user không tìm thấy (để tránh token vô chủ)
                        tokenDAO.deleteToken(tokenString); 
                    } else if ("Active".equalsIgnoreCase(user.getStatus())) {
                        verificationMessage = "Tài khoản của bạn đã được xác minh trước đó.";
                        tokenDAO.markTokenUsed(tokenString); 
                        // DÒNG SỬ DỤNG HÀM DELETE: Xóa token nếu tài khoản đã Active (đã được xác minh rồi)
                        tokenDAO.deleteToken(tokenString); 
                    } else {
                        // Token hợp lệ và tài khoản chưa Active, tiến hành xác minh
                        boolean userStatusUpdated = userDAO.updateUserStatus(user.getUserID(), "Active");
                        tokenDAO.markTokenUsed(tokenString); 

                        if (userStatusUpdated) {
                            verificationMessage = "Tài khoản của bạn đã được xác minh thành công! Bạn có thể đăng nhập ngay bây giờ.";
                            // DÒNG SỬ DỤNG HÀM DELETE: Xóa token sau khi xác minh thành công
                            tokenDAO.deleteToken(tokenString); 
                        } else {
                            verificationMessage = "Có lỗi xảy ra trong quá trình cập nhật trạng thái người dùng. Vui lòng thử lại.";
                        }
                    }
                }
            } catch (Exception e) { 
                e.printStackTrace();
                verificationMessage = "Lỗi hệ thống không xác định trong quá trình xử lý xác minh. Vui lòng thử lại.";
            }
        }
        
        request.setAttribute("verificationMessage", verificationMessage);
        request.getRequestDispatcher("/verificationStatus.jsp").forward(request, response);
    }
}