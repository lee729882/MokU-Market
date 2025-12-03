package com.MokU.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVO {

    private Integer reportId;
    private Integer reporterId;
    private Integer targetUserId;
    private Integer productId;
    private Integer postId;
    private Integer chatRoomId;
    private String  reasonType;
    private String  description;
    private String  status;
    private Integer processedBy;
    private Date    processedAt;
    private Date    createdAt;
}