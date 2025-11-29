package com.MokU.controller;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import com.MokU.service.CommentService;
import com.MokU.vo.CommentVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/comments")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService service;

    @GetMapping("/{postId}")
    public List<CommentVO> getComments(@PathVariable int postId) {
        return service.getComments(postId);
    }

    @PostMapping("/{postId}")
    public String create(
            @PathVariable int postId,
            @RequestBody CommentVO vo) {

        vo.setBoardId(postId);
        service.insert(vo);
        return "OK";
    }

    @PutMapping("/{id}")
    public String update(
            @PathVariable int id,
            @RequestBody CommentVO vo,
            @RequestParam String username) {

        CommentVO origin = service.getById(id);

        if (!origin.getWriter().equals(username))
            return "NO_PERMISSION";

        vo.setId(id);
        service.update(vo);
        return "OK";
    }

    @DeleteMapping("/{id}")
    public String delete(
            @PathVariable int id,
            @RequestParam String username) {

        CommentVO origin = service.getById(id);

        if (!origin.getWriter().equals(username))
            return "NO_PERMISSION";

        service.delete(id);
        return "OK";
    }
}
