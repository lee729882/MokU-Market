package com.MokU.controller;

import java.io.File;
import java.util.Date;
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
    public Map<String, Object> updateProfileImage(@RequestParam("file") MultipartFile file, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // ✅ 세션에서 로그인 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            response.put("success", false);
            response.put("message", "❌ 로그인 후 이용해주세요.");
            return response;
        }

        if (file.isEmpty()) {
            response.put("success", false);
            response.put("message", "⚠️ 업로드된 파일이 없습니다.");
            return response;
        }

        try {
            // ✅ 저장 경로 설정
            String uploadDir = session.getServletContext().getRealPath("/resources/profile/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            // ✅ 파일명 중복 방지
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File dest = new File(uploadDir, fileName);
            file.transferTo(dest);

            // ✅ DB에 저장할 상대경로
            String dbPath = "/resources/profile/" + fileName;

            // ✅ DB 업데이트
            user.setProfileImagePath(dbPath);
            memberService.updateProfileImage(user);

            // ✅ 세션 갱신
            session.setAttribute("loginUser", user);
            session.setAttribute("user", user);

            // ✅ JSON 응답
            response.put("success", true);
            response.put("message", "✅ 프로필 이미지가 성공적으로 변경되었습니다.");
            response.put("imagePath", dbPath);
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "❌ 업로드 중 오류가 발생했습니다.");
            return response;
        }
    }


}
