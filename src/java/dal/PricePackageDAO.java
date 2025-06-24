/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.PricePackage;

/**
 *
 * @author ASUS
 */
public class PricePackageDAO extends DBContext {

    public PricePackageDAO() {
        super();
    }

    CourseDAO courseDAO = new CourseDAO();

    public PricePackage getPricePackageByPricePackageID(int pricePackageId) {
        PricePackage pricePackage = null;
        try {
            String sql = "Select * from PricePackage where pricePackageID = " + pricePackageId;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không

                Course course = courseDAO.getCoureByCourseID(rs.getInt(2));
                String name = rs.getString(3);
                int accessDuration = rs.getInt(4);
                double listPrice = rs.getDouble(5);
                double salePrice = rs.getDouble(6);
                String desc = rs.getString(7);
                String status = rs.getString(8);

                pricePackage = new PricePackage(pricePackageId, course, name, accessDuration, listPrice, salePrice, desc, status);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return pricePackage;
    }

    //get all pricePackage
    public List getAllPricePackage() {
        List<PricePackage> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM PricePackage";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                //Lấy PricePackage
                PricePackage pricePackage = getPricePackageByPricePackageID(rs.getInt(1));
                list.add(pricePackage);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<PricePackage> getAllDistinctPricePackagesByName() {
        List<PricePackage> list = new ArrayList<>();

        try {
            //  lọc ra các bản ghi PricePackage với tên name duy nhất (không trùng nhau).
            // Mỗi name chỉ lấy 1 bản ghi đại diện (bản ghi có pricePackageID nhỏ nhất).
            String sql = "SELECT * FROM PricePackage WHERE pricePackageID IN ( "
                         + "SELECT MIN(pricePackageID) FROM PricePackage GROUP BY name )";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("pricePackageID");
                PricePackage pkg = getPricePackageByPricePackageID(id);
                list.add(pkg);
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return list;
    }

    public List<PricePackage> pagingPricePackage(int courseId, int index) {
        List<PricePackage> list = new ArrayList<>();
        String sql = "SELECT [pricePackageID],\n"
                + "       [courseID],\n"
                + "       [name],\n"
                + "       [accessDuration],\n"
                + "       [listPrice],\n"
                + "       [salePrice],\n"
                + "       [description],\n"
                + "       [status]\n"
                + "FROM [CourseManagementDB].[dbo].[PricePackage]\n"
                + "WHERE [courseID] = ?\n"
                + "ORDER BY [pricePackageID]\n"
                + "OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY;";

        try {
            CourseDAO courseDao = new CourseDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseId);
            ps.setInt(2, (index - 1) * 3); // tính OFFSET
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = courseDao.getCoureByCourseID(rs.getInt("courseID"));
                PricePackage pkg = new PricePackage(
                        rs.getInt("pricePackageID"),
                        course,
                        rs.getString("name"),
                        rs.getInt("accessDuration"),
                        rs.getDouble("listPrice"),
                        rs.getDouble("salePrice"),
                        rs.getString("description"),
                        rs.getString("status")
                );
                list.add(pkg);
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }

        return list;
    }

    public int getTotalPricePackageByCourseID(int id) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM [CourseManagementDB].[dbo].[PricePackage] WHERE [courseID] = ?";

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

    public int insertPricePackage(PricePackage pkg) {
        int rowEffect = 0;
        String sql = "INSERT INTO [dbo].[PricePackage] "
                + "([courseID], [name], [accessDuration], [listPrice], [salePrice], [description], [status]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pkg.getCourse().getCourseID());
            ps.setString(2, pkg.getName());
            ps.setInt(3, pkg.getAccessDuration());
            ps.setDouble(4, pkg.getListPrice());
            ps.setDouble(5, pkg.getSalePrice());
            ps.setString(6, pkg.getDescription());
            ps.setString(7, pkg.getStatus());
            rowEffect = ps.executeUpdate();
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return rowEffect;
    }

    public int updatePricePackage(PricePackage pkg) {
        int rowEffect = 0;
        String sql = "UPDATE [dbo].[PricePackage] SET "
                + "[courseID] = ?, "
                + "[name] = ?, "
                + "[accessDuration] = ?, "
                + "[listPrice] = ?, "
                + "[salePrice] = ?, "
                + "[description] = ?, "
                + "[status] = ? "
                + "WHERE [pricePackageID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pkg.getCourse().getCourseID());
            ps.setString(2, pkg.getName());
            ps.setInt(3, pkg.getAccessDuration());
            ps.setDouble(4, pkg.getListPrice());
            ps.setDouble(5, pkg.getSalePrice());
            ps.setString(6, pkg.getDescription());
            ps.setString(7, pkg.getStatus());
            ps.setInt(8, pkg.getPricePackageID());
            rowEffect = ps.executeUpdate();
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return rowEffect;
    }

    public int deletePricePackage(int pricePackageID) {
        int rowEffect = 0;
        String sql = "DELETE FROM [dbo].[PricePackage] WHERE [pricePackageID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pricePackageID);
            rowEffect = ps.executeUpdate();
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return rowEffect;
    }
    
    // hàm update pricePackage
    public void updatePricePackageRegistration(PricePackage pricePackage) {
        String sql = "UPDATE PricePackage SET "
                + "[name] = ?, "
                + "[listPrice] = ?, "
                + "[salePrice] = ? "
                + "WHERE [pricePackageID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pricePackage.getName());
            st.setDouble(2, pricePackage.getListPrice());
            st.setDouble(3, pricePackage.getSalePrice());
            st.setInt(4, pricePackage.getPricePackageID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updatePricePackage: " + e.getMessage());
        }
    }
    
    

    // Thêm PricePackage mới, trả về ID
    public int addPricePackage(PricePackage pkg) {
        String sql = "INSERT INTO PricePackage (courseID, name, accessDuration, listPrice, salePrice, description, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        int generatedId = -1;
        try (
             PreparedStatement ps = connection.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, pkg.getCourse().getCourseID());
            ps.setString(2, pkg.getName());
            
            if (pkg.getAccessDuration() >0) {
                ps.setInt(3, pkg.getAccessDuration());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setDouble(4, pkg.getListPrice());
            ps.setDouble(5, pkg.getSalePrice());
            ps.setString(6, pkg.getDescription() != null ? pkg.getDescription() : "");
            ps.setString(7, pkg.getStatus() != null ? pkg.getStatus() : "Active");

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedId;
    }
    
    public List<PricePackage> getPricePackagesByCourseId(int courseId) {
        List<PricePackage> list = new ArrayList<>();
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.getCourseByIdd(courseId);

        if (course == null) {
            return list;
        }

        String sql = "SELECT * FROM PricePackage WHERE courseID = ? AND status = 'Active'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PricePackage pkg = new PricePackage();
                    pkg.setPricePackageID(rs.getInt("pricePackageID"));
                    pkg.setCourse(course); // Gán cả đối tượng Course
                    pkg.setName(rs.getString("name"));
                    pkg.setAccessDuration(rs.getInt("accessDuration"));
                    pkg.setListPrice(rs.getDouble("listPrice"));
                    pkg.setSalePrice(rs.getDouble("salePrice"));
                    pkg.setDescription(rs.getString("description"));
                    pkg.setStatus(rs.getString("status"));
                    list.add(pkg);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi trong getPricePackagesByCourseId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    public PricePackage getPricePackageById(int pricePackageId) {
        String sql = "SELECT * FROM PricePackage WHERE pricePackageID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, pricePackageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CourseDAO courseDAO = new CourseDAO();
                    Course course = courseDAO.getCourseByIdd(rs.getInt("courseID"));
                    
                    PricePackage pkg = new PricePackage();
                    pkg.setPricePackageID(rs.getInt("pricePackageID"));
                    pkg.setCourse(course); // Gán cả đối tượng Course
                    pkg.setName(rs.getString("name"));
                    pkg.setAccessDuration(rs.getInt("accessDuration"));
                    pkg.setListPrice(rs.getDouble("listPrice"));
                    pkg.setSalePrice(rs.getDouble("salePrice"));
                    pkg.setDescription(rs.getString("description"));
                    pkg.setStatus(rs.getString("status"));
                    
                    return pkg;
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi trong getPricePackageById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    


    public static void main(String[] args) {
        PricePackageDAO dao = new PricePackageDAO();
        PricePackage pd = dao.getPricePackageByPricePackageID(1);
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.getCoureByCourseID(pd.getCourse().getCourseID());
        PricePackage pdNew = new PricePackage(1,course, pd.getName(), 30, 1, 2, pd.getDescription(), pd.getStatus());
        int x = dao.updatePricePackage(pdNew);
        System.out.println(x);
        System.out.println(pd);
    }
}
