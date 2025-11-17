package com.MokU.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.MokU.vo.ProductVO;

@Mapper
public interface ProductDAO {

    // 기본 기능
    void insertProduct(ProductVO vo);

    List<ProductVO> getProductsByCategory(@Param("category") String category);

    ProductVO getProductById(@Param("productId") int productId);

    void increaseViewCount(@Param("productId") int productId);

    int isLiked(@Param("userId") int userId,
                @Param("productId") int productId);

    void addLike(@Param("userId") int userId,
                 @Param("productId") int productId);

    void removeLike(@Param("userId") int userId,
                    @Param("productId") int productId);

    void increaseLikeCount(@Param("productId") int productId);

    void decreaseLikeCount(@Param("productId") int productId);


    // ⭐ 여러 장 이미지 기능
    void insertProductImage(@Param("productId") int productId,
                            @Param("imagePath") String imagePath,
                            @Param("orders") int orders);

    List<String> getImagesByProductId(@Param("productId") int productId);
}
