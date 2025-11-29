package com.MokU.service;

import java.util.List;
import com.MokU.vo.BoardVO;

public interface BoardService {
    void insert(BoardVO vo);
    List<BoardVO> getBoards(String school, String category);
    BoardVO getById(int id);
    void update(BoardVO vo);
    void delete(int id);
}
