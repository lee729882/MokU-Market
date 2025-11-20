package com.MokU.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatRoomVO {

    private int roomId;
    private int productId;
    private int sellerId;
    private int buyerId;

    private Date createdAt;
    private Date lastMessageAt;

    private String lastMessage;

    private int unreadCount;
    private int price;

    // 화면 표시용
    private String productTitle;
    private String opponentName;
    private String productImageUrl;
    private String status;   // ← JSP에서 status 뱃지를 사용하면 필요

}
