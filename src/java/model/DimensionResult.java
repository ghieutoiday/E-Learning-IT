/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */

//Class này tạo ra để dùng trong QuizLessonDTO (hiển thị ra List kết quả theo Dimension)
public class DimensionResult {
    
    private String dimensionName;
    private int totalQuestions;
    private int correctCount;

    public DimensionResult() {
    }

    public DimensionResult(String dimensionName, int totalQuestions, int correctCount) {
        this.dimensionName = dimensionName;
        this.totalQuestions = totalQuestions;
        this.correctCount = correctCount;
    }

    public String getDimensionName() {
        return dimensionName;
    }

    public void setDimensionName(String dimensionName) {
        this.dimensionName = dimensionName;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public int getCorrectCount() {
        return correctCount;
    }

    public void setCorrectCount(int correctCount) {
        this.correctCount = correctCount;
    }

    
}
