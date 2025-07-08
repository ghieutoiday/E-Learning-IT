/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author gtrun
 */
public class TypeQuestion {

    private int typeQuestionId;
    private String name;

    public TypeQuestion() {
    }

    public TypeQuestion(int typeQuestionId) {
        this.typeQuestionId = typeQuestionId;
    }

    public TypeQuestion(int typeQuestionId, String name) {
        this.typeQuestionId = typeQuestionId;
        this.name = name;
    }

    public int getTypeQuestionId() {
        return typeQuestionId;
    }

    public void setTypeQuestionId(int typeQuestionId) {
        this.typeQuestionId = typeQuestionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "TypeQuestion{" + "typeQuestionId=" + typeQuestionId + ", name=" + name + '}';
    }

}
