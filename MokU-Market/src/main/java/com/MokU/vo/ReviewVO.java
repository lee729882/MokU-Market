package com.MokU.vo;

import java.util.Date;

public class ReviewVO {

    private int reviewId;
    private int dealId;      // = roomId
    private int writerId;
    private int targetId;
    private Integer rating;  // 별점 null 허용이면 Integer
    private String content;
    private Date createdAt;

    // ★ 마이페이지용 추가 필드
    private String writerName;       // 내가 받은 후기에서 작성자 이름
    private String targetName;       // 내가 남긴 후기에서 상대 이름
    private int productId;
    private String productTitle;
    private String productImagePath;
    private String writerRole;       // BUYER / SELLER

    // ===== 기본 필드 getter/setter =====
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getDealId() { return dealId; }
    public void setDealId(int dealId) { this.dealId = dealId; }

    public int getWriterId() { return writerId; }
    public void setWriterId(int writerId) { this.writerId = writerId; }

    public int getTargetId() { return targetId; }
    public void setTargetId(int targetId) { this.targetId = targetId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    // ===== 추가 필드 getter/setter =====
    public String getWriterName() { return writerName; }
    public void setWriterName(String writerName) { this.writerName = writerName; }

    public String getTargetName() { return targetName; }
    public void setTargetName(String targetName) { this.targetName = targetName; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductTitle() { return productTitle; }
    public void setProductTitle(String productTitle) { this.productTitle = productTitle; }

    public String getProductImagePath() { return productImagePath; }
    public void setProductImagePath(String productImagePath) { this.productImagePath = productImagePath; }

    public String getWriterRole() { return writerRole; }
    public void setWriterRole(String writerRole) { this.writerRole = writerRole; }
}
