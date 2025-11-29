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
    private String writer;
    private String school;
    private String category;

    private int likeCount;

    // ================================
    // 날짜 필드 (DB 매핑용)
    // ================================
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ================================
    // 🔥 이미지(BLOB, MIME TYPE)
    // ================================
    @JsonIgnore
    private byte[] imageData;   // BLOB 저장

    @JsonIgnore
    private String imageType;   // image/jpeg, image/png 등


    // ==============================================================
    // 🔥 프론트로 내보낼 Base64 변환된 이미지 문자열
    //    JSONIgnore가 아니므로 JSON으로 정상 출력됨
    // ==============================================================
    @JsonProperty("imageBase64")
    public String getImageBase64() {
        if (imageData == null || imageType == null) return null;

        return "data:" + imageType + ";base64," + Base64.getEncoder().encodeToString(imageData);
    }
}
