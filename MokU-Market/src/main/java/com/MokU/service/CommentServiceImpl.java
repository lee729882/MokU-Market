package com.MokU.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.MokU.mapper.CommentMapper;
import com.MokU.vo.CommentVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentMapper mapper;

    @Override
    public void insert(CommentVO vo) {
        mapper.insert(vo);
    }

    @Override
    public List<CommentVO> getComments(int boardId) {
        return mapper.getComments(boardId);
    }

    @Override
    public CommentVO getById(int id) {
        return mapper.getById(id);
    }

    @Override
    public void update(CommentVO vo) {
        mapper.update(vo);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }
}
