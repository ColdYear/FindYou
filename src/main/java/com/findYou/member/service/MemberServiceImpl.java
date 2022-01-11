package com.findYou.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.exception.BizNotFoundException;
import com.findYou.member.dao.IMemberDao;
import com.findYou.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements IMemberService {

	@Inject
	IMemberDao memberDao;

	@Override
	public List<MemberVO> getMemberList(MemberVO memberVO) {
		List<MemberVO>memberList = memberDao.getMemberList(memberVO);
		return memberList;
	}

	@Override
	public MemberVO getMember(String memId) throws BizNotFoundException{
		MemberVO member = memberDao.getMember(memId);
		if(member==null) throw new BizNotFoundException();
		return member;
	}

	public MemberVO loginCheckMember(String memId) {
		MemberVO member = memberDao.getMember(memId);
		return member;
	}
	
	
	@Override
	public int modifyMember(MemberVO member) {
		int cnt = memberDao.updateJoinMember(member);
		
		return cnt;
	}

	@Override
	public int removeMember(MemberVO member) {
		int cnt = memberDao.deleteMember(member);
		return cnt;
	}

	@Override
	public int insertMember(MemberVO member) {
		return memberDao.insertMember(member);
		
	}
	@Override
	public List<MemberVO> managerViewMember(MemberVO member) {
		List<MemberVO> vmt = memberDao.managerViewMember(member);
		return vmt;
	}
	


	@Override
	public String getAddr(B2bParticipationVO partVO) {
		String member= memberDao.getAddr(partVO);
		 return member;
	}
	

}
