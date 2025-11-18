package com.MokU.service;

import java.util.List;
import com.MokU.vo.ProductVO;

public interface ProductService {

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

    /* ============================
       ★★ 여러 장 상품 이미지 추가 기능
       ============================ */

    // 1) 상품 이미지 INSERT
    void insertProductImage(int productId, String imagePath, int orders);

    // 2) 상품별 이미지 목록 조회
    List<String> getImagesByProductId(int productId);

    // 3) 상품 등록 시 여러 장 이미지 저장
    void saveProductImages(int productId, List<String> imagePaths);
    
    int getTotalLikesBySeller(int sellerId);   // 🔥 추가

}
