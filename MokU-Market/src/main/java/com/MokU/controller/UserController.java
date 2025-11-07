package com.MokU.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.MokU.service.MemberService;
import com.MokU.vo.MemberVO;

@Controller
@RequestMapping("/controller")
public class UserController {

    @Autowired
    private MemberService memberService;

    // ✅ 마이페이지
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("user", user);
        return "mypage";
    }

    // ✅ 비밀번호 변경
    @GetMapping("/changePassword")
    public String changePassword() {
        return "changePassword";
    }

    @GetMapping("/myProducts")
    public String myProducts() { return "user_myProducts"; }

    @GetMapping("/favorites")
    public String favorites() { return "user_favorites"; }

    @GetMapping("/reviews")
    public String reviews() { return "user_reviews"; }

    @GetMapping(value = "/verifyWifi", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String verifyWifi(HttpServletRequest request, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "로그인이 필요합니다.";

        String ip = request.getRemoteAddr();
        System.out.println("사용자 IP: " + ip);

        // ✅ 테스트용: 특정 Wi-Fi IP(183.109.228.30) + localhost 허용
        if (ip.equals("183.109.228.30") || ip.startsWith("127.0.0.") || ip.startsWith("0:0:0:0")) {
            user.setIsLocationVerified("Y");
            user.setVerifiedPlace("목포대학교 Wi-Fi 인증");
            memberService.updateLocationVerified(user);
            session.setAttribute("loginUser", user);
            return "📡 캠퍼스 Wi-Fi 인증 완료!";
        } else {
            return "❌ 캠퍼스 네트워크(Wi-Fi)에서만 인증 가능합니다. (현재 IP: " + ip + ")";
        }
    }



}
