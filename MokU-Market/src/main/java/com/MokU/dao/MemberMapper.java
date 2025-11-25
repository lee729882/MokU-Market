package com.MokU.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.MokU.vo.MemberVO;

@Mapper
public interface MemberMapper {

    void insertMember(MemberVO member); // 회원가입

    MemberVO loginMember(MemberVO member); // 로그인

    int countByEmail(String email);
    int countByPhone(String phone);

    void updatePasswordByEmail(@Param("email") String email,
                               @Param("newPw") String newPw);

    void updateLocationVerified(MemberVO member);

    void updateProfileImage(MemberVO user);

    // 🔹 상세페이지 / 프로필 조회 핵심 메서드
    MemberVO getMemberById(@Param("userId") int userId);
}
