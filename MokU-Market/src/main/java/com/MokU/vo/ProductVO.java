package com.MokU.vo;

import lombok.Data;

@Data
public class ProductVO {
    private int productId;
    private String title;
    private String category;
    private int price;
    private String description;
    private int sellerId;
    private Double latitude;   // ✅ null 허용
    private Double longitude;  // ✅ null 허용
    private String imagePath;
}
