package com.MokU.vo;

import java.sql.Timestamp;
import lombok.Data;

@Data

public class RentProductVO {

    private int rentProductId;
    private int sellerId;
    private String sellerName;

    private String title;
    private String description;
    private int price;
    private String durationType;

    private byte[] imageData;   // 업로드용
    private byte[] imageBlob;   // DB 저장/조회용
    private String base64Image; // JSP 표시용

    private String status;
    private Timestamp createdAt;
    private Timestamp endAt;
}

