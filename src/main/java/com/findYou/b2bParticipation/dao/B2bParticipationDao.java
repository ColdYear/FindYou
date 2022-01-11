package com.findYou.b2bParticipation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.member.vo.MemberVO;

@Mapper
public interface B2bParticipationDao {

	
	/**
	 * 
	* @methodName : insetPart 
	* @author     : pc13
	* @date       : 2021.12.17 
	* @param partVO
	* @return
	* 참여인원 등록
	 */
	public int insertOrDelete(B2bParticipationVO partVO);
	
	/**
	 * 
	* @methodName : selectId 
	* @author     : pc13
	* @date       : 2021.12.17 
	* @param partVO
	* @return
	* 참여 인원 아이디 찾기
	 */
	public B2bParticipationVO selectId(B2bParticipationVO partVO);
	
	/**
	 * 
	* @methodName : cancelN 
	* @author     : pc13
	* @date       : 2021.12.17 
	* @param partVO
	* @return
	* 참여 취소한 회원 참여로 바꿈.
	 */
	public int cancelN(B2bParticipationVO partVO);
	
	/**
	 * 
	* @methodName : cancelY 
	* @author     : pc13
	* @date       : 2021.12.17 
	* @param partVO
	* @return
	* 참여회원 참여 취소
	 */
	public int cancelY(B2bParticipationVO partVO);
	
	/**
	 * 
	* @methodName : participationCount 
	* @author     : pc13
	* @date       : 2021.12.17 
	* @param partVO
	* @return
	* 참여인원 수
	 */
	public int participationCount(B2bParticipationVO partVO);
	

	/**
	 * 
	* @methodName : delYn 
	* @author     : pc13
	* @date       : 2021.12.18 
	* @param partVO
	* @return
	* 참여 여부 확인하기
	 */
	public String cancleYn(B2bParticipationVO partVO);
	
	/**
	 * 
	* @methodName : b2bParticipationList 
	* @author     : pc13
	* @date       : 2021.12.20 
	* @param partVO
	* @return
	* 게시글 번호에 맞는 참여 목록 리스트
	 */
	public List<B2bParticipationVO> b2bParticipationList(B2bParticipationVO partVO);
	
	/**
	 * 
	* @methodName : getTitleList 
	* @author     : pc13
	* @date       : 2021.12.20 
	* @param b2bPartId
	* @return
	* 아이디로 참여한 게시글 번호 찾기
	 */
	public List<B2bParticipationVO> getTitleList(String b2bPartId);

	/**
	 * 
	* @methodName : deleteBusinessPartticipation 
	* @author     : pc13
	* @date       : 2021.12.22 
	* @return
	* 게시글 삭제될 때 참여 인원 목록 삭제
	 */
	public int deleteBusinessPartticipation(BusinessBoardVO board);
	
	/**
	 * 
	* @methodName : countPart 
	* @author     : pc13
	* @date       : 2022.12.30 
	* @param b2bBoardIndex
	* @return
	* 게시글 번호에 참여인원 수
	 */
	public int countPart(int b2bBoardIndex);
	
	
	
}
