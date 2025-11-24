package com.MokU.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.MokU.vo.ProductVO;

@Mapper
public interface ProductDAO {

    // 기본 기능
    void insertProduct(ProductVO vo);

    List<ProductVO> getProductsByCategory(@Param("category") String category);

    ProductVO getProductById(@Param("productId") int productId);

    void increaseViewCount(@Param("productId") int productId);

    int isLiked(@Param("userId") int userId,
                @Param("productId") int productId);

    void addLike(@Param("userId") int userId,
                 @Param("productId") int productId);

    void removeLike(@Param("userId") int userId,
                    @Param("productId") int productId);

    void increaseLikeCount(@Param("productId") int productId);

    void decreaseLikeCount(@Param("productId") int productId);


    // ⭐ 여러 장 이미지 기능
    void insertProductImage(@Param("productId") int productId,
                            @Param("imagePath") String imagePath,
                            @Param("orders") int orders);

    List<String> getImagesByProductId(@Param("productId") int productId);


    // ⭐ 판매자 관련 기능
    int getTotalLikesBySeller(@Param("sellerId") int sellerId);

    int updateProduct(ProductVO product);   // POJO 하나라 @Param 불필요

    // ❌ updateHiddenYn 는 완전히 삭제 (사용 안 함)

    int deleteById(@Param("productId") int productId);

    // ✅ 자식 테이블 삭제용 메서드
    int deleteLikesByProductId(@Param("productId") int productId);
    int deleteImagesByProductId(@Param("productId") int productId);

    List<ProductVO> getAllProducts();

    // ✅ 판매자 기준 상품 조회
    List<ProductVO> getProductsBySeller(@Param("sellerId") int sellerId);

    // ✅ 유저가 찜한 상품 조회
    List<ProductVO> getFavoriteProductsByUser(@Param("userId") int userId);

    /** ✅ 해당 상품을 판매완료 상태로 변경 */
    void markProductSold(@Param("productId") int productId);

    /** ✅ 해당 상품을 판매완료 해제(판매중) 상태로 변경 */
    void markProductUnsold(@Param("productId") int productId);
    
 // 찜 많은 순 TOP N
    List<ProductVO> findTopByFavoriteCount(@Param("limit") int limit);

    // 조회수 많은 순 TOP N
    List<ProductVO> findTopByViewCount(@Param("limit") int limit);

    // 상품별 찜 개수 조회
    int getLikeCountForProduct(@Param("productId") int productId);

    // 내가 등록한 상품 개수
    int getMyProductsCount(@Param("userId") int userId);

    // 내가 찜한 상품 개수
    int getMyFavoriteProductsCount(@Param("userId") int userId);
}
