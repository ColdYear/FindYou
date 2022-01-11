package com.findYou.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.member.vo.MemberSearchVO;
import com.findYou.member.vo.MemberVO;

@Mapper
public interface IMemberDao {
	
	/**
	 * 
	* @methodName : getMemberCount 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return int
	* 회원의 전체 행 개수를 가져옴
	 */
	public int getMemberCount(MemberSearchVO searchVO);
	
	
	/**
	 * 
	* @methodName : getNormalMemberList 
	* @author     : 여인욱
	* @date       : 2021.12.04 
	* @param searchVO
	* @return List<MemberVO>
	* 검색 조건에 맞는 일반 회원들 목록 조회
	 */
	public List<MemberVO> getMemberList(MemberVO memberVO);
	
	
	/**
	 * 
	* @methodName : getNormalMember 
	* @author     : 여인욱
	* @date       : 2021.12.04 
	* @param memId
	* @return MemberVO
	* 아이디에 맞는 일반 회원 한명을 조회
	 */
	public MemberVO getMember(String memId);
	/**
	 * 
	* @methodName : getMember_Hp
	* @author     : 주세일
	* @date       : 2021.12.09
	* @param memHp
	* @return MemberVO
	* 핸드폰 번호 맞는 일반 회원 한명을 조회
	 */
	public MemberVO getMember_Hp(String memHp);
	/**
	 * 
	* @methodName : updateNormalMember 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param member
	* @return int
	* 일반 회원의 정보를 수정한다.
	 */
	public int updateMember(MemberVO member);
	
	
	/**
	 * 
	* @methodName : deleteNormalMember 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param member
	* @return int
	* 일반 회원 탈퇴
	 */
	public int deleteMember(MemberVO member);
	
	
	/**
	 * 
	* @methodName : insertBusinessMember 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param member
	* @return int
	* 사업자 회원 삽입
	 */
	public int insertMember(MemberVO member);
	
	public int updateJoinMember(MemberVO member);
	
	public List<MemberVO> managerViewMember(MemberVO memberVO);
	
	public String getAddr(B2bParticipationVO partVO);
}
