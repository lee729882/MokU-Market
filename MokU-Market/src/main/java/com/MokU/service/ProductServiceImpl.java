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
    public void increaseLikeCount(int productId) {
        productDAO.increaseLikeCount(productId);
    }
}
