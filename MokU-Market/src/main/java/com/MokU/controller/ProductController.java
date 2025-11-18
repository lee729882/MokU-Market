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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        model.addAttribute("mode", "add");   // ✅ 등록 모드 구분용
        return "product_form";
    }

    /** ============================================
     *  상품 등록 처리 (여러 장 이미지 저장 포함)
     *  ============================================ */
    @PostMapping("/add")
    public String addProduct(@ModelAttribute ProductVO vo,
                             @RequestParam("files") MultipartFile[] files,
                             HttpServletRequest request,
                             HttpSession session) throws IOException {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        // 판매자 ID 세팅
        vo.setSellerId(user.getUserId());

        // 업로드 폴더
        String uploadDir = request.getServletContext().getRealPath("/upload/product/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        List<String> imagePaths = new ArrayList<>();

        // === 이미지 저장 ===
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File dest = new File(uploadDir, fileName);
                file.transferTo(dest);

                imagePaths.add("/upload/product/" + fileName); // DB 저장용 경로
            }
        }

        // 대표 이미지 설정
        if (!imagePaths.isEmpty()) {
            vo.setImagePath(imagePaths.get(0));
        } else {
            vo.setImagePath("/upload/product/no_image.png");
        }

        // === 상품 먼저 INSERT (productId 생성) ===
        productService.insertProduct(vo);
        int productId = vo.getProductId();  // Oracle selectKey 로 생성된 PK

        // === 여러 장 이미지 insert ===
        if (!imagePaths.isEmpty()) {
            productService.saveProductImages(productId, imagePaths);
        }

        // 카테고리 인코딩 후 Redirect
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

    /** ============================================
     *  상품 상세
     *  ============================================ */
    @GetMapping("/detail")
    public String detail(@RequestParam("id") int id,
                         HttpSession session,
                         Model model) {

        // 조회수 중복 방지
        String viewedKey = "viewed_" + id;
        if (session.getAttribute(viewedKey) == null) {
            productService.increaseViewCount(id);
            session.setAttribute(viewedKey, true);
        }

        ProductVO product = productService.getProductById(id);
        if (product == null) {
            return "redirect:/home";
        }
        model.addAttribute("product", product);

        MemberVO seller = memberService.getMemberById(product.getSellerId());
        model.addAttribute("seller", seller);

        // === 여러 이미지 불러오기 ===
        List<String> imageList = productService.getImagesByProductId(id);
        if (imageList.isEmpty()) {
            imageList.add(product.getImagePath());
        }
        model.addAttribute("images", imageList);

        // 로그인 사용자
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        boolean liked = false;

        if (user != null) {
            liked = productService.isLiked(user.getUserId(), id);
            model.addAttribute("user", user);
        }

        model.addAttribute("liked", liked);

        // 🔥 판매자 전체 찜 수
        int sellerTotalLikes = productService.getTotalLikesBySeller(product.getSellerId());
        model.addAttribute("likeCount", sellerTotalLikes);

        // 🔥 현재 접속자가 이 상품의 판매자인지 여부
        boolean isSeller = (user != null && user.getUserId() == product.getSellerId());
        model.addAttribute("isSeller", isSeller);

        return "product_detail";
    }

    /** ============================================
     *  찜 토글 (AJAX)
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

        // 1) 좋아요 토글
        boolean liked = productService.toggleLike(userId, productId);

        // 2) 이 상품의 판매자 정보 조회
        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            result.put("status", "error");
            return result;
        }

        // 3) 판매자가 받은 전체 찜 수 다시 계산
        int sellerTotalLikes = productService.getTotalLikesBySeller(product.getSellerId());

        // 4) 응답
        result.put("status", "success");
        result.put("liked", liked);
        result.put("likeCount", sellerTotalLikes);  // 판매자 전체 찜 수

        return result;
    }

    /* ====================================================
     *  🔥 판매자 기능 : 수정 / 판매완료 / 숨김 / 삭제
     * ==================================================== */

    /** 상품 수정 폼 (GET) */
    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int productId,
                           HttpSession session,
                           Model model,
                           RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            rttr.addFlashAttribute("msg", "존재하지 않는 상품입니다.");
            return "redirect:/home";
        }

        // 판매자 본인 여부 체크
        if (product.getSellerId() != user.getUserId()) {
            rttr.addFlashAttribute("msg", "수정 권한이 없습니다.");
            return "redirect:/product/detail?id=" + productId;
        }

        model.addAttribute("product", product);
        model.addAttribute("user", user);
        model.addAttribute("mode", "edit");   // JSP에서 등록/수정 구분용

        // 기존 등록 폼 재사용
        return "product_form";
    }

    /** 상품 수정 처리 (POST) */
    @PostMapping("/edit")
    public String editSubmit(@ModelAttribute ProductVO form,
                             HttpSession session,
                             RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        boolean ok = productService.updateProduct(form, user.getUserId());
        if (!ok) {
            rttr.addFlashAttribute("msg", "수정 권한이 없거나 수정에 실패했습니다.");
        } else {
            rttr.addFlashAttribute("msg", "상품 정보가 수정되었습니다.");
        }

        return "redirect:/product/detail?id=" + form.getProductId();
    }

    /** 판매완료로 상태 변경 */
    @GetMapping("/markSold")
    public String markSold(@RequestParam("id") int productId,
                           HttpSession session,
                           RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        boolean ok = productService.markSold(productId, user.getUserId());
        if (!ok) {
            rttr.addFlashAttribute("msg", "판매완료 처리 권한이 없거나 실패했습니다.");
        } else {
            rttr.addFlashAttribute("msg", "판매완료 상태로 변경되었습니다.");
        }

        return "redirect:/product/detail?id=" + productId;
    }

    /** 상품 숨기기 (노출 off) */
    @GetMapping("/hide")
    public String hide(@RequestParam("id") int productId,
                       HttpSession session,
                       RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        boolean ok = productService.hideProduct(productId, user.getUserId());
        if (!ok) {
            rttr.addFlashAttribute("msg", "숨기기 처리 권한이 없거나 실패했습니다.");
        } else {
            rttr.addFlashAttribute("msg", "상품이 목록에서 숨김 처리되었습니다.");
        }

        return "redirect:/product/detail?id=" + productId;
    }

    /** 상품 삭제 */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int productId,
                         HttpSession session,
                         RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        boolean ok = productService.deleteProduct(productId, user.getUserId());
        if (!ok) {
            rttr.addFlashAttribute("msg", "삭제 권한이 없거나 삭제에 실패했습니다.");
            return "redirect:/product/detail?id=" + productId;
        }

        rttr.addFlashAttribute("msg", "상품이 삭제되었습니다.");
        return "redirect:/home";   // 또는 내 상점, 목록 등 원하는 곳으로
    }
}
