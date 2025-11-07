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
    public ProductVO getProductById(int id) {
        return productDAO.getProductById(id);
    }
}
