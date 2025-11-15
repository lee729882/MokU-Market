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


}
