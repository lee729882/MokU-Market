package com.MokU.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
    public int isLiked(@Param("userId") int userId, @Param("productId") int productId);
    public void addLike(@Param("userId") int userId, @Param("productId") int productId);
    public void removeLike(@Param("userId") int userId, @Param("productId") int productId);
    public void increaseLikeCount(int productId);
    public void decreaseLikeCount(int productId);

}