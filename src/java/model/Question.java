package model;

public class Question {

    private int questionID;
    private int courseID;
    private int lessonID;
    private int dimensionID;
    private int typeQuestionID;
    private String content;
    private String media;
    private String explanation;
    private int level;
    private String status;

    public Question() {
    }

    public Question(int courseID, int lessonID, int dimensionID, int typeQuestionID, String content,
            String media, String explanation, int level, String status) {
        this.courseID = courseID;
        this.lessonID = lessonID;
        this.dimensionID = dimensionID;
        this.typeQuestionID = typeQuestionID;
        this.content = content;
        this.media = media;
        this.explanation = explanation;
        this.level = level;
        this.status = status;
    }

    // Getters and setters
    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public int getDimensionID() {
        return dimensionID;
    }

    public void setDimensionID(int dimensionID) {
        this.dimensionID = dimensionID;
    }

    public int getTypeQuestionID() {
        return typeQuestionID;
    }

    public void setTypeQuestionID(int typeQuestionID) {
        this.typeQuestionID = typeQuestionID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
