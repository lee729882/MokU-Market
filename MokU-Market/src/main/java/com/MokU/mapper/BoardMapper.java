package com.MokU.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.MokU.vo.BoardVO;

@Mapper
public interface BoardMapper {
    void insert(BoardVO vo);
    List<BoardVO> getBoards(Map<String, Object> params);
    BoardVO getById(int id);
    void update(BoardVO vo);
    void delete(int id);

    void increaseLike(int id);
    void decreaseLike(int id);
}
