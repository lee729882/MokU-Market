package com.MokU.service;

import java.util.List;

import com.MokU.dao.ReviewDAO;
import com.MokU.vo.ReviewVO;

public interface ReviewService {

    ReviewVO getMyReview(int dealId, int writerId);

    void writeReview(ReviewVO vo);   // 신규 작성

    void editReview(ReviewVO vo);    // 수정
    
    List<ReviewVO> getReceivedReviews(int userId); // 상대가 나에 대해 쓴 것
    List<ReviewVO> getWrittenReviews(int userId);  // 내가 남긴 것
}
