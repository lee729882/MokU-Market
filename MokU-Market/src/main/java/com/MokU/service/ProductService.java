package com.MokU.service;

import java.util.List;
import com.MokU.vo.ProductVO;

public interface ProductService {

    // ===== 기본 기능 =====
    void insertProduct(ProductVO vo);

    List<ProductVO> getProductsByCategory(String category);

    List<ProductVO> getAllProducts();

    ProductVO getProductById(int productId);

    void increaseViewCount(int productId);

    boolean isLiked(int userId, int productId);

    void addLike(int userId, int productId);

    void removeLike(int userId, int productId);

    void increaseLikeCount(int productId);

    void decreaseLikeCount(int productId);

    boolean toggleLike(int userId, int productId);

    int getLikeCount(int productId);

    // ===== 여러 장 이미지 =====
    void insertProductImage(int productId, String imagePath, int orders);

    List<String> getImagesByProductId(int productId);

    void saveProductImages(int productId, List<String> imagePaths);

    int getTotalLikesBySeller(int sellerId);

    // ===== 판매자 전용(수정 / 판매완료 / 삭제) =====
    boolean updateProduct(ProductVO product, int sellerId);

    /** ✅ 판매완료 처리 (STATUS = 'SOLD') */
    boolean markSold(int productId, int sellerId);

    /** ✅ 판매완료 해제, 다시 판매중 (STATUS = 'ONSALE') */
    boolean markUnsold(int productId, int sellerId);

    boolean deleteProduct(int productId, int sellerId);

    // 여러 장 이미지 전체 교체 (수정 시 사용)
    void replaceProductImages(int productId, List<String> imagePaths);

    /* =========================================
       ✅ 마이페이지용 조회 기능
       ========================================= */

    // 내가 등록한 상품(판매자 기준)
    List<ProductVO> getMyProducts(int sellerId);

    // 내가 찜한 상품(좋아요 기준)
    List<ProductVO> getMyFavoriteProducts(int userId);
}
