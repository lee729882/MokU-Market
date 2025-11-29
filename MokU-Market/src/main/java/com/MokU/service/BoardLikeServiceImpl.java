package com.MokU.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.MokU.mapper.BoardLikeMapper;
import com.MokU.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardLikeServiceImpl implements BoardLikeService {

    private final BoardLikeMapper likeMapper;
    private final BoardMapper boardMapper;  // like_count 업데이트용

    @Override
    public boolean toggleLike(String username, int boardId) {

        Map<String, Object> params = new HashMap<>();
        params.put("username", username);
        params.put("boardId", boardId);

        int exists = likeMapper.exists(params);

        if (exists > 0) {
            // 좋아요 취소
            likeMapper.delete(params);
            boardMapper.decreaseLike(boardId);   // ↓ board.like_count - 1
            return false;
        } else {
            // 좋아요 추가
            likeMapper.insert(params);
            boardMapper.increaseLike(boardId);   // ↑ board.like_count + 1
            return true;
        }
    }

    @Override
    public boolean isLiked(String username, int boardId) {
        Map<String, Object> params = new HashMap<>();
        params.put("username", username);
        params.put("boardId", boardId);
        return likeMapper.exists(params) > 0;
    }

    @Override
    public int countLikes(int boardId) {
        // like_count 컬럼에서 직접 조회
        return boardMapper.getById(boardId).getLikeCount();
    }
}
