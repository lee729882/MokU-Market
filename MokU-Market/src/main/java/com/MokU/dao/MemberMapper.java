package com.MokU.dao;

import org.apache.ibatis.annotations.Mapper;
import com.MokU.vo.MemberVO;

@Mapper
public interface MemberMapper {

    void insertMember(MemberVO member); // 회원가입

    MemberVO loginMember(MemberVO member); // 로그인
    
    int countByEmail(String email);
    int countByPhone(String phone);
}
