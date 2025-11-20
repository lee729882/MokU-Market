package com.MokU.controller;

import javax.servlet.http.HttpSession;

import com.MokU.service.ChatService;
import com.MokU.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.ui.Model;

@ControllerAdvice
public class GlobalModelAttribute {

    @Autowired
    private ChatService chatService;

    @ModelAttribute
    public void addGlobalAttributes(Model model, HttpSession session) {

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            int userId = loginUser.getUserId();

            // 헤더에서 사용할 로그인 유저 / 미읽은 메시지 수
            int unreadCount = chatService.getTotalUnreadCount(userId);

            model.addAttribute("user", loginUser);     // header.jsp 에서 ${user}
            model.addAttribute("unreadCount", unreadCount); // header.jsp 에서 ${unreadCount}
        }
    }
}
