package com.MokU.mapper;

import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardLikeMapper {
    int exists(Map<String, Object> map);
    void insert(Map<String, Object> map);
    void delete(Map<String, Object> map);
}

