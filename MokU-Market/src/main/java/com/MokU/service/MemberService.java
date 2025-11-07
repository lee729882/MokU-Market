package com.MokU.service;

import com.MokU.vo.MemberVO;

public interface MemberService {
    void register(MemberVO member);
    MemberVO login(MemberVO member);
    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);
}
