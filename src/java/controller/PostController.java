/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.PostCategoryDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import model.Post;
import java.io.File;
import java.util.Date;
import model.PostCategory;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "PostController", urlPatterns = {"/postcontroller"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PostController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private PostDAO postDAO = new PostDAO();
    private UserDAO userDAO = new UserDAO();

    private PostCategoryDAO postCategoryDAO = new PostCategoryDAO();

    private static final int POSTS_PER_PAGE = 5;

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
                case "delete":
                    String deletePostId = request.getParameter("id");
                    if (deletePostId != null && !deletePostId.isEmpty()) {
                        postDAO.deletePost(Integer.parseInt(deletePostId));
                    }
                    response.sendRedirect("postcontroller");
                    break;

                case "list":
                    String search = request.getParameter("search");
                    String sortBy = request.getParameter("sortBy");
                    String category = request.getParameter("category");
                    String author = request.getParameter("author");
                    String dateFilter = request.getParameter("dateFilter");
                    String status = request.getParameter("status");
                    String feature = request.getParameter("feature");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page"))
                            : 1;

                    List<Post> posts = postDAO.getFilteredPosts(search, sortBy, category, author, dateFilter, status,
                            feature, page, POSTS_PER_PAGE);
                    int totalPosts = postDAO.getTotalFilteredPosts(search, category, author, dateFilter, status,
                            feature);
                    int totalPages = (totalPosts + POSTS_PER_PAGE - 1) / POSTS_PER_PAGE;

                    request.setAttribute("posts", posts);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                    request.setAttribute("authors", userDAO.getAllAuthors());
                    request.setAttribute("search", search);
                    request.setAttribute("sortBy", sortBy);
                    request.setAttribute("category", category);
                    request.setAttribute("author", author);
                    request.setAttribute("dateFilter", dateFilter);
                    request.setAttribute("status", status);
                    request.setAttribute("feature", feature);

                    request.getRequestDispatcher("/admin/postslist.jsp").forward(request, response);
                    break;

                case "view":
                    String postId = request.getParameter("id");
                    if (postId != null && !postId.isEmpty()) {
                        Post post = postDAO.getPostByID(Integer.parseInt(postId));
                        request.setAttribute("post", post);
                        request.getRequestDispatcher("/admin/postdetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("postcontroller");
                    }
                    break;
                case "viewdetail":
                    String idPost = request.getParameter("id");
                    if (idPost != null && !idPost.isEmpty()) {
                        Post post = postDAO.getPostByID(Integer.parseInt(idPost));
                        request.setAttribute("post", post);
                        request.getRequestDispatcher("/post-details.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("postcontroller");
                    }
                    break;
                case "showAddForm":
                    request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                    request.getRequestDispatcher("/admin/addpost.jsp").forward(request, response);
                    break;

                case "showEditForm":
                    String editPostId = request.getParameter("id");
                    if (editPostId != null && !editPostId.isEmpty()) {
                        Post post = postDAO.getPostByID(Integer.parseInt(editPostId));
                        request.setAttribute("post", post);
                        request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                        request.getRequestDispatcher("/admin/editpost.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("postcontroller");
                    }
                    break;

                default:
                    response.sendRedirect("postcontroller");
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
                case "add":
                    UserDAO userDAO = new UserDAO();
                    User owner = userDAO.getUserByEmail("tranthibich@gmail.com");

                    if (owner == null) {
                        request.setAttribute("error", "Default owner not found");
                        request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                        request.getRequestDispatcher("/admin/addpost.jsp").forward(request, response);
                        return;
                    }

                    String title = request.getParameter("title");
                    String categoryId = request.getParameter("category");
                    String briefInfo = request.getParameter("briefInfo");
                    String description = request.getParameter("description");
                    String status = request.getParameter("status");
                    boolean feature = request.getParameter("feature") != null;

                    // Check for duplicate title
                    if (postDAO.isTitleExists(title)) {
                        request.setAttribute("error", "A post with this title already exists!");
                        request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                        // Preserve form data using request parameters
                        request.setAttribute("oldTitle", title);
                        request.setAttribute("oldBriefInfo", briefInfo);
                        request.setAttribute("oldDescription", description);
                        request.setAttribute("oldCategory", categoryId);
                        request.setAttribute("oldStatus", status);
                        request.setAttribute("oldFeature", feature);
                        request.getRequestDispatcher("/admin/addpost.jsp").forward(request, response);
                        return;
                    }

                    // Handle file upload
                    Part filePart = request.getPart("thumbnail");
                    String fileName = filePart.getSubmittedFileName();
                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    String newFileName = System.currentTimeMillis() + fileExtension;

                    // Get the web root directory path
                    String webRootPath = request.getServletContext().getRealPath("/");
                    String projectRootPath = webRootPath.substring(0, webRootPath.indexOf("build"));
                    String uploadPath = projectRootPath + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "post" + File.separator;

                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // Save file
                    String filePath = uploadPath + newFileName;
                    filePart.write(filePath);

                    Post post = new Post();
                    post.setTitle(title);
                    post.setBriefInfo(briefInfo);
                    post.setDescription(description);
                    post.setStatus(status);
                    post.setFeature(feature);
                    post.setThumbnail(newFileName);
                    post.setCreateDate(new Date());
                    post.setUpdateDate(new Date());
                    post.setOwner(owner);

                    PostCategoryDAO categoryDAO = new PostCategoryDAO();
                    PostCategory category = categoryDAO.getPostCategoryByID(Integer.parseInt(categoryId));
                    post.setPostCategory(category);

                    boolean success = postDAO.addPost(post);
                    if (!success) {
                        request.setAttribute("error", "Failed to add post. Please try again!");
                        request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                        // Preserve form data using request parameters
                        request.setAttribute("oldTitle", title);
                        request.setAttribute("oldBriefInfo", briefInfo);
                        request.setAttribute("oldDescription", description);
                        request.setAttribute("oldCategory", categoryId);
                        request.setAttribute("oldStatus", status);
                        request.setAttribute("oldFeature", feature);
                        request.getRequestDispatcher("/admin/addpost.jsp").forward(request, response);
                        return;
                    }
                    response.sendRedirect("postcontroller");
                    break;

                case "edit":
                    int editPostId = Integer.parseInt(request.getParameter("id"));
                    String editTitle = request.getParameter("title");
                    String editCategoryId = request.getParameter("category");
                    String editBriefInfo = request.getParameter("briefInfo");
                    String editDescription = request.getParameter("description");
                    String editStatus = request.getParameter("status");
                    boolean editFeature = request.getParameter("feature") != null;

                    // Check for duplicate title (excluding current post)
                    Post existingPost = postDAO.getPostByID(editPostId);
                    if (existingPost == null) {
                        request.setAttribute("error", "Post not found!");
                        response.sendRedirect("postcontroller");
                        return;
                    }

                    if (!existingPost.getTitle().equals(editTitle) && postDAO.isTitleExists(editTitle)) {
                        request.setAttribute("error", "A post with this title already exists!");
                        request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                        request.setAttribute("post", existingPost);
                        // Preserve form data
                        request.setAttribute("oldTitle", editTitle);
                        request.setAttribute("oldBriefInfo", editBriefInfo);
                        request.setAttribute("oldDescription", editDescription);
                        request.setAttribute("oldCategory", editCategoryId);
                        request.setAttribute("oldStatus", editStatus);
                        request.setAttribute("oldFeature", editFeature);
                        request.getRequestDispatcher("/admin/editpost.jsp").forward(request, response);
                        return;
                    }

                    // Handle file upload if a new file is provided
                    Part editFilePart = request.getPart("thumbnail");
                    String editFileName = editFilePart.getSubmittedFileName();
                    String editNewFileName = existingPost.getThumbnail(); // Keep existing thumbnail by default

                    if (editFileName != null && !editFileName.isEmpty()) {
                        String editFileExtension = editFileName.substring(editFileName.lastIndexOf("."));
                        editNewFileName = System.currentTimeMillis() + editFileExtension;

                        // Get the web root directory path
                        String editWebRootPath = request.getServletContext().getRealPath("/");
                        String editProjectRootPath = editWebRootPath.substring(0, editWebRootPath.indexOf("build"));
                        String editUploadPath = editProjectRootPath + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "post" + File.separator;

                        File editUploadDir = new File(editUploadPath);
                        if (!editUploadDir.exists()) {
                            editUploadDir.mkdirs();
                        }

                        // Save file
                        String editFilePath = editUploadPath + editNewFileName;
                        editFilePart.write(editFilePath);
                    }

                    existingPost.setTitle(editTitle);
                    existingPost.setBriefInfo(editBriefInfo);
                    existingPost.setDescription(editDescription);
                    existingPost.setStatus(editStatus);
                    existingPost.setFeature(editFeature);
                    existingPost.setThumbnail(editNewFileName);
                    existingPost.setUpdateDate(new Date());

                    PostCategoryDAO editCategoryDAO = new PostCategoryDAO();
                    PostCategory editCategory = editCategoryDAO.getPostCategoryByID(Integer.parseInt(editCategoryId));
                    existingPost.setPostCategory(editCategory);

                    try {
                        postDAO.updatePost(existingPost);
                        Thread.sleep(1000);
                        response.sendRedirect("postcontroller");
                    } catch (Exception e) {
                        request.setAttribute("error", "Failed to update post. Please try again!");
                        request.setAttribute("categories", postCategoryDAO.getAllPostCategories());
                        request.setAttribute("post", existingPost);
                        // Preserve form data
                        request.setAttribute("oldTitle", editTitle);
                        request.setAttribute("oldBriefInfo", editBriefInfo);
                        request.setAttribute("oldDescription", editDescription);
                        request.setAttribute("oldCategory", editCategoryId);
                        request.setAttribute("oldStatus", editStatus);
                        request.setAttribute("oldFeature", editFeature);
                        request.getRequestDispatcher("/admin/editpost.jsp").forward(request, response);
                    }
                    break;

                default:
                    response.sendRedirect("postcontroller");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Post Controller";
    }
}
