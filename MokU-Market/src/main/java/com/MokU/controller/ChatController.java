package com.MokU.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.MokU.service.ChatService;
import com.MokU.service.ProductService;
import com.MokU.service.ReviewService;      // ✅ 추가
import com.MokU.vo.ChatMessageVO;
import com.MokU.vo.ChatRoomVO;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;
import com.MokU.vo.ReviewVO;               // ✅ 추가

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;   // ✅ 추가

    /**
     * 채팅 아이콘 클릭 시 진입 – 방 리스트만 먼저 보여줌
     */
    @GetMapping
    public String chatHome(HttpSession session,
                           Model model,
                           RedirectAttributes rttr) {

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        int userId = loginUser.getUserId();

        // 내가 참여 중인 모든 채팅방 목록
        List<ChatRoomVO> rooms = chatService.getRoomsByUser(userId);

        model.addAttribute("rooms", rooms);
        model.addAttribute("activeRoom", null); // 처음 진입 시 선택된 방 없음
        model.addAttribute("messages", null);
        model.addAttribute("loginUser", loginUser);

        return "chat/chatRoom";
    }

    /**
     * 상품 상세에서 "채팅하기" 버튼 클릭
     */
    @GetMapping("/start")
    public String startChat(@RequestParam("productId") int productId,
                            HttpSession session,
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

        int sellerId = product.getSellerId();
        int buyerId = user.getUserId();

        // 본인 상품이면 채팅 시작 X
        if (sellerId == buyerId) {
            return "redirect:/product/detail?id=" + productId;
        }

        ChatRoomVO room = chatService.createOrGetRoom(productId, sellerId, buyerId);

        return "redirect:/chat/room?roomId=" + room.getRoomId();
    }

    /**
     * 특정 채팅방 화면
     */
    @GetMapping("/room")
    public String viewRoom(@RequestParam("roomId") int roomId,
                           HttpSession session,
                           Model model,
                           RedirectAttributes rttr) {

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }
        int userId = loginUser.getUserId();

        ChatRoomVO room = chatService.getRoomWithOpponent(roomId, userId);
        if (room == null) {
            rttr.addFlashAttribute("msg", "존재하지 않는 채팅방입니다.");
            return "redirect:/home";
        }

        // 권한 체크
        if (room.getSellerId() != userId && room.getBuyerId() != userId) {
            rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
            return "redirect:/home";
        }

        // 왼쪽 리스트용 : 내가 참여 중인 모든 채팅방
        List<ChatRoomVO> rooms = chatService.getRoomsByUser(userId);

        // 메시지 목록 + 읽음 처리
        List<ChatMessageVO> messages = chatService.getMessages(roomId, userId);

        // 상단 상품 정보
        ProductVO product = productService.getProductById(room.getProductId());

        // ✅ 이 거래(roomId)에 대해 내가 쓴 후기 1건 조회
        ReviewVO myReview = reviewService.getMyReview(roomId, userId);
        boolean hasReview = (myReview != null);

        model.addAttribute("rooms", rooms);
        model.addAttribute("activeRoom", room);
        model.addAttribute("messages", messages);
        model.addAttribute("product", product);
        model.addAttribute("loginUser", loginUser);

        // ✅ 후기 정보 전달 (JSP에서 '후기 남기기' / '수정하기' 분기용)
        model.addAttribute("myReview", myReview);
        model.addAttribute("hasReview", hasReview);

        return "chat/chatRoom";
    }

    /**
     * 메시지 전송 (AJAX)
     */
    @PostMapping(value = "/room/send", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> sendMessage(@RequestParam("roomId") int roomId,
                                           @RequestParam("content") String content,
                                           HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) {
            result.put("status", "login_required");
            return result;
        }
        int userId = user.getUserId();

        if (content == null || content.trim().isEmpty()) {
            result.put("status", "error");
            result.put("message", "메시지 내용을 입력해 주세요.");
            return result;
        }

        ChatMessageVO msg = chatService.sendMessage(roomId, userId, content.trim());

        result.put("status", "success");
        result.put("message", msg);
        return result;
    }

    /**
     * 상품 기준 채팅방 목록 조회 (판매자가 판매완료 누를 때 사용)
     */
    @GetMapping(value = "/rooms/by-product", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> getRoomsByProduct(@RequestParam("productId") int productId,
                                                 HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }

        ProductVO product = productService.getProductById(productId);
        if (product == null || product.getSellerId() != loginUser.getUserId()) {
            result.put("status", "forbidden");
            return result;
        }

        List<ChatRoomVO> rooms = chatService.getRoomsByProduct(productId);
        result.put("status", "success");
        result.put("rooms", rooms);

        return result;
    }

    /**
     * 판매자가 구매자 선택 (거래 요청 상태로 변경)
     */
    @PostMapping(value = "/confirmBuyer", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> confirmBuyer(@RequestBody Map<String, Object> body,
                                            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }

        Integer roomIdObj    = (Integer) body.get("roomId");
        Integer productIdObj = (Integer) body.get("productId");

        if (roomIdObj == null || productIdObj == null) {
            result.put("status", "error");
            result.put("message", "잘못된 요청입니다.");
            return result;
        }

        int roomId    = roomIdObj;
        int productId = productIdObj;

        ChatRoomVO room = chatService.getRoom(roomId);
        if (room == null || room.getProductId() != productId) {
            result.put("status", "error");
            result.put("message", "채팅방 정보를 찾을 수 없습니다.");
            return result;
        }

        if (room.getSellerId() != loginUser.getUserId()) {
            result.put("status", "forbidden");
            result.put("message", "판매자만 구매자를 선택할 수 있습니다.");
            return result;
        }

        chatService.updateTradeStatus(roomId, "REQUESTED");

        result.put("status", "success");
        return result;
    }

    /**
     * 구매자가 거래 확정 (상품 SOLD 처리)
     */
    @PostMapping(value = "/confirmTradeByBuyer", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> confirmTradeByBuyer(@RequestBody Map<String, Object> body,
                                                   HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }

        Integer roomIdObj    = (Integer) body.get("roomId");
        Integer productIdObj = (Integer) body.get("productId");

        if (roomIdObj == null || productIdObj == null) {
            result.put("status", "error");
            result.put("message", "잘못된 요청입니다.");
            return result;
        }

        int roomId    = roomIdObj;
        int productId = productIdObj;

        ChatRoomVO room = chatService.getRoom(roomId);
        if (room == null || room.getProductId() != productId) {
            result.put("status", "error");
            result.put("message", "채팅방 정보를 찾을 수 없습니다.");
            return result;
        }

        if (room.getBuyerId() != loginUser.getUserId()) {
            result.put("status", "forbidden");
            result.put("message", "구매자만 거래를 확정할 수 있습니다.");
            return result;
        }

        if (!"REQUESTED".equals(room.getTradeStatus())) {
            result.put("status", "error");
            result.put("message", "판매자가 아직 거래 확정을 요청하지 않았습니다.");
            return result;
        }

        ProductVO product = productService.getProductById(productId);
        if (product == null) {
            result.put("status", "error");
            result.put("message", "상품 정보를 찾을 수 없습니다.");
            return result;
        }
        if ("SOLD".equals(product.getStatus())) {
            result.put("status", "error");
            result.put("message", "이미 판매완료된 상품입니다.");
            return result;
        }

        chatService.updateTradeStatus(roomId, "CONFIRMED");
        productService.markSold(productId, room.getSellerId());

        result.put("status", "success");
        return result;
    }

    /**
     * 채팅방 삭제 (참여자만 가능)
     */
    @PostMapping(value = "/room/delete", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> deleteRoom(@RequestParam("roomId") int roomId,
                                          HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }

        try {
            chatService.deleteRoom(roomId, loginUser.getUserId());
            result.put("status", "success");
        } catch (IllegalStateException e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", "채팅방 삭제 중 오류가 발생했습니다.");
        }

        return result;
    }

    /* ======================= 후기 작성 / 수정 ======================= */

    /**
     * 후기 저장 (이미 있으면 수정, 없으면 새로 작성)
     * body: { dealId: roomId, rating: 5, content: "좋은 거래였어요" }
     */
    @PostMapping(value = "/review/save", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> saveReview(@RequestBody Map<String, Object> body,
                                          HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }
        int writerId = loginUser.getUserId();

        Integer dealIdObj   = (Integer) body.get("dealId");   // = roomId
        Integer ratingObj   = (Integer) body.get("rating");
        String  content     = (String)  body.get("content");

        if (dealIdObj == null || content == null) {
            result.put("status", "error");
            result.put("message", "잘못된 요청입니다.");
            return result;
        }

        int dealId = dealIdObj;
        Integer rating = ratingObj;   // null 허용

        // 거래(채팅방) 정보 확인
        ChatRoomVO room = chatService.getRoom(dealId);
        if (room == null) {
            result.put("status", "error");
            result.put("message", "거래 정보를 찾을 수 없습니다.");
            return result;
        }

        // 이 거래의 상대방 ID
        int targetId = (writerId == room.getSellerId()) ? room.getBuyerId() : room.getSellerId();

        // 기존에 내가 쓴 후기 있는지 확인
        ReviewVO existing = reviewService.getMyReview(dealId, writerId);

        if (existing == null) {
            // 새로 작성
            ReviewVO vo = new ReviewVO();
            vo.setDealId(dealId);
            vo.setWriterId(writerId);
            vo.setTargetId(targetId);
            vo.setRating(rating);
            vo.setContent(content);

            reviewService.writeReview(vo);
        } else {
            // 수정 (악용 방지 로직은 여기에서 시간 제한 등 추가 가능)
            existing.setRating(rating);
            existing.setContent(content);
            reviewService.editReview(existing);
        }

        result.put("status", "success");
        return result;
    }
}
