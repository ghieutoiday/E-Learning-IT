package dto;

import java.util.List;

public class DashboardStatsDTO {

    private int newSubject;
    private int allSubject;
    private int successfulRegistration;
    private int cancelledRegistration;
    private int submittedRegistration;
    private int totalRevenue;
    private int newCustomer;
    private int newBought;
    private List<String> orderLabels;
    private List<Integer> orderCounts;
    private List<Integer> successfulOrderCounts;
    private List<String> categoryNames;
    private List<Integer> categoryRevenues;

    public int getNewSubject() {
        return newSubject;
    }

    public void setNewSubject(int newSubject) {
        this.newSubject = newSubject;
    }

    public int getAllSubject() {
        return allSubject;
    }

    public void setAllSubject(int allSubject) {
        this.allSubject = allSubject;
    }

    public int getSuccessfulRegistration() {
        return successfulRegistration;
    }

    public void setSuccessfulRegistration(int successfulRegistration) {
        this.successfulRegistration = successfulRegistration;
    }

    public int getCancelledRegistration() {
        return cancelledRegistration;
    }

    public void setCancelledRegistration(int cancelledRegistration) {
        this.cancelledRegistration = cancelledRegistration;
    }

    public int getSubmittedRegistration() {
        return submittedRegistration;
    }

    public void setSubmittedRegistration(int submittedRegistration) {
        this.submittedRegistration = submittedRegistration;
    }

    public int getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(int totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getNewCustomer() {
        return newCustomer;
    }

    public void setNewCustomer(int newCustomer) {
        this.newCustomer = newCustomer;
    }

    public int getNewBought() {
        return newBought;
    }

    public void setNewBought(int newBought) {
        this.newBought = newBought;
    }

    public List<String> getOrderLabels() {
        return orderLabels;
    }

    public void setOrderLabels(List<String> orderLabels) {
        this.orderLabels = orderLabels;
    }

    public List<Integer> getOrderCounts() {
        return orderCounts;
    }

    public void setOrderCounts(List<Integer> orderCounts) {
        this.orderCounts = orderCounts;
    }

    public List<Integer> getSuccessfulOrderCounts() {
        return successfulOrderCounts;
    }

    public void setSuccessfulOrderCounts(List<Integer> successfulOrderCounts) {
        this.successfulOrderCounts = successfulOrderCounts;
    }

    public List<String> getCategoryNames() {
        return categoryNames;
    }

    public void setCategoryNames(List<String> categoryNames) {
        this.categoryNames = categoryNames;
    }

    public List<Integer> getCategoryRevenues() {
        return categoryRevenues;
    }

    public void setCategoryRevenues(List<Integer> categoryRevenues) {
        this.categoryRevenues = categoryRevenues;
    }
}
