package com.MokU.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.MokU.vo.ChatRoomVO;
import com.MokU.vo.ChatMessageVO;

public interface ChatDAO {

    int createRoom(ChatRoomVO vo);

    ChatRoomVO findRoomById(int roomId);

    ChatRoomVO findRoomByParticipants(Map<String, Object> params);

    List<ChatRoomVO> findRoomsByUser(int userId);

    int insertMessage(ChatMessageVO vo);

    List<ChatMessageVO> getMessagesByRoom(int roomId);

    int countUnreadMessages(Map<String, Object> params);

    int markMessagesAsRead(Map<String, Object> params);

    int updateRoomLastMessage(Map<String, Object> params);
    
    int countTotalUnread(int userId);
    
    int countUnreadByUser(int userId);
    
    List<ChatRoomVO> findRoomsByProduct(@Param("productId") int productId);


}
