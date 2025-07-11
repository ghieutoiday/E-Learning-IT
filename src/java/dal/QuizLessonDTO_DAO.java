/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author ASUS
 */
public class QuizLessonDTO_DAO {

    private static QuizLessonDTO_DAO instance;

    private QuizLessonDTO_DAO() {
        super();
    }

    public static QuizLessonDTO_DAO getInstance() {
        if (instance == null) {
            synchronized (QuizLessonDTO_DAO.class) {
                if (instance == null) {
                    instance = new QuizLessonDTO_DAO();
                }
            }
        }
        return instance;
    }
    
    
}
