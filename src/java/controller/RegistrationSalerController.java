/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDAO;
import dal.PricePackageDAO;
import dal.RegistrationDAO;
import dal.UserDAO;
import jakarta.mail.MessagingException;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Course;
import model.PricePackage;
import model.Registration;
import java.util.Date;
import model.User;
import utils.EmailUtil;
import utils.PasswordGenerator;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author admin
 */
@WebServlet(name = "RegistrationSalerController", urlPatterns = {"/registrationsalercontroller"})
public class RegistrationSalerController extends HttpServlet {

    private RegistrationDAO registrationDAO;
    private CourseDAO courseDAO;
    private PricePackageDAO pricePackageDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        registrationDAO = new RegistrationDAO();
        courseDAO = new CourseDAO();
        pricePackageDAO = new PricePackageDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("loggedInUser");

        // Kiểm tra xem người dùng đã đăng nhập chưa và có phải là Saler không
        if (currentUser == null || currentUser.getRole() == null || currentUser.getRole().getRoleID() != 3) {
            request.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");

        if ("detail".equals(action)) {
            String registrationID = request.getParameter("registrationID");
            if (registrationID != null && !registrationID.isEmpty()) {
                Registration registration = registrationDAO.getRegistrationByRegistrationID(Integer.parseInt(registrationID));
                if (registration != null) {
                    request.setAttribute("Saler", registration);
                    request.getRequestDispatcher("registration-details-saler.jsp").forward(request, response);
                    return;
                }
            }
            response.sendRedirect("registration-list-saler.jsp");
            return;
        }

        if ("edit".equals(action)) {
            String registrationIDParam = request.getParameter("registrationID");
            if (registrationIDParam != null && !registrationIDParam.isEmpty()) {
                int registrationID = Integer.parseInt(registrationIDParam);
                Registration Saler = registrationDAO.getRegistrationByRegistrationID(registrationID);
                request.setAttribute("Saler", Saler);
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-edit-saler.jsp").forward(request, response);
                return;

            }
        }
        if ("new".equals(action)) {
            request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
            request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
            request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
            return;
        }

        // Lấy các tham số sắp xếp từ request
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder"); // là 'asc' hoặc 'desc'

        // Nếu tham số sắp xếp là null hoặc rỗng thì mặc định sắp xếp theo registrationID và tăng dần
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "registrationID";
        }
        if (sortOrder == null || sortOrder.trim().isEmpty()) {
            sortOrder = "asc";
        }

        // Láy các tham số search, filter từ request
        String emailSearch = request.getParameter("emailSearch");
        String courseName = request.getParameter("courseName");
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        int lastUpdateByUserId = currentUser.getUserID();

        // Gửi lại các tham số sang JSP để hiện lại giá trị nhập
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("emailSearch", emailSearch);
        request.setAttribute("courseName", courseName);
        request.setAttribute("name", name);
        request.setAttribute("status", status);

        List<Course> courseList = new CourseDAO().getAllCourse();
        List<PricePackage> packageList = new PricePackageDAO().getAllDistinctPricePackagesByName();

        // Gọi ra DAO để có thể lấy ra tất cả registration, có thể sort tăng hoặc giảm dần ở các cột, có thể lọc theo courseName, name pricepackage và status
        List<Registration> listRegistrationBySaler = RegistrationDAO.getInstance().getRegistrationsByAllFilters(emailSearch, courseName, name, status, sortBy, sortOrder, lastUpdateByUserId);

