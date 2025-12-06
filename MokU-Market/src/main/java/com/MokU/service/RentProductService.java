package com.MokU.service;

import java.util.List;
import com.MokU.vo.RentPaymentVO;
import com.MokU.vo.RentProductVO;

public interface RentProductService {

    /** 상품 등록 */
    void insertRentProduct(RentProductVO vo);

    /** 전체 상품 조회 */
    List<RentProductVO> getAllRentProducts();

    /** 하나 조회 */
    RentProductVO getRentProductById(int rentProductId);

    /** PK 생성 */
    int getNextRentProductId();

    /** 대여 시작 + 결제기록 저장 */
    boolean startRental(int productId, String durationType, String buyerName);

    /** 상품 삭제 */
    boolean deleteRentProduct(int productId, String sellerName);

    /** 만료 여부 / 남은 시간 */
    boolean isExpired(RentProductVO vo);
    String getRemainingTime(RentProductVO vo);
    void updateExpiredRentals();

    /** 내가 빌려준 / 빌린 상품 조회 */
    List<RentProductVO> getProductsIGave(String sellerName);
    List<RentProductVO> getProductsIRented(String renterName);

    /** 이번달 전체 수익/지출 */
    int getMonthlyEarned(String sellerName);
    int getMonthlySpent(String buyerName);

    /** 🔥 하루별 기록을 위해 필요한 이번달 결제 전체 리스트 */
    List<RentPaymentVO> getMonthlyPayments(String name, int year, int month);
}
