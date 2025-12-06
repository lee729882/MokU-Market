package com.MokU.vo;

import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.Data;

@Data
public class RentPaymentVO {

    private int paymentId;
    private int rentProductId;
    private String buyerName;
    private String sellerName;
    private int price;
    private String durationType;

    private Timestamp startAt;   // 대여 시작(결제 시간)
    private Timestamp endAt;     // 대여 종료
    private Timestamp createdAt; // 기록 생성 시간
    private String status;

    // ⭐ 달력 통계에서 하루 기준 매출/소비 계산용
    private LocalDate paymentDate; 
}
