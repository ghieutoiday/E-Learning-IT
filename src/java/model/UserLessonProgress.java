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
public class UserLessonProgress {
    
    private int userLessonProgressID;
    private User user;
    private Lesson lesson;
    private String status;
    private Date completeDate, createDate, updateDate;

    public UserLessonProgress() {
    }

    public UserLessonProgress(int userLessonProgressID, User user, Lesson lesson, String status, Date completeDate, Date createDate, Date updateDate) {
        this.userLessonProgressID = userLessonProgressID;
        this.user = user;
        this.lesson = lesson;
        this.status = status;
        this.completeDate = completeDate;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public int getUserLessonProgressID() {
        return userLessonProgressID;
    }

    public void setUserLessonProgressID(int userLessonProgressID) {
        this.userLessonProgressID = userLessonProgressID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}