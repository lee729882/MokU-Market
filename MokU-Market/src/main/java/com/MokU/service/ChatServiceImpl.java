package com.MokU.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.MokU.dao.ChatDAO;
import com.MokU.vo.ChatMessageVO;
import com.MokU.vo.ChatRoomVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ChatServiceImpl implements ChatService {

    @Autowired
    private ChatDAO chatDAO;

    @Override
    @Transactional
    public ChatRoomVO createOrGetRoom(int productId, int sellerId, int buyerId) {

        Map<String, Object> params = new HashMap<>();
        params.put("productId", productId);
        params.put("sellerId", sellerId);
        params.put("buyerId",  buyerId);

        // 이미 있는 방인지 확인
        ChatRoomVO room = chatDAO.findRoomByParticipants(params);
        if (room != null) {
            return room;
        }

        // 없으면 새로 생성
        ChatRoomVO newRoom = new ChatRoomVO();
        newRoom.setProductId(productId);
        newRoom.setSellerId(sellerId);
        newRoom.setBuyerId(buyerId);

        chatDAO.createRoom(newRoom);

        // 생성된 roomId 로 다시 조회 (상품 정보까지 JOIN된 버전)
        return chatDAO.findRoomById(newRoom.getRoomId());
    }

    @Override
    public ChatRoomVO getRoom(int roomId) {
        return chatDAO.findRoomById(roomId);
    }

    @Override
    public List<ChatRoomVO> getRoomsByUser(int userId) {
        return chatDAO.findRoomsByUser(userId);
    }

    /**
     * 방 입장 시: 메시지 목록 가져오면서, 상대가 보낸 미읽 메시지는 읽음 처리
     */
    @Override
    @Transactional
    public List<ChatMessageVO> getMessages(int roomId, int userId) {

        Map<String, Object> params = new HashMap<>();
        params.put("roomId", roomId);
        params.put("userId", userId);

        // 안 읽은 것 읽음 처리
        chatDAO.markMessagesAsRead(params);

        // 전체 메시지 목록
        return chatDAO.getMessagesByRoom(roomId);
    }

    /**
     * 메시지 전송: insert + 방의 마지막 메시지 내용/시간 업데이트
     */
    @Override
    @Transactional
    public ChatMessageVO sendMessage(int roomId, int senderId, String content) {

        ChatMessageVO msg = new ChatMessageVO();
        msg.setRoomId(roomId);
        msg.setSenderId(senderId);
        msg.setContent(content);

        chatDAO.insertMessage(msg);   // SEQ로 messageId 채워짐

        Map<String, Object> params = new HashMap<>();
        params.put("roomId", roomId);
        params.put("lastMessage", content);
        chatDAO.updateRoomLastMessage(params);

        return msg;
    }

    @Override
    public int countTotalUnread(int userId) {
        return chatDAO.countTotalUnread(userId);
    }

    @Override
    public int getTotalUnreadCount(int userId) {
        return chatDAO.countUnreadByUser(userId);
    }
    
    @Override
    public List<ChatRoomVO> getRoomsByProduct(int productId) {
        return chatDAO.findRoomsByProduct(productId);
    }

    /* 🔹 trade_status 한 번에 변경 (최소 수정 버전) */
    @Override
    @Transactional
    public void updateTradeStatus(int roomId, String tradeStatus) {
        chatDAO.updateTradeStatus(roomId, tradeStatus);
    }
}
