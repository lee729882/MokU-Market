package com.MokU.vo;

import java.util.Date;
import lombok.Data;

@Data
public class CommentVO {
    private int id;
    private int boardId;
    private String writer;
    private String content;
    private Date createdAt;
}
