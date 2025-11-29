package com.MokU.service;

public interface BoardLikeService {
    boolean toggleLike(String username, int boardId);
    boolean isLiked(String username, int boardId);
    int countLikes(int boardId);
}
