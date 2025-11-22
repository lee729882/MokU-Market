package com.MokU.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.MokU.dao.ReviewDAO;
import com.MokU.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDAO reviewDAO;

    @Override
    public ReviewVO getMyReview(int dealId, int writerId) {
        return reviewDAO.findByDealAndWriter(dealId, writerId);
    }

    @Override
    @Transactional
    public void writeReview(ReviewVO vo) {
        reviewDAO.insertReview(vo);
    }

    @Override
    @Transactional
    public void editReview(ReviewVO vo) {
        reviewDAO.updateReview(vo);
    }

    // ✅ 내가 받은 후기 목록 (상대가 나를 평가한 것)
    @Override
    @Transactional(readOnly = true)
    public List<ReviewVO> getReceivedReviews(int userId) {
        return reviewDAO.findReceivedReviews(userId);
    }

    // ✅ 내가 작성한 후기 목록
    @Override
    @Transactional(readOnly = true)
    public List<ReviewVO> getWrittenReviews(int userId) {
        return reviewDAO.findWrittenReviews(userId);
    }
}
