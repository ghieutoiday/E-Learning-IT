/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import model.Question;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.TypeQuestion;

/**
 *
 * @author gtrun
 */
public class TypeQuestionDAO extends DBContext{

    public TypeQuestionDAO() {
        super();
    }
    
    public TypeQuestion getTypeQuestionById(int id) {
    TypeQuestion typeQuestion = null;
    String sql = "SELECT [typeQuestionID], [name] FROM [dbo].[TypeQuestion] WHERE [typeQuestionID] = ?";

    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            typeQuestion = new TypeQuestion();
            typeQuestion.setTypeQuestionId(rs.getInt("typeQuestionID"));
            typeQuestion.setName(rs.getString("name"));
        }

        rs.close();
        ps.close();
    } catch (SQLException ex) {
        java.util.logging.Logger.getLogger(CourseDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
    }

    return typeQuestion;
}
    
    
    
}
