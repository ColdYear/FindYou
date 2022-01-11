package com.findYou.login.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.member.dao.IMemberDao;

import com.findYou.member.vo.MemberSearchVO;
import com.findYou.member.vo.MemberVO;

@Service
public class LoginServiceImpl implements ILoginService {

	@Inject
	IMemberDao memberDao;

	@Override
	public List<MemberVO> getMemberList(MemberSearchVO searchVO) {
		List<MemberVO> memberList = memberDao.getMemberList(null);
		return memberList;
	}

	@Override
	public MemberVO getMember_Hp(String memHp) {
		// 아이디,비밀번호 변경을 위한 한명 찾기.
	
		MemberVO member_hp = memberDao.getMember_Hp(memHp);
	
		return member_hp;
	}

	@Override
	public void memberModify(MemberVO member) {
		 memberDao.updateMember(member);
	}

}
