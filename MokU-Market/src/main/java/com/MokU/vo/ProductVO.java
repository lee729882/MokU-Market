package com.MokU.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
    private int productId;
    private int sellerId;          // NUMBER 타입 매칭
    private String title;
    private int price;
    private String category;
    private String description;
    private String imagePath;
    private String placeName;
    private Double latitude;
    private Double longitude;
    private int viewCount;
    private int likeCount;
    private String status;
    private Date createdAt;
    private Date updatedAt;

    // Getter & Setter 전부 생성
}
