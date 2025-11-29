package com.MokU.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.MokU.mapper.BoardMapper;
import com.MokU.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

    private final BoardMapper mapper;

    @Override
    public void insert(BoardVO vo) {
        mapper.insert(vo);
    }

    @Override
    public List<BoardVO> getBoards(String school, String category) {
        Map<String, Object> params = new HashMap<>();
        params.put("school", school);
        params.put("category", category);
        return mapper.getBoards(params);
    }

    @Override
    public BoardVO getById(int id) {
        return mapper.getById(id);
    }

    @Override
    public void update(BoardVO vo) {
        mapper.update(vo);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }
}
