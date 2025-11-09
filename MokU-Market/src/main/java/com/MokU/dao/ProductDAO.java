package com.MokU.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.MokU.vo.ProductVO;

@Mapper
public interface ProductDAO {

    // ✅ 상품 등록
    void insertProduct(ProductVO vo);

    // ✅ 카테고리별 상품 목록
    List<ProductVO> getProductsByCategory(String category);

    // ✅ 상품 상세보기
    ProductVO getProductById(int productId);

    // ✅ 조회수 증가
    void increaseViewCount(int productId);

    // ✅ 좋아요(찜) 증가
    void increaseLikeCount(int productId);
}