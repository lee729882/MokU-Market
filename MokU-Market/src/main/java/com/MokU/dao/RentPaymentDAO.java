package com.MokU.dao;

import java.util.List;
import com.MokU.vo.RentPaymentVO;

public interface RentPaymentDAO {

    int getNextPaymentId();

    void insertPayment(RentPaymentVO vo);

    // 특정 사용자가 구매한 결제 기록 조회
    List<RentPaymentVO> getPaymentsByBuyer(String buyerName);

    // 이번달 매출 (내가 번 돈)
    Integer getMonthlyEarned(String sellerName);

    // 이번달 지출 (내가 쓴 돈)
    Integer getMonthlySpent(String buyerName);

    // 📌 날짜별 통계용 — 특정 연/월 전체 결제 내역 반환
    List<RentPaymentVO> findPaymentsInMonth(
        String name, 
        int year, 
        int month
    );

    // 📌 하루 단위 데이터(수익 + 지출 합산) 달력 표시용
    List<RentPaymentVO> findDailyPayments(
        String name,
        int year,
        int month
    );
}
