/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class UserQuizAnswer {

    private int answerID;
    private User user;
    private Quiz quiz;
    private Question question;
    private AnswerOption selectedAnswer;
    private boolean isCorrect;
    private int attemptNumber;
    private Date startTime, endTime;

    public UserQuizAnswer() {
    }

    public UserQuizAnswer(int answerID, User user, Quiz quiz, Question question, AnswerOption selectedAnswer, boolean isCorrect, int attemptNumber, Date startTime, Date endTime) {
        this.answerID = answerID;
        this.user = user;
        this.quiz = quiz;
        this.question = question;
        this.selectedAnswer = selectedAnswer;
        this.isCorrect = isCorrect;
        this.attemptNumber = attemptNumber;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getAnswerID() {
        return answerID;
    }

    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public AnswerOption getSelectedAnswer() {
        return selectedAnswer;
    }

    public void setSelectedAnswer(AnswerOption selectedAnswer) {
        this.selectedAnswer = selectedAnswer;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public int getAttemptNumber() {
        return attemptNumber;
    }

    public void setAttemptNumber(int attemptNumber) {
        this.attemptNumber = attemptNumber;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
    
    
}
