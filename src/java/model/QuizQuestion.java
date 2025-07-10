/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class QuizQuestion {
    private int quizQuestionID;
    private Quiz quiz;
    private Question question;

    public QuizQuestion() {
    }

    public QuizQuestion(int quizQuestionID, Quiz quiz, Question question) {
        this.quizQuestionID = quizQuestionID;
        this.quiz = quiz;
        this.question = question;
    }

    public int getQuizQuestionID() {
        return quizQuestionID;
    }

    public void setQuizQuestionID(int quizQuestionID) {
        this.quizQuestionID = quizQuestionID;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }
    
}
