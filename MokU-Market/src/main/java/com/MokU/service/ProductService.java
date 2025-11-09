package com.MokU.service;

import java.util.List;
import com.MokU.vo.ProductVO;

public interface ProductService {

    void insertProduct(ProductVO vo);

    List<ProductVO> getProductsByCategory(String category);

    ProductVO getProductById(int productId);

    void increaseViewCount(int productId);

    void increaseLikeCount(int productId);
}
