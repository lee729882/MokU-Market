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
import com.MokU.service.ProductService;   // �쐟 異붽�
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;           // �쐟 �븘�슂 �떆 異붽�

import lombok.var;

import com.MokU.service.ReviewService;   // �쐟 異붽�

@Controller
@RequestMapping("/controller")
public class UserController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private ProductService productService;   // �쐟 �궡 �벑濡앺뀥 / 李쒗뀥 議고쉶�슜 �꽌鍮꾩뒪

    @Autowired
    private ReviewService reviewService;
    
    
    
    // 留덉씠�럹�씠吏� (�븳 �솕硫댁뿉�꽌 �꺆 �쟾�솚)
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        int userId = user.getUserId();

        // �궡 �벑濡앺뀥, �궡 愿��떖�뀥 媛쒖닔 怨꾩궛
        int myProductCount = productService.getMyProducts(userId).size();
        int myFavoriteCount = productService.getMyFavoriteProducts(userId).size();

        // �썑湲� 媛쒖닔 怨꾩궛
        int receivedReviewCount = reviewService.getReceivedReviews(userId).size();  // 諛쏆� �썑湲� 媛쒖닔
        int writtenReviewCount = reviewService.getWrittenReviews(userId).size();    // �옉�꽦�븳 �썑湲� 媛쒖닔

        model.addAttribute("user", user);
        model.addAttribute("myProductCount", myProductCount);
        model.addAttribute("myFavoriteCount", myFavoriteCount);
        model.addAttribute("receivedReviewCount", receivedReviewCount);
        model.addAttribute("writtenReviewCount", writtenReviewCount);

        model.addAttribute("myProducts", productService.getMyProducts(userId));
        model.addAttribute("favoriteProducts", productService.getMyFavoriteProducts(userId));

        // �썑湲� 議고쉶
        var received = reviewService.getReceivedReviews(userId);
        var written  = reviewService.getWrittenReviews(userId);

        model.addAttribute("receivedReviews", received);
        model.addAttribute("writtenReviews", written);

        return "mypage";
    }



    // �쐟 (�삁�쟾泥섎읆 蹂꾨룄 �럹�씠吏�濡� �벐吏� �븡�쓣 嫄곕씪硫� �궗�떎 �븘�옒 3媛쒕뒗 �뾾�뼱�룄 �맗�땲�떎)
    @GetMapping("/myProducts")
    public String myProducts() { return "user_myProducts"; }

    @GetMapping("/favorites")
    public String favorites() { return "user_favorites"; }

    @GetMapping("/reviews")
    public String reviews() { return "user_reviews"; }

    // �쐟 鍮꾨�踰덊샇 蹂�寃�
    @GetMapping("/changePassword")
    public String changePassword() {
        return "changePassword";
    }

    // �쐟 Wi-Fi �씤利�, �봽濡쒗븘 �씠誘몄� 蹂�寃� 遺�遺꾩� 洹몃�濡� �쑀吏�
    @GetMapping(value = "/verifyWifi", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String verifyWifi(HttpServletRequest request, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.";

        String ip = request.getRemoteAddr();
        System.out.println("�궗�슜�옄 IP: " + ip);

        if (ip.equals("183.109.228.30") || ip.startsWith("127.0.0.") || ip.startsWith("0:0:0:0")) {
            user.setIsLocationVerified("Y");
            user.setVerifiedPlace("紐⑺룷���븰援� Wi-Fi �씤利�");
            user.setVerifiedAt(new java.util.Date());

            System.out.println("�쐟 UPDATE �샇異� �쟾: " + user.getUserId());
            memberService.updateLocationVerified(user);
            System.out.println("�쐟 UPDATE �샇異� �셿猷�");

            session.setAttribute("loginUser", user);
            return "�윋� 罹좏띁�뒪 Wi-Fi �씤利� �셿猷�!";
        } else {
            return "�쓬 罹좏띁�뒪 �꽕�듃�썙�겕(Wi-Fi)�뿉�꽌留� �씤利� 媛��뒫�빀�땲�떎. (�쁽�옱 IP: " + ip + ")";
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
            response.put("message", "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.");
            return response;
        }

        if (file.isEmpty()) {
            response.put("success", false);
            response.put("message", "�뙆�씪�씠 �뾾�뒿�땲�떎.");
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

            // �윍� DB�뿉�꽌 �떎�떆 �씫�뼱 ���꽌 �꽭�뀡 媛깆떊
            MemberVO updatedUser = memberService.getMemberById(user.getUserId());
            session.setAttribute("loginUser", updatedUser);

            response.put("success", true);
            response.put("message", "�봽濡쒗븘 �씠誘몄�媛� �젙�긽�쟻�쑝濡� 蹂�寃쎈릺�뿀�뒿�땲�떎.");
            response.put("imagePath", updatedUser.getProfileImagePath());
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "�뾽濡쒕뱶 �떎�뙣");
            return response;
        }
    }
}
