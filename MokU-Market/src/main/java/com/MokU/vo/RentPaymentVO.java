package com.MokU.vo;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class RentPaymentVO {
    private int paymentId;
    private int rentProductId;
    private String buyerName;
    private String sellerName;
    private int price;
    private String durationType;
    private Timestamp startAt;
    private Timestamp endAt;
    private Timestamp createdAt;
    private String status;
}
