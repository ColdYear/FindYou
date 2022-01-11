package com.findYou.member.service;

import java.util.List;

import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.exception.BizNotFoundException;
import com.findYou.member.vo.MemberVO;

public interface IMemberService {

	/**
	 * 
	* @methodName : getMemberList 
	* @author     : pc34 
	* @date       : 2021.12.14 
	* @param searchVO
	* @return List<MemberVO>
	* 멤버 리스트 조회
	 */
	public List<MemberVO> getMemberList(MemberVO memberVO);
	
	/**
	 * 
	* @methodName : getBusinessMember 
	* @author     : 여인욱
	* @date       : 2021.12.04 
	* @param memId
	* @return BusinessMemberVO
	* 아이디에 맞는 회원 한명을 조회
	 */
	public MemberVO getMember(String memId) throws BizNotFoundException;


	/**
	 * 
	* @methodName : modifyMember 
	* @author     : pc34 
	* @date       : 2021.12.08 
	* @param member
	* @return int
	* 회원 정보 수정
	 */
	public int modifyMember(MemberVO member);
	
	
	/**
	 * 
	* @methodName : removeMember 
	* @author     : pc34 
	* @date       : 2021.12.08 
	* @param member
	* @return int
	* 회원 삭제
	 */
	public int removeMember(MemberVO member);
	
	
	/**
	 * 
	* @methodName : insertMember 
	* @author     : pc34 
	* @date       : 2021.12.08 
	* @param member
	* @return int
	* 회원 삽입
	 */
	public int insertMember(MemberVO member);


	
	public List<MemberVO> managerViewMember(MemberVO memberVO);
	
	/**
	 * 
	* @methodName : getAddr 
	* @author     : pc13
	* @date       : 2021.12.17 
	* @param memId
	* @return
	* 회원 아이디에 맞는 주소찾기
	 */
	public String getAddr(B2bParticipationVO partVO);
}
