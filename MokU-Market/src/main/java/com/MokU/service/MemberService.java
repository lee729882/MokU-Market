package com.MokU.service;

import com.MokU.vo.MemberVO;

public interface MemberService {

    // 회원가입
    void register(MemberVO member);

    // 로그인 – ★ 현재 컨트롤러에서 사용하는 방식
    MemberVO login(String email, String password);

    // 중복 확인
    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);

    // 비밀번호 변경
    void updatePasswordByEmail(String email, String newPw);

    // 위치 인증 업데이트
    void updateLocationVerified(MemberVO member);

    // 프로필 이미지 업데이트
    void updateProfileImage(MemberVO user);

    // 특정 회원 조회
    MemberVO getMemberById(int userId);
}
