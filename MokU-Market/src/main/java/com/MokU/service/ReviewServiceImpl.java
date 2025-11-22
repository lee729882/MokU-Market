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
    public void writeReview(ReviewVO vo) {
        reviewDAO.insertReview(vo);
    }

    @Override
    public void editReview(ReviewVO vo) {
        reviewDAO.updateReview(vo);
    }

    @Override
    public List<ReviewVO> getReceivedReviews(int userId) {
        List<ReviewVO> list = reviewDAO.findReceivedReviews(userId);
        System.out.println("✅ [ReviewService] received size = " + (list == null ? 0 : list.size()));
        return list;
    }

    @Override
    public List<ReviewVO> getWrittenReviews(int userId) {
        List<ReviewVO> list = reviewDAO.findWrittenReviews(userId);
        System.out.println("✅ [ReviewService] written size = " + (list == null ? 0 : list.size()));
        return list;
    }
}
