package com.MokU.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.MokU.dao.ProductDAO;
import com.MokU.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;   // ✅ DAO만 사용

    // ================== 기본 기능 ==================
    @Override
    public void insertProduct(ProductVO vo) {
        productDAO.insertProduct(vo);
    }
    
    @Override
    public List<ProductVO> getAllProducts() {
        return productDAO.getAllProducts();
    }

    @Override
    public List<ProductVO> getProductsByCategory(String category) {
        return productDAO.getProductsByCategory(category);
    }

    @Override
    public ProductVO getProductById(int productId) {
        // ⚠️ 여기서 조회수까지 올릴지, 컨트롤러에서만 올릴지 한쪽으로만 쓰시는 게 좋습니다.
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

    // ================== 여러 장 이미지 ==================
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

    /** 4) 여러 장 이미지 전체 교체 (수정 시 사용) */
    @Override
    @Transactional
    public void replaceProductImages(int productId, List<String> imagePaths) {

        // 기존 이미지 전부 삭제
        productDAO.deleteImagesByProductId(productId);

        if (imagePaths == null || imagePaths.isEmpty()) {
            return;
        }

        int order = 1;
        for (String path : imagePaths) {
            if (path == null || path.isEmpty()) continue;
            productDAO.insertProductImage(productId, path, order++);
        }
    }

    // ========== 판매자 전용 기능 (수정 / 판매완료 / 삭제) ==========
    @Override
    @Transactional
    public boolean updateProduct(ProductVO product, int sellerId) {

        // 기존 상품 조회
        ProductVO origin = productDAO.getProductById(product.getProductId());
        if (origin == null) return false;

        // 판매자 본인 확인
        if (origin.getSellerId() != sellerId) return false;

        // 실제 수정 처리 (title/price/description 등은 Mapper에서 처리)
        return productDAO.updateProduct(product) == 1;
    }

    /** ✅ 판매완료 처리 (STATUS = 'SOLD') */
    @Override
    @Transactional
    public boolean markSold(int productId, int sellerId) {
        ProductVO origin = productDAO.getProductById(productId);
        if (origin == null) return false;
        if (origin.getSellerId() != sellerId) return false;

        // ✅ Mapper의 markProductSold() 호출
        productDAO.markProductSold(productId);   // STATUS = 'SOLD'
        return true;
    }

    /** ✅ 판매완료 해제 (다시 판매중, STATUS = 'ON_SALE') */
    @Override
    @Transactional
    public boolean markUnsold(int productId, int sellerId) {
        ProductVO origin = productDAO.getProductById(productId);
        if (origin == null) return false;
        if (origin.getSellerId() != sellerId) return false;

        // ✅ Mapper의 markProductUnsold() 호출
        productDAO.markProductUnsold(productId); // STATUS = 'ON_SALE'
        return true;
    }

    @Override
    @Transactional
    public boolean deleteProduct(int productId, int sellerId) {

        // 1) 기존 상품 조회 및 권한 체크
        ProductVO origin = productDAO.getProductById(productId);
        if (origin == null) return false;
        if (origin.getSellerId() != sellerId) return false;

        // 2) 자식 먼저 삭제 (좋아요 + 이미지)
        productDAO.deleteLikesByProductId(productId);   // FK_LIKES_PRODUCT 해결
        productDAO.deleteImagesByProductId(productId);  // 이미지 테이블도 정리

        // 3) 마지막에 상품 삭제
        int rows = productDAO.deleteById(productId);
        return rows == 1;
    }

    // ========== 마이페이지 조회 ==========
    @Override
    public List<ProductVO> getMyProducts(int sellerId) {
        return productDAO.getProductsBySeller(sellerId);
    }

    @Override
    public List<ProductVO> getMyFavoriteProducts(int userId) {
        return productDAO.getFavoriteProductsByUser(userId);
    }
}
