package model;

public class AnswerOption {

    private int answerOptionID;
    private int questionID;
    private String content;
    private boolean isCorrect;

    public AnswerOption(int questionID, String content, boolean isCorrect) {
        this.questionID = questionID;
        this.content = content;
        this.isCorrect = isCorrect;
    }

    // Getters and setters
    public int getAnswerOptionID() {
        return answerOptionID;
    }

    public void setAnswerOptionID(int answerOptionID) {
        this.answerOptionID = answerOptionID;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }
}
