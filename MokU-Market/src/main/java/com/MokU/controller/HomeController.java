package com.MokU.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String redirectToRegister() {
        // 서버 시작 시 첫 화면을 회원가입 페이지로 설정
        return "login";  // ✅ /WEB-INF/views/member/login.jsp 로 이동
    }
}
