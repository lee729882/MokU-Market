package com.MokU.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.MokU.service.MemberService;
import com.MokU.service.EmailService;
import com.MokU.service.ProductService;
import com.MokU.service.ReviewService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;
import com.MokU.vo.ReviewVO;

@Controller
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;


    // ================================
    // 회원가입 페이지
    // ================================
    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(MemberVO vo, HttpSession session, Model model) {

        Boolean verified = (Boolean) session.getAttribute("emailVerified");
        String email = (String) session.getAttribute("authEmail");

        if (verified == null || !verified || !vo.getEmail().equals(email)) {
            model.addAttribute("error", "이메일 인증이 필요합니다.");
            return "signup";
        }

        if (memberService.existsByEmail(vo.getEmail())) {
            model.addAttribute("error", "이미 가입된 이메일입니다.");
            return "signup";
        }

        if (memberService.existsByPhone(vo.getPhone())) {
            model.addAttribute("error", "이미 가입된 전화번호입니다.");
            return "signup";
        }

        vo.setVerified("Y");
        memberService.register(vo);

        session.invalidate();

        model.addAttribute("name", vo.getName());
        model.addAttribute("email", vo.getEmail());

        return "signup_success";
    }


    // ================================
    // 이메일 중복 체크
    // ================================
    @GetMapping("/member/checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("email") String email) {
        return memberService.existsByEmail(email) ? "exists" : "ok";
    }


    // ================================
    // 전화번호 중복 체크
    // ================================
    @GetMapping("/member/checkPhone")
    @ResponseBody
    public String checkPhone(@RequestParam("phone") String phone) {
        return memberService.existsByPhone(phone) ? "exists" : "ok";
    }


    // ================================
    // 로그인
    // ================================
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        MemberVO user = memberService.login(email, password);

        if (user == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }

        session.setAttribute("loginUser", user);
        session.setAttribute("loginUserId", user.getUserId());
        session.setAttribute("loginName", user.getName());

        // ✅ 관리자 계정이면 신고 관리 페이지로 바로 이동
        if (user.isAdmin()) {
            return "redirect:/admin/report/list";
        }

        // ✅ 일반 유저는 기존 홈으로 이동
        return "redirect:/controller/home";
    }



    // ================================
    // 로그아웃
    // ================================
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }


    // ================================
    // 비밀번호 찾기 1: 페이지
    // ================================
    @GetMapping("/member/forgot-password")
    public String forgotPasswordPage() {
        return "forgotPassword";
    }


    // ================================
    // 비밀번호 찾기 2: 인증코드 발송
    // ================================
    @PostMapping("/member/sendResetCode")
    @ResponseBody
    public String sendResetCode(@RequestParam("email") String email, HttpSession session) {
        try {
            String code = emailService.sendAuthCode(email);

            session.setAttribute("resetEmail", email);
            session.setAttribute("resetCode", code);
            return "success";

        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }


    // ================================
    // 비밀번호 찾기 3: 인증코드 확인
    // ================================
    @PostMapping("/member/verifyResetCode")
    @ResponseBody
    public String verifyResetCode(@RequestParam("code") String code, HttpSession session) {

        String saved = (String) session.getAttribute("resetCode");

        if (saved != null && saved.equals(code)) {
            session.setAttribute("resetVerified", true);
            return "verified";
        }
        return "invalid";
    }


    // ================================
    // 비밀번호 찾기 4: 비밀번호 변경
    // ================================
    @PostMapping("/member/resetPassword")
    @ResponseBody
    public String resetPassword(@RequestParam("newPw") String newPw, HttpSession session) {
        Boolean verified = (Boolean) session.getAttribute("resetVerified");
        String email = (String) session.getAttribute("resetEmail");

        if (verified != null && verified && email != null) {
            memberService.updatePasswordByEmail(email, newPw);
            session.removeAttribute("resetVerified");
            return "success";
        }
        return "fail";
    }


    // ================================
    // 홈 화면
    // ================================
    @GetMapping("/controller/home")
    public String homePage(HttpSession session, Model model) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        }

        List<ProductVO> topViewProducts =
                productService.getTopProductsByViewCount(8);

        List<ProductVO> topFavoriteProducts =
                productService.getTopProductsByFavoriteCount(8);

        model.addAttribute("topViewProducts", topViewProducts);
        model.addAttribute("topFavoriteProducts", topFavoriteProducts);

        @SuppressWarnings("unchecked")
        List<ProductVO> recentProducts =
                (List<ProductVO>) session.getAttribute("recentProducts");

        model.addAttribute("recentProducts", recentProducts);

        return "home";
    }


    // ================================
    // 프로필 페이지
    // ================================
    @GetMapping("/profile")
    public String profile(@RequestParam("id") int memberId,
                          HttpSession session,
                          Model model) {

        MemberVO profileMember = memberService.getMemberById(memberId);
        if (profileMember == null) return "redirect:/home";

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        boolean isOwner = (loginUser != null && loginUser.getUserId() == memberId);

        List<ProductVO> products = productService.getMyProducts(memberId);
        List<ReviewVO> received = reviewService.getReceivedReviews(memberId);
        List<ReviewVO> written = reviewService.getWrittenReviews(memberId);

        model.addAttribute("member", profileMember);
        model.addAttribute("isOwner", isOwner);
        model.addAttribute("products", products);
        model.addAttribute("receivedReviews", received);
        model.addAttribute("writtenReviews", written);

        return "profile";
    }
}
