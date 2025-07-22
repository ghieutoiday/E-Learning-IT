/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.List;

/**
 *
 * @author ASUS
 */
public class QuizHandleDTO {
    private int quizID;
    private List<QuestionDTO> listQuestionDTO;

    public QuizHandleDTO() {
    }

    public QuizHandleDTO(int quizID, List<QuestionDTO> listQuestionDTO) {
        this.quizID = quizID;
        this.listQuestionDTO = listQuestionDTO;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public List<QuestionDTO> getListQuestionDTO() {
        return listQuestionDTO;
    }

    public void setListQuestionDTO(List<QuestionDTO> listQuestionDTO) {
        this.listQuestionDTO = listQuestionDTO;
    }

    
    
}
