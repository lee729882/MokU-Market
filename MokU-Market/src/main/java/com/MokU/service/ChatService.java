package com.MokU.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.MokU.vo.ChatMessageVO;
import com.MokU.vo.ChatRoomVO;

public interface ChatService {

    // 상품 상세에서 채팅 시작 (이미 있으면 재사용)
    ChatRoomVO createOrGetRoom(int productId, int sellerId, int buyerId);

    // roomId로 방 조회 (상품 정보 JOIN된 버전)
    ChatRoomVO getRoom(int roomId);

    // 사용자 기준 참여 중인 채팅방 목록
    List<ChatRoomVO> getRoomsByUser(int userId);

    // 방 입장 시 메시지 목록 + 읽음 처리
    List<ChatMessageVO> getMessages(int roomId, int userId);

    // 메시지 보내기 (DB insert + 마지막 메시지 갱신 후, 방금 저장된 메시지 리턴)
    ChatMessageVO sendMessage(int roomId, int senderId, String content);
    
    // 전체 미읽음 (기존)
    int countTotalUnread(int userId);

    int getTotalUnreadCount(int userId);

    // 상품 기준 채팅방 목록
    List<ChatRoomVO> getRoomsByProduct(int productId);

    /* 🔹 거래 상태 변경 (NONE / REQUESTED / CONFIRMED 등)
       - Controller 에서 trade_status 문자열만 넘겨서 최소 수정으로 사용 */
    void updateTradeStatus(int roomId, String tradeStatus);
    
    void resetTradeStatusByProduct(int productId);
    
    // ✅ 채팅방 삭제 (참여자만 가능)
    void deleteRoom(int roomId, int loginUserId);

    void deleteAllByProductId(int productId);

}
