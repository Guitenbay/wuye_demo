package com.wuyedemo.wuye_demo.bean;

public class PropertyFeeRecord {
    //物业费记录
    private String residentID;
    private String residenceID;
    private String propertyFeeID;
    private String paymentTime;
    private double propertyFee;

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

    public String getPropertyFeeID() {
        return propertyFeeID;
    }

    public void setPropertyFeeID(String propertyFeeID) {
        this.propertyFeeID = propertyFeeID;
    }

    public String getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(String paymentTime) {
        this.paymentTime = paymentTime;
    }

    public double getPropertyFee() {
        return propertyFee;
    }

    public void setPropertyFee(double propertyFee) {
        this.propertyFee = propertyFee;
    }
}
