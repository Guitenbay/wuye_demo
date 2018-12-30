package com.wuyedemo.wuye_demo.bean;

public class PropertyFeeRecord {
    //物业费记录
    private String residentID;
    private String residenceID;
    private String paymentID;
    private String startTime;
    private double payment;

    public String getResidentID() {
        return residentID;
    }

    public void setResidentID(String residentID) {
        this.residentID = residentID;
    }

    public String getResidenceID() {
        return residenceID;
    }

    public void setResidenceID(String residenceID) {
        this.residenceID = residenceID;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public double getPayment() {
        return payment;
    }

    public void setPayment(double payment) {
        this.payment = payment;
    }
}