        request.setAttribute("courseList", courseList);
        request.setAttribute("packageList", packageList);
        request.setAttribute("listRegistrationBySaler", listRegistrationBySaler);
        request.getRequestDispatcher("registration-list-saler.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("loggedInUser");

        // Kiểm tra xem currentUser có phải là Saler không
        if (currentUser == null || currentUser.getRole().getRoleID() != 3) {
            session.setAttribute("errorMessage", "Bạn không có quyền thực hiện hành động này.");
            response.sendRedirect("home");
            return;
        }
        if ("edit".equals(action)) {
            String registrationIDStr = request.getParameter("registrationID");
            String courseIDStr = request.getParameter("courseID");
            String pricePackageIDStr = request.getParameter("pricePackageID");
            String name = request.getParameter("name");
            String listPriceStr = request.getParameter("listPrice");
            String salePriceStr = request.getParameter("salePrice");
            String userIDStr = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String validFromStr = request.getParameter("validFrom");
            String validToStr = request.getParameter("validTo");
            String status = request.getParameter("status");
            String note = request.getParameter("note");

            Date validFrom = null;
            Date validTo = null;

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            int registrationID = -1;
            int courseID = -1;
            int pricePackageID = -1;
            int userID = -1;
            double parsedListPrice = 0.0;
            double parsedSalePrice = 0.0;

            try {
                if (listPriceStr != null && !listPriceStr.trim().isEmpty()) {
                    parsedListPrice = Double.parseDouble(listPriceStr);
                }

                if (salePriceStr != null && !salePriceStr.trim().isEmpty()) {
                    parsedSalePrice = Double.parseDouble(salePriceStr);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi: Giá trị không hợp lệ.");
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registrationsalercontroller?action=edit&registrationID=" + registrationIDStr).forward(request, response);
                return;
            }

            String oldStatus = null;
            String recipientEmail = null; // Email sẽ dùng để gửi mail

            try {
                // Lấy thông tin Registration cũ trước khi cập nhật
                Registration oldRegistration = registrationDAO.getRegistrationByRegistrationID(registrationID);
                oldStatus = oldRegistration.getStatus();
                // Lấy email từ User liên quan đến oldRegistration
                User userLinkedToOldReg = userDAO.getUserByID(oldRegistration.getUser().getUserID());
                recipientEmail = userLinkedToOldReg.getEmail();

                Registration registration = new Registration();
                registration.setRegistrationID(Integer.parseInt(registrationIDStr));
                registration.setValidFrom(validFrom);
                registration.setValidTo(validTo);
                registration.setStatus(status);
                registration.setNote(note);

                Course course = new CourseDAO().getCoureByCourseID(Integer.parseInt(courseIDStr));
                registration.setCourse(course);

                boolean registrationUpdated = registrationDAO.updateRegistration(registration);

                PricePackage pricePackage = new PricePackage();
                pricePackage.setPricePackageID(Integer.parseInt(pricePackageIDStr));
                pricePackage.setName(name);
                pricePackage.setListPrice(Double.parseDouble(listPriceStr));
                pricePackage.setSalePrice(Double.parseDouble(salePriceStr));
                pricePackageDAO.updatePricePackageRegistration(pricePackage);

                User user = new User();
                user.setUserID(Integer.parseInt(userIDStr));
                user.setFullName(fullName);
                user.setGender(gender);
                user.setEmail(email);
                user.setMobile(mobile);
                userDAO.updateUserRegistration(user);

                // --- Logic gửi email ---
                // kiểm tra xem registrationUpdate và status != null, oldStatus khác Paid và status new là Paid
                if (registrationUpdated && oldStatus != null && !oldStatus.equalsIgnoreCase("Paid") && status.equalsIgnoreCase("Paid")) {

                    // Kiểm tra email người nhận có hợp lệ không
                    if (recipientEmail != null && !recipientEmail.isEmpty()) {
                        String subject = "Notification: Your Registration Has Been Successfully Paid!";
                        String content = "Hello " + fullName + ",<br><br>"
                                + "We would like to inform you that your course registration (ID: " + registrationID + ") has been successfully paid.<br>"
                                + "Please access the following link to log in: <br>"
                                + "<a href=\"http://localhost:9999/E-Learning-IT/home\">Click here to log in</a>.<br><br>"
                                + "Sincerely,<br>"
                                + "E-Learning Team.";
                        try {
                            // tiến hành gửi mail
                            EmailUtil.sendEmail(recipientEmail, subject, content);
                        } catch (jakarta.mail.MessagingException e) {
                            e.printStackTrace();
                        }
                    }
                }

                List<Course> courseList = new CourseDAO().getAllDistinctCourseByName();
                List<PricePackage> packageList = new PricePackageDAO().getAllDistinctPricePackagesByName();
                Registration registrationList = registrationDAO.getRegistrationByRegistrationID(registrationID);
                request.setAttribute("Saler", registration);

                request.setAttribute("courseList", courseList);
                request.setAttribute("Saler", registrationList);
                request.setAttribute("packageList", packageList);

                response.sendRedirect("registrationsalercontroller?action=detail&registrationID=" + registrationIDStr);
            } catch (Exception e) { // Bắt các lỗi DAO
                e.printStackTrace();
                request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống khi cập nhật đăng ký.");
                request.getRequestDispatcher("registrationsalercontroller?action=edit&registrationID=" + registrationIDStr).forward(request, response);
            }
        } else if ("new".equals(action)) {
            User user = (User) session.getAttribute("loggedInUser");

            String courseIDStr = request.getParameter("courseID");
            String packageName = request.getParameter("packageName");
            String listPriceStr = request.getParameter("listPrice");
            String salePriceStr = request.getParameter("salePrice");

            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");

            String validFromStr = request.getParameter("validFrom");
            String validToStr = request.getParameter("validTo");
            String status = request.getParameter("status");
            String note = request.getParameter("note");

            java.util.Date validFrom = null;
            java.util.Date validTo = null;

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // 2. Validate và parse các giá trị
            try {
                if (validFromStr != null && !validFromStr.isEmpty()) {
                    validFrom = sdf.parse(validFromStr);
                }
                if (validToStr != null && !validToStr.isEmpty()) {
                    validTo = sdf.parse(validToStr);
                }
            } catch (ParseException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi: Định dạng ngày tháng không hợp lệ (yyyy-MM-dd).");
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
                return;
            }

            int courseID = 0;
            double listPrice = 0.0;
            double salePrice = 0.0;

            try {
                // Validate và parse Course ID
                if (courseIDStr == null || courseIDStr.isEmpty()) {
                    throw new Exception("Vui lòng chọn khóa học.");
                }
                courseID = Integer.parseInt(courseIDStr);

                // Validate và parse List Price
                if (listPriceStr == null || listPriceStr.trim().isEmpty()) {
                    throw new Exception("Giá niêm yết không hợp lệ hoặc để trống.");
                }
                listPrice = Double.parseDouble(listPriceStr);

                // Validate và parse Sale Price
                if (salePriceStr == null || salePriceStr.trim().isEmpty()) {
                    throw new Exception("Giá bán không hợp lệ hoặc để trống.");
                }
                salePrice = Double.parseDouble(salePriceStr);

                // Validate các trường bắt buộc khác
                if (fullName == null || fullName.trim().isEmpty()) {
                    throw new Exception("Họ tên người học không được để trống.");
                }
                if (email == null || email.trim().isEmpty() || !email.matches("^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$")) {
                    throw new Exception("Email không hợp lệ hoặc để trống.");
                }
                if (mobile == null || mobile.trim().isEmpty() || !mobile.matches("^\\d{10,11}$")) {
                    throw new Exception("Số điện thoại không hợp lệ (phải là 10-11 chữ số).");
                }
                if (validFrom == null || validTo == null) { // Kiểm tra ngày có được nhập không
                    throw new Exception("Ngày bắt đầu và Ngày kết thúc không được để trống.");
                }
                if (validFrom.after(validTo)) {
                    throw new Exception("Ngày bắt đầu không được sau ngày kết thúc.");
                }

            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Lỗi định dạng số (Course ID, List Price, Sale Price) không hợp lệ.");
                e.printStackTrace(); 
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                request.setAttribute("errorMessage", e.getMessage());
                e.printStackTrace();
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
                return;
            }

            User userRegistration; // Đối tượng User sẽ được gán cho Registration

            User existingUser = userDAO.getUserByEmail(email);
            if (existingUser != null) {
                userRegistration = existingUser;
            } else {

                // Email chưa tồn tại. Tạo User mới
                User newUser = new User();
                newUser.setFullName(fullName);
                newUser.setGender(gender);
                newUser.setEmail(email);
                newUser.setMobile(mobile);
                String rawPassword = PasswordGenerator.generateRandomPassword(10); // Sinh mật khẩu ngẫu nhiên 10 ký tự
                String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
                newUser.setPassword(hashedPassword);

                int newUserID = userDAO.addNewUser(newUser);

                // Lưu mật khẩu raw để gửi email (chỉ khi tạo user mới)
                request.setAttribute("newlyGeneratedPassword", rawPassword); // Lưu vào request để sau này lấy ra gửi email

                userRegistration = userDAO.getUserByID(newUserID);
            }

            Course courseRegistrationID = courseDAO.getCoureByCourseID(courseID);

            PricePackage newPricePackage = new PricePackage();
            newPricePackage.setCourse(courseRegistrationID);
            newPricePackage.setName(packageName);
            newPricePackage.setListPrice(listPrice);
            newPricePackage.setSalePrice(salePrice);
            newPricePackage.setStatus("Active");
            int pricePackageID = pricePackageDAO.addPricePackage(newPricePackage);

            PricePackage finalPricePackage = pricePackageDAO.getPricePackageByPricePackageID(pricePackageID);

            // 6. Tạo Registration
            int userID = user.getUserID();
            Registration newRegistration = new Registration();
            newRegistration.setUser(userRegistration);
            newRegistration.setCourse(courseRegistrationID);
            newRegistration.setPricePackage(finalPricePackage);
            newRegistration.setValidFrom(new java.sql.Date(validFrom.getTime()));
            newRegistration.setValidTo(new java.sql.Date(validTo.getTime()));
            newRegistration.setStatus(status);
            newRegistration.setTotalCost(salePrice);
            newRegistration.setNote(note);

            int newRegistrationID = -1;
            try {
                newRegistrationID = registrationDAO.addRegistration(newRegistration, userID);
            } catch (IllegalArgumentException e) {
                // Bắt IllegalArgumentException từ DAO nếu user là null
                request.setAttribute("errorMessage", "Lỗi dữ liệu đăng ký: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
                return;
            } catch (Exception e) { // Bắt các lỗi khác có thể xảy ra trong addRegistration
                request.setAttribute("errorMessage", "Lỗi khi thêm đăng ký: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
                return;
            }

            if (newRegistrationID > 0) {
                // Lấy thông tin Registration vừa tạo 
                Registration addedRegistration = registrationDAO.getRegistrationByRegistrationID(newRegistrationID);

                if (addedRegistration != null && "Paid".equalsIgnoreCase(addedRegistration.getStatus())) {
                    User registeredUser = addedRegistration.getUser();
                    if (registeredUser != null && registeredUser.getEmail() != null && !registeredUser.getEmail().isEmpty()) {
                        String recipientEmail = registeredUser.getEmail();

                        // kiểm tra xem user này có phải user mới được tạo không, nếu existingUser là null thì là user mới
                        if (existingUser == null) { // Nếu là user mới được tạo
                            String newPassword = (String) request.getAttribute("newlyGeneratedPassword"); // Lấy mật khẩu raw

                            String subject = "Welcome to Our Course!";
                            String emailContent = "Hello " + registeredUser.getFullName() + ",<br><br>"
                                    + "Welcome! You have successfully registered for the course <b>" + addedRegistration.getCourse().getCourseName() + "</b>.<br>"
                                    + "Your account has been activated. Please log in with your email: <b>" + recipientEmail + "</b> and your password is: <b>" + newPassword + "</b>.<br><br>"
                                    + "Please access the following link to log in: <br>"
                                    + "<a href=\"http://localhost:9999/E-Learning-IT/home\">Click here to log in</a>" + "</b>.<br>"
                                    + "You should change your password for security.<br><br>"
                                    + "Sincerely,<br>"
                                    + "E-Learning Team.";
                            try {
                                // gửi mail
                                System.out.println("Email content before sending:\n" + emailContent);
                                EmailUtil.sendEmail(recipientEmail, subject, emailContent);
                            } catch (MessagingException mailException) {
                                mailException.printStackTrace();
                            }
                        }
                    }
                }

                response.sendRedirect("registrationsalercontroller?action=detail&registrationID=" + newRegistrationID);
            } else {
                // Xử lý trường hợp thêm registration thất bại (DAO trả về -1)
                request.setAttribute("errorMessage", "Lỗi: Không thể thêm đăng ký mới vào hệ thống. Vui lòng kiểm tra dữ liệu và log server.");
                request.setAttribute("courseList", courseDAO.getAllDistinctCourseByName());
                request.setAttribute("packageList", pricePackageDAO.getAllDistinctPricePackagesByName());
                request.getRequestDispatcher("registration-addnew-saler.jsp").forward(request, response);
                return;
            }

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
