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

}
