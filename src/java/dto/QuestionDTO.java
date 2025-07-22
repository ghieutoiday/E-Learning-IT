/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.List;
import model.AnswerOption;
import model.Question;

/**
 *
 * @author ASUS
 */
public class QuestionDTO {
    private Question question;
    private List<AnswerOption> listAnswerOption;

    public QuestionDTO() {
    }

    public QuestionDTO(Question question, List<AnswerOption> listAnswerOption) {
        this.question = question;
        this.listAnswerOption = listAnswerOption;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public List<AnswerOption> getListAnswerOption() {
        return listAnswerOption;
    }

    public void setListAnswerOption(List<AnswerOption> listAnswerOption) {
        this.listAnswerOption = listAnswerOption;
    }

    
}
