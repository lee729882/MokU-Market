package com.MokU.service;

import java.sql.Timestamp;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MokU.dao.RentProductDAO;
import com.MokU.dao.RentPaymentDAO;
import com.MokU.vo.RentPaymentVO;
import com.MokU.vo.RentProductVO;

@Service
public class RentProductServiceImpl implements RentProductService {

    @Autowired
    private RentProductDAO rentProductDAO;

    @Autowired
    private RentPaymentDAO rentPaymentDAO;   // 🔥 추가 (결제 기록 DAO)

    @Override
    public int getNextRentProductId() {
        return rentProductDAO.getNextRentProductId();
    }

    @Override
    public void insertRentProduct(RentProductVO vo) {
        int newId = rentProductDAO.getNextRentProductId();
        vo.setRentProductId(newId);

        if (vo.getImageData() != null) {
            vo.setImageBlob(vo.getImageData());
        }

        rentProductDAO.insertRentProduct(vo);
    }

    @Override
    public List<RentProductVO> getAllRentProducts() {
        // 🔥 만료된 상품 상태 초기화
        updateExpiredRentals();

        List<RentProductVO> list = rentProductDAO.findAllRentProducts();
        for (RentProductVO p : list) convertImageToBase64(p);

        return list;
    }

    @Override
    public RentProductVO getRentProductById(int rentProductId) {
        RentProductVO vo = rentProductDAO.findRentProductById(rentProductId);
        convertImageToBase64(vo);
        return vo;
    }

    private void convertImageToBase64(RentProductVO vo) {
        if (vo != null && vo.getImageBlob() != null) {
            vo.setBase64Image(Base64.getEncoder().encodeToString(vo.getImageBlob()));
        }
    }

    /** ======================================
     * 🔥 대여 시작 + 결제 기록 저장
     * ====================================== */
    @Override
    public boolean startRental(int rentProductId, String durationType, String buyerName) {

        RentProductVO product = rentProductDAO.findRentProductById(rentProductId);
        if (product == null) return false;

        Timestamp now = new Timestamp(System.currentTimeMillis());
        Timestamp endAt;

        switch (durationType) {
            case "3MIN":   endAt = new Timestamp(now.getTime() + 3 * 60 * 1000); break;
            case "1DAY":   endAt = new Timestamp(now.getTime() + 24 * 60 * 60 * 1000); break;
            case "1MONTH": endAt = new Timestamp(now.getTime() + 30L * 24 * 60 * 60 * 1000); break;
            case "3MONTH": endAt = new Timestamp(now.getTime() + 90L * 24 * 60 * 60 * 1000); break;
            default: return false;
        }

        // 🔥 상품 상태 업데이트 (RENTED)
        int updated = rentProductDAO.updateRentalStatus(rentProductId, "RENTED", endAt);
        if (updated <= 0) return false;

        // ===========================================
        // 🔥 결제 기록 테이블 저장
        // ===========================================
        RentPaymentVO pay = new RentPaymentVO();

        pay.setPaymentId(rentPaymentDAO.getNextPaymentId());
        pay.setRentProductId(product.getRentProductId());
        pay.setBuyerName(buyerName);
        pay.setSellerName(product.getSellerName());
        pay.setPrice(product.getPrice());
        pay.setDurationType(durationType);
        pay.setStartAt(now);
        pay.setEndAt(endAt);
        pay.setStatus("COMPLETED");

        rentPaymentDAO.insertPayment(pay);

        return true;
    }

    /** 삭제 */
    @Override
    public boolean deleteRentProduct(int rentProductId, String sellerName) {

        RentProductVO product = rentProductDAO.findRentProductById(rentProductId);
        if (product == null) return false;

        if ("RENTED".equals(product.getStatus())) return false;

        if (!product.getSellerName().trim().equals(sellerName.trim())) return false;

        int deleted = rentProductDAO.deleteRentProduct(rentProductId, sellerName);
        return deleted > 0;
    }

    /** 만료 체크 */
    @Override
    public boolean isExpired(RentProductVO vo) {
        if (vo.getEndAt() == null) return false;
        return vo.getEndAt().before(new Timestamp(System.currentTimeMillis()));
    }

    /** 남은 시간 계산 */
    @Override
    public String getRemainingTime(RentProductVO vo) {
        if (vo.getEndAt() == null) return "-";

        long diff = vo.getEndAt().getTime() - System.currentTimeMillis();
        if (diff <= 0) return "만료됨";

        long minutes = diff / 1000 / 60;
        long seconds = (diff / 1000) % 60;

        return minutes + "분 " + seconds + "초";
    }

    /** 만료된 상품 자동 초기화 */
    @Override
    public void updateExpiredRentals() {
        List<RentProductVO> list = rentProductDAO.findAllRentProducts();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        for (RentProductVO p : list) {
            if ("RENTED".equals(p.getStatus()) && p.getEndAt() != null) {
                if (p.getEndAt().before(now)) {
                    rentProductDAO.updateRentalStatus(p.getRentProductId(), "AVAILABLE", null);
                }
            }
        }
    }
}
