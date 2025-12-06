package com.MokU.dao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.MokU.vo.RentProductVO;

public interface RentProductDAO {

    int getNextRentProductId();

    void insertRentProduct(RentProductVO vo);

    List<RentProductVO> findAllRentProducts();

    RentProductVO findRentProductById(int rentProductId);

    /** 대여 상태 + 종료시간 + 대여자 업데이트 */
    int updateRentalStatus(
        @Param("rentProductId") int rentProductId,
        @Param("status") String status,
        @Param("endAt") Timestamp endAt,
        @Param("renterName") String renterName
    );

    /** 상품 삭제 */
    int deleteRentProduct(
        @Param("productId") int productId,
        @Param("sellerName") String sellerName
    );
    
    List<RentProductVO> findProductsIGave(@Param("sellerName") String sellerName);

    List<RentProductVO> findProductsIRented(@Param("renterName") String renterName);

}