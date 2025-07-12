package model;

import java.util.Date;
import java.util.List;

public class AdminLessonNote {
    private int noteID;
    
    private int lessonID;
    
    private String noteContent;
    
    private int createdByUserID;
    
    private Date createdDate;
    
    private Date updatedDate;
    
    private List<AdminNoteMedia> media; 

    
    
    // Constructors, Getters, and Setters
    public AdminLessonNote() { }

    public AdminLessonNote(int noteID, int lessonID, String noteContent, int createdByUserID, Date createdDate, Date updatedDate) {
        this.noteID = noteID;
        
        this.lessonID = lessonID;
        
        this.noteContent = noteContent;
        
        this.createdByUserID = createdByUserID;
        
        
        this.createdDate = createdDate;
        
        this.updatedDate = updatedDate;
    }

    public int getNoteID() {
        return noteID;
    }

    public void setNoteID(int noteID) {
        
        this.noteID = noteID;
    }

    public int getLessonID() {
        
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public String getNoteContent() {
        
        return noteContent;
    }

    public void setNoteContent(String noteContent) {
        
        this.noteContent = noteContent;
    }

    public int getCreatedByUserID() {
        return createdByUserID;
    }

    public void setCreatedByUserID(int createdByUserID) {
        
        this.createdByUserID = createdByUserID;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        
        this.updatedDate = updatedDate;
    }

    public List<AdminNoteMedia> getMedia() {
        
        return media;
    }

    public void setMedia(List<AdminNoteMedia> media) {
        
        this.media = media;
    }
    
}