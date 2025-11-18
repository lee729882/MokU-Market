package com.MokU.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MokU.dao.ProductDAO;
import com.MokU.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    @Override
    public void insertProduct(ProductVO vo) {
        productDAO.insertProduct(vo);
    }

    @Override
    public List<ProductVO> getProductsByCategory(String category) {
        return productDAO.getProductsByCategory(category);
    }

    @Override
    public ProductVO getProductById(int productId) {
        // ✅ 상세보기 시 자동으로 조회수 +1
        productDAO.increaseViewCount(productId);
        return productDAO.getProductById(productId);
    }

    @Override
    public void increaseViewCount(int productId) {
        productDAO.increaseViewCount(productId);
    }

    @Override
    public boolean isLiked(int userId, int productId) {
        return productDAO.isLiked(userId, productId) > 0;
    }

    @Override
    public void addLike(int userId, int productId) {
        productDAO.addLike(userId, productId);
    }

    @Override
    public void removeLike(int userId, int productId) {
        productDAO.removeLike(userId, productId);
    }

    @Override
    public void increaseLikeCount(int productId) {
        productDAO.increaseLikeCount(productId);
    }

    @Override
    public void decreaseLikeCount(int productId) {
        productDAO.decreaseLikeCount(productId);
    }

    @Override
    public boolean toggleLike(int userId, int productId) {

        int check = productDAO.isLiked(userId, productId);

        if (check > 0) {
            productDAO.removeLike(userId, productId);
            productDAO.decreaseLikeCount(productId);
            return false; // 좋아요 해제
        } else {
            productDAO.addLike(userId, productId);
            productDAO.increaseLikeCount(productId);
            return true; // 좋아요 추가
        }
    }

    @Override
    public int getLikeCount(int productId) {
        ProductVO product = productDAO.getProductById(productId);
        return product.getLikeCount();
    }

    /* ====================================================
        🔥🔥 여러 장 이미지 기능 추가된 부분 (3개) 🔥🔥
       ==================================================== */

    /** 1) 단일 이미지 저장 */
    @Override
    public void insertProductImage(int productId, String imagePath, int orders) {
        productDAO.insertProductImage(productId, imagePath, orders);
    }

    /** 2) 상품 이미지 목록 조회 */
    @Override
    public List<String> getImagesByProductId(int productId) {
        return productDAO.getImagesByProductId(productId);
    }

    /** 3) 하나의 상품에 여러 장 이미지 저장 처리 */
    @Override
    public void saveProductImages(int productId, List<String> imagePaths) {
        int order = 1;

        for (String path : imagePaths) {
            productDAO.insertProductImage(productId, path, order);
            order++;
        }
    }
    @Override
    public int getTotalLikesBySeller(int sellerId) {
        return productDAO.getTotalLikesBySeller(sellerId);
    }
}
