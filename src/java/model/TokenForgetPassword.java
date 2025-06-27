/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author gtrun
 */
public class TokenForgetPassword {
//    tokenID int IDENTITY (1,1) primary key,
//token varchar(255) not null,
//expiryTime TIMESTAMP not null,
//isUsed bit not null,
//userID int not null,
//CONSTRAINT FK_token_User FOREIGN KEY (userID) REFERENCES [User](userID)
    private int tokenID;
    private String token;
    private LocalDateTime expiryTime;
    private boolean isUsed;
    private User userID;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(int tokenID, String token, LocalDateTime expiryTime, boolean isUsed, User userID) {
        this.tokenID = tokenID;
        this.token = token;
        this.expiryTime = expiryTime;
        this.isUsed = isUsed;
        this.userID = userID;
    }

    public int getTokenID() {
        return tokenID;
    }

    public void setTokenID(int tokenID) {
        this.tokenID = tokenID;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LocalDateTime getExpiryTime() {
        return expiryTime;
    }

    public void setExpiryTime(LocalDateTime expiryTime) {
        this.expiryTime = expiryTime;
    }

    public boolean isIsUsed() {
        return isUsed;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    public User getUserID() {
        return userID;
    }

    public void setUserID(User userID) {
        this.userID = userID;
    }

    @Override
    public String toString() {
        return "TokenForgetPassword{" + "tokenID=" + tokenID + ", token=" + token + ", expiryTime=" + expiryTime + ", isUsed=" + isUsed + ", userID=" + userID + '}';
    } 
    
}
