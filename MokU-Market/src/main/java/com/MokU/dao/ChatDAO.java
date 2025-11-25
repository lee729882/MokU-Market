package com.MokU.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.MokU.vo.ChatRoomVO;
import com.MokU.vo.ChatMessageVO;

public interface ChatDAO {

    // ===== 채팅방 관련 =====
    int createRoom(ChatRoomVO vo);

    ChatRoomVO findRoomById(int roomId);

    ChatRoomVO findRoomByParticipants(Map<String, Object> params);

    List<ChatRoomVO> findRoomsByUser(@Param("userId") int userId);

    List<ChatRoomVO> findRoomsByProduct(@Param("productId") int productId);

    // 🔸 거래 상태 변경 (NONE / REQUESTED / CONFIRMED 등)
    void updateTradeStatus(@Param("roomId") int roomId,
                           @Param("tradeStatus") String tradeStatus);

    // ===== 메시지 관련 =====
    int insertMessage(ChatMessageVO vo);

    List<ChatMessageVO> getMessagesByRoom(int roomId);

    int countUnreadMessages(Map<String, Object> params);

    int markMessagesAsRead(Map<String, Object> params);

    int updateRoomLastMessage(Map<String, Object> params);

    // ===== 미읽음 카운트 =====
    int countTotalUnread(@Param("userId") int userId);

    int countUnreadByUser(@Param("userId") int userId);
    
    void resetTradeStatusByProduct(@Param("productId") int productId);

    void deleteMessagesByRoom(int roomId);

    void deleteRoom(int roomId);

    ChatRoomVO findRoomWithOpponent(Map<String, Object> param);  // ← 추가

}
