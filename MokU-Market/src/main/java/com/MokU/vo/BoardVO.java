package com.MokU.vo;

import java.sql.Timestamp;
import java.util.Base64;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class BoardVO {

    private int id;
    private String title;
    private String content;

    // ======================================
    // 🔥 board.writer_name 컬럼 <— 닉네임 저장됨
    // ======================================
    private String writerName;

    private String school;
    private String category;

    private int likeCount;

    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ======================================
    // 🔥 이미지 BLOB 데이터
    // ======================================
    @JsonIgnore
    private byte[] imageData;   // DB IMAGE_DATA 컬럼

    @JsonIgnore
    private String imageType;   // DB IMAGE_TYPE 컬럼

    // ======================================
    // JSON 변환 시 Base64 이미지 자동 제공
    // ======================================
    @JsonProperty("imageBase64")
    public String getImageBase64() {
        if (imageData == null) return null;
        if (imageType == null) return null;

        return "data:" + imageType + ";base64," +
                Base64.getEncoder().encodeToString(imageData);
    }
}
