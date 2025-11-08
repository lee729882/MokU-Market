package com.MokU.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.MokU.service.ProductService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    /** ✅ 상품 등록 폼 이동 (로그인 사용자 정보 포함) */
    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        // 로그인된 사용자 세션 확인
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        } else {
            // 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        return "product_form"; // JSP 파일 이름
    }

    /** ✅ 상품 등록 처리 */
    @PostMapping("/add")
    public String addProduct(@ModelAttribute ProductVO vo,
                             @RequestParam("files") MultipartFile file,
                             HttpServletRequest request,
                             HttpSession session) throws IOException {

        // 로그인 사용자 세션에서 작성자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
        	vo.setSellerId(user.getUserId());
        }

        // 이미지 업로드 처리
        if (!file.isEmpty()) {
            String uploadDir = request.getServletContext().getRealPath("/resources/uploads/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            File dest = new File(uploadDir, fileName);
            file.transferTo(dest);

            vo.setImagePath("/resources/uploads/" + fileName);
        }

        // 상품 등록
        productService.insertProduct(vo);

        // 등록 후 카테고리별 목록으로 이동
        return "redirect:/product/list?category=" + vo.getCategory();
    }

    /** ✅ 카테고리별 목록 보기 */
    @GetMapping("/list")
    public String listByCategory(@RequestParam("category") String category,
                                 HttpSession session,
                                 Model model) {

        // 1️⃣ 상품 목록, 카테고리 전달
        model.addAttribute("products", productService.getProductsByCategory(category));
        model.addAttribute("category", category);

        // 2️⃣ 로그인 사용자 전달 (헤더 표시용)
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        }

        return "product_list";
    }

    /** ✅ 상품 상세보기 */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id,
                         HttpSession session,
                         Model model) {

        model.addAttribute("product", productService.getProductById(id));

        // 헤더용 사용자 정보 전달
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        }

        return "product_detail";
    }
}
