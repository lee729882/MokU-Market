package com.MokU.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.MokU.vo.ProductVO;

@Mapper
public interface ProductDAO {
    void insertProduct(ProductVO vo);
    List<ProductVO> getProductsByCategory(String category);
    ProductVO getProductById(int id);
}
