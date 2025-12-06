package com.MokU.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
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
import com.MokU.service.ReportService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;
import com.MokU.vo.ReportVO;

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

import com.MokU.service.RentProductService;
import com.MokU.vo.RentProductVO;




@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private ChatService chatService;

    @Autowired
    private ReportService reportService;

    
    /* ============================================
     *  �긽�뭹 �벑濡� �뤌 �씠�룞
     * ============================================ */
    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("mode", "add");   // �벑濡� 紐⑤뱶
        return "product_form";
    }

    /* ============================================
     *  �긽�뭹 �벑濡� 泥섎━ (�뿬�윭 �옣 �씠誘몄� ���옣 �룷�븿)
     * ============================================ */
    @PostMapping("/add")
    public String addProduct(@ModelAttribute ProductVO vo,
                             @RequestParam("files") MultipartFile[] files,
                             HttpServletRequest request,
                             HttpSession session) throws IOException {
        System.out.println("=== /product/add �샇異� ===");
        System.out.println("files is null? " + (files == null));
        if (files != null) {
            System.out.println("files.length = " + files.length);
            for (int i = 0; i < files.length; i++) {
                MultipartFile f = files[i];
                System.out.println("  [" + i + "] name=" + f.getName()
                        + ", original=" + f.getOriginalFilename()
                        + ", empty=" + f.isEmpty());
            }
        }
        MemberVO user = (MemberVO) session.getAttribute("loginUser");

        if (user == null) return "redirect:/login";

        // �뙋留ㅼ옄 ID �꽭�똿
        vo.setSellerId(user.getUserId());

        // �뾽濡쒕뱶 �뤃�뜑
        String uploadDir = request.getServletContext().getRealPath("/upload/product/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        List<String> imagePaths = new ArrayList<>();

        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                // �쐟 理쒕� 5�옣(���몴 1 + �꽌釉� 4)源뚯�留� �뿀�슜
                if (imagePaths.size() >= 5) break;

                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File dest = new File(uploadDir, fileName);
                file.transferTo(dest);

                imagePaths.add("/upload/product/" + fileName);
            }
        }

        // ���몴 �씠誘몄� �꽕�젙
        if (!imagePaths.isEmpty()) {
            vo.setImagePath(imagePaths.get(0));
        } else {
            vo.setImagePath("/upload/product/no_image2.png");
        }

        // �긽�뭹 INSERT (PK �깮�꽦)
        productService.insertProduct(vo);
        int productId = vo.getProductId();

        // �뿬�윭 �옣 �씠誘몄� INSERT
        if (!imagePaths.isEmpty()) {
            productService.saveProductImages(productId, imagePaths);
        }

        // 移댄뀒怨좊━ �씤肄붾뵫 �썑 紐⑸줉�쑝濡�
        String encodedCategory = URLEncoder.encode(vo.getCategory(), StandardCharsets.UTF_8);
        return "redirect:/product/list?category=" + encodedCategory;
    }

    /* ============================================
     *  移댄뀒怨좊━蹂� 紐⑸줉
     * ============================================ */
    @GetMapping("/list")
    public String list(
            @RequestParam(value = "category", required = false) String category,
            HttpSession session,
            Model model) {

        // 濡쒓렇�씤 �궗�슜�옄
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("user", user);
        }

        List<ProductVO> products;

        // 以묎퀬嫄곕옒 = �쟾泥대낫湲�
        if (category == null || category.trim().isEmpty() || "以묎퀬嫄곕옒".equals(category)) {
            products = productService.getAllProducts();
            category = "�쟾泥대낫湲�";
        } else {
            products = productService.getProductsByCategory(category);
        }

        model.addAttribute("products", products);
        model.addAttribute("category", category);

        return "product_list";
    }

    /* ============================================
     *  �긽�뭹 �긽�꽭
     *  - 議고쉶�닔 利앷�
     *  - 理쒓렐 蹂� �긽�뭹 �꽭�뀡 ���옣
     * ============================================ */
    /* ============================================
     *  �긽�뭹 �긽�꽭
     *  - ?productId= �삉�뒗 ?id= �몮 �떎 �뿀�슜
     * ============================================ */
    @GetMapping("/detail")
    public String detail(
            @RequestParam(value = "productId", required = false) Integer productId,
            @RequestParam(value = "id",        required = false) Integer id,
            HttpSession session,
            Model model) {

        // 1) id / productId 以� �떎�젣 媛� 寃곗젙
        Integer pid = (productId != null) ? productId : id;
        if (pid == null) {
            // �몮 �떎 �뾾�쑝硫� �솃�쑝濡� �룎�젮蹂대깂 (400 ���떊 �궗�슜�옄 移쒗솕�쟻�쑝濡� 泥섎━)
            return "redirect:/home";
        }

        // �쐟 議고쉶�닔 以묐났 諛⑹�
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

        // �뿬�윭 �씠誘몄�
        List<String> imageList = productService.getImagesByProductId(pid);
        if (imageList == null || imageList.isEmpty()) {
            imageList = new ArrayList<>();
            String mainImage = product.getImagePath();
            if (mainImage != null && !mainImage.trim().isEmpty()) {
                imageList.add(mainImage);
            }
        }
        model.addAttribute("images", imageList);

        // 濡쒓렇�씤 / 李� �뿬遺�
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        boolean liked = false;
        if (user != null) {
            liked = productService.isLiked(user.getUserId(), pid);
            model.addAttribute("user", user);
        }
        model.addAttribute("liked", liked);

        // �뙋留ㅼ옄 �쟾泥� 李� �닔
        int sellerTotalLikes = productService.getTotalLikesBySeller(product.getSellerId());
        model.addAttribute("likeCount", sellerTotalLikes);

        // �쁽�옱 �젒�냽�옄媛� �뙋留ㅼ옄�씤吏� �뿬遺�
        boolean isSeller = (user != null && user.getUserId() == product.getSellerId());
        model.addAttribute("isSeller", isSeller);

        // �쐟 理쒓렐 蹂� �긽�뭹 �꽭�뀡�뿉 異붽� (List濡� �떒�닚 泥섎━)
        @SuppressWarnings("unchecked")
        List<ProductVO> recentList =
                (List<ProductVO>) session.getAttribute("recentProducts");
        if (recentList == null) {
            recentList = new ArrayList<>();
        }

        // 以묐났 �젣嫄�
        recentList.removeIf(p -> p.getProductId() == pid);

        // 留� �븵�뿉 異붽�
        recentList.add(0, product);

        // 理쒕� 5媛쒕쭔 �쑀吏�
        if (recentList.size() > 5) {
            recentList = recentList.subList(0, 5);
        }

        session.setAttribute("recentProducts", recentList);

        // �긽�뭹�뿉 ���븳 李� 媛쒖닔 議고쉶
        int likeCount = productService.getTotalLikesByProduct(pid);
        model.addAttribute("likeCount", likeCount);  // 李� 媛쒖닔 紐⑤뜽�뿉 異붽�
        

        // ✅ 이미 신고했는지 여부 계산 (로그인 + 판매자가 아닌 경우만)
        boolean alreadyReported = false;
        if (user != null && user.getUserId() != product.getSellerId()) {
            alreadyReported = reportService.hasReportedProduct(user.getUserId(), pid);
        }
        model.addAttribute("alreadyReported", alreadyReported);

        
        return "product_detail";
    }


    /* ============================================
     *  �긽�뭹 �닔�젙 �뤌 �씠�룞 (�뙋留ㅼ옄留�)
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

        // �뙋留ㅼ옄 蹂몄씤留� �닔�젙 媛��뒫
        if (product.getSellerId() != user.getUserId()) {
            return "redirect:/product/detail?productId=" + productId;
        }

        model.addAttribute("user", user);
        model.addAttribute("product", product);
        model.addAttribute("mode", "edit");

        // �뿬�윭 �옣 �씠誘몄� 由ъ뒪�듃
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
     *  �긽�뭹 �닔�젙 泥섎━
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

        // 湲곗〈 �긽�뭹 議고쉶 (沅뚰븳/���몴�씠誘몄� �솗�씤)
        ProductVO original = productService.getProductById(productId);
        if (original == null || original.getSellerId() != sellerId) {
            return "redirect:/product/detail?productId=" + productId;
        }

        // �깉 �씠誘몄� �뾽濡쒕뱶 �뿬遺� 泥댄겕
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
                product.setImagePath(imagePaths.get(0));   // �깉 ���몴 �씠誘몄�
            } else {
                product.setImagePath(original.getImagePath());
            }

        } else {
            // �깉 �씠誘몄�媛� �뾾�떎硫� 湲곗〈 ���몴 �씠誘몄� �쑀吏�
            product.setImagePath(original.getImagePath());
        }

        // 湲곕낯 �긽�뭹 �젙蹂� �닔�젙
        boolean updated = productService.updateProduct(product, sellerId);
        if (!updated) {
            return "redirect:/product/detail?productId=" + productId;
        }

        // �깉 �씠誘몄�媛� �엳�쓣 �븣留� PRODUCT_IMAGES �쟾泥� 援먯껜
        if (hasNewImage && !imagePaths.isEmpty()) {
            productService.replaceProductImages(productId, imagePaths);
        }

        return "redirect:/product/detail?productId=" + productId;
    }

    /* ============================================
     *  李� �넗湲� (AJAX)
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

        // 醫뗭븘�슂 �넗湲�
        boolean liked = productService.toggleLike(userId, productId);

        // �긽�뭹 議고쉶
        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            result.put("status", "error");
            return result;
        }

        // �빐�떦 �긽�뭹�뿉 ���븳 李� 媛쒖닔 議고쉶
        int likeCount = productService.getTotalLikesByProduct(productId);

        result.put("status", "success");
        result.put("liked", liked);
        result.put("likeCount", likeCount);  // �쁽�옱 �긽�뭹�뿉 ���븳 李� 媛쒖닔留� 媛깆떊

        return result;
    }

    /* ============================================
     *  �뙋留ㅼ셿猷� / �뙋留ㅼ셿猷� �빐�젣 / �궘�젣
     * ============================================ */

    /** �뙋留ㅼ셿猷뚮줈 �긽�깭 蹂�寃� (STATUS = 'SOLD') */
    @GetMapping(value = "/markSold", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String markSold(@RequestParam("id") int productId,
                           HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            return "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.";
        }

        boolean ok = productService.markSold(productId, user.getUserId());
        if (!ok) {
            return "�뙋留ㅼ셿猷� 泥섎━ 沅뚰븳�씠 �뾾嫄곕굹 �떎�뙣�뻽�뒿�땲�떎.";
        }
        return "�뙋留ㅼ셿猷� �긽�깭濡� 蹂�寃쎈릺�뿀�뒿�땲�떎.";
    }

    /** �뙋留ㅼ셿猷� �빐�젣 �넂 �떎�떆 �뙋留ㅼ쨷 (STATUS = 'ONSALE') */
    @GetMapping(value = "/markUnsold", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String markUnsold(@RequestParam("id") int productId,
                             HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            return "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.";
        }

        boolean ok = productService.markUnsold(productId, user.getUserId());
        if (!ok) {
            return "�뙋留ㅼ셿猷� �빐�젣 沅뚰븳�씠 �뾾嫄곕굹 �떎�뙣�뻽�뒿�땲�떎.";
        }

        // �빐�떦 �긽�뭹 愿��젴 梨꾪똿諛� 嫄곕옒 �긽�깭/援щℓ�옄 �젙蹂� 珥덇린�솕
        chatService.resetTradeStatusByProduct(productId);

        return "�뙋留ㅼ셿猷� �긽�깭媛� �빐�젣�릺�뼱 �떎�떆 �뙋留ㅼ쨷�쑝濡� 蹂�寃쎈릺�뿀�뒿�땲�떎.";
    }

    /** �긽�뭹 �궘�젣 */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int productId,
                         HttpSession session,
                         RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            rttr.addFlashAttribute("msg", "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.");
            return "redirect:/login";
        }

        boolean ok = productService.deleteProduct(productId, user.getUserId());
        if (!ok) {
            rttr.addFlashAttribute("msg", "�궘�젣 沅뚰븳�씠 �뾾嫄곕굹 �궘�젣�뿉 �떎�뙣�뻽�뒿�땲�떎.");
            return "redirect:/product/detail?productId=" + productId;
        }

        rttr.addFlashAttribute("msg", "�긽�뭹�씠 �궘�젣�릺�뿀�뒿�땲�떎.");
        return "redirect:/home";
    }
 // �긽�뭹�뿉 ���븳 李� 媛쒖닔 諛섑솚
    @GetMapping("/likeCount")
    @ResponseBody
    public Map<String, Object> getLikeCount(@RequestParam("productId") int productId) {
        Map<String, Object> result = new HashMap<>();

        // �긽�뭹 議고쉶
        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            result.put("status", "error");
            return result;
        }

        // �빐�떦 �긽�뭹�뿉 ���븳 李� 媛쒖닔 議고쉶
        int likeCount = productService.getTotalLikesByProduct(productId);
        result.put("status", "success");
        result.put("likeCount", likeCount);

        return result;
    }

    	
    @PostMapping("/report")
    @ResponseBody
    public Map<String, Object> reportProduct(@RequestBody Map<String, String> payload,
                                             HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 로그인 유저 확인
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }

        try {
            int productId    = Integer.parseInt(payload.get("productId"));
            String reasonType   = payload.get("reasonType");    // FRAUD, ABUSE 등 코드
            String reasonDetail = payload.get("reasonDetail");  // 사용자가 입력한 상세 사유

            int reporterId = loginUser.getUserId();

            // ✅ 1) 이미 이 상품을 신고했는지 체크
            if (reportService.hasReportedProduct(reporterId, productId)) {
                result.put("status", "duplicated");
                result.put("message", "이미 해당 상품을 신고하셨습니다.");
                return result;
            }

            // 상품 정보 (판매자 ID 얻기 위해)
            ProductVO product = productService.getProductById(productId);
            if (product == null) {
                result.put("status", "error");
                result.put("message", "존재하지 않는 상품입니다.");
                return result;
            }

            // ✅ 2) 신고 저장
            ReportVO vo = new ReportVO();
            vo.setReporterId(reporterId);
            vo.setTargetUserId(product.getSellerId());
            vo.setProductId(productId);
            vo.setPostId(null);           // 상품 신고이므로 비움
            vo.setChatRoomId(null);       // 필요 시 채팅방 ID 세팅
            vo.setReasonType(reasonType);
            vo.setDescription(reasonDetail);
            vo.setStatus("NEW");

            reportService.saveReport(vo);

            result.put("status", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", "신고 처리 중 오류가 발생했습니다.");
        }

        return result;
    }
    
    @Autowired
    private RentProductService rentProductService;


    /* ============================================
     *  렌탈 상품 목록
     * ============================================ */
   
    @GetMapping("/rent")
    public String rentProductList(Model model, HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");

        List<RentProductVO> rentProducts = rentProductService.getAllRentProducts();

        model.addAttribute("products", rentProducts);
        model.addAttribute("loginUser", user);   // ⭐ 추가

        return "product/rent";
    }





    /* ============================================
     *  렌탈 상품 등록 페이지
     * ============================================ */
    @GetMapping("/rent/add")
    public String showRentAddPage(HttpSession session, Model model) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);

        return "product/rent_add";
    }


    /* ============================================
     *  렌탈 상품 등록 처리
     * ============================================ */
    @PostMapping("/rent/add")
    public String addRentProduct(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("durationType") String durationType,
            @RequestParam("price") int price,
            @RequestParam("file") MultipartFile file,
            HttpSession session) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        RentProductVO vo = new RentProductVO();

     // seller_id 저장 (DB 컬럼과 일치)
      vo.setSellerName(user.getName());


     // 나머지 필드
     vo.setTitle(title);
     vo.setDescription(description);
     vo.setDurationType(durationType);
     vo.setPrice(price);
     vo.setStatus("AVAILABLE");
     vo.setCreatedAt(new Timestamp(System.currentTimeMillis()));

     // 이미지 업로드
     if (file != null && !file.isEmpty()) {
         vo.setImageData(file.getBytes());
     }

     // 서비스 호출
     rentProductService.insertRentProduct(vo);


        return "redirect:/product/rent";
    }




	//상품 삭제
  //상품 삭제
  //상품 삭제
    @PostMapping("/rent/delete")
    public String deleteRentProduct(@RequestParam("productId") int productId,
                                    HttpSession session,
                                    RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");

        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        String sellerName = user.getName().trim();
        boolean result = rentProductService.deleteRentProduct(productId, sellerName);

        if (result) {
            rttr.addFlashAttribute("msg", "상품이 삭제되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "본인이 등록한 상품만 삭제할 수 있습니다.");
        }

        return "redirect:/product/rent";
    }

    @PostMapping("/rent/start")
    public String startRent(
            @RequestParam("productId") int productId,
            @RequestParam("durationType") String durationType,
            HttpSession session,
            RedirectAttributes rttr) {

        MemberVO user = (MemberVO) session.getAttribute("loginUser");

        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        boolean result = rentProductService.startRental(productId, durationType);

        if (!result) {
            rttr.addFlashAttribute("msg", "이미 대여중인 상품입니다.");
        } else {
            rttr.addFlashAttribute("msg", "대여가 시작되었습니다!");
        }

        return "redirect:/product/rent";
    }






    


}
