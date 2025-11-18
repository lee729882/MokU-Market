package com.MokU.service;

import java.util.List;

import com.MokU.vo.ProductVO;

public interface ProductService {

    // ===== 기본 기능 =====
    void insertProduct(ProductVO vo);

    List<ProductVO> getProductsByCategory(String category);

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

    // ===== 판매자 전용(수정 / 판매완료 / 숨김 / 삭제) =====
    boolean updateProduct(ProductVO product, int sellerId);

    boolean markSold(int productId, int sellerId);

    boolean hideProduct(int productId, int sellerId);

    boolean deleteProduct(int productId, int sellerId);
}
