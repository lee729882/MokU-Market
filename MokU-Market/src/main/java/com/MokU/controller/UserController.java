package com.MokU.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.MokU.service.MemberService;
import com.MokU.service.ProductService;   // ✅ 추가
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;           // ✅ 필요 시 추가

import lombok.var;

import com.MokU.service.ReviewService;   // ✅ 추가

@Controller
@RequestMapping("/controller")
public class UserController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private ProductService productService;   // ✅ 내 등록템 / 찜템 조회용 서비스

    @Autowired
    private ReviewService reviewService;
    
 // ✅ 마이페이지 (한 화면에서 탭 전환)
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        int userId = user.getUserId();
        System.out.println("✅ [mypage] login userId = " + userId);

        model.addAttribute("user", user);

        model.addAttribute("myProducts",
                productService.getMyProducts(userId));
        model.addAttribute("favoriteProducts",
                productService.getMyFavoriteProducts(userId));

        // 후기 조회
        var received = reviewService.getReceivedReviews(userId);
        var written  = reviewService.getWrittenReviews(userId);

        model.addAttribute("receivedReviews", received);
        model.addAttribute("writtenReviews", written);

        return "mypage";
    }




    // ✅ (예전처럼 별도 페이지로 쓰지 않을 거라면 사실 아래 3개는 없어도 됩니다)
    @GetMapping("/myProducts")
    public String myProducts() { return "user_myProducts"; }

    @GetMapping("/favorites")
    public String favorites() { return "user_favorites"; }

    @GetMapping("/reviews")
    public String reviews() { return "user_reviews"; }

    // ✅ 비밀번호 변경
    @GetMapping("/changePassword")
    public String changePassword() {
        return "changePassword";
    }

    // ✅ Wi-Fi 인증, 프로필 이미지 변경 부분은 그대로 유지
    @GetMapping(value = "/verifyWifi", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String verifyWifi(HttpServletRequest request, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "로그인이 필요합니다.";

        String ip = request.getRemoteAddr();
        System.out.println("사용자 IP: " + ip);

        if (ip.equals("183.109.228.30") || ip.startsWith("127.0.0.") || ip.startsWith("0:0:0:0")) {
            user.setIsLocationVerified("Y");
            user.setVerifiedPlace("목포대학교 Wi-Fi 인증");
            user.setVerifiedAt(new java.util.Date());

            System.out.println("✅ UPDATE 호출 전: " + user.getUserId());
            memberService.updateLocationVerified(user);
            System.out.println("✅ UPDATE 호출 완료");

            session.setAttribute("loginUser", user);
            return "📡 캠퍼스 Wi-Fi 인증 완료!";
        } else {
            return "❌ 캠퍼스 네트워크(Wi-Fi)에서만 인증 가능합니다. (현재 IP: " + ip + ")";
        }
    }

    @PostMapping(value = "/updateProfileImage", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> updateProfileImage(@RequestParam("file") MultipartFile file,
                                                  HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        if (file.isEmpty()) {
            response.put("success", false);
            response.put("message", "파일이 없습니다.");
            return response;
        }

        try {
            String uploadDir = session.getServletContext().getRealPath("/upload/profile/");
            File folder = new File(uploadDir);
            if (!folder.exists()) folder.mkdirs();

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File saveFile = new File(uploadDir, fileName);
            file.transferTo(saveFile);

            String dbPath = "/upload/profile/" + fileName;

            user.setProfileImagePath(dbPath);
            memberService.updateProfileImage(user);

            // 🔥 DB에서 다시 읽어 와서 세션 갱신
            MemberVO updatedUser = memberService.getMemberById(user.getUserId());
            session.setAttribute("loginUser", updatedUser);

            response.put("success", true);
            response.put("message", "프로필 이미지가 정상적으로 변경되었습니다.");
            response.put("imagePath", updatedUser.getProfileImagePath());
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "업로드 실패");
            return response;
        }
    }
}
