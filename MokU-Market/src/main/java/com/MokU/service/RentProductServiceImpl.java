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
    private RentPaymentDAO rentPaymentDAO;

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

    // ================================
    // 🔥 대여 시작 + 결제 기록 저장
    // ================================
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

        // 상품 상태 업데이트 + renter_name 저장
        int updated = rentProductDAO.updateRentalStatus(
                rentProductId,
                "RENTED",
                endAt,
                buyerName
        );
        if (updated <= 0) return false;

        // 결제 기록 저장
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

    @Override
    public boolean deleteRentProduct(int rentProductId, String sellerName) {

        RentProductVO product = rentProductDAO.findRentProductById(rentProductId);
        if (product == null) return false;

        if ("RENTED".equals(product.getStatus())) return false;
        if (!product.getSellerName().trim().equals(sellerName.trim())) return false;

        int deleted = rentProductDAO.deleteRentProduct(rentProductId, sellerName);
        return deleted > 0;
    }

    @Override
    public boolean isExpired(RentProductVO vo) {
        if (vo.getEndAt() == null) return false;
        return vo.getEndAt().before(new Timestamp(System.currentTimeMillis()));
    }

    @Override
    public String getRemainingTime(RentProductVO vo) {
        if (vo.getEndAt() == null) return "-";

        long diff = vo.getEndAt().getTime() - System.currentTimeMillis();
        if (diff <= 0) return "만료됨";

        long minutes = diff / 1000 / 60;
        long seconds = (diff / 1000) % 60;

        return minutes + "분 " + seconds + "초";
    }

    @Override
    public void updateExpiredRentals() {

        List<RentProductVO> list = rentProductDAO.findAllRentProducts();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        for (RentProductVO p : list) {
            if ("RENTED".equals(p.getStatus()) && p.getEndAt() != null) {
                if (p.getEndAt().before(now)) {
                    rentProductDAO.updateRentalStatus(
                            p.getRentProductId(),
                            "AVAILABLE",
                            null,
                            null  // renter_name 초기화
                    );
                }
            }
        }
    }

    @Override
    public List<RentProductVO> getProductsIGave(String sellerName) {
        List<RentProductVO> list = rentProductDAO.findProductsIGave(sellerName);
        for (RentProductVO p : list) convertImageToBase64(p);
        return list;
    }

    @Override
    public List<RentProductVO> getProductsIRented(String renterName) {
        List<RentProductVO> list = rentProductDAO.findProductsIRented(renterName);
        for (RentProductVO p : list) convertImageToBase64(p);
        return list;
    }

    @Override
    public int getMonthlyEarned(String sellerName) {
        return rentPaymentDAO.getMonthlyEarned(sellerName);
    }

    @Override
    public int getMonthlySpent(String buyerName) {
        return rentPaymentDAO.getMonthlySpent(buyerName);
    }

    // ======================================================
    // 🔥 [⭐ 달력 통계를 위해 반드시 필요한 기능]
    // ======================================================
    @Override
    public List<RentPaymentVO> getMonthlyPayments(String name, int year, int month) {
        return rentPaymentDAO.findPaymentsInMonth(name, year, month);
    }
}
