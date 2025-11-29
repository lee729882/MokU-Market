package com.MokU.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MokU.vo.CommentVO;

@Mapper
public interface CommentMapper {
    void insert(CommentVO vo);
    List<CommentVO> getComments(int boardId);
    void update(CommentVO vo);
    void delete(int id);
    CommentVO getById(int id);
}
