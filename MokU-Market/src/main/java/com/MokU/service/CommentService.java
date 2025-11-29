package com.MokU.service;

import java.util.List;
import com.MokU.vo.CommentVO;

public interface CommentService {
    void insert(CommentVO vo);
    List<CommentVO> getComments(int boardId);
    void update(CommentVO vo);
    void delete(int id);
    CommentVO getById(int id);
}
