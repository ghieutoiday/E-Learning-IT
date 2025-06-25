/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SliderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Slider;
import java.io.File;
import jakarta.servlet.http.Part;

@WebServlet(name = "SliderController", urlPatterns = {"/slidercontroller"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class SliderController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SliderDAO sliderDAO = new SliderDAO();
    private static final int SLIDERS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                /*case "delete":
                    String deleteSliderId = request.getParameter("id");
                    if (deleteSliderId != null && !deleteSliderId.isEmpty()) {
                        sliderDAO.deleteSlider(Integer.parseInt(deleteSliderId));
                    }
                    response.sendRedirect("slidercontroller");
                    break;
                 */

                case "list":
                    String search = request.getParameter("search");
                    String status = request.getParameter("status");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int rowsPerPage = request.getParameter("rowsPerPage") != null ? Integer.parseInt(request.getParameter("rowsPerPage")) : SLIDERS_PER_PAGE;

                    // Column visibility parameters
                    boolean hideID = "true".equals(request.getParameter("hideID"));
                    boolean hideImage = "true".equals(request.getParameter("hideImage"));
                    boolean hideTitle = "true".equals(request.getParameter("hideTitle"));
                    boolean hideBacklink = "true".equals(request.getParameter("hideBacklink"));
                    boolean hideStatus = "true".equals(request.getParameter("hideStatus"));

                    List<Slider> sliders = sliderDAO.getFilteredSliders(search, status, page, rowsPerPage);
                    int totalSliders = sliderDAO.getTotalFilteredSliders(search, status);
                    int totalPages = (totalSliders + rowsPerPage - 1) / rowsPerPage;
                    request.setAttribute("totalSliders", totalSliders);
                    request.setAttribute("sliders", sliders);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("search", search);
                    request.setAttribute("status", status);
                    request.setAttribute("rowsPerPage", rowsPerPage);

                    request.setAttribute("hideID", hideID);
                    request.setAttribute("hideImage", hideImage);
                    request.setAttribute("hideTitle", hideTitle);
                    request.setAttribute("hideBacklink", hideBacklink);
                    request.setAttribute("hideStatus", hideStatus);

                    request.getRequestDispatcher("/admin/sliderlist.jsp").forward(request, response);
                    break;

                case "view":
                    String sliderId = request.getParameter("id");
                    if (sliderId != null && !sliderId.isEmpty()) {
                        Slider slider = sliderDAO.getSliderById(Integer.parseInt(sliderId));
                        request.setAttribute("slider", slider);
                        request.getRequestDispatcher("/admin/sliderdetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("slidercontroller");
                    }
                    break;

                /*case "showAddForm":
                    request.getRequestDispatcher("/admin/addslider.jsp").forward(request, response);
                    break;
                 */
                case "showEditForm":
                    String editSliderId = request.getParameter("id");
                    if (editSliderId != null && !editSliderId.isEmpty()) {
                        Slider slider = sliderDAO.getSliderById(Integer.parseInt(editSliderId));
                        request.setAttribute("slider", slider);
                        request.getRequestDispatcher("/admin/editslider.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("slidercontroller");
                    }
                    break;

                case "toggleStatus":
                    String toggleSliderId = request.getParameter("id");
                    if (toggleSliderId != null && !toggleSliderId.isEmpty()) {
                        Slider slider = sliderDAO.getSliderById(Integer.parseInt(toggleSliderId));
                        slider.setStatus(slider.getStatus().equals("Active") ? "Inactive" : "Active");
                        sliderDAO.updateSlider(slider);
                    }
                    response.sendRedirect("slidercontroller");
                    break;

                default:
                    response.sendRedirect("slidercontroller");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "edit":
                    int editSliderId = Integer.parseInt(request.getParameter("id"));
                    String editTitle = request.getParameter("title");
                    String editBacklink = request.getParameter("backlink");
                    String editStatus = request.getParameter("status");
                    String editNotes = request.getParameter("notes");
                    String editUserID = request.getParameter("userID");

                    // Check for duplicate title (excluding current slider)
                    Slider existingSlider = sliderDAO.getSliderById(editSliderId);
                    if (existingSlider == null) {
                        request.setAttribute("error", "Slider not found!");
                        response.sendRedirect("slidercontroller");
                        return;
                    }

                    if (!existingSlider.getTitle().equals(editTitle) && sliderDAO.getSliderByTitle(editTitle) != null) {
                        request.setAttribute("error", "A slider with this title already exists!");
                        request.setAttribute("slider", existingSlider);
                        // Preserve form data
                        request.setAttribute("oldTitle", editTitle);
                        request.setAttribute("oldBacklink", editBacklink);
                        request.setAttribute("oldStatus", editStatus);
                        request.setAttribute("oldNotes", editNotes);
                        request.setAttribute("oldUserID", editUserID);
                        request.getRequestDispatcher("/admin/editslider.jsp").forward(request, response);
                        return;
                    }

                    // Handle file upload if a new file is provided
                    Part editFilePart = request.getPart("image");//Lấy tệp đã tải lên
                    String editFileName = editFilePart.getSubmittedFileName(); //Lấy tên của tệp đã tải lên
                    String editNewFileName = existingSlider.getImage(); //Đặt tên tệp hình ảnh mặc định thành hình ảnh của thanh trượt hiện tại.

                    if (editFileName != null && !editFileName.isEmpty()) {
                        String editFileExtension = editFileName.substring(editFileName.lastIndexOf("."));//Trích xuất phần mở rộng tệp
                        editNewFileName = System.currentTimeMillis() + editFileExtension;//Tạo tên tệp duy nhất cho tệp mới.

                        // Get the web root directory path
                        
                        //Trả về đường dẫn tuyệt đối đến thư mục gốc của ứng dụng web
                        String editWebRootPath = request.getServletContext().getRealPath("/"); 
                        //Điều chỉnh đường dẫn để trỏ đến thư mục nguồn của dự án, không bao gồm thư mục build .
                        String editProjectRootPath = editWebRootPath.substring(0, editWebRootPath.indexOf("build"));
                        String editUploadPath = editProjectRootPath + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "sliderlist" + File.separator;

                        File editUploadDir = new File(editUploadPath); //Tạo một đối tượng File biểu diễn thư mục tải lên.
                        if (!editUploadDir.exists()) {
                            editUploadDir.mkdirs();
                        }

                        // Save file
                        String editFilePath = editUploadPath + editNewFileName; //Xây dựng đường dẫn đầy đủ cho tệp mới.
                        editFilePart.write(editFilePath);//Lưu tập tin đã tải lên máy chủ.

                    }
                    //Update Slider
                    existingSlider.setTitle(editTitle);
                    existingSlider.setBacklink(editBacklink);
                    existingSlider.setStatus(editStatus);
                    existingSlider.setNotes(editNotes);
                    existingSlider.setUserID(editUserID);
                    existingSlider.setImage(editNewFileName);

                    try {
                        sliderDAO.updateSlider(existingSlider);
                        Thread.sleep(1000);
                        response.sendRedirect("slidercontroller");
                    } catch (Exception e) {
                        request.setAttribute("error", "Failed to update slider. Please try again!");
                        request.setAttribute("slider", existingSlider);
                        // Preserve form data
                        request.setAttribute("oldTitle", editTitle);
                        request.setAttribute("oldBacklink", editBacklink);
                        request.setAttribute("oldStatus", editStatus);
                        request.setAttribute("oldNotes", editNotes);
                        request.setAttribute("oldUserID", editUserID);
                        request.getRequestDispatcher("/admin/editslider.jsp").forward(request, response);
                    }
                    break;

                default:
                    response.sendRedirect("slidercontroller");
                    break;

                /*case "add":
                    String title = request.getParameter("title");
                    String image = request.getParameter("image");
                    String backlink = request.getParameter("backlink");
                    String status = request.getParameter("status");
                    String notes = request.getParameter("notes");

                    Slider slider = new Slider();
                    slider.setTitle(title);
                    slider.setImage(image);
                    slider.setBacklink(backlink);
                    slider.setStatus(status);
                    slider.setNotes(notes);

                    sliderDAO.addSlider(slider);
                    response.sendRedirect("slidercontroller");
                    break;
                 */
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Slider Controller";
    }
}
