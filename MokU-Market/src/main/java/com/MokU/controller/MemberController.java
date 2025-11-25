package com.MokU.controller;

import java.io.File;
import java.util.List;   // ✅ 추가

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.MokU.service.MemberService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;
import com.MokU.vo.ReviewVO;
import com.MokU.service.ProductService;   // ✅ 추가
import com.MokU.service.ReviewService;

@Controller
public class MemberController {
	
    @Autowired
    private MemberService memberService;
    
    @Autowired
    private com.MokU.service.EmailService emailService;
    
    @Autowired
    private ProductService productService;   // ✅ 메인화면 상품 조회용
    
    @Autowired
    private ReviewService reviewService;   // ✅ 메인화면 상품 조회용
    

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
        return "login"; // → /WEB-INF/views/login.jsp 로 연결됨
    }

    @PostMapping("/login")
    public String login(MemberVO vo, HttpSession session, Model model) {
        // DB에서 이메일/비밀번호 검증
        MemberVO loginUser = memberService.login(vo);

        if (loginUser != null) {
            // ✅ 로그인 성공 → 세션에 사용자 저장
            session.setAttribute("loginUser", loginUser);
            System.out.println("✅ 로그인 성공: " + loginUser.getEmail());

            // ✅ 홈 페이지로 이동
            return "redirect:/home";
        } else {
            // ❌ 로그인 실패 → 에러 메시지 전달
            model.addAttribute("error", "이메일 또는 비밀번호가 올바르지 않습니다.");
            return "login"; // login.jsp로 다시 이동
        }
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }


 // 1 비밀번호 찾기 페이지 이동
 @GetMapping("/member/forgot-password")
 public String forgotPasswordPage() {
     return "forgotPassword";
 }

 // 2️ 인증코드 이메일 전송
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

 // 3️ 인증코드 확인
 @PostMapping("/member/verifyResetCode")
 @ResponseBody
 public String verifyResetCode(@RequestParam("code") String code, HttpSession session) {
     String savedCode = (String) session.getAttribute("resetCode");
     if (savedCode != null && savedCode.equals(code)) {
         session.setAttribute("resetVerified", true);
         return "verified";
     }
     return "invalid";
 }

 // 4️ 새 비밀번호 변경
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
 
//✅ 홈 화면 (로그인 여부와 무관하게 진입 가능)
@GetMapping({"/home"})
public String homePage(HttpSession session, Model model) {

  // 1) 로그인 유저가 있으면 화면에서 쓸 수 있게 전달
  MemberVO user = (MemberVO) session.getAttribute("loginUser");
  if (user != null) {
      model.addAttribute("user", user);
  }

  // 2) 조회수 TOP N / 찜 TOP N 상품 조회
  List<ProductVO> topViewProducts =
          productService.getTopProductsByViewCount(8);

  List<ProductVO> topFavoriteProducts =
          productService.getTopProductsByFavoriteCount(8);

  model.addAttribute("topViewProducts", topViewProducts);
  model.addAttribute("topFavoriteProducts", topFavoriteProducts);

  // 3) 세션에 저장된 최근 본 상품 목록 전달 (로그인 여부와 무관)
  @SuppressWarnings("unchecked")
  List<ProductVO> recentProducts =
          (List<ProductVO>) session.getAttribute("recentProducts");
  model.addAttribute("recentProducts", recentProducts);

  // 4) home.jsp로 이동
  return "home";
}
@GetMapping("/profile")
public String profile(@RequestParam("id") int memberId,
                      HttpSession session,
                      Model model) {

    MemberVO profileMember = memberService.getMemberById(memberId);
    if (profileMember == null) {
        return "redirect:/home";   // 없으면 홈으로
    }

    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
    boolean isOwner = (loginUser != null && loginUser.getUserId() == memberId);

    List<ProductVO> products = productService.getMyProducts(memberId);
    List<ReviewVO> receivedReviews = reviewService.getReceivedReviews(memberId);
    List<ReviewVO> writtenReviews  = reviewService.getWrittenReviews(memberId);

    model.addAttribute("member", profileMember);
    model.addAttribute("isOwner", isOwner);
    model.addAttribute("products", products);
    model.addAttribute("receivedReviews", receivedReviews);
    model.addAttribute("writtenReviews", writtenReviews);

    return "profile";   // → /WEB-INF/views/profile.jsp
}



}
