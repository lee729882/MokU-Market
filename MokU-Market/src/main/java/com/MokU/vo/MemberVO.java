package com.MokU.vo;

import java.util.Date;

public class MemberVO {
    private int userId;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String verified;

    // ✅ JSP에서 사용하는 추가 필드
    private Double mannerTemp = 36.5;
    private int productCount = 0;
    private int favoriteCount = 0;
    private int chatCount = 0;
    
    // ✅ 위치 인증 관련 필드 추가
    private String isLocationVerified; // 위치 인증 여부 (Y/N)
    private String verifiedPlace;      // 인증된 학교명 (예: 목포대학교)
    private Date verifiedAt;           // 인증 완료 시각

    private String profileImagePath;

    // ===== Getter & Setter =====
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getVerified() { return verified; }
    public void setVerified(String verified) { this.verified = verified; }

    public Double getMannerTemp() { return mannerTemp; }
    public void setMannerTemp(Double mannerTemp) { this.mannerTemp = mannerTemp; }

    public int getProductCount() { return productCount; }
    public void setProductCount(int productCount) { this.productCount = productCount; }

    public int getFavoriteCount() { return favoriteCount; }
    public void setFavoriteCount(int favoriteCount) { this.favoriteCount = favoriteCount; }

    public int getChatCount() { return chatCount; }
    public void setChatCount(int chatCount) { this.chatCount = chatCount; }

    public String getIsLocationVerified() { return isLocationVerified; }
    public void setIsLocationVerified(String isLocationVerified) { this.isLocationVerified = isLocationVerified; }

    public String getVerifiedPlace() { return verifiedPlace; }
    public void setVerifiedPlace(String verifiedPlace) { this.verifiedPlace = verifiedPlace; }

    public Date getVerifiedAt() { return verifiedAt; }
    public void setVerifiedAt(Date verifiedAt) { this.verifiedAt = verifiedAt; }
    
    public String getProfileImagePath() {
        return profileImagePath;
    }

    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }
}
