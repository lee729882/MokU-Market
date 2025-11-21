package com.MokU.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.MokU.service.ChatService;
import com.MokU.service.ProductService;
import com.MokU.vo.ChatMessageVO;
import com.MokU.vo.ChatRoomVO;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ProductVO;

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

    /**
     * 상품 상세에서 "채팅하기" 버튼 클릭
     */
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

        return "chat/chatRoom"; // 이미 쓰고 계신 채팅 JSP
    }


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

        // ✅ roomId 쿼리스트링으로 넘겨서 /chat/room 으로 이동
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

        ChatRoomVO room = chatService.getRoom(roomId);
        if (room == null) {
            rttr.addFlashAttribute("msg", "존재하지 않는 채팅방입니다.");
            return "redirect:/home";
        }

        // 권한 체크
        if (room.getSellerId() != userId && room.getBuyerId() != userId) {
            rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
            return "redirect:/home";
        }

        // ✅ 왼쪽 리스트용 : 내가 참여 중인 모든 채팅방
        List<ChatRoomVO> rooms = chatService.getRoomsByUser(userId);

        // 메시지 목록 + 읽음 처리
        List<ChatMessageVO> messages = chatService.getMessages(roomId, userId);

        // 상단 상품 정보
        ProductVO product = productService.getProductById(room.getProductId());

        // ✅ JSP에서 사용할 이름 맞춰서 세팅
        model.addAttribute("rooms", rooms);          // 왼쪽 리스트
        model.addAttribute("activeRoom", room);      // 현재 방
        model.addAttribute("messages", messages);    // 메시지들
        model.addAttribute("product", product);      // 상품 정보(필요 시)
        model.addAttribute("loginUser", loginUser);  // 로그인 유저

        // /WEB-INF/views/chat/chatRoom.jsp
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

        // 이 상품의 실제 판매자인지 간단히 체크 (선택 사항)
        // ProductService 에서 product 가져와서 sellerId 비교
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
     * 구매자 확정 (상품 판매완료 처리)
     */
    /**
     * 구매자 확정 (상품 판매완료 처리)
     */
    @PostMapping(value = "/confirmBuyer", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> confirmBuyer(@RequestBody Map<String, Object> payload,
                                            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("status", "login_required");
            return result;
        }

        try {
            int roomId    = ((Number) payload.get("roomId")).intValue();
            int productId = ((Number) payload.get("productId")).intValue();

            // 1) 채팅방 조회
            ChatRoomVO room = chatService.getRoom(roomId);
            if (room == null) {
                result.put("status", "error");
                result.put("message", "채팅방을 찾을 수 없습니다.");
                return result;
            }

            // 2) 현재 로그인 사용자가 판매자인지 검증
            int sellerId = loginUser.getUserId();
            if (room.getSellerId() != sellerId) {
                result.put("status", "error");
                result.put("message", "구매자를 확정할 권한이 없습니다.");
                return result;
            }

            // 3) productId 일치 여부(안전 체크)
            if (room.getProductId() != productId) {
                result.put("status", "error");
                result.put("message", "요청한 상품 정보가 올바르지 않습니다.");
                return result;
            }

            // 4) 상품 판매완료 처리 (서비스 시그니처에 맞게 sellerId 함께 전달)
            boolean ok = productService.markSold(productId, sellerId);
            if (!ok) {
                result.put("status", "error");
                result.put("message", "상품 상태를 변경하지 못했습니다.");
                return result;
            }

            result.put("status", "success");
            return result;

        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", "서버 처리 중 오류가 발생했습니다.");
            return result;
        }
    }


}
