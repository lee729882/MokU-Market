package com.MokU.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

    private int reviewId;   // REVIEW_ID
    private int dealId;     // DEAL_ID  (예: CHAT_ROOM.ROOM_ID 를 사용한다고 가정)
    private int writerId;   // WRITER_ID
    private int targetId;   // TARGET_ID
    private Integer rating; // RATING (1~5 등, nullable)
    private String content; // CONTENT
    private Date createdAt; // CREATED_AT
    // 1) 거래 상품 정보
    private int productId;           // 상품 상세로 이동할 때 사용
    private String productTitle;     // 상품 제목
    private String productImagePath; // 썸네일 이미지 경로

    // 2) 역할/이름 표시
    private String writerName;   // 리뷰 작성자 이름 (받은 후기 영역에서 "OOO 님")
    private String targetName;   // 리뷰 대상자 이름 (쓴 후기 영역에서 "OOO 님")
    private String writerRole;   // 'BUYER' 또는 'SELLER' (내가 구매자인지/판매자인지)
    
    // getter / setter
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
}
