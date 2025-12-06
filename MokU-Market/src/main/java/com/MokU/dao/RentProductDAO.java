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

    int updateRentalStatus(
            @Param("rentProductId") int rentProductId,
            @Param("status") String status,
            @Param("endAt") Timestamp endAt
    );
    
    /** 상품 삭제 */
    int deleteRentProduct(@Param("productId") int productId,
            @Param("sellerName") String sellerName);

}
