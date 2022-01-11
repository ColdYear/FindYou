package com.findYou.login.service;

import java.util.List;

import com.findYou.member.vo.MemberSearchVO;
import com.findYou.member.vo.MemberVO;



public interface ILoginService {
	
	public List<MemberVO> getMemberList(MemberSearchVO searchVO);
	public MemberVO getMember_Hp(String memHp);
	public void memberModify(MemberVO member);
}
