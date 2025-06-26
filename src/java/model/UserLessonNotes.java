/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class UserLessonNotes {

    private int noteID;
    private User user;
    private Lesson lesson;
    private String content;
    private Date createDate, updateDate;
    private List<Media> media;

    public UserLessonNotes() {
        this.media = new ArrayList<>(); // Khởi tạo danh sách rỗng
    }

    public UserLessonNotes(int noteID, User user, Lesson lesson, String content, Date createDate, Date updateDate) {
        this.noteID = noteID;
        this.user = user;
        this.lesson = lesson;
        this.content = content;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.media = new ArrayList<>(); // Khởi tạo danh sách rỗng
    }

    public int getNoteID() {
        return noteID;
    }

    public void setNoteID(int noteID) {
        this.noteID = noteID;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public List<Media> getMedia() {
        return media;
    }

    public void setMedia(List<Media> media) {
        this.media = media;
    }

    @Override
    public String toString() {
        return "UserLessonNotes{" + "noteID=" + noteID + ", user=" + user + ", lesson=" + lesson + ", content=" + content + ", createDate=" + createDate + ", updateDate=" + updateDate + ", media=" + media + '}';
    }
}
