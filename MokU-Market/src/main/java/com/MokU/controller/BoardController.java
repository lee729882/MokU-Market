package com.MokU.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

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

    // =======================================
    // 📌 게시글 목록
    // =======================================
    @GetMapping
    public List<BoardVO> getBoards(
            @RequestParam String school,
            @RequestParam String category) {

        return boardService.getBoards(school, category);
    }

    // =======================================
    // 📌 게시글 작성
    // writerName = 세션에 저장된 로그인 유저 이름
    // =======================================
    @PostMapping
    public String create(
            HttpSession session,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String writerName,   // 프론트에서 전달됨
            @RequestParam String school,
            @RequestParam String category,
            @RequestParam(required = false) MultipartFile image) {

        // 🔥 서버에서도 세션값 검증
        String sessionWriter = (String) session.getAttribute("loginName");
        if (sessionWriter == null) return "NO_LOGIN";

        // 🔥 혹시라도 프론트에서 writerName 조작할까봐 검증
        if (!sessionWriter.equals(writerName)) {
            return "INVALID_WRITER";
        }

        BoardVO vo = new BoardVO();
        vo.setTitle(title);
        vo.setContent(content);
        vo.setWriterName(writerName);
        vo.setSchool(school);
        vo.setCategory(category);

        if (image != null && !image.isEmpty()) {
            try {
                vo.setImageData(image.getBytes());
                vo.setImageType(image.getContentType());
            } catch (IOException e) {
                return "IMAGE_ERROR";
            }
        }

        boardService.insert(vo);
        return "OK";
    }

    // =======================================
    // 📌 게시글 수정
    // =======================================
    @PutMapping("/{id}")
    public String update(
            HttpSession session,
            @PathVariable int id,
            @RequestParam String writerName,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam(required = false) MultipartFile image) {

        String sessionWriter = (String) session.getAttribute("loginName");
        if (sessionWriter == null) return "NO_LOGIN";
        if (!sessionWriter.equals(writerName)) return "INVALID_WRITER";

        BoardVO post = boardService.getById(id);
        if (post == null) return "NOT_FOUND";

        if (!post.getWriterName().equals(writerName))
            return "NO_PERMISSION";

        post.setTitle(title);
        post.setContent(content);

        if (image != null && !image.isEmpty()) {
            try {
                post.setImageData(image.getBytes());
                post.setImageType(image.getContentType());
            } catch (IOException e) {
                return "IMAGE_ERROR";
            }
        }

        boardService.update(post);
        return "OK";
    }

    // =======================================
    // 📌 게시글 삭제
    // =======================================
    @DeleteMapping("/{id}")
    public String delete(
            HttpSession session,
            @PathVariable int id,
            @RequestParam String writerName) {

        String sessionWriter = (String) session.getAttribute("loginName");
        if (sessionWriter == null) return "NO_LOGIN";
        if (!sessionWriter.equals(writerName)) return "INVALID_WRITER";

        BoardVO post = boardService.getById(id);
        if (post == null) return "NOT_FOUND";

        if (!post.getWriterName().equals(writerName))
            return "NO_PERMISSION";

        boardService.delete(id);
        return "OK";
    }

    // =======================================
    // 📌 좋아요 토글
    // =======================================
    @PostMapping("/{id}/like")
    public Object like(
            HttpSession session,
            @PathVariable int id,
            @RequestParam String writerName) {

        String sessionWriter = (String) session.getAttribute("loginName");
        if (sessionWriter == null) {
            return new Object() { public final String error = "NO_LOGIN"; };
        }
        if (!sessionWriter.equals(writerName)) {
            return new Object() { public final String error = "INVALID_WRITER"; };
        }

        boolean liked = likeService.toggleLike(writerName, id);
        int likeCount = likeService.countLikes(id);

        return new Object() {
            public final boolean isLiked = liked;
            public final int likeCountValue = likeCount;
        };
    }

    // =======================================
    // 📌 좋아요 상태 조회
    // =======================================
    @GetMapping("/{id}/like")
    public Object likeStatus(
            HttpSession session,
            @PathVariable int id,
            @RequestParam String writerName) {

        String sessionWriter = (String) session.getAttribute("loginName");
        if (sessionWriter == null) {
            return new Object() { public final String error = "NO_LOGIN"; };
        }
        if (!sessionWriter.equals(writerName)) {
            return new Object() { public final String error = "INVALID_WRITER"; };
        }

        boolean liked = likeService.isLiked(writerName, id);
        int likeCount = likeService.countLikes(id);

        return new Object() {
            public final boolean isLiked = liked;
            public final int count = likeCount;
        };
    }
}
