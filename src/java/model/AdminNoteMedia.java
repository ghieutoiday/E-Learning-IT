package model;

public class AdminNoteMedia {
    private int mediaID;
    
    private int noteID;
    
    private String mediaType;
    
    private String mediaURL;
    
    private String content;
    

    // Constructors, Getters, and Setters
    public AdminNoteMedia() { 
    }

    public AdminNoteMedia(int mediaID, int noteID, String mediaType, String mediaURL, String content) {
        this.mediaID = mediaID;
        
        this.noteID = noteID;
        
        this.mediaType = mediaType;
        
        this.mediaURL = mediaURL;
        
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

    public String getMediaURL() {
        
        return mediaURL;
    }

    public void setMediaURL(String mediaURL) {
        
        this.mediaURL = mediaURL;
    }

    public String getContent() {
        
        return content;
    }

    public void setContent(String content) {
        
        this.content = content;
    }
    
    
}