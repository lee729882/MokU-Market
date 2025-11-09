package com.MokU.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
    public String addForm(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("user", user);
        return "product_form";
    }

    /** ✅ 상품 등록 처리 (다중 이미지 업로드 지원) */
    @PostMapping("/add")
    public String addProduct(@ModelAttribute ProductVO vo,
                             @RequestParam("files") MultipartFile[] files,
                             HttpServletRequest request,
                             HttpSession session) throws IOException {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        vo.setSellerId(user.getUserId()); // moku_user.user_id 참조

        // ✅ 업로드 폴더 경로 지정
        String uploadDir = request.getServletContext().getRealPath("/resources/uploads/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        // ✅ 파일 여러 장 업로드 처리
        List<String> filePaths = new ArrayList<>();
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File dest = new File(uploadDir, fileName);
                file.transferTo(dest);
                filePaths.add("/resources/uploads/" + fileName);
            }
        }

        // ✅ 대표 이미지는 첫 번째 이미지로 지정
        if (!filePaths.isEmpty()) {
            vo.setImagePath(filePaths.get(0));
        }

        productService.insertProduct(vo);
        return "redirect:/product/list?category=" + vo.getCategory();
    }

    /** ✅ 카테고리별 목록 보기 */
    @GetMapping("/list")
    public String listByCategory(@RequestParam("category") String category,
                                 HttpSession session,
                                 Model model) {
        model.addAttribute("products", productService.getProductsByCategory(category));
        model.addAttribute("category", category);

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) model.addAttribute("user", user);
        return "product_list";
    }

    /** ✅ 상품 상세보기 */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id,
                         HttpSession session,
                         Model model) {
        ProductVO product = productService.getProductById(id);
        model.addAttribute("product", product);

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) model.addAttribute("user", user);
        return "product_detail";
    }

    /** ✅ 좋아요 처리 */
    @PostMapping("/like/{id}")
    @ResponseBody
    public String likeProduct(@PathVariable("id") int id) {
        productService.increaseLikeCount(id);
        return "success";
    }
}
