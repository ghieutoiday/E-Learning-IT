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
public class Course {

    private int courseID;
    private String courseName;
    private CourseCategory courseCategory;
    private String briefInfo, thumbnail, description;
    private User owner;
    private String status;
    private int numberOfLesson;
    private int feature;
    private Date createDate;
    private double listPrice;
    private double salePrice;
    private int registrationCount;

    public Course() {
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String description, User owner, String status, int numberOfLesson, int feature, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.feature = feature;
        this.createDate = createDate;
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String description, User owner, String status, int numberOfLesson, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.createDate = createDate;
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String thumbnail, String description, User owner, String status, int numberOfLesson, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.thumbnail = thumbnail;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.createDate = createDate;
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String thumbnail, String description, User owner, String status, int numberOfLesson, int feature, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.thumbnail = thumbnail;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.feature = feature;
        this.createDate = createDate;
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String briefInfo, String thumbnail, String description, User owner, String status, int numberOfLesson, int feature, Date createDate, double listPrice, double salePrice) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.briefInfo = briefInfo;
        this.thumbnail = thumbnail;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.feature = feature;
        this.createDate = createDate;
        this.listPrice = listPrice;
        this.salePrice = salePrice;
    }


    public String getBriefInfo() {
        return briefInfo;
    }

    public void setBriefInfo(String briefInfo) {
        this.briefInfo = briefInfo;
    }
    

    public int getFeature() {
        return feature;
    }

    public void setFeature(int feature) {
        this.feature = feature;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public CourseCategory getCourseCategory() {
        return courseCategory;
    }

    public void setCourseCategory(CourseCategory courseCategory) {
        this.courseCategory = courseCategory;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getNumberOfLesson() {
        return numberOfLesson;
    }

    public void setNumberOfLesson(int numberOfLesson) {
        this.numberOfLesson = numberOfLesson;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public double getListPrice() {
        return listPrice;
    }

    public void setListPrice(double listPrice) {
        this.listPrice = listPrice;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }
    
    public int getRegistrationCount() {
        return registrationCount;
    }

    public void setRegistrationCount(int registrationCount) {
        this.registrationCount = registrationCount;
    }
    
    public String toPromptString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Tên khóa học: ").append(courseName != null ? courseName : "N/A").append("\n");
        sb.append("Mã khóa học: ").append(courseID).append("\n");
        sb.append("Thể loại: ").append(courseCategory != null ? courseCategory.getCourseCategoryName(): "N/A").append("\n");
        sb.append("Thông tin tóm tắt: ").append(briefInfo != null && !briefInfo.isEmpty() ? briefInfo : "Chưa có thông tin tóm tắt.").append("\n");
        sb.append("Mô tả chi tiết: ").append(description != null && !description.isEmpty() ? description : "Chưa có mô tả chi tiết.").append("\n");
        sb.append("Người tạo: ").append(owner != null ? owner.getFullName() : "N/A").append("\n");
        sb.append("Trạng thái: ").append(status != null ? status : "N/A").append("\n");
        sb.append("Số lượng bài học: ").append(numberOfLesson).append(" bài\n");
        sb.append("Ngày tạo: ").append(createDate != null ? createDate.toString() : "N/A").append("\n");
        sb.append("Giá niêm yết: ").append(listPrice).append(" VNĐ\n"); 
        sb.append("Giá khuyến mãi: ").append(salePrice).append(" VNĐ\n"); 
        sb.append("Số lượt đăng ký: ").append(registrationCount).append(" người\n");
        sb.append("Tính năng nổi bật (Feature Code): ").append(feature).append("\n");


        return sb.toString();
    }

}
