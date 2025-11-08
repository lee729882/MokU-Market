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

    /** ✅ 상품 등록 폼 이동 */
    @GetMapping("/add")
    public String addForm() {
        return "product_form";
    }

    /** ✅ 상품 등록 처리 */
    @PostMapping("/add")
    public String addProduct(@ModelAttribute ProductVO vo,
                             @RequestParam("file") MultipartFile file,
                             HttpServletRequest request) throws IOException {

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

        productService.insertProduct(vo);
        return "redirect:/product/list?category=" + vo.getCategory();
    }

    /** ✅ 카테고리별 목록 보기 */
    @GetMapping("/list")
    public String listByCategory(@RequestParam("category") String category,
                                 HttpSession session, Model model) {

        // ✅ 1. 상품 목록과 카테고리 전달
        model.addAttribute("products", productService.getProductsByCategory(category));
        model.addAttribute("category", category);

        // ✅ 2. 로그인한 사용자 정보 JSP로 전달
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        }

        return "product_list"; // ✅ JSP 파일 이름 그대로 유지
    }

    /** ✅ 상세보기 */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id, Model model) {
        model.addAttribute("product", productService.getProductById(id));
        return "product_detail";
    }
}
