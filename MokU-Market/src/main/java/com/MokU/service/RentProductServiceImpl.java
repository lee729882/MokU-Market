package com.MokU.service;

import java.sql.Timestamp;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MokU.dao.RentProductDAO;
import com.MokU.vo.RentProductVO;

@Service
public class RentProductServiceImpl implements RentProductService {

    @Autowired
    private RentProductDAO rentProductDAO;

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
        // 🔥 ① 먼저 만료된 상품들을 AVAILABLE 상태로 초기화
        updateExpiredRentals();

        List<RentProductVO> list = rentProductDAO.findAllRentProducts();
        for (RentProductVO p : list) {
            convertImageToBase64(p);
        }
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
            String base64 = Base64.getEncoder().encodeToString(vo.getImageBlob());
            vo.setBase64Image(base64);
        }
    }

    /** 대여 시작 */
    @Override
    public boolean startRental(int rentProductId, String durationType) {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Timestamp endAt;

        switch (durationType) {
        case "3MIN":
            endAt = new Timestamp(now.getTime() + 3 * 60 * 1000);
            break;

        case "1DAY":
            endAt = new Timestamp(now.getTime() + 24 * 60 * 60 * 1000);
            break;

        case "1MONTH":
            endAt = new Timestamp(now.getTime() + 30L * 24 * 60 * 60 * 1000);
            break;

        case "3MONTH":
            endAt = new Timestamp(now.getTime() + 90L * 24 * 60 * 60 * 1000);
            break;

        default:
            return false;
    }


        int updated = rentProductDAO.updateRentalStatus(rentProductId, "RENTED", endAt);
        return updated > 0;
    }

    /** 삭제 */
    @Override
    public boolean deleteRentProduct(int rentProductId, String sellerName) {

        RentProductVO product = rentProductDAO.findRentProductById(rentProductId);
        if (product == null) return false;

        // 🔥 RENTED면 삭제 불가
        if ("RENTED".equals(product.getStatus())) return false;

        if (!product.getSellerName().trim().equals(sellerName.trim())) {
            return false;
        }

        int deleted = rentProductDAO.deleteRentProduct(rentProductId, sellerName);
        return deleted > 0;
    }

    /* ===========================================================
     *   🔥  새로 구현된 기능들
     * =========================================================== */

    /** 만료되었는지 확인 */
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
