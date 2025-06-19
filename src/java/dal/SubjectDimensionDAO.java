/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.SubjectDimension;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;

/**
 *
 * @author gtrun
 */
public class SubjectDimensionDAO extends DBContext {

    public SubjectDimensionDAO() {
        super();
    }
    
    public int getTotalSubjectDimensionByCourseID(int id) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM [CourseManagementDB].[dbo].[SubjectDimension] WHERE [courseID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return total;
    }

    public List<SubjectDimension> getAllSubjectDimensionsByCourseID(int courseID) {
        List<SubjectDimension> list = new ArrayList<>();

        String sql = "SELECT [dimensionID]\n"
                + "      ,[courseID]\n"
                + "      ,[type]\n"
                + "      ,[name]\n"
                + "      ,[description]\n"
                + "  FROM [dbo].[SubjectDimension]\n"
                + "  where [courseID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseDAO courseDao = new CourseDAO();
                Course course = courseDao.getCoureByCourseID(courseID);
                SubjectDimension subjectDimension = new SubjectDimension(rs.getInt("dimensionID"), course, rs.getString("type"), rs.getString("name"), rs.getString("description"));
                list.add(subjectDimension);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    CourseDAO courseDao = new CourseDAO();

    public SubjectDimension getSubjectDimensionByID(int id) {
        SubjectDimension sd = null;
        String sql = "SELECT [dimensionID], [courseID], [type], [name], [description] "
                + "FROM [dbo].[SubjectDimension] "
                + "WHERE [dimensionID] = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int dimensionID = rs.getInt("dimensionID");
                    int courseIdFromDb = rs.getInt("courseID");
                    String type = rs.getString("type");
                    String name = rs.getString("name");
                    String description = rs.getString("description");

                    // Fetch the Course object using CourseDAO
                    Course course = courseDao.getCoureByCourseID(courseIdFromDb);

                    sd = new SubjectDimension(dimensionID, course, type, name, description);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDimensionDAO.class.getName()).log(Level.SEVERE, "Error retrieving SubjectDimension by ID: " + id, ex);
        }
        return sd;
    }

    public int deleteSubjectDimension(int id) {
        int rowsAffected = 0;
        String sql = "DELETE FROM [dbo].[SubjectDimension] WHERE [dimensionID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            rowsAffected = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(SubjectDimensionDAO.class.getName()).log(Level.SEVERE, "Error deleting SubjectDimension with ID: " + id, ex);
        }
        return rowsAffected;
    }

    public int createSubjectDimension(SubjectDimension subjectDimension) {
        int rowsAffected = 0;
        String sql = "INSERT INTO [dbo].[SubjectDimension] ([courseID], [type], [name], [description]) "
                + "VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Assuming Course object has a getId() method
            ps.setInt(1, subjectDimension.getCourse().getCourseID()); // Use getCourseID() from the Course object
            ps.setString(2, subjectDimension.getType());
            ps.setString(3, subjectDimension.getName());
            ps.setString(4, subjectDimension.getDescription());

            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDimensionDAO.class.getName()).log(Level.SEVERE, "Error creating SubjectDimension: " + subjectDimension.getName(), ex);
        }
        return rowsAffected;
    }

    public int updateSubjectDimension(SubjectDimension sd) {
        int rowEffect = 0;

        String sql = "UPDATE [dbo].[SubjectDimension]\n"
                + "     SET [type] = ? \n"
                + "      ,[name] = ? \n"
                + "      ,[description] = ? \n"
                + " WHERE dimensionID = ? ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sd.getType());
            ps.setString(2, sd.getName());
            ps.setString(3, sd.getDescription());
            ps.setInt(4, sd.getDimensionID());
            rowEffect = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowEffect;
    }

    public Integer getCourseIDBySubjectDimensionID(int idSd) {
        String sql = "SELECT [courseID] "
                + "FROM [CourseManagementDB].[dbo].[SubjectDimension] "
                + "WHERE dimensionID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idSd);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("courseID");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDimensionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi truy vấn courseID từ dimensionID: " + idSd, ex);
        }
        return null;
    }
    
    public List<SubjectDimension> pagingSubjectDimension(int courseId, int index, int pageSize) {
        List<SubjectDimension> list = new ArrayList<>();
        String sql = "SELECT [dimensionID]\n"
                + "      ,[courseID]\n"
                + "      ,[type]\n"
                + "      ,[name]\n"
                + "      ,[description]\n"
                + "  FROM [CourseManagementDB].[dbo].[SubjectDimension]\n"
                + "  where [courseID] = ?\n"
                + "  order by [dimensionID]\n"
                + "  offset ? rows fetch next ? rows only";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseId);
            ps.setInt(2, (index - 1) * pageSize); // Tính OFFSET
            ps.setInt(3, pageSize); // Số lượng bản ghi muốn lấy (FETCH NEXT)
            CourseDAO courseDao = new CourseDAO();
            Course course = courseDao.getCoureByCourseID(courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubjectDimension sd = new SubjectDimension(
                        rs.getInt("dimensionID"),
                        course,
                        rs.getString("type"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(sd);
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        SubjectDimensionDAO sdDao = new SubjectDimensionDAO();
        SubjectDimension sd = sdDao.getSubjectDimensionByID(13);
        int x = sdDao.getTotalSubjectDimensionByCourseID(1);
        System.out.println(x);
    }

}
