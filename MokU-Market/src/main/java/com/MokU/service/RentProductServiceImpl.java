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

    /** PK 생성 */
    @Override
    public int getNextRentProductId() {
        return rentProductDAO.getNextRentProductId();
    }

    /** 상품 등록 */
    @Override
    public void insertRentProduct(RentProductVO vo) {

        // 1) PK 생성
        int newId = rentProductDAO.getNextRentProductId();
        vo.setRentProductId(newId);

        // 2) imageData → imageBlob 필드로 전달 (DB 컬럼명 맞추기)
        if (vo.getImageData() != null) {
            vo.setImageBlob(vo.getImageData());
        }

        // 3) DB 저장
        rentProductDAO.insertRentProduct(vo);
    }

    /** 전체 상품 조회 */
    @Override
    public List<RentProductVO> getAllRentProducts() {
        List<RentProductVO> list = rentProductDAO.findAllRentProducts();

        // 이미지 Base64 변환 → JSP 오류 방지
        for (RentProductVO p : list) {
            convertImageToBase64(p);
        }
        return list;
    }

    /** 단일 상품 조회 */
    @Override
    public RentProductVO getRentProductById(int rentProductId) {
        RentProductVO vo = rentProductDAO.findRentProductById(rentProductId);
        convertImageToBase64(vo);
        return vo;
    }

    /** Base64 변환 함수 */
    private void convertImageToBase64(RentProductVO vo) {
        if (vo != null && vo.getImageBlob() != null) {
            String base64 = Base64.getEncoder().encodeToString(vo.getImageBlob());
            vo.setBase64Image(base64);
        }
    }

    /** 대여 시작 처리 */
    @Override
    public boolean startRental(int rentProductId, String durationType) {

        // 종료 시간 계산
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Timestamp endAt = null;

        switch (durationType) {
            case "1H":
                endAt = new Timestamp(now.getTime() + 60 * 60 * 1000);
                break;
            case "3H":
                endAt = new Timestamp(now.getTime() + 3 * 60 * 60 * 1000);
                break;
            case "1D":
                endAt = new Timestamp(now.getTime() + 24 * 60 * 60 * 1000);
                break;
            default:
                return false;
        }

        // DB 업데이트 실행
        int updated = rentProductDAO.updateRentalStatus(rentProductId, "RENTED", endAt);

        return updated > 0;
    }
    
    //상품 삭제
    @Override
    public boolean deleteRentProduct(int rentProductId, String sellerName) {
        RentProductVO product = rentProductDAO.findRentProductById(rentProductId);

        if (product == null) return false;

        if (!product.getSellerName().equals(sellerName)) {
            return false;
        }

        int deleted = rentProductDAO.deleteRentProduct(rentProductId, sellerName);
        return deleted > 0;
    }

    
}
