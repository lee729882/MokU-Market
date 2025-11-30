package com.MokU.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.MokU.vo.MemberVO;

@Mapper
public interface MemberMapper {

    // 회원가입
    void insertMember(MemberVO member);

    // 🔥 로그인(XML의 <select id="login"> 과 정확히 일치)
    MemberVO login(
            @Param("email") String email,
            @Param("password") String password);

    // 이메일 중복 체크
    int countByEmail(@Param("email") String email);

    // 전화번호 중복 체크
    int countByPhone(@Param("phone") String phone);

    // 비밀번호 변경
    void updatePasswordByEmail(
            @Param("email") String email,
            @Param("newPw") String newPw);

    // 위치 인증 업데이트
    void updateLocationVerified(MemberVO member);

    // 프로필 이미지 경로 업데이트
    void updateProfileImage(MemberVO user);

    // 유저 ID로 조회
    MemberVO getMemberById(@Param("userId") int userId);
}
