package com.MokU.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MokU.dao.MemberMapper;
import com.MokU.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public void register(MemberVO member) {
        memberMapper.insertMember(member);
    }

    @Override
    public MemberVO login(MemberVO member) {
        return memberMapper.loginMember(member);
    }

    @Override
    public boolean existsByEmail(String email) {
        return memberMapper.countByEmail(email) > 0;
    }

    @Override
    public boolean existsByPhone(String phone) {
        return memberMapper.countByPhone(phone) > 0;
    }

    @Override
    public void updatePasswordByEmail(String email, String newPw) {
        memberMapper.updatePasswordByEmail(email, newPw);
    }

    @Override
    public void updateLocationVerified(MemberVO user) {
        memberMapper.updateLocationVerified(user);
    }

    @Override
    public void updateProfileImage(MemberVO user) {
        memberMapper.updateProfileImage(user);
    }

    // 🔹 상세페이지 / 프로필 공용
    @Override
    public MemberVO getMemberById(int userId) {
        return memberMapper.getMemberById(userId);
    }
}
