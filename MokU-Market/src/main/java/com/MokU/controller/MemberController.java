package com.MokU.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.MokU.service.MemberService;
import com.MokU.vo.MemberVO;

@Controller
public class MemberController {
	
    @Autowired
    private MemberService memberService;

    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(MemberVO vo, HttpSession session, Model model) {
        Boolean verified = (Boolean) session.getAttribute("emailVerified");
        String email = (String) session.getAttribute("authEmail");

        if (verified == null || !verified || !vo.getEmail().equals(email)) {
            model.addAttribute("error", "이메일 인증이 완료되지 않았습니다.");
            return "signup";
        }

        // DB 중복 체크
        boolean emailExists = memberService.existsByEmail(vo.getEmail());
        boolean phoneExists = memberService.existsByPhone(vo.getPhone());

        System.out.println("✅ 이메일 검사: " + vo.getEmail() + " -> " + emailExists);
        System.out.println("✅ 전화번호 검사: " + vo.getPhone() + " -> " + phoneExists);

        if (emailExists) {
            model.addAttribute("error", "이미 등록된 이메일입니다.");
            return "signup";
        }
        if (phoneExists) {
            model.addAttribute("error", "이미 등록된 전화번호입니다.");
            return "signup";
        }

        vo.setVerified("Y");
        memberService.register(vo);
        session.invalidate();

        model.addAttribute("name", vo.getName());
        model.addAttribute("email", vo.getEmail());
        return "signup_success";
    }


    // ✅ 이메일 중복 확인
    @GetMapping("/member/checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("email") String email) {
        boolean exists = memberService.existsByEmail(email);
        return exists ? "exists" : "ok";
    }

    // ✅ 전화번호 중복 확인
    @GetMapping("/member/checkPhone")
    @ResponseBody
    public String checkPhone(@RequestParam("phone") String phone) {
        boolean exists = memberService.existsByPhone(phone);
        return exists ? "exists" : "ok";
    }
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
