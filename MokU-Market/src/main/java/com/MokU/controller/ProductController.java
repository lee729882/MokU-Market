package com.MokU.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.MokU.service.ProductService;
import com.MokU.service.MemberService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private MemberService memberService;

    /** ============================================
     *  상품 등록 폼 이동
     *  ============================================ */
    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);
        return "product_form";
    }

    /** ============================================
     *  상품 등록 처리
     *  ============================================ */
    @PostMapping("/add")
    public String addProduct(@ModelAttribute ProductVO vo,
                             @RequestParam("files") MultipartFile[] files,
                             HttpServletRequest request,
                             HttpSession session) throws IOException {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        vo.setSellerId(user.getUserId());

        String uploadDir = request.getServletContext().getRealPath("/resources/uploads/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        List<String> filePaths = new ArrayList<>();
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File dest = new File(uploadDir, fileName);
                file.transferTo(dest);

                filePaths.add("/resources/uploads/" + fileName);
            }
        }

        if (!filePaths.isEmpty()) {
            vo.setImagePath(filePaths.get(0));
        } else {
            vo.setImagePath("/resources/images/no_image.png");
        }

        productService.insertProduct(vo);

        String encodedCategory = URLEncoder.encode(vo.getCategory(), StandardCharsets.UTF_8);
        return "redirect:/product/list?category=" + encodedCategory;
    }

    /** ============================================
     *  카테고리별 목록
     *  ============================================ */
    @GetMapping("/list")
    public String list(@RequestParam("category") String category,
                       HttpSession session,
                       Model model) {

        model.addAttribute("products", productService.getProductsByCategory(category));
        model.addAttribute("category", category);

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) model.addAttribute("user", user);

        return "product_list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam("id") int id,
                         HttpSession session,
                         Model model) {

        productService.increaseViewCount(id);

        ProductVO product = productService.getProductById(id);
        model.addAttribute("product", product);

        MemberVO seller = memberService.getMemberById(product.getSellerId());
        model.addAttribute("seller", seller);

        List<String> images = new ArrayList<>();
        images.add(product.getImagePath());
        model.addAttribute("images", images);

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        boolean liked = false;

        if (user != null) {
            liked = productService.isLiked(user.getUserId(), id);
            model.addAttribute("user", user);
        }

        model.addAttribute("liked", liked);

        // ⭐⭐⭐ 반드시 추가 — 찜 개수 전달 ⭐⭐⭐
        int likeCount = productService.getLikeCount(id);
        model.addAttribute("likeCount", likeCount);

        return "product_detail";
    }


    /** ============================================
     *  찜 토글 처리 (좋아요 / 좋아요 취소)
     *  ============================================ */
    @PostMapping("/toggleLike")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestBody Map<String, Integer> req,
                                          HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            result.put("status", "login_required");
            return result;
        }

        int userId = user.getUserId();
        int productId = req.get("productId");

        // 찜 토글
        boolean liked = productService.toggleLike(userId, productId);

        // 찜 개수 조회
        int likeCount = productService.getLikeCount(productId);

        // JSON 반환
        result.put("status", "success");
        result.put("liked", liked);
        result.put("likeCount", likeCount);

        return result;
    }





}
