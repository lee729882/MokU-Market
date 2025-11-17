package com.MokU.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {

    private int productId;
    private int sellerId;
    private String title;
    private int price;
    private String category;
    private String description;

    private String imagePath;       // 대표 이미지 (첫 번째 사진)
    private String placeName;
    private Double latitude;
    private Double longitude;

    private int viewCount;
    private int likeCount;
    private String status;

    private Date createdAt;
    private Date updatedAt;

    // 🔥 여러 장 이미지
    private List<String> imageList;
}
