/*
 * Click nbfs://.netbeans/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbproject://nbproject/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Media {
    private int mediaID;
    private int noteID;
    private String mediaType, mediaUrl;
    private String content; // Thêm thuộc tính content từ MediaNotes

    public Media() {
    }

    public Media(int mediaID, int noteID, String mediaType, String mediaUrl, String content) {
        this.mediaID = mediaID;
        this.noteID = noteID;
        this.mediaType = mediaType;
        this.mediaUrl = mediaUrl;
        this.content = content;
    }

    public int getMediaID() {
        return mediaID;
    }

    public void setMediaID(int mediaID) {
        this.mediaID = mediaID;
    }

    public int getNoteID() {
        return noteID;
    }

    public void setNoteID(int noteID) {
        this.noteID = noteID;
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType;
    }

    public String getMediaUrl() {
        return mediaUrl;
    }

    public void setMediaUrl(String mediaUrl) {
        this.mediaUrl = mediaUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}