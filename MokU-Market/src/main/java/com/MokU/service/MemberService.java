package com.MokU.service;

import com.MokU.vo.MemberVO;

public interface MemberService {

    void register(MemberVO member);
    MemberVO login(MemberVO member);

    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);

    void updatePasswordByEmail(String email, String newPw);

    void updateLocationVerified(MemberVO member);

    void updateProfileImage(MemberVO user);

    // ⭐ 판매자 정보 조회용 (상세페이지 필수)
    MemberVO getMemberById(int userId);
}
