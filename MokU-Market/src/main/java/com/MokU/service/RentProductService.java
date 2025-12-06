package com.MokU.service;

import java.util.List;
import com.MokU.vo.RentProductVO;

public interface RentProductService {

    void insertRentProduct(RentProductVO vo);

    List<RentProductVO> getAllRentProducts();

    RentProductVO getRentProductById(int rentProductId);

    // 🔥 PK 생성용 메서드 추가
    int getNextRentProductId();
    boolean startRental(int rentProductId, String durationType);
    
    boolean deleteRentProduct(int productId, String sellerName);//상품 삭제 기능

    boolean isExpired(RentProductVO vo);            // 대여 종료 여부 판단
    String getRemainingTime(RentProductVO vo);      // 남은 시간 계산
    void updateExpiredRentals();                    // 만료된 상품 자동 초기화

}
