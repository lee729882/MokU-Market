package com.MokU.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.MokU.service.BoardService;
import com.MokU.service.BoardLikeService;
import com.MokU.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final BoardLikeService likeService;

    // ================================
    // 게시글 목록
    // ================================
    @GetMapping
    public List<BoardVO> getBoards(
            @RequestParam String school,
            @RequestParam String category) {

        return boardService.getBoards(school, category);
    }

    // ================================
    // 게시글 작성 (이미지 → DB BLOB 저장)
    // ================================
    @PostMapping
    public String create(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String writer,
            @RequestParam String school,
            @RequestParam String category,
            @RequestParam(required = false) MultipartFile image) {

        BoardVO vo = new BoardVO();
        vo.setTitle(title);
        vo.setContent(content);
        vo.setWriter(writer);
        vo.setSchool(school);
        vo.setCategory(category);

        if (image != null && !image.isEmpty()) {
            try {
                vo.setImageData(image.getBytes());          // 🔥 BLOB 데이터
                vo.setImageType(image.getContentType());    // 🔥 MIME 타입 (image/jpeg 등)
            } catch (IOException e) {
                e.printStackTrace();
                return "IMAGE_ERROR";
            }
        }

        boardService.insert(vo);
        return "OK";
    }

    // ================================
    // 게시글 수정
    // ================================
    @PutMapping("/{id}")
    public String update(
            @PathVariable int id,
            @RequestParam String username,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam(required = false) MultipartFile image) {

        BoardVO post = boardService.getById(id);
        if (post == null) return "NOT_FOUND";

        if (!post.getWriter().equals(username))
            return "NO_PERMISSION";

        post.setTitle(title);
        post.setContent(content);

        if (image != null && !image.isEmpty()) {
            try {
                post.setImageData(image.getBytes());
                post.setImageType(image.getContentType());
            } catch (IOException e) {
                e.printStackTrace();
                return "IMAGE_ERROR";
            }
        }

        boardService.update(post);
        return "OK";
    }

    // ================================
    // 게시글 삭제
    // ================================
    @DeleteMapping("/{id}")
    public String delete(
            @PathVariable int id,
            @RequestParam String username) {

        BoardVO post = boardService.getById(id);
        if (post == null) return "NOT_FOUND";

        if (!post.getWriter().equals(username))
            return "NO_PERMISSION";

        boardService.delete(id);
        return "OK";
    }

    // ================================
    // 좋아요 토글
    // ================================
    @PostMapping("/{id}/like")
    public Object like(
            @PathVariable int id,
            @RequestParam String username) {

        boolean liked = likeService.toggleLike(username, id);
        int likeCount = likeService.countLikes(id);

        return new Object() {
            public final boolean isLiked = liked;
            public final int likeCountValue = likeCount;
        };
    }

    // ================================
    // 좋아요 상태 조회
    // ================================
    @GetMapping("/{id}/like")
    public Object likeStatus(
            @PathVariable int id,
            @RequestParam String username) {

        boolean liked = likeService.isLiked(username, id);
        int likeCount = likeService.countLikes(id);

        return new Object() {
            public final boolean isLiked = liked;
            public final int count = likeCount;
        };
    }
}
