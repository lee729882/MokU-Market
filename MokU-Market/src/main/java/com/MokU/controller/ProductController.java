package com.MokU.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.MokU.service.ChatService;
import com.MokU.service.MemberService;
import com.MokU.service.ProductService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private ChatService chatService;

    /* ============================================
     *  상품 등록 폼 이동
     * ============================================ */
    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("mode", "add");   // 등록 모드
        return "product_form";
    }

    /* ============================================
     *  상품 등록 처리 (여러 장 이미지 저장 포함)
     * ============================================ */
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

        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                // ✅ 최대 5장(대표 1 + 서브 4)까지만 허용
                if (imagePaths.size() >= 5) break;

                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File dest = new File(uploadDir, fileName);
                file.transferTo(dest);

                imagePaths.add("/upload/product/" + fileName);
            }
        }

        // 대표 이미지 설정
        if (!imagePaths.isEmpty()) {
            vo.setImagePath(imagePaths.get(0));
        } else {
            vo.setImagePath("/upload/product/no_image.png");
        }

        // 상품 INSERT (PK 생성)
        productService.insertProduct(vo);
        int productId = vo.getProductId();

        // 여러 장 이미지 INSERT
        if (!imagePaths.isEmpty()) {
            productService.saveProductImages(productId, imagePaths);
        }

        // 카테고리 인코딩 후 목록으로
        String encodedCategory = URLEncoder.encode(vo.getCategory(), StandardCharsets.UTF_8);
        return "redirect:/product/list?category=" + encodedCategory;
    }

    /* ============================================
     *  카테고리별 목록
     * ============================================ */
    @GetMapping("/list")
    public String list(
            @RequestParam(value = "category", required = false) String category,
            HttpSession session,
            Model model) {

        // 로그인 사용자
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        }

        List<ProductVO> products;

        // 중고거래 = 전체보기
        if (category == null || category.trim().isEmpty() || "중고거래".equals(category)) {
            products = productService.getAllProducts();
            category = "전체보기";
        } else {
            products = productService.getProductsByCategory(category);
        }

        model.addAttribute("products", products);
        model.addAttribute("category", category);

        return "product_list";
    }

    /* ============================================
     *  상품 상세
     *  - 조회수 증가
     *  - 최근 본 상품 세션 저장
     * ============================================ */
    /* ============================================
     *  상품 상세
     *  - ?productId= 또는 ?id= 둘 다 허용
     * ============================================ */
    @GetMapping("/detail")
    public String detail(
            @RequestParam(value = "productId", required = false) Integer productId,
            @RequestParam(value = "id",        required = false) Integer id,
            HttpSession session,
            Model model) {

        // 1) id / productId 중 실제 값 결정
        Integer pid = (productId != null) ? productId : id;
        if (pid == null) {
            // 둘 다 없으면 홈으로 돌려보냄 (400 대신 사용자 친화적으로 처리)
            return "redirect:/home";
        }

        // ✅ 조회수 중복 방지
        String viewedKey = "viewed_" + pid;
        if (session.getAttribute(viewedKey) == null) {
            productService.increaseViewCount(pid);
            session.setAttribute(viewedKey, true);
        }

        ProductVO product = productService.getProductById(pid);
        if (product == null) {
            return "redirect:/home";
        }
        model.addAttribute("product", product);

        MemberVO seller = memberService.getMemberById(product.getSellerId());
        model.addAttribute("seller", seller);

        // 여러 이미지
        List<String> imageList = productService.getImagesByProductId(pid);
        if (imageList == null || imageList.isEmpty()) {
            imageList = new ArrayList<>();
            String mainImage = product.getImagePath();
            if (mainImage != null && !mainImage.trim().isEmpty()) {
                imageList.add(mainImage);
            }
        }
        model.addAttribute("images", imageList);

        // 로그인 / 찜 여부
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        boolean liked = false;
        if (user != null) {
            liked = productService.isLiked(user.getUserId(), pid);
            model.addAttribute("user", user);
        }
        model.addAttribute("liked", liked);

        // 판매자 전체 찜 수
        int sellerTotalLikes = productService.getTotalLikesBySeller(product.getSellerId());
        model.addAttribute("likeCount", sellerTotalLikes);

        // 현재 접속자가 판매자인지 여부
        boolean isSeller = (user != null && user.getUserId() == product.getSellerId());
        model.addAttribute("isSeller", isSeller);

        // ✅ 최근 본 상품 세션에 추가 (List로 단순 처리)
        @SuppressWarnings("unchecked")
        List<ProductVO> recentList =
                (List<ProductVO>) session.getAttribute("recentProducts");
        if (recentList == null) {
            recentList = new ArrayList<>();
        }

        // 중복 제거
        recentList.removeIf(p -> p.getProductId() == pid);

        // 맨 앞에 추가
        recentList.add(0, product);

        // 최대 5개만 유지
        if (recentList.size() > 5) {
            recentList = recentList.subList(0, 5);
        }

        session.setAttribute("recentProducts", recentList);

        return "product_detail";
    }


    /* ============================================
     *  상품 수정 폼 이동 (판매자만)
     * ============================================ */
    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int productId,
                           HttpSession session,
                           Model model) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }

        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            return "redirect:/home";
        }

        // 판매자 본인만 수정 가능
        if (product.getSellerId() != user.getUserId()) {
            return "redirect:/product/detail?productId=" + productId;
        }

        model.addAttribute("user", user);
        model.addAttribute("product", product);
        model.addAttribute("mode", "edit");

        // 여러 장 이미지 리스트
        List<String> imageList = productService.getImagesByProductId(productId);
        if (imageList == null || imageList.isEmpty()) {
            imageList = new ArrayList<>();
            if (product.getImagePath() != null) {
                imageList.add(product.getImagePath());
            }
        }
        model.addAttribute("images", imageList);

        return "product_form";
    }

    /* ============================================
     *  상품 수정 처리
     * ============================================ */
    @PostMapping("/edit")
    public String editProduct(
            @ModelAttribute ProductVO product,
            @RequestParam(value = "files", required = false) List<MultipartFile> files,
            HttpSession session,
            HttpServletRequest request
    ) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        int sellerId = user.getUserId();
        product.setSellerId(sellerId);

        int productId = product.getProductId();

        // 기존 상품 조회 (권한/대표이미지 확인)
        ProductVO original = productService.getProductById(productId);
        if (original == null || original.getSellerId() != sellerId) {
            return "redirect:/product/detail?productId=" + productId;
        }

        // 새 이미지 업로드 여부 체크
        boolean hasNewImage =
                (files != null
                        && !files.isEmpty()
                        && files.stream().anyMatch(f -> f != null && !f.isEmpty()));

        List<String> imagePaths = new ArrayList<>();

        if (hasNewImage) {
            String uploadDir = request.getServletContext().getRealPath("/upload/product/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) continue;

                String originalName = file.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String savedName = uuid + "_" + originalName;

                File dest = new File(uploadDir, savedName);
                file.transferTo(dest);

                String webPath = "/upload/product/" + savedName;
                imagePaths.add(webPath);
            }

            if (!imagePaths.isEmpty()) {
                product.setImagePath(imagePaths.get(0));   // 새 대표 이미지
            } else {
                product.setImagePath(original.getImagePath());
            }

        } else {
            // 새 이미지가 없다면 기존 대표 이미지 유지
            product.setImagePath(original.getImagePath());
        }

        // 기본 상품 정보 수정
        boolean updated = productService.updateProduct(product, sellerId);
        if (!updated) {
            return "redirect:/product/detail?productId=" + productId;
        }

        // 새 이미지가 있을 때만 PRODUCT_IMAGES 전체 교체
        if (hasNewImage && !imagePaths.isEmpty()) {
            productService.replaceProductImages(productId, imagePaths);
        }

        return "redirect:/product/detail?productId=" + productId;
    }

    /* ============================================
     *  찜 토글 (AJAX)
     * ============================================ */
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

        boolean liked = productService.toggleLike(userId, productId);

        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            result.put("status", "error");
            return result;
        }

        int sellerTotalLikes = productService.getTotalLikesBySeller(product.getSellerId());

        result.put("status", "success");
        result.put("liked", liked);
        result.put("likeCount", sellerTotalLikes);

        return result;
    }

    /* ============================================
     *  판매완료 / 판매완료 해제 / 삭제
     * ============================================ */

    /** 판매완료로 상태 변경 (STATUS = 'SOLD') */
    @GetMapping(value = "/markSold", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String markSold(@RequestParam("id") int productId,
                           HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            return "로그인이 필요합니다.";
        }

        boolean ok = productService.markSold(productId, user.getUserId());
        if (!ok) {
            return "판매완료 처리 권한이 없거나 실패했습니다.";
        }
        return "판매완료 상태로 변경되었습니다.";
    }

    /** 판매완료 해제 → 다시 판매중 (STATUS = 'ONSALE') */
    @GetMapping(value = "/markUnsold", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String markUnsold(@RequestParam("id") int productId,
                             HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            return "로그인이 필요합니다.";
        }

        boolean ok = productService.markUnsold(productId, user.getUserId());
        if (!ok) {
            return "판매완료 해제 권한이 없거나 실패했습니다.";
        }

        // 해당 상품 관련 채팅방 거래 상태/구매자 정보 초기화
        chatService.resetTradeStatusByProduct(productId);

        return "판매완료 상태가 해제되어 다시 판매중으로 변경되었습니다.";
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
            return "redirect:/product/detail?productId=" + productId;
        }

        rttr.addFlashAttribute("msg", "상품이 삭제되었습니다.");
        return "redirect:/home";
    }
}
