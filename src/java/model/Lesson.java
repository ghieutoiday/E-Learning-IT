/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Lesson {
    private int lessonID;
    private Course course;
    private Lesson topic;
    private String name, type;
    private int orderNum;
    private String status;
    private String contentVideo, contentHtml;
    private int duration;

    public Lesson() {
    }

    public Lesson(int lessonID, Course course, Lesson topic, String name, String type, int orderNum, String status, String contentVideo, String contentHtml, int duration) {
        this.lessonID = lessonID;
        this.course = course;
        this.topic = topic;
        this.name = name;
        this.type = type;
        this.orderNum = orderNum;
        this.status = status;
        this.contentVideo = contentVideo;
        this.contentHtml = contentHtml;
        this.duration = duration;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Lesson getTopic() {
        return topic;
    }

    public void setTopic(Lesson topic) {
        this.topic = topic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContentVideo() {
        return contentVideo;
    }

    public void setContentVideo(String contentVideo) {
        this.contentVideo = contentVideo;
    }

    public String getContentHtml() {
        return contentHtml;
    }

    public void setContentHtml(String contentHtml) {
        this.contentHtml = contentHtml;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    @Override
    public String toString() {
        return "Lesson{" + "lessonID=" + lessonID + ", course=" + course + ", topic=" + topic + ", name=" + name + ", type=" + type + ", orderNum=" + orderNum + ", status=" + status + ", contentVideo=" + contentVideo + ", contentHtml=" + contentHtml + ", duration=" + duration + '}';
    }

    
}
