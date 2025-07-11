/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author ASUS
 */

//Class này tạo ra để hiển thị kết quả cho màn Quiz Lesson - Form 2
public class QuizLessonDTO {

    private int actualQuizTime, correctAnswers, unAnswers, numberQuestions;
    private List<DimensionResult> dimensionResults;
    private String quizStatus;

    public QuizLessonDTO() {
    }

    public QuizLessonDTO(int actualQuizTime, int correctAnswers, int unAnswers, int numberQuestions, List<DimensionResult> dimensionResults, String quizStatus) {
        this.actualQuizTime = actualQuizTime;
        this.correctAnswers = correctAnswers;
        this.unAnswers = unAnswers;
        this.numberQuestions = numberQuestions;
        this.dimensionResults = dimensionResults;
        this.quizStatus = quizStatus;
    }

    public int getActualQuizTime() {
        return actualQuizTime;
    }

    public void setActualQuizTime(int actualQuizTime) {
        this.actualQuizTime = actualQuizTime;
    }

    public int getCorrectAnswers() {
        return correctAnswers;
    }

    public void setCorrectAnswers(int correctAnswers) {
        this.correctAnswers = correctAnswers;
    }

    public int getUnAnswers() {
        return unAnswers;
    }

    public void setUnAnswers(int unAnswers) {
        this.unAnswers = unAnswers;
    }

    public int getNumberQuestions() {
        return numberQuestions;
    }

    public void setNumberQuestions(int numberQuestions) {
        this.numberQuestions = numberQuestions;
    }

    public List<DimensionResult> getDimensionResults() {
        return dimensionResults;
    }

    public void setDimensionResults(List<DimensionResult> dimensionResults) {
        this.dimensionResults = dimensionResults;
    }

    public String getQuizStatus() {
        return quizStatus;
    }

    public void setQuizStatus(String quizStatus) {
        this.quizStatus = quizStatus;
    }
    
    
}
