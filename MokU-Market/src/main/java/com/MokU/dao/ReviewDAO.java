package com.MokU.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.MokU.vo.ReviewVO;

public interface ReviewDAO {

    void insertReview(ReviewVO vo);

    void updateReview(ReviewVO vo);

    ReviewVO findByDealAndWriter(@Param("dealId") int dealId,
                                 @Param("writerId") int writerId);

    // 내가 받은 리뷰
    List<ReviewVO> findReceivedReviews(@Param("userId") int userId);

    // 내가 쓴 리뷰
    List<ReviewVO> findWrittenReviews(@Param("userId") int userId);
}
