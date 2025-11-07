package com.MokU.vo;

public class EmailAuthVO {
    private String email;
    private String authCode;
    private String createdAt;

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getAuthCode() { return authCode; }
    public void setAuthCode(String authCode) { this.authCode = authCode; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
