package com.MokU.service;

import java.util.List;

import com.MokU.dao.ReviewDAO;
import com.MokU.vo.ReviewVO;

public interface ReviewService {

    // 채팅방 기준 내 후기 1건 조회
    ReviewVO getMyReview(int dealId, int writerId);

    // 저장/수정
    void writeReview(ReviewVO vo);
    void editReview(ReviewVO vo);

    // 마이페이지용 목록
    List<ReviewVO> getReceivedReviews(int userId);
    List<ReviewVO> getWrittenReviews(int userId);
    
    List<ReviewVO> getReviewsForMember(int memberId);

}
